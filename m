Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763A24792B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhLQRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:19:41 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36472 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbhLQRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:19:30 -0500
Received: by mail-ot1-f42.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so3732980otl.3;
        Fri, 17 Dec 2021 09:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Zx+iGaRJx7HOeobGJtBFJYWR+l1UjgQTuzqvPExFxA=;
        b=OBKyvldax38jIlnpPKhTu9pbhs2ZETjR7ogsPt3bO3Ymd46sSl57RxVPjCgmT1mEKX
         UNUOxcwoR9PU2lRjIAK6AveJ+Bi+xipAk03oCKATotrUZRVqTcQUz9PQdYhbxJ6bf9QB
         qj1SRf6RXsL60ShJXqgXDPWsDM68mF8NJdVItTw7wApSRFnntebdVnAiHHgJdP4cN18k
         ihVHiIlB2ntJ8wpPWZZXFhJCrjaWz1pTGP59aVbJkOA0YEpSq1Nb0sK0TdAM1xJj+ksV
         CqjhxdVnN7PAFB/MEon1I83NUkWkNLoYzxM0i79GP0ygm0uIijztHk73/57kgnurlJr9
         3U9w==
X-Gm-Message-State: AOAM5328tmSprvYRfpn48pOrg6ranNKvtWyz+WDx9TOTHXqYaQGTzs9s
        dbnUo5ic3im3fTL8jHhyKbRDrE12u37i4G+1jS8=
X-Google-Smtp-Source: ABdhPJztoPqn/1Su9cfXcuaCyeozUoTqwJGGdS30ToTcoGqzV+VCNtcC4Lcb+2ReZtjWo+NLFWB5n59F2HXnfpyLmtU=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2958544otu.254.1639761569499;
 Fri, 17 Dec 2021 09:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com> <20211217115708.882525-9-tanureal@opensource.cirrus.com>
In-Reply-To: <20211217115708.882525-9-tanureal@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 18:19:18 +0100
Message-ID: <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for CLSA0100
 and CSC3551 ACPI nodes
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:57 PM Lucas Tanure
<tanureal@opensource.cirrus.com> wrote:
>
> The ACPI device with CLSA0100 or CSC3551 is a sound card
> with multiple instances of CS35L41 connectec by I2C to

"connected" I suppose?

> the main CPU.
>
> We add an ID to the i2c_multi_instantiate_ids list to enumerate
> all I2C slaves correctly.
>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>

This requires an ACK from Hans.

If you receive one, please feel free to add my ACK to it too.

Thanks!

> ---
>  drivers/acpi/scan.c                          |  3 +++
>  drivers/platform/x86/i2c-multi-instantiate.c | 11 +++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b7a6b982226e..8740cfa11f59 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1712,8 +1712,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>                 {"BSG1160", },
>                 {"BSG2150", },
> +               {"CSC3551", },
>                 {"INT33FE", },
>                 {"INT3515", },
> +               /* Non-conforming _HID for Cirrus Logic already released */
> +               {"CLSA0100", },
>                 {}
>         };
>
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 4956a1df5b90..a889789b966c 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -147,6 +147,14 @@ static const struct i2c_inst_data int3515_data[]  = {
>         {}
>  };
>
> +static const struct i2c_inst_data cs35l41_hda[] = {
> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +       {}
> +};
> +
>  /*
>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -154,7 +162,10 @@ static const struct i2c_inst_data int3515_data[]  = {
>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>         { "BSG1160", (unsigned long)bsg1160_data },
>         { "BSG2150", (unsigned long)bsg2150_data },
> +       { "CSC3551", (unsigned long)cs35l41_hda },
>         { "INT3515", (unsigned long)int3515_data },
> +       /* Non-conforming _HID for Cirrus Logic already released */
> +       { "CLSA0100", (unsigned long)cs35l41_hda },
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> --
> 2.34.1
>
