Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA974F624F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiDFO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiDFO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:56:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D91DFDD3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:47:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9Ja9xz_1649213242;
Received: from 30.39.96.171(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V9Ja9xz_1649213242)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 10:47:23 +0800
Message-ID: <802b944d-d168-d9c8-add3-1fe17f3985f5@linux.alibaba.com>
Date:   Wed, 6 Apr 2022 10:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] sched: avoid unnecessary atomic_read when
 sync_core_before_usermode() is empty
Content-Language: en-US
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        NeilBrown <neilb@suse.de>,
        Vasily Averin <vasily.averin@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220402030822.11441-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20220402030822.11441-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've run schbench and found wakeup latency on some arm64 machines worse 
than others. Perf shows there's a hotspot on 
atomic_read(&mm->membarrier_state);

We're still working for the real reason behind it (maybe cache or sth 
hardware related), and we do see remove this function can help improve 
performance.

Thanks.

On 2022/4/2 11:08, Tianchen Ding wrote:
> On archs except x86, CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE is not
> defined. We found membarrier_mm_sync_core_before_usermode() looks like
> this when compiled by gcc10:
> 
> 	if (current->mm != mm)
> 		return;
> 	atomic_read(&mm->membarrier_state);
> 
> This memory access is unnecessary. Remove it to improve performance.
> 
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   include/linux/sched/mm.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index a80356e9dc69..3ded68d9f913 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -401,6 +401,7 @@ enum {
>   #include <asm/membarrier.h>
>   #endif
>   
> +#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>   {
>   	if (current->mm != mm)
> @@ -410,6 +411,11 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>   		return;
>   	sync_core_before_usermode();
>   }
> +#else
> +static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
> +{
> +}
> +#endif
>   
>   extern void membarrier_exec_mmap(struct mm_struct *mm);
>   

