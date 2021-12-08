Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCCC46D681
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhLHPOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:14:37 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33385 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhLHPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:14:35 -0500
Received: by mail-oo1-f42.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so921878ooe.0;
        Wed, 08 Dec 2021 07:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO8jIk5TnTHmrDV73LLWIJ3K9m3LY+NFIWxlzAYiSiw=;
        b=NtpIeiGVKkKBtjeid5VCorefFOljJo3HPpg/PQTv3j7Twc58xH3U9Tei1ij2316REI
         0EA2LAo2/HCsZNmXu/FEtOtUjct4q33lllaTN9kCKJNfSuC2lNBzSw66TvAC8jcQVjoO
         V0V2FRzvp+PuvUJllOtihYLT78xH9jcw6XTmfPrAjTlG8wI5v3y+7ZZodiVpFJq0I1rH
         mPQ6GLUbhly/TWLmEPHX4VTA4f1dof6sZc9WJk4OTSZptSkQKZheqo3KygvOjiO93Nqi
         Fyn5ogrqRJynGNaOgvEy7ZECrDdnOcT3gfKY77IZ+PoFyhb8r6HX1YA2Ik6rF2OgWKN/
         3bvA==
X-Gm-Message-State: AOAM532ru77fFOT6jEMq1vRnHmFZ6qYUgZQ1F92qIuuxMWKM3Fv80WkT
        nc1jkStE6ZvzZ4zlAjrM7RfW3P9iAj58kh7h25A=
X-Google-Smtp-Source: ABdhPJwOPtLLKR6JsuLNFjDDiMh8dviA2TAjULBFufeTuyAFEU+g+Q5Av2J5POgnu99rAMadn1XWNFi/9pxKAS7Vrgw=
X-Received: by 2002:a4a:1d82:: with SMTP id 124mr27693oog.91.1638976263344;
 Wed, 08 Dec 2021 07:11:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20211206122952.74139-5-kirill.shutemov@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 16:10:52 +0100
Message-ID: <CAJZ5v0iH_CQC-ak_NQC5yONT-tFVC1iikSsfVWFh+z+QL5FKdg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: PM: Avoid cache flush on entering S4
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
> According to the ACPI spec v6.4, section 16.2 the cache flushing
> required on entering to S1, S2, and S3.
>
> No need to flush caches on hibernation (S4).
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 14e8df0ac762..8166d863ed6b 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -902,8 +902,6 @@ static int acpi_hibernation_enter(void)
>  {
>         acpi_status status = AE_OK;
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         /* This shouldn't return.  If it returns, we have a problem */
>         status = acpi_enter_sleep_state(ACPI_STATE_S4);
>         /* Reprogram control registers */
> --

Applied (with some edits in the subject and changelog) as 5.17 material, thanks!
