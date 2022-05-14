Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9A526F05
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiENCgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiENCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:36:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3887466F04
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:38:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o130so2401882ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py2sBia6KCgnjUPnf4BnYoNjPVjFUOkjSMfyVSuwTa4=;
        b=Zuhm1QP5kn11DK5lpcZ6HgHrw52uvK16p/JqfBw3k70ts6FU7xn1WeYAhPcGT1Qtwl
         8d2fj00zlfDLMC3A+DbJcT7xDGL5CbPvb6IcG4juzSUsZ2dKFgzSPg0C/xczcwX2djkF
         vEy08oX1KZBuO2tf0pAFUyZXQqgw+LK1K/6uVgM4xMHgWV4HTYVEy1Z4RPcnxrgkwPwH
         3dIwO1DQkPGO1RHhj8e0P0hHQJvClAK2UszoeZTasTtf38UDBNKMqTYN4KEmA+suaI0z
         Hu8KZI7/mW6j+xRt7Yx7KZGwAgNY6goVFeZoJikDYihGSSuXUM1RfZ9MiXvCgg13QpYm
         5y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py2sBia6KCgnjUPnf4BnYoNjPVjFUOkjSMfyVSuwTa4=;
        b=UEGqlsYMd+PB9zVE8aGUHREhL/yLFMmGQf5hVxyp/7jJ9mbJXTCzgjvBiLVpBNvpIT
         xshPudHhbnL6r/7O6zwqJA6s51dQpJvgiigAZOx8Hev1+bUjTYXSxN5ywIFvxzxJlzNF
         S31MaFZ7PH203g7p78Bc6xzbsc9x6gNMbtybHDSoEI8LszadAwnNIP0esbzN2/oL5p4e
         s5CpxTAMQT9HnPEOmT8q6r1q1d5XG6qlwH4NfBMhLyXhSWLNAGkIULBdwfm3JZ1i2XZ+
         LUZGAusa44txVYd5C74Lk1KfpkS5LraSebcOUw+jJcisHPmT77tqTwkQE42G2mW7lV0E
         i/Ig==
X-Gm-Message-State: AOAM533BIlYqRuaz3gNiq/bSfE/4m0lgwWra4qUmfBizaoF1qWS9XkTa
        GQzwD/wlJPwGGuXcKRvkzfFA04Y00zuCI1QeUk03Bu/ufXM=
X-Google-Smtp-Source: ABdhPJyYXDXmPRwsG4uGpbG+svQYxJMo3bACygxmD2ctNbvlZzIp+bvDIoDk+YyNUuTEK9Y4msMJHBFJia4AYJzRhss=
X-Received: by 2002:a81:2414:0:b0:2f4:e1d8:810a with SMTP id
 k20-20020a812414000000b002f4e1d8810amr8892836ywk.80.1652488015279; Fri, 13
 May 2022 17:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220513201243.2381133-1-vladimir.oltean@nxp.com>
In-Reply-To: <20220513201243.2381133-1-vladimir.oltean@nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 May 2022 17:26:19 -0700
Message-ID: <CAGETcx9vjrh_ORhGq0g5oH5kUE8MbcyEW4Mv9i=S8m9PLzBkhA@mail.gmail.com>
Subject: Re: [RFC PATCH devicetree] of: property: mark "interrupts" as
 optional for fw_devlink
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
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

On Fri, May 13, 2022 at 1:13 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> I have a board with an Ethernet PHY whose driver currently works in poll
> mode. I am in the process of making some changes through which it will
> be updated to use interrupts. The changes are twofold.
>
> First, an irqchip driver needs to be written, and device trees need to
> be updated. But old kernels need to work with the updated device trees
> as well. From their perspective, the interrupt-parent is a missing
> supplier, so fw_devlink will block the consumer from probing.
>
> Second, proper interrupt support is only expected to be fulfilled on a
> subset of boards on which this irqchip driver runs. The driver detects
> this and fails to probe on unsatisfied requirements, which should allow
> the consumer driver to fall back to poll mode. But fw_devlink treats a
> supplier driver that failed to probe the same as a supplier driver that
> did not probe at all, so again, it blocks the consumer.

This is easy to fix. I can send a patch for this soon. So, if the
driver matches the supplier and then fails the probe (except
EPROBE_DEFER), we can stop blocking the consumer on that supplier.

> According to Saravana's commit a9dd8f3c2cf3 ("of: property: Add
> fw_devlink support for optional properties"), the way to deal with this
> issues is to mark the struct supplier_bindings associated with
> "interrupts" and "interrupts-extended" as "optional". Optional actually
> means that fw_devlink will no longer create a fwnode link to the
> interrupt parent, unless we boot with "fw_devlink.strict".

