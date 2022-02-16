Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E884B7F03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiBPDzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiBPDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:55:15 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86565EB142;
        Tue, 15 Feb 2022 19:55:02 -0800 (PST)
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jz3t54pJWz8wjL;
        Wed, 16 Feb 2022 11:51:41 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Wed, 16
 Feb 2022 11:54:59 +0800
From:   Zhipeng Xie <xiezhipeng1@huawei.com>
To:     <peterz@infradead.org>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <fanwentao@huawei.com>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <xiezhipeng1@huawei.com>, <xiexiuqi@huawei.com>
Subject: PING: [PATCH v2] perf/core: Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled
Date:   Wed, 16 Feb 2022 11:54:27 -0500
Message-ID: <20220216165427.18270-1-xiezhipeng1@huawei.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220209145417.6495-1-xiezhipeng1@huawei.com>
References: <20220209145417.6495-1-xiezhipeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

Could you please review the V2 version?

On Wed, February 9, 2022 10:54 PM, Zhipeng Xie wrote:
> This problem can be reproduced with CONFIG_PERF_USE_VMALLOC enabled
> on both
> x86_64 and aarch64 arch when using sysdig -B(using ebpf)[1].
> sysdig -B works fine after rebuilding the kernel with
> CONFIG_PERF_USE_VMALLOC
> disabled.
> 
> I tracked it down to the if condition event->rb->nr_pages != nr_pages in
> perf_mmap is true when CONFIG_PERF_USE_VMALLOC is enabled where
> event->rb->nr_pages = 1 and nr_pages = 2048 resulting perf_mmap to return
> -EINVAL.This is because when CONFIG_PERF_USE_VMALLOC is enabled,
> rb->nr_pages
> is always equal to 1.
> 
> Arch with CONFIG_PERF_USE_VMALLOC enabled by default:
>	arc/arm/csky/mips/sh/sparc/xtensa
> Arch with CONFIG_PERF_USE_VMALLOC disabled by default:
>	x86_64/aarch64/...
> 
> Fix this problem by using data_page_nr.
> 
> [1] https://github.com/draios/sysdig
> 
> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> ---
>  kernel/events/core.c        | 2 +-
>  kernel/events/internal.h    | 5 +++++
>  kernel/events/ring_buffer.c | 5 -----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 57c7197838db..370292effd32 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6352,7 +6352,7 @@ static int perf_mmap(struct file *file, struct
> vm_area_struct *vma)
>  again:
>	mutex_lock(&event->mmap_mutex);
>	if (event->rb) {
> -		if (event->rb->nr_pages != nr_pages) {
> +		if (data_page_nr(event->rb) != nr_pages) {
>			ret = -EINVAL;
>			goto unlock;
>		}
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 082832738c8f..5816c0719dbf 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -116,6 +116,11 @@ static inline int page_order(struct perf_buffer *rb)
>  }
>  #endif
> 
> +static int data_page_nr(struct perf_buffer *rb)
> +{
> +	return rb->nr_pages << page_order(rb);
> +}
> +
>  static inline unsigned long perf_data_size(struct perf_buffer *rb)
>  {
>	return rb->nr_pages << (PAGE_SHIFT + page_order(rb));
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 52868716ec35..fb35b926024c 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -859,11 +859,6 @@ void rb_free(struct perf_buffer *rb)
>  }
> 
>  #else
> -static int data_page_nr(struct perf_buffer *rb)
> -{
> -	return rb->nr_pages << page_order(rb);
> -}
> -
>  static struct page *
>  __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  {
> --
> 2.18.1

Best Regards,
Zhipeng Xie
