Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9FA4B2E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiBKUJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:09:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E2C55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:08:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso7894624wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9cyFQ7dfr8DHuc7BsoLlqZjssykMfFpohqclYEWC+M=;
        b=q5UR9qQBS8mH2xHYRhIxT0/dTVwsz5EgrCWy+79CCt6C4o+Lo2o/EPEU8a0p7UDKse
         AqQIqfwl4LUKe0pnAJIzMUj4uBxEPEDUsCPvD1VhncWQJpJkBj3RCMbwpAxQCA860rF2
         HzLVNuMnGgob+e9vJ+OEjPKW+wPkIS7er2Iy7Uv9mrozFpHyYJCvHyp/fKBbqAeW3so6
         Jmej3f4yQgPLnxwbSSwwuh2BLPm2tdk6P0zCobnjFfI+65GxU9C8KVY9ksq3cINjUVGR
         0twtVRR8eCmgcP5oq9hj/17ejps1PtOdNoHoSP6p0WC7SKQNyhYxxWiMHhSNY7a7/Svc
         gzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9cyFQ7dfr8DHuc7BsoLlqZjssykMfFpohqclYEWC+M=;
        b=BD7P5rPUet4pJEFtAxbQEbGl+anZKpBetDAY5ujtJBqVp/QpCabgSLMV23Z79Ynd0/
         iGrh/ARuTfLm+1eNJG4y7C9zhc+5+b8zjO5smA2Qwx1mCdFCXVNZKeKEQOY9dd2X7XSU
         wON61tKr24MeZQdepNW50EB+jRnJySyK8MOutnzmC+IOwVFRaEe/+iha31JphxGwARMG
         IvFjMwuqIFkYjxT1H/Dv5Xze2yLQ9XjR2ceXLxuSN3dGG6WNGAr18UovaSRhCCzdJ2sj
         uGwSk7JN2GJAHj+yTCGiNbOtIVSt8QRsnCF+gpCZswF4EqMNVjX0RsyqoO80sEkDgcE3
         DziA==
X-Gm-Message-State: AOAM531FZUwe6EdqYoTgWpwCC5kBC381Lt83faQTjomO17+oVC97M8k9
        M32e+FQDGG0I9h49+L+BR5Zrd35PwLxzevkBPWHAag==
X-Google-Smtp-Source: ABdhPJxelKFdvb9PDzJgumowcbB5dWOTz1Kjfv+S/7q3i3SiVPkyMSZ+hxVJpdQfolVsbZIoaolXrFh/TW0mX1i1voQ=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1656197wms.88.1644610138118;
 Fri, 11 Feb 2022 12:08:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com>
In-Reply-To: <20220208150945.266978-1-juew@google.com>
From:   Jue Wang <juew@google.com>
Date:   Fri, 11 Feb 2022 12:08:46 -0800
Message-ID: <CAPcxDJ7iHshyZdCp9ngrfFV4j2=HTvXF5naN+E+D_AvcH8n4wg@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony and Borislav,

Gently ping?

Thanks,
-Jue

