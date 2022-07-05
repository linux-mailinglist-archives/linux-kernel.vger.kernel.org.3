Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C15676C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiGESp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiGESp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:45:26 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B31C11F;
        Tue,  5 Jul 2022 11:45:25 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id i14so3693538yba.1;
        Tue, 05 Jul 2022 11:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IJa3F4chuHeeOTo8oUJNcMPecHREZFykKcSbqyP2C4=;
        b=UBtG3OXsFipBmTyXEeF1jnYa3tUrwTz4FCs6p3YdSDSJvHGqIWTr6rFG2hcRtP7SZs
         pQZhFj1F6kOEcR3K6ijoJrUXAAcL4dEeVK7SUmQZupMwJQMxs0tfbiPFOUa0YVNL/7D5
         TC5XN4paiEDdn8Qx+bIUmwBzsm2cSkTfde28UzSzU7O4lN2XkzoxKKvpBunWMpJnHIGz
         TJMiW67HHSS2CuByST+N8UQP0qysncbjoD9BJePCg24G3qpaC1qCJlXfNJagzeNC459k
         FAqDjuvQf+y/p9KOmEVT5Ri6WPgpJeFEKO4GrOgZ/WZgW1F7KUVMp3hTG9R2dK1zIxac
         HLOg==
X-Gm-Message-State: AJIora/2chEuoFrqcBN0emU95XtOW8XxarbqaAhXi14MyoJpo2TbvGuw
        Y9LYk+PTkX0+MTZK874IYAlYI2vnewen11WS7Tg=
X-Google-Smtp-Source: AGRyM1v3/TAoUlh/vSdI/8KbANU/81b6OhRkHJO7TopyYQJNhdiSQvywavpjsOHJSgzUP9KxubpmVxa2Uf9mXyNVY4w=
X-Received: by 2002:a05:6902:50e:b0:66e:7f55:7a66 with SMTP id
 x14-20020a056902050e00b0066e7f557a66mr3495794ybs.365.1657046724197; Tue, 05
 Jul 2022 11:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1656659147-20396-1-git-send-email-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <1656659147-20396-1-git-send-email-TonyWWang-oc@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:45:13 +0200
Message-ID: <CAJZ5v0jXZKECfaJ0fqx+Hb5vhaw6uFgOaJD1BxwRUjOfMXMJJQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: Replace vendor check with X86_FEATURE_MWAIT
 in ffh_cstate_init
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LindaChai@zhaoxin.com,
        LeoLiu@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 9:05 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> The original commit 991528d73486 ("ACPI: Processor native C-states using
> MWAIT") has a vendor check for Intel in the function of ffh_cstate_init().
>
> Commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
> systems") and commit 280b68a3b3b9 ("x86/cstate: Allow ACPI C1 FFH MWAIT
> use on Hygon systems") add vendor check for AMD and HYGON in the function
> of ffh_cstate_init().
>
> Recent Zhaoxin and Centaur CPUs support MONITOR/MWAIT instructions that
> can be used for ACPI Cx state in the same way as Intel. So expected to
> add the support of these CPUs in the function of ffh_cstate_init() too.
>
> The CPU feature X86_FEATURE_MWAIT indicates processor supports MONITOR/
> MWAIT instructions. So the check for many CPU vendors in ffh_cstate_init()
> is unnecessary, use X86_FEATURE_MWAIT to replace the CPU vendor check.
>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if I'm expected to pick up this one.  Thanks!


> ---
>  arch/x86/kernel/acpi/cstate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7945eae..a64c38f 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -209,11 +209,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
>
>  static int __init ffh_cstate_init(void)
>  {
> -       struct cpuinfo_x86 *c = &boot_cpu_data;
> -
> -       if (c->x86_vendor != X86_VENDOR_INTEL &&
> -           c->x86_vendor != X86_VENDOR_AMD &&
> -           c->x86_vendor != X86_VENDOR_HYGON)
> +       if (!boot_cpu_has(X86_FEATURE_MWAIT))
>                 return -1;
>
>         cpu_cstate_entry = alloc_percpu(struct cstate_entry);
> --
> 2.7.4
>
