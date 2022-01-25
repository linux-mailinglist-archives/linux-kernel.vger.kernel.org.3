Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6949AC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiAYGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346935AbiAYFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:16:29 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C26C02B87A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:42:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q204so7584816iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZO9IWfCaPNvDnddtd3qJzYE26vaQYc0Zp3E/Qjx4ylc=;
        b=YiECLlECJ+eIBubs9DaUHuzI+HyQpIufpAStNpfFZSpaL19BAH0H2bdBfrLFlwc9iD
         d+c7jNS8+8WoXNgewdqPmL1XjdW0mN2BxWQgo8g3pPTWZ1Hxux3ZVO0ljdzzrUu5J/1/
         7kV7HKSk/+ULaQMAfSw2ZmU3Gfr990cigj1ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZO9IWfCaPNvDnddtd3qJzYE26vaQYc0Zp3E/Qjx4ylc=;
        b=vcZm1tNeHmUUCN3c7pSly7ofnwrJargBqOSmj2FBkC4+ngnUZxEIMTKyJd2mQJrmPI
         +lnlzWGOZLaN+LV83VcpB8/o7Ne1xP/e+NTecC4iDjYrbNWM5JHU6dXacbxvP2Qaheva
         hZsftMPvBHpbqb3JpeOkqosE+psvsCPh+xUUIcqwUtfIP1Ha3vRRloOm9cQlAfNK/zxO
         0+LgAAwdhqGxfaOoMJt3jABJiA7CiqmJWmM5hl1nlqrxXH/yGICzFLuS8qFk+uP61820
         Vr98HDWQNd2GoNiyV/yxReb0hTXczjc75AoSEkrayueiV4iAkhwIExl0HZlCLpHBOzLv
         /Ktg==
X-Gm-Message-State: AOAM531vLPut/zK7/fsZyq8IHYv1XZF36JPSu1uDV+Osy7RWDh2UeSZX
        8dpswQdPIrZRvXZLTNxzlSIADctpVf5Yuenqd1+NHcSpewaoPQ==
X-Google-Smtp-Source: ABdhPJy5sevDMqGESgc8mpL1cSyFr48cmsbV/2arf3uYOAp8dr7Yk2KBh5J1Wwgr+N7sLLs2l4sQweJAcAuL/Bx7eGs=
X-Received: by 2002:a6b:ba05:: with SMTP id k5mr10036122iof.194.1643082160079;
 Mon, 24 Jan 2022 19:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <20220105031242.287751-3-dustin@howett.net>
In-Reply-To: <20220105031242.287751-3-dustin@howett.net>
From:   Tzung-Bi Shih <tzungbi@chromium.org>
Date:   Tue, 25 Jan 2022 11:42:29 +0800
Message-ID: <CALtnz63d7utST13=S7UbExDzSE0GnoFA7JowQkkFSqrSUTmCdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: reserve only the I/O ports required
 for the MEC EC
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:35 AM Dustin L. Howett <dustin@howett.net> wrote:
>
> Some ChromeOS EC devices (such as the Framework Laptop) only map I/O
> ports 0x800-0x807. Making the larger reservation required by the non-MEC
> LPC (the 0xFF ports for the memory map, and the 0xFF ports for the
> parameter region) is non-viable on these devices.
>
> Since we probe the MEC EC first, we can get away with a smaller
> reservation that covers the MEC EC ports. If we fall back to classic
> LPC, we can grow the reservation to cover the memory map and the
> parameter region.
>
> Signed-off-by: Dustin L. Howett <dustin@howett.net>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c         | 39 ++++++++++++-------
>  .../linux/platform_data/cros_ec_commands.h    |  4 ++
>  2 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 458eb59db2ff..06fdfe365710 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -341,9 +341,14 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>         u8 buf[2];
>         int irq, ret;
>
> -       if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> -                                dev_name(dev))) {
> -               dev_err(dev, "couldn't reserve memmap region\n");
> +       /*
> +        * The Framework Laptop (and possibly other non-ChromeOS devices)
> +        * only exposes the eight I/O ports that are required for the Microchip EC.
> +        * Requesting a larger reservation will fail.
> +        */
> +       if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> +                                EC_HOST_CMD_MEC_REGION_SIZE, dev_name(dev))) {
> +               dev_err(dev, "couldn't reserve MEC region\n");
>                 return -EBUSY;
>         }
>
> @@ -357,6 +362,12 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>         cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
>         cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>         if (buf[0] != 'E' || buf[1] != 'C') {
> +               if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> +                                        dev_name(dev))) {
> +                       dev_err(dev, "couldn't reserve memmap region\n");
> +                       return -EBUSY;
> +               }
> +
>                 /* Re-assign read/write operations for the non MEC variant */
>                 cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
>                 cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
> @@ -366,17 +377,19 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>                         dev_err(dev, "EC ID not detected\n");
>                         return -ENODEV;
>                 }
> -       }
>
> -       if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> -                                EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> -               dev_err(dev, "couldn't reserve region0\n");
> -               return -EBUSY;
> -       }
> -       if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> -                                EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> -               dev_err(dev, "couldn't reserve region1\n");
> -               return -EBUSY;
> +               /* Reserve the remaining I/O ports required by the non-MEC protocol. */
> +               if (!devm_request_region(dev, EC_HOST_CMD_REGION0 + EC_HOST_CMD_MEC_REGION_SIZE,
> +                                        EC_HOST_CMD_REGION_SIZE - EC_HOST_CMD_MEC_REGION_SIZE,
> +                                        dev_name(dev))) {
> +                       dev_err(dev, "couldn't reserve remainder of region0\n");
> +                       return -EBUSY;
> +               }
> +               if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> +                                        EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> +                       dev_err(dev, "couldn't reserve region1\n");
> +                       return -EBUSY;
> +               }
>         }
>
>         ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 271bd87bff0a..a85b1176e6c0 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -55,6 +55,10 @@
>  #define EC_HOST_CMD_REGION0    0x800
>  #define EC_HOST_CMD_REGION1    0x880
>  #define EC_HOST_CMD_REGION_SIZE 0x80
> +/*
> + * Other machines report only the region spanned by the Microchip MEC EC.
> + */
> +#define EC_HOST_CMD_MEC_REGION_SIZE 0x08
>
>  /* EC command register bit functions */
>  #define EC_LPC_CMDR_DATA       BIT(0)  /* Data ready for host to read */
> --
> 2.34.1
>
>
