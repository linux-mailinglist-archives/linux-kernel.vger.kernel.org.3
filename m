Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C056A5A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiGGOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiGGOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:39:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1725E9A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:39:10 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 267Ecbi9057072;
        Thu, 7 Jul 2022 23:38:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 07 Jul 2022 23:38:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 267EcbSj057068
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jul 2022 23:38:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <777637fc-2664-9b22-3d1b-959dc29704df@I-love.SAKURA.ne.jp>
Date:   Thu, 7 Jul 2022 23:38:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lib/smp_processor_id: fix imbalanced
 instrumentation_end() call
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a636d8e0-ad32-5888-acac-671f7f553bb3@I-love.SAKURA.ne.jp>
In-Reply-To: <a636d8e0-ad32-5888-acac-671f7f553bb3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that nobody is interested in this patch.

Andrew, can you take this patch and
https://lkml.kernel.org/r/225b0c28-8333-9849-0d7b-2a561fb20ccb@I-love.SAKURA.ne.jp ?

On 2022/06/22 14:46, Tetsuo Handa wrote:
> Currently instrumentation_end() won't be called if printk_ratelimit()
> returned false.
> 
> Fixes: 126f21f0e8d46e2c ("lib/smp_processor_id: Move it into noinstr section")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  lib/smp_processor_id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> index 046ac6297c78..a2bb7738c373 100644
> --- a/lib/smp_processor_id.c
> +++ b/lib/smp_processor_id.c
> @@ -47,9 +47,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>  
>  	printk("caller is %pS\n", __builtin_return_address(0));
>  	dump_stack();
> -	instrumentation_end();
>  
>  out_enable:
> +	instrumentation_end();
>  	preempt_enable_no_resched_notrace();
>  out:
>  	return this_cpu;