On Tue, Feb 8, 2022 at 7:09 AM Jue Wang <juew@google.com> wrote:
>
> The fast string copy instructions ("rep movs*") could consume an
> uncorrectable memory error in the cache line _right after_ the
> desired region to copy and raise an MCE.
>
> Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string copy
> and will avoid such spurious machine checks. However, that is less
> preferrable due to the permanent performance impact. Considering memory
> poison is rare, it's desirable to keep fast string enabled until an MCE
> is seen.
>
> Intel has confirmed the following:
> 1. The CPU erratum of fast string copy only applies to
> SKX/CLX/CPL generations.
> 2. Directly return from MCE handler will result in complete execution
> of the fast string copy (rep movs*) with no data loss or corruption.
> 3. Directly return from MCE handler will not result in another MCE
> firing on the next poisoned cache line due to rep movs*.
> 4. Directly return from MCE handler will resume execution from a
> correct point in code.
> 5. Directly return from MCE handler due to any other SRAR MCEs will
> result in the same instruction that triggered the MCE firing a second
> MCE immediately.
> 6. It's not safe to directly return without disabling the fast string
> copy, as the next fast string copy of the same buffer on the same CPU
> would result in a PANIC MCE.
>
> The mitigation in this patch should mitigate the erratum completely with
> the only caveat that the fast string copy is disabled on the affected
> hyper thread thus performance degradation.
>
> This is still better than the OS crashes on MCEs raised on an
> irrelevant process due to 'rep movs*' accesses in a kernel context,
> e.g., copy_page.
>
> Since a host drain / fail-over usually starts right after the first
> MCE is signaled, which results in VM migration or termination, the
> performance degradation is a transient effect.
>
> Tested:
>
> Injected errors on 1st cache line of 8 anonymous pages of process
> 'proc1' and observed MCE consumption from 'proc2' with no panic
> (directly returned).
>
> Without the fix, the host panicked within a few minutes on a
> random 'proc2' process due to kernel access from copy_page.
>
> Signed-off-by: Jue Wang <juew@google.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c     | 53 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/internal.h |  5 ++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5818b837fd4d..abbd4936dfa8 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -834,6 +834,49 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
>         m->cs = regs->cs;
>  }
>
> +/*
> + * Disable fast string copy and return from the MCE handler upon the first SRAR
> + * MCE on bank 1 due to a CPU erratum on Intel SKX/CLX/CPL CPUs.
> + * The fast string copy instructions ("rep movs*") could consume an
> + * uncorrectable memory error in the cache line _right after_ the
> + * desired region to copy and raise an MCE with RIP pointing to the
> + * instruction _after_ the "rep movs*".
> + * This mitigation addresses the issue completely with the caveat of
> + * performance degradation on the CPU affected. This is still better
> + * than the OS crashes on MCEs raised on an irrelevant process due to
> + * 'rep movs*' accesses in a kernel context (e.g., copy_page).
> + * Since a host drain / fail-over usually starts right after the first
> + * MCE is signaled, which results in VM migration or termination, the
> + * performance degradation is a transient effect.
> + *
> + * Returns true when fast string copy on cpu should be disabled.
> + */
> +static bool quirk_skylake_repmov(void)
> +{
> +       u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +       u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
> +
> +       if ((mcgstatus & MCG_STATUS_LMCES) &&
> +           unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
> +               u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +
> +               if ((mc1_status &
> +                    (MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
> +                     MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
> +                     MCI_STATUS_AR|MCI_STATUS_S)) ==
> +                   (MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
> +                    MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S)) {
> +                       msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +                                     MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
> +                       mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +                       mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +                       pr_err_once("Errata detected, disable fast string copy instructions.\n");
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
>  /*
>   * Do a quick check if any of the events requires a panic.
>   * This decides if we keep the events around or clear them.
> @@ -1403,6 +1446,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
>         else if (unlikely(!mca_cfg.initialized))
>                 return unexpected_machine_check(regs);
>
> +       if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
> +               return;
> +
>         /*
>          * Establish sequential order between the CPUs entering the machine
>          * check handler.
> @@ -1858,6 +1904,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>
>                 if (c->x86 == 6 && c->x86_model == 45)
>                         mce_flags.snb_ifu_quirk = 1;
> +
> +               /*
> +                * Skylake, Cascacde Lake and Cooper Lake require a quirk on
> +                * rep movs.
> +                */
> +               if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
> +                       mce_flags.skx_repmov_quirk = 1;
>         }
>
>         if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 52c633950b38..cec227c25138 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -170,7 +170,10 @@ struct mce_vendor_flags {
>         /* SandyBridge IFU quirk */
>         snb_ifu_quirk           : 1,
>
> -       __reserved_0            : 57;
> +       /* Skylake, Cascade Lake, Cooper Lake rep movs quirk */
> +       skx_repmov_quirk                : 1,
> +
> +       __reserved_0            : 56;
>  };
>
>  extern struct mce_vendor_flags mce_flags;
> --
> 2.35.0.263.gb82422642f-goog
>
