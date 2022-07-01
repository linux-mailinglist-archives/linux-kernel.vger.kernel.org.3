Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377EA562C37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiGAHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiGAHDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:03:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4B677F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:02:59 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3176b6ed923so14527707b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Oxpr/H6WS/cbatfKxunj+Rm+HXq43uwJ9TOx0tf4pg=;
        b=G4+aGmI06EueqwK7C5Qo4w/41Yp3wU/CWyAMnimOU3r1x56NK0xwWd5NnQsEtkPJT1
         j1wWR6jutsCmi+xE7hxYUqJNrQrMI+GL07X5ZYgIgqDAqQnMWhF8y5nc40xNPfhYS3jC
         0nJhLPxfL1eyodYvq4oKHJFLeueGwA5XPbFVGoQA05bmNWxXq8PGbVqamZrTZs9J6qBh
         1fRZx/U4bPFmJBSVu1knm/cNESUDsxYs6X7kurTJA14GFNtyIPF26073epdL9z6eSE2L
         X78efI4BN3icU+xkSEEQMO42kPgo3k8M7uVN2JrWdQyoK9p0Z0nOVmWHNbnRgASj9y0m
         xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Oxpr/H6WS/cbatfKxunj+Rm+HXq43uwJ9TOx0tf4pg=;
        b=vhlVM8Ew5TDDfbPV7AvqYvq6QXhUYYxpxqCJ+M0SeuqbrE0+6DqERJjT8InvWqEMDb
         AiXuOi5liEYq9EClasL5H/+ud0Nz/TXzIT/hcj7ETo4U8IPzN4Cacg3ee5v09rgSSHLn
         usDwqV6b93foqfjDx+wvf/d0AorAbHmiPo4uZRX0GFtJwrv0MFVaMhE4whLmV9eD5Cxj
         fqcYi+47KCYWR2R6Y86Rnr6z9EZLnpiT3V1YktsVwlq/zu9/FW6zMu8mthzfy4e9pgk5
         pGEv6ML9ishz/lJMJ2fQ5fY1yitpdGR0StfsmjZc1Ftd0nOfOx/rwGM5mjNndRpoFI+U
         1Mtw==
X-Gm-Message-State: AJIora/FiPkut/3UmnEUlxnyQ7c/Yot8Ui1BQazAH0c+0O3UCfE2nXwE
        0CEIicIeDw3mWsiEfZcuuz1/MbukPp5NXf+KeJ7wgw==
X-Google-Smtp-Source: AGRyM1sjHYE6b1ihEm8EzVroyoytiPu2X1qfGuWU3WGWHfolVcCLEjpB4ZdcYExvwYNCmCj3ip+B1gZf6PvcXiQN0KE=
X-Received: by 2002:a81:4896:0:b0:317:f767:95f8 with SMTP id
 v144-20020a814896000000b00317f76795f8mr15214195ywa.218.1656658978077; Fri, 01
 Jul 2022 00:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <4799738.LvFx2qVVIh@steina-w> <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
 <5265491.31r3eYUQgx@steina-w>
In-Reply-To: <5265491.31r3eYUQgx@steina-w>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Jul 2022 00:02:22 -0700
Message-ID: <CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:02 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Saravana,
>
> Am Freitag, 1. Juli 2022, 02:37:14 CEST schrieb Saravana Kannan:
> > On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi,
> > >
> > > Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> > > > Hi,
> > > >
> > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > > "power-domains" property, the execution will never get to the point
> > > > > where driver_deferred_probe_check_state() is called before the
> > > > > supplier
> > > > > has probed successfully or before deferred probe timeout has expired.
> > > > >
> > > > > So, delete the call and replace it with -ENODEV.
> > > >
> > > > Looks like this causes omaps to not boot in Linux next. With this
> > > > simple-pm-bus fails to probe initially as the power-domain is not
> > > > yet available. On platform_probe() genpd_get_from_provider() returns
> > > > -ENOENT.
> > > >
> > > > Seems like other stuff is potentially broken too, any ideas on
> > > > how to fix this?
> > >
> > > I think I'm hit by this as well, although I do not get a lockup.
> > > In my case I'm using
> > > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts and probing of
> > > 38320000.blk-ctrl fails as the power-domain is not (yet) registed.
> >
> > Ok, took a look.
> >
> > The problem is that there are two drivers for the same device and they
> > both initialize this device.
> >
> >     gpc: gpc@303a0000 {
> >         compatible = "fsl,imx8mq-gpc";
> >     }
> >
> > $ git grep -l "fsl,imx7d-gpc" -- drivers/
> > drivers/irqchip/irq-imx-gpcv2.c
> > drivers/soc/imx/gpcv2.c
> >
> > IMHO, this is a bad/broken design.
> >
> > So what's happening is that fw_devlink will block the probe of
> > 38320000.blk-ctrl until 303a0000.gpc is initialized. And it stops
> > blocking the probe of 38320000.blk-ctrl as soon as the first driver
> > initializes the device. In this case, it's the irqchip driver.
> >
> > I'd recommend combining these drivers into one. Something like the
> > patch I'm attaching (sorry for the attachment, copy-paste is mangling
> > the tabs). Can you give it a shot please?
>
> I tried this patch and it delayed the driver initialization (those of UART as
> well BTW). Unfortunately the driver fails the same way:

Thanks for testing the patch!

> > [    1.125253] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed to
> attach power domain "bus"
>
> More than that it even introduced some more errors:
> > [    0.008160] irq: no irq domain found for gpc@303a0000 !

So the idea behind my change was that as long as the irqchip isn't the
root of the irqdomain (might be using the terms incorrectly) like the
gic, you can make it a platform driver. And I was trying to hack up a
patch that's the equivalent of platform_irqchip_probe() (which just
ends up eventually calling the callback you use in IRQCHIP_DECLARE().
I probably made some mistake in the quick hack that I'm sure if
fixable.

> > [    0.013251] Failed to map interrupt for
> > /soc@0/bus@30400000/timer@306a0000

However, this timer driver also uses TIMER_OF_DECLARE() which can't
handle failure to get the IRQ (because it's can't -EPROBE_DEFER). So,
this means, the timer driver inturn needs to be converted to a
platform driver if it's supposed to work with the IRQCHIP_DECLARE()
being converted to a platform driver.

But that's a can of worms not worth opening. But then I remembered
this simpler workaround will work and it is pretty much a variant of
the workaround that's already in the gpc's irqchip driver to allow two
drivers to probe the same device (people really should stop doing
that).

Can you drop my previous hack patch and try this instead please? I'm
99% sure this will work.

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b9c22f764b4d..8a0e82067924 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
device_node *node,
         * later the GPC power domain driver will not be skipped.
         */
        of_node_clear_flag(node, OF_POPULATED);
+       fwnode_dev_initialized(domain->fwnode, false);
        return 0;
 }

-Saravana
