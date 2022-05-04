Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29425195B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiEDDMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiEDDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7D21822
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 868A561A09
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C778C385A9;
        Wed,  4 May 2022 03:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651633748;
        bh=F8QW+wIsoFr2lyq4hl8rS+K765rspuzoJi3AePuUQiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QbEWqbMDeBnrtlbOwJi3nmf9RCz6cxuliAo21guAoJRwQUKqFbN+cpKqvmnokdU61
         wbgM39UugxOW1HV5LspeCP/OzSA+MLt0h4Lpp0mzur1REH84SMMsHcsB9Ed9HbXBp6
         QQr0/LJ/oDMbommUtugfKB6W+mludnh65xSYQQxIQ50Xl6E+oxwVAO3UA/bZVf60ap
         pu67EHpZiUWSQ7EzAM0SwDwIyrO7FQBwd2mOh9SccwaHXj7rM2tTuV8XWACe4BgzBt
         h0XXEap7e4OCa5u/ZD3Mu7PxaPnJka25PFs+Zo7/UcSgLwA9F+taxCxSw9M+2lDieT
         W53R6U0MCwfbQ==
Date:   Wed, 4 May 2022 12:09:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        rostedt@goodmis.org, yun.wang@linux.alibaba.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobe: sync issue's on ftraced-kprobe.
Message-Id: <20220504120903.057867b1b2e2fb2b2a542470@kernel.org>
In-Reply-To: <20220502045102.40005-1-ppbuk5246@gmail.com>
References: <20220502045102.40005-1-ppbuk5246@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 May 2022 13:51:02 +0900
Levi Yun <ppbuk5246@gmail.com> wrote:

> In kprobe_ftrace_handler, it accesses get kporbe without kprobe_mutex
> held.
> 
> This makes some of synchronizing issue when we use kprobe API in
> kernel-module.

NAK this, because get_kprobes() doesn't require the kprobe_mutex in
the preempt-disabled context. Please read the comment of get_kprobe().

/*
 * This routine is called either:
 *      - under the 'kprobe_mutex' - during kprobe_[un]register().
 *                              OR
 *      - with preemption disabled - from architecture specific code.
 */
struct kprobe *get_kprobe(void *addr)

Moreover, we can not use mutex inside kprobe handler because it runs
in the interrupt context.

Thank you,

> 
> Below is what i experienced:
> 
> CPU 0									CPU 1
> <...>									<In module code>
> kprobe_ftrace_handler
>     get_kprobe
>         __this_cpu_write
> 									unregister_kprobe
> 									unload_module
> 						<			kprobe memory gone>
> 	p->pre_handler <access invalid memory>
> 	page_fault
> 		kprobe_fault_handler
> 			(In here, kprobe memory gone,
> 			 double page fault is happening inifinie).
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  arch/x86/kernel/kprobes/ftrace.c | 3 +++
>  include/linux/kprobes.h          | 2 ++
>  kernel/kprobes.c                 | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index dd2ec14adb77..76147ff6ed88 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -25,6 +25,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> +	mutex_lock(&kprobe_mutex);
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (unlikely(!p) || kprobe_disabled(p))
>  		goto out;
> @@ -57,7 +58,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		 */
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> +
>  out:
> +	mutex_unlock(&kprobe_mutex);
>  	ftrace_test_recursion_unlock(bit);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 157168769fc2..4a18147ff6d6 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -191,6 +191,8 @@ struct kprobe_blacklist_entry {
>  DECLARE_PER_CPU(struct kprobe *, current_kprobe);
>  DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> +extern struct mutex kprobe_mutex;
> +
>  extern void kprobe_busy_begin(void);
>  extern void kprobe_busy_end(void);
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dd58c0be9ce2..b65f055b6fa2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -64,7 +64,7 @@ static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
>  static bool kprobes_all_disarmed;
>  
>  /* This protects 'kprobe_table' and 'optimizing_list' */
> -static DEFINE_MUTEX(kprobe_mutex);
> +DEFINE_MUTEX(kprobe_mutex);
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
>  
>  kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
