Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3058A1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiHDURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiHDURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:17:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D81658E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:17:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m4so1313120ejr.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7n+nzKAW6RL6v3KbdhDpYkJhC3HJJpDBhjdnpuUOk5E=;
        b=jrU/VjXMSj8Gz2B3mvq62j+rkBg/AauCzc5iveyD2rIpgzjchFOaDecdoe7EmmuVSt
         zDq/EUc9kzlA0OJh9k6hDNvCIbCeOxSgRjXSkIqviRqUIP/BfkucIO+grTpQRgYVyLqt
         Y4KV7K21eKRzLKruBv5TYEF4vnE4ihlkygFPAyJH104jYvvomeeGGIReTH2vQnxGeG7U
         1Vn5/a4dby7ylgGptIrjMOyvdrCGxHuiY96yWva5qmLA4aVJGvNQfAOAWSSdUM/0xRrd
         kdArNUWC9a5vgRjBGuWY3yT2Eh1BALW+vqCzo32DTh0JUR6Nt4fvgM8qpzKd95gbvtZy
         St+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7n+nzKAW6RL6v3KbdhDpYkJhC3HJJpDBhjdnpuUOk5E=;
        b=YQUbFunN21ArsA3uTKm4ej41coOEi2ntMVjUFwNs/yQbHcv9+YpGQsBMQHyLYIVtOT
         GKtKscKk8r1dm0m9WFkFuQwwmE7qENNXm9q1wJsniT2wTtXxdmztpSUwNEEzIeirGxgu
         Y54rnczfzhu/bKYDpfIRhHf7YpFg41ifSh2wIFu8hCb/qJ2C3mID11O8dFCjdZ8vUDcz
         PLeb05pRKDUSKeB5irLEshOEqwrYPoZXw19mIdDPLSTV/QMaoQMRamZKki9LSBegPR73
         N6hiJbENVPX16KH1iyFqRqG6cSmqB+jNrIB3ruvSDG0+E3m/mzsx4XY5R4dZXKqRJzcU
         Zn3Q==
X-Gm-Message-State: ACgBeo3KClQYJ7jOe+f7iG6ZK3AHz/HtEjiBC5Gt+IPzeRIofKmAyizo
        NWbuMeEJZD0trrNT3rP54iE=
X-Google-Smtp-Source: AA6agR7gbF9JuMdB2tm4YCSUynGbg2XS4VTkZ5uKVhu6NurElgJm0m23zN+XbuVkkJhOQNHqNUKx7Q==
X-Received: by 2002:a17:907:738a:b0:730:7537:848c with SMTP id er10-20020a170907738a00b007307537848cmr2688491ejc.488.1659644226990;
        Thu, 04 Aug 2022 13:17:06 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b0043a5bcf80a2sm1127022edq.60.2022.08.04.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:17:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 4 Aug 2022 22:17:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
Message-ID: <YuwpQEYCwTl+m6j5@gmail.com>
References: <20220804155450.08c5b87e@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804155450.08c5b87e@imladris.surriel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> In a large enough fleet of computers, it is common to have a few bad CPUs.
> Those can often be identified by seeing that some commonly run kernel code,
> which runs fine everywhere else, keeps crashing on the same CPU core on one
> particular bad system.
> 
> However, the failure modes in CPUs that have gone bad over the years are
> often oddly specific, and the only bad behavior seen might be segfaults
> in programs like bash, python, or various system daemons that run fine
> everywhere else.
> 
> Add a printk() to show_signal_msg() to print the CPU, core, and socket
> at segfault time. This is not perfect, since the task might get rescheduled
> on another CPU between when the fault hit, and when the message is printed,
> but in practice this has been good enough to help us identify several bad
> CPU cores.
> 
> segfault[1349]: segfault at 0 ip 000000000040113a sp 00007ffc6d32e360 error 4 in segfault[401000+1000] on CPU 0 (core 0, socket 0)
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> CC: Dave Jones <dsj@fb.com>
> ---
>  arch/x86/mm/fault.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index fad8faa29d04..a9b93a7816f9 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  		unsigned long address, struct task_struct *tsk)
>  {
>  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> +	/* This is a racy snapshot, but it's better than nothing. */
> +	int cpu = READ_ONCE(raw_smp_processor_id());
>  
>  	if (!unhandled_signal(tsk, SIGSEGV))
>  		return;
> @@ -782,6 +784,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  
>  	print_vma_addr(KERN_CONT " in ", regs->ip);
>  
> +	/*
> +	 * Dump the likely CPU where the fatal segfault happened.
> +	 * This can help identify faulty hardware.
> +	 */
> +	printk(KERN_CONT " on CPU %d (core %d, socket %d)", cpu,
> +	       topology_core_id(cpu), topology_physical_package_id(cpu));

LGTM, applying this to tip:x86/mm unless someone objects.

I've added the tidbit to the changelog that this only gets printed if 
show_unhandled_signals (/proc/sys/kernel/print-fatal-signals) is enabled - 
which is off by default. So your patch expands upon a default-off debug 
printout in essence - where utility maximization is OK.

Thanks,

	Ingo
