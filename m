Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45A5789B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiGRSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGRSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:43:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AD2CDFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:43:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy29so21801687ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ApIzTUmw17ziVO0t5cqTr6stUleQZ43FKaMqK+NHlc=;
        b=X1LMmxGZOWRmLCeS3EQf38Jit/U0ezSct3kQ7MykW7jHYr2d0OeUla6mQzOZAgQOWQ
         HJSGjmEtB+A7rzJhrDsS32ZnS1x5WTdfw476iNZbkufSAW6uwRmGsgNhX4R94VmzANM9
         idxUxp0Qqtxrzg3/UWfcHOof+w8EFYNJ0yMBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ApIzTUmw17ziVO0t5cqTr6stUleQZ43FKaMqK+NHlc=;
        b=bwJ/o6WO58ZmHr/CGuvEDklbpwzvfdQ9sY5k93VQKgU06troFYkiupS+9dUuTJ97nd
         v5oJrLyShM9x0IuAhqSXy5jz+ugitesEMuVf1sgyZuaKojxLKNIksxxgQEA0o6JEJ+pU
         pKbZCo7VIofyf3/OrLrFNFiTuHGJo7A1wQE3xUwfHyWAb/kWTmPU8YVdVEPMq7bAS6T0
         2XHDykAj9u5DRkRCDJMlDBQ3IUpVKAZXABX1nD+UG8Iw3IwrjPtJ21JyC0mZuDk5QEry
         nf3+dnetgtL97mxkz9hivurBqDDiwkz7rMz8y8l7BzwaCw2xlz/OiK7dPljdo7doTYt7
         WDRg==
X-Gm-Message-State: AJIora+soQoIJYKKzUKVuH9+lB0qIgRqR1Suuz3IMlva0uaVFrneqp9L
        Gn511YZBWVqtY1oeIOhXti8a2HB82Nvn4s28
X-Google-Smtp-Source: AGRyM1s6fup3v/SYNwpcvIUBv7tjYZFQCxF5cDllMtYRMb7hy0inbcSyP4RRjb/ZpNIsM2jWHVkG4Q==
X-Received: by 2002:a17:906:5d16:b0:72f:248d:525a with SMTP id g22-20020a1709065d1600b0072f248d525amr7818365ejt.441.1658169818519;
        Mon, 18 Jul 2022 11:43:38 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906304f00b0072f42ca2932sm821364ejd.137.2022.07.18.11.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:43:37 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d16so18326306wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:43:36 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr24360022wrh.193.1658169816031; Mon, 18
 Jul 2022 11:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230952.787452088@linutronix.de> <20220718173923.891284477@linutronix.de>
In-Reply-To: <20220718173923.891284477@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:43:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFNV17=y3CQo1-FgRT5p04JFTa7RV16TN1RFL8sptZ-Q@mail.gmail.com>
Message-ID: <CAHk-=wgFNV17=y3CQo1-FgRT5p04JFTa7RV16TN1RFL8sptZ-Q@mail.gmail.com>
Subject: Re: [patch 1/3] x86/cpu: Remove segment load from switch_to_new_gdt()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I appreciate the added big comments in this code, but looking at this patch:

On Mon, Jul 18, 2022 at 10:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> +/**
> + * switch_to_new_gdt - Switch form early GDT to the direct one
> + * @cpu:       The CPU number for which this is invoked
> + *
> + * Invoked during early boot to switch from early GDT and early per CPU
> + * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
> + * CPU area.
>   */
>  void switch_to_new_gdt(int cpu)
>  {
> -       /* Load the original GDT */
>         load_direct_gdt(cpu);
> -       /* Reload the per-cpu base */
> -       load_percpu_segment(cpu);
> +
> +       /*
> +        * No need to load the %gs (%fs for 32bit) segment. It is already
> +        * correct, %gs is 0 on 64bit and %fs is __KERNEL_PERCPU on 32 bit.
> +        *
> +        * Writing %gs on 64bit would zero GSBASE which would make any per
> +        * CPU operation up to the point of the wrmsrl() fault.
> +        *
> +        * 64bit requires to point GSBASE to the new offset. Until the
> +        * wrmsrl() happens the early mapping is still valid. That means
> +        * the GSBASE update will lose any prior per CPU data which was
> +        * not copied over in setup_per_cpu_areas().
> +        *
> +        * For secondary CPUs this is not a problem because they start
> +        * already with the direct GDT and the real GSBASE. This invocation
> +        * is pointless and will be removed in a subsequent step.
> +        */
> +       if (IS_ENABLED(CONFIG_X86_64))
> +               wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>  }

... while those comments are nice and all, I do think this retains the
basic insanity of having "switch_to_new_gdt()" do magical things on
x86-64 that don't really match the name.

So honestly, I'd be happier of that whole

       if (IS_ENABLED(CONFIG_X86_64))
               wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));

was migrated to the callers instead. There aren't *that* many callers.

I expect that it is then quite possible that several of the call-sites
would go "GS_BASE is already correct here, I can remove this".

But even if every single caller keeps that wrmsrl() around, at least
it wouldn't be hidden behind a function call that has a name that
implies something completely different is happening.

And no, I don't care *that* deeply, so this is just a suggestion.

But wouldn't it be nice if this function was actually named by what it
does, rather than by what it used to do back in the i386 days when the
GDT affected the segment bases?

                  Linus
