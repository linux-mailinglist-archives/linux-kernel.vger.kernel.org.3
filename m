Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7754ACF2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbiBHCuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiBHCuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:50:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C1C061355;
        Mon,  7 Feb 2022 18:50:03 -0800 (PST)
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt6np2m3QzZfGd;
        Tue,  8 Feb 2022 10:45:50 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Tue, 8
 Feb 2022 10:50:00 +0800
From:   Zhipeng Xie <xiezhipeng1@huawei.com>
To:     <peterz@infradead.org>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <mingo@redhat.com>, <namhyung@kernel.org>,
        <xiezhipeng1@huawei.com>, <xiexiuqi@huawei.com>,
        <fanwentao@huawei.com>
Subject: Re: [PATCH] Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled
Date:   Tue, 8 Feb 2022 10:49:31 -0500
Message-ID: <20220208154931.4371-1-xiezhipeng1@huawei.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220207141136.GG23216@worktop.programming.kicks-ass.net>
References: <20220207141136.GG23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On Mon, February 7, 2022 10:12 PM, Peter Zijlstra wrote:
> Your $Subject needs a subsystem prefix.

Thanks for your comments, I will adjust the patch Subject and resend the
patch according to your suggestions.

> On Mon, Feb 07, 2022 at 12:02:59PM -0500, Zhipeng Xie wrote:
> > when CONFIG_PERF_USE_VMALLOC is enabled, rb->nr_pages is always
> > equal to 1 in rb_alloc, causing perf_mmap return -EINVAL when mmap.
> > Fix this problem using data_page_nr.
> 
> How can this be? This would mean that any arch that selects that hasn't
> worked for forever ?! That seems unlikely.

Arch with CONFIG_PERF_USE_VMALLOC enabled by default: 
	arc/arm/csky/mips/sh/sparc/xtensa
Arch with CONFIG_PERF_USE_VMALLOC disabled by default:
	x86_64/aarch64/...
I have this problem when using sysdig -B(using ebpf)[1] on an aarch64 kernel
with CONFIG_PERF_USE_VMALLOC enabled. sysdig -B works fine after rebuilding
the kernel with the CONFIG_PERF_USE_VMALLOC disabled. I tracked it down to the
if condition event->rb->nr_pages != nr_pages in perf_mmap is true where
event->rb->nr_pages = 1 and nr_pages = 2048 resulting perf_mmap to return
-EINVAL.

[1] https://github.com/draios/sysdig

> > Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> 
> If this is correct; this is also missing a Fixes: tag.

Sorry, I don't know when this problem was introduced, so
I have no idea which commit my patch fixes.from the git log,
this problem seems to have existed for a long time, even before
the ebpf feature was introduced.
