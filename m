Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7366B573C91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiGMSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiGMSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:33:21 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA815830;
        Wed, 13 Jul 2022 11:33:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id p129so20747040yba.7;
        Wed, 13 Jul 2022 11:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWjRY66Dd3VvPH0b0UVWnpuY2Ub93GEIDqqzGeA91TA=;
        b=lJ94ZcuGUV3bY4sS5oYxuWmfz8Q+xsXRPAQUlbONgrrJzLMc0kIHvKbH54unKBxYtf
         NYzneV6ckt6bMDOreaNjqjwaeqWruMqGbAmfmsGRdVP2uSpJmKJMjp83IzwAM6HW9Nv4
         pldFA7GYn6UjHVwVsWRbpnwVAk8/AXqQu8bJTLCRJKuTQDq76mNY0A4sy8q3QeIdZeSf
         9C/ECGLKGTMgRL4W0wAjvuboO4ZMOMoqcq2GMGeY3XoEKGDNE5No0MSQT6RnH802evOk
         JulDztujUMm1pyK2JHrBCvhs2GQGBWO2b3tCyE4P7ycKaQvFjH17Onx6r4RRwJ9gtAxY
         ndbA==
X-Gm-Message-State: AJIora+u3uwNnD/3pORjh4R2qt5vEbXgMZFbcB8TH5tt6/lIDiyGiN8i
        b1cA3Nv5jKXjB93wvHpRrrPxjHhNyVpmIA04gQ2qPyqv
X-Google-Smtp-Source: AGRyM1slsQQhyyLQWzRsKVIZ4Ct+edEiIkC65mp+GEJxWFn/6ef1OImmjIeVjq9V4TQZgCskxVfKZjpGTYJ05I/1/60=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr4967139ybg.633.1657737200312; Wed, 13
 Jul 2022 11:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220701023328.2783-1-mario.limonciello@amd.com> <20220701023328.2783-2-mario.limonciello@amd.com>
In-Reply-To: <20220701023328.2783-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 20:33:09 +0200
Message-ID: <CAJZ5v0isKcnm-xEHok1UeAdFJtRzi62SKXEUmNCVM+bdtsWRoQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] ACPI / x86: Use new `pm_suspend_preferred_s2idle`
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 4:33 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Drop the direct check from the FADT and use the helper instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2963229062f8..b1483d5092c1 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -369,7 +369,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>         if (lps0_device_handle)
>                 return 0;
>
> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +       if (!pm_suspend_preferred_s2idle())

This needs to be checked in a different place in this function.

Let me cut a patch for that.

>                 return 0;
>
>         if (acpi_s2idle_vendor_amd()) {
> --