The optional flag is really meant for DT properties where even if the
supplier is present, the consumer might not use it. With that
reasoning, fw_devlink doesn't wait for those suppliers to probe even
if the driver is present. fw_devlink outright ignores those properties
unless fw_devlink.strict=1 (default is = 0).
For some more context on why I added the optional flag, see Greet's
last paragraph in this email explaining IOMMUs:
https://lore.kernel.org/lkml/CAMuHMdXft=pJXXqY-i_GQTr8FtFJePQ_drVHRMPAFUqSy4aNKA@mail.gmail.com/#t

I'm still not fully sold if the "optional" flag was the right way to
fix it and honestly might just delete it.

> So practically speaking, interrupts are now not "handled as optional",
> but rather "not handled" by fw_devlink. This has quite wide ranging
> side effects,

Yeah, and a lot of other boards/systems might be depending on
enforcing "interrupts" dependency. So this patch really won't work for
those cases.

So, I have to Nack this patch. But I tried to address your use case
and other similar cases with this recent patch:
https://lore.kernel.org/lkml/20220429220933.1350374-1-saravanak@google.com/

If the time out is too long (10s) then you can reduce it for your
board (set it to 1), but by default every device that could probe will
probe and fw_devlink will no longer block those probes. Btw, I talked
about this in LPC2021 but only finally got around to sending out this
patch. Can you give it a shot please?

> for example it happens to fix the case (linked below)
> where we have a cyclic dependency between a parent being an interrupt
> supplier to a child, fw_devlink blocking the child from probing, and the
> parent waiting for the child to probe before the parent itself finishes
> probing successfully. This isn't really the main thing I'm intending
> with this change, but rather a side observation.
>
> The reason why I'm blaming the commit below is because old kernels
> should work with updated device trees, and that commit is practically
> where the support was added. IMHO it should have been backported to
> older kernels exactly for DT compatibility reasons, but it wasn't.
>
> Fixes: a9dd8f3c2cf3 ("of: property: Add fw_devlink support for optional properties")
> Link: https://lore.kernel.org/netdev/20210826074526.825517-2-saravanak@google.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Technically this patch targets the devicetree git tree, but I think it
> needs an ack from device core maintainers and/or people who contributed
> to the device links and fw_devlink, or deferred probing in general.
>
> With this patch in place, the way in which things will work is that:
> - of_irq_get() will return -EPROBE_DEFER a number of times.
> - fwnode_mdiobus_phy_device_register(), through
>   driver_deferred_probe_check_state(), will wait until the initcall
>   stage is over (simplifying a bit), then fall back to poll mode.
> - The PHY driver will now finally probe successfully
> - The PHY driver might defer probe for so long, that the Ethernet
>   controller might actually get an -EPROBE_DEFER when calling
>   phy_attach_direct() or one of the many of its derivatives.
>   This happens because "phy-handle" support was removed from fw_devlink
>   in commit 3782326577d4 ("Revert "of: property: fw_devlink: Add support
>   for "phy-handle" property"").

The next DT property I add support to would be phy-handle. But to do
so, I need to make sure Generic PHYs are probed through the normal
binding process but still try to handle the case where the PHY
framework calls device_bind_driver() directly. I've spent a lot of
time thinking about this. I have had a tab open with the phy_device.c
code for months in my laptop. It's still there :)

Once I add support for this, I can then add support for some of the
other mdio-* properties and then finally try to enable default async
boot for DT based systems.

-Saravana

> - Until the PHY probes, the Ethernet controller may call
>   phylink_fwnode_phy_connect() -> fwnode_phy_find_device(), and this
>   will return NULL with an unspecified reason. This needs to be patched
>   to return -EPROBE_DEFER instead of -ENODEV until
>   driver_deferred_probe_check_state() says otherwise
> - Even so, some drivers like DSA treat PHY connection errors as "soft"
>   and continue probing. This is problematic because an -EPROBE_DEFER
>   coming from the PHY will result in a missing net_device. What we want
>   is to fix the backpressure all the way to the Ethernet controller
>   probing.
>
> This is to say, don't expect that all things start working just with
> this single change. I'm copying some Ethernet driver maintainers as a
> heads up about this fact, and my plan to address the other issues until
> the above works.
>
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 8e90071de6ed..a9ceb02e00d9 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1393,7 +1393,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_leds, },
>         { .parse_prop = parse_backlight, },
>         { .parse_prop = parse_gpio_compat, },
> -       { .parse_prop = parse_interrupts, },
> +       { .parse_prop = parse_interrupts, .optional = true, },
>         { .parse_prop = parse_regulators, },
>         { .parse_prop = parse_gpio, },
>         { .parse_prop = parse_gpios, },
> --
> 2.25.1
>
