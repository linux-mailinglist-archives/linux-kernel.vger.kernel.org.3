Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19D45607CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiF2Rx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiF2RxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:53:20 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16561FCF4;
        Wed, 29 Jun 2022 10:53:19 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31780ad7535so155619297b3.8;
        Wed, 29 Jun 2022 10:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1liYLQU8cdNAjp5w6VPZ5Hc0pQCTqK8+fYV8wkB3Mo=;
        b=GDRkUZOO/nU/2Iy6ztnW6Yfsvy0ZTc0eSPFhVhcKSGr5lYsNGZw8Ex5vDZeBSVHyPr
         qp5KYEjeZMxqMe58MjUA7VsNplxT/aCQkEYFX4PTFYyyIe+tPxusIqJubQ8D5zeijrVZ
         INHXlBd6XFjOyyBVMD6uEFXLEpfaWUC6HXplEuLKOW49b8yre1DSJgcYIywMWf0X5gRw
         5CIsklJfylVYfg4v8zQ4XlsRZLVY9pyOfj9NmSVMSOZhwQyfIVqGO7lCCRtoM4gNu1M1
         TZQqwRVeC26Xra/8PpBYHykYTZwcwfU+AeU4w62imJQN73CtZCaBFirHD6T347n+PVmc
         KcVA==
X-Gm-Message-State: AJIora/SgdiUshl7YWHQ/iyExMhhGmdujs7OeM8GoH2XumwnQooUCeJg
        JdwR/fOY3hTOad5JDN3wpuHz6lRL33Sbi8NyGc+rpTnl
X-Google-Smtp-Source: AGRyM1svcTZDhkLwToOIp/jO3UxgaPuVplQ4ZmGkGYGpPLQzXal5w8OEq+BEscgAA3R4l6AaRYr7OGUGbTFlGdQIAKM=
X-Received: by 2002:a0d:c486:0:b0:31c:3b63:91fe with SMTP id
 g128-20020a0dc486000000b0031c3b6391femr358878ywd.7.1656525198833; Wed, 29 Jun
 2022 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220622074248.19004-1-limanyi@uniontech.com>
In-Reply-To: <20220622074248.19004-1-limanyi@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:53:07 +0200
Message-ID: <CAJZ5v0hGEvw6quaK9oh4Qc2A4ggA68Y0ycBMrEfJ7EDZS=E4bA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: save NVS memory for Lenovo G40-45
To:     Manyi Li <limanyi@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 9:43 AM Manyi Li <limanyi@uniontech.com> wrote:
>
> [821d6f0359b0614792ab8e2fb93b503e25a65079] is to make machines
> produced from 2012 to now not saving NVS region to accelerate S3.
>
> But, Lenovo G40-45, a platform released in 2015, still needs NVS memory
> saving during S3. A quirk is introduced for this platform.
>
> Signed-off-by: Manyi Li <limanyi@uniontech.com>
> ---
>  drivers/acpi/sleep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 04ea1569df78..974746e6e59d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -360,6 +360,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
>                 },
>         },
> +       {
> +       .callback = init_nvs_save_s3,
> +       .ident = "Lenovo G40-45",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "80E1"),
> +               },
> +       },
>         /*
>          * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
>          * the Low Power S0 Idle firmware interface (see
> --

Applied as 5.20 material, thanks!
