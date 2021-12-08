Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2E46D648
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhLHPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:02:12 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36683 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhLHPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:02:09 -0500
Received: by mail-oi1-f176.google.com with SMTP id t23so4492178oiw.3;
        Wed, 08 Dec 2021 06:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYgHMZyP/SCresb9+R/6+9a+5haS0Ujj/DJvPk9PiVU=;
        b=Jsrh8Xb/rlKz7q8oBpVQhX+svRWmoYrg5NttbPzaTpBM0jKuvvBRzcIppzwy/X4Z4h
         Wy2lbV2Givs2fTExb/VUJp0PwePPBlcz8Y7ov1ySHFI/uKMQnWo7fMcxJ9TWAedRyn8A
         HZNwCGQvh46qx9hdbTvt3HNAYVAD9ObCtKIhqf5dLvyciFkpmy4cRrtnv9hiWhHLeepS
         wQaXiW4OmtLd/N77YhT+3WsYmwS/nAJ8AH5SMZCxB2HHEme055dG18cGFmDSoW+BiZeU
         pwmcub/va9+LDXowVzrCfr5pZAdH0Y7WJOSSBgtHacaUviDFrVpoIrihac0IHU5quVKx
         NJRg==
X-Gm-Message-State: AOAM53244/L6fgJczoeXqTcxWmrwVmGmct04yoXnF8Mav42vg9dIHR5C
        Jg3UJo8qEIxdOscccfaHh+PxVUBjhZsSvYc4qm4i7iof
X-Google-Smtp-Source: ABdhPJzJLywQoA8bmDyhHvJ14lg4mSgPhruhShHGSHHoBi0bd0BNCOXk+BeElaOWsKWqMPX8ftAfkd67Ps38ExQYCcw=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr12009677oih.51.1638975517572;
 Wed, 08 Dec 2021 06:58:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20211206122952.74139-2-kirill.shutemov@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 15:58:26 +0100
Message-ID: <CAJZ5v0g4bCYJHrbWXrQWwhYa9QNCAFfia4gB6e7PWWXeuVycAQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: Do not flush cache for on entering S4 and S5
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 1:30 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> According to the ACPI spec v6.4, section 16.2 the cache flushing is
> required on entering to S1, S2, and S3. ACPICA code flushes cache
> regardless of the sleep state.
>
> Blind cache flush on entering S5 causes problems for TDX. Flushing
> happens with WBINVD that is not supported in the TDX environment.
>
> TDX only supports S5 and adjusting ACPICA code to conform to the spec
> fixes the issue.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I've converted this patch to the upstream ACPICA code base format and
submitted a pull request with it to the upstream project.

Thanks!

> ---
>  drivers/acpi/acpica/hwesleep.c  | 3 ++-
>  drivers/acpi/acpica/hwsleep.c   | 3 ++-
>  drivers/acpi/acpica/hwxfsleep.c | 2 --
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
> index 808fdf54aeeb..ceb5a4292efa 100644
> --- a/drivers/acpi/acpica/hwesleep.c
> +++ b/drivers/acpi/acpica/hwesleep.c
> @@ -104,7 +104,8 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
>
>         /* Flush caches, as per ACPI specification */
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (sleep_state < ACPI_STATE_S4)
> +               ACPI_FLUSH_CPU_CACHE();
>
>         status = acpi_os_enter_sleep(sleep_state, sleep_control, 0);
>         if (status == AE_CTRL_TERMINATE) {
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index 34a3825f25d3..ee094a3aaaab 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -110,7 +110,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>
>         /* Flush caches, as per ACPI specification */
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (sleep_state < ACPI_STATE_S4)
> +               ACPI_FLUSH_CPU_CACHE();
>
>         status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
>         if (status == AE_CTRL_TERMINATE) {
> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> index e4cde23a2906..ba77598ee43e 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -162,8 +162,6 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
>                 return_ACPI_STATUS(status);
>         }
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
>                                     (u32)acpi_gbl_FADT.s4_bios_request, 8);
>         if (ACPI_FAILURE(status)) {
> --
> 2.32.0
>
