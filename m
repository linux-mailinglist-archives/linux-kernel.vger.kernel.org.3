Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47764868B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiAFRe2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jan 2022 12:34:28 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:46750 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiAFReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:34:24 -0500
Received: by mail-qv1-f44.google.com with SMTP id r6so2981325qvr.13;
        Thu, 06 Jan 2022 09:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrrcpSOjpVBQjfLKYFTKueeToB19AVYUAAYHWQfgysI=;
        b=mQRYzmewiWv7qumzannnbrYXeo3AHwkoXkd5TuCwkm02EifG5u55TKwDJDQjx6qahO
         UJBetc1o3ebszxvsKchssZnPwrLxLNXKtO3iRbJQGBp5Ldq5XTESjQp9e+WiOcgG39w4
         PMMA45H28z6HMLkNS7hZBwfIR7Mdpudne8srHd3wArXD1jFUCVaPWpIjRNFAibY66df6
         /zXrGILtyfeqyAGm6PJk9ZKIB04m5mbx/CteBycZVf8bSeGwL07BsO6BMrQZfOU7QT0Y
         6ZoFzecWlCynjyKEh5Dz6TaglM+zFopgPMQ6OVr5q4Bxng2Io22eLsFi1mhQEl8bzU1N
         JcUw==
X-Gm-Message-State: AOAM532qZvUK16UzGny4Odg/p4L+/5Pdz8yBVLUSDE1w/OsPzpYAp9bK
        fDoISUnKzZMS3X183C+zQYpSr1xDe2PD93orQZ0=
X-Google-Smtp-Source: ABdhPJwDxMHP0IkOGxFap2RTf2cnVE9AHI228gO5l/l0V9RmqWOeSM9M4liwZOxkXXXZDtiVphrxEUuIBDiaHoluwEs=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr54554275qvd.52.1641490464220;
 Thu, 06 Jan 2022 09:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20220106074306.2712090-1-ray.huang@amd.com>
In-Reply-To: <20220106074306.2712090-1-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jan 2022 18:34:13 +0100
Message-ID: <CAJZ5v0iHo9JMggbJmyFL9XoWS2oTWSugbMtD_C2OBHpmw+ePCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Fix the dependence issue of AMD P-State
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 8:43 AM Huang Rui <ray.huang@amd.com> wrote:
>
> The AMD P-State driver is based on ACPI CPPC function, so ACPI should be
> dependence of this driver in the kernel config.
>
> In file included from ../drivers/cpufreq/amd-pstate.c:40:0:
> ../include/acpi/processor.h:226:2: error: unknown type name ‘phys_cpuid_t’
>   phys_cpuid_t phys_id; /* CPU hardware ID such as APIC ID for x86 */
>   ^~~~~~~~~~~~
> ../include/acpi/processor.h:355:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
>  phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
>  ^~~~~~~~~~~~
>  phys_addr_t
>   CC      drivers/rtc/rtc-rv3029c2.o
> ../include/acpi/processor.h:356:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
>  phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
>  ^~~~~~~~~~~~
>  phys_addr_t
> ../include/acpi/processor.h:357:20: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
>  int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
>                     ^~~~~~~~~~~~
>                     phys_addr_t
>
> See https://lore.kernel.org/lkml/20e286d4-25d7-fb6e-31a1-4349c805aae3@infradead.org/.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index a951768c3ebb..55516043b656 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -36,9 +36,9 @@ config X86_PCC_CPUFREQ
>
>  config X86_AMD_PSTATE
>         tristate "AMD Processor P-State driver"
> -       depends on X86
> -       select ACPI_PROCESSOR if ACPI
> -       select ACPI_CPPC_LIB if X86_64 && ACPI
> +       depends on X86 && ACPI
> +       select ACPI_PROCESSOR
> +       select ACPI_CPPC_LIB if X86_64
>         select CPU_FREQ_GOV_SCHEDUTIL if SMP
>         help
>           This driver adds a CPUFreq driver which utilizes a fine grain
> --

Applied (under a modified subject), thanks!
