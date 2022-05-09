Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8B51F6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiEIIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiEIIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:01:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807E195BF1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:58:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so16296991pjv.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3f/qnVS2WcXj7iwOwyZu0+V2UDXqQKKLdu50e65PWk=;
        b=IPsL8eNXADYfgkb1P5Z6nd5wrXDTkdIpPH8ibsl6bxuq/UPgZ4bu/a1MHv/o+EXBvz
         gaW5r9C9DYOpxC9FkcE36xE4Ia1yssvWI10MjHbg7xC/RiniUQBK7GZhP3ZMTDb6m8N/
         ygVnqKxoGfaanRn2uuKm3A1t28JiiWaKFaQW7v8HDeouvGa84CiZ8Me3VsGn0IF8Tuzz
         C6A3gPbcCrX94xMzTfgzEpXNUzcVUUODbKHD5YNkzQivBjhepHHa8QNcUbTJmG/vJTJd
         o3iWn6vP/tSqUwilqHsLJsVE4vam9IkLmcMBZSjTVVy5xBV2XZdHTTXEVlTFZL0hui1K
         1kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3f/qnVS2WcXj7iwOwyZu0+V2UDXqQKKLdu50e65PWk=;
        b=kpCBJ1N/+sOabkmWdQEDjYxeXjL7AyUWfMosFBMb6zb0wDnKe6kNutRXjNlMfFLvhZ
         JdSGYtkeMYsxQYw67XF+NA1ILtXSNLs3uDdnTKL3l5ZVda34uzuNh/HtH47XIDsOlelv
         ZlRKgaUURcjtX2kFXKARtbzGb5LNW8+DcnzFwQ8LjM9UvqYCLLH9t5iUCJTINfwgYgMP
         bXh65VBjhIN9DDefRYJu1mPzwBe+TZhMrcmmpQtP06uAAXocgk5Zc1zvEixZdBEdxh4J
         9ohYDc70bH3NvmHvIYOYBJ7lAZOCzXDNZgPjuskD9nkXMt7P4WCxE1Du3LcpYQsPrvKN
         YS9w==
X-Gm-Message-State: AOAM53111iLPEAMqzF0Tj6ypfUZ6uapKORa1Ow8vWW/FibWegtrjBO2H
        OIvIHrrf0PpMXEEZ//stQtnMrSAUB6/p2ATXd2EyIw==
X-Google-Smtp-Source: ABdhPJxa3Zcby7TuMv1GkHzVZ0aCfHyAL/VzB6G45ZEKW+xqKpPz8XjxFKqLAKKAGntS5KrPrQCTTw3yXCp2fnXQ69c=
X-Received: by 2002:a17:90b:1a86:b0:1dc:eae9:9b5b with SMTP id
 ng6-20020a17090b1a8600b001dceae99b5bmr12472341pjb.100.1652083002113; Mon, 09
 May 2022 00:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220413065458.88541-1-sumit.garg@linaro.org> <20220413065458.88541-3-sumit.garg@linaro.org>
 <20220506161258.p5jztdy33hlua3bu@maple.lan>
In-Reply-To: <20220506161258.p5jztdy33hlua3bu@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 9 May 2022 13:26:30 +0530
Message-ID: <CAFA6WYPej2XpNicmYhRLiQBinWBKEggwR7g7szA5Dq8KjuReKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 at 21:43, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 13, 2022 at 12:24:58PM +0530, Sumit Garg wrote:
> > After fixing wrongly single-stepping into the irq handler, when we execute
> > single-step in kdb/kgdb, we can see only the first step can work.
>
> I might be nitpicking since, again, I've no problems with the code
> but... I'd rather this patch description focused on what this patch
> does rather than what the patch before it does!
>
> Something more like:
>
>   Currently only the first attempt to single-step has any effect.
>   After that all further stepping remains "stuck" at the same program
>   counter value.
>

Ack, I will use this instead.

-Sumit

>
> Daniel.
>
>
>
>
> > Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
> > i think PSTATE.SS=1 should be set each step for transferring the PE to the
> > 'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
> > since the second single-step.
> >
> > After the first single-step, the PE transferes to the 'Inactive' state,
> > with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
> > kernel_active_single_step()=true. Then the PE transferes to the
> > 'Active-pending' state when ERET and returns to the debugger by step
> > exception.
> >
> > Before this patch:
> > ==================
> > Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
> > [0]kdb>
> >
> > [0]kdb>
> > [0]kdb> bp write_sysrq_trigger
> > Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
> >     is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0
> >
> > [0]kdb> go
> > $ echo h > /proc/sysrq-trigger
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
> > [1]kdb>
> >
> > After this patch:
> > =================
> > Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
> > [0]kdb> bp write_sysrq_trigger
> > Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
> >     is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0
> >
> > [0]kdb> go
> > $ echo h > /proc/sysrq-trigger
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
> > [1]kdb> ss
> >
> > Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
> > [1]kdb>
> >
> > Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> > Co-developed-by: Wei Li <liwei391@huawei.com>
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/debug-monitors.h | 1 +
> >  arch/arm64/kernel/debug-monitors.c      | 5 +++++
> >  arch/arm64/kernel/kgdb.c                | 2 ++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> > index 00c291067e57..9e1e864d6440 100644
> > --- a/arch/arm64/include/asm/debug-monitors.h
> > +++ b/arch/arm64/include/asm/debug-monitors.h
> > @@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
> >  void kernel_enable_single_step(struct pt_regs *regs);
> >  void kernel_disable_single_step(void);
> >  int kernel_active_single_step(void);
> > +void kernel_regs_reset_single_step(struct pt_regs *regs);
> >
> >  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> >  int reinstall_suspended_bps(struct pt_regs *regs);
> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > index 4f3661eeb7ec..ea3f410aa385 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -438,6 +438,11 @@ int kernel_active_single_step(void)
> >  }
> >  NOKPROBE_SYMBOL(kernel_active_single_step);
> >
> > +void kernel_regs_reset_single_step(struct pt_regs *regs)
> > +{
> > +     set_regs_spsr_ss(regs);
> > +}
> > +
> >  /* ptrace API */
> >  void user_enable_single_step(struct task_struct *task)
> >  {
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index 2aede780fb80..acf2196b1e9b 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
> >                */
> >               if (!kernel_active_single_step())
> >                       kernel_enable_single_step(linux_regs);
> > +             else
> > +                     kernel_regs_reset_single_step(linux_regs);
> >               err = 0;
> >               break;
> >       default:
> > --
> > 2.25.1
