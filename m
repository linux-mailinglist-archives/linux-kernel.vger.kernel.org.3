Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543653F6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiFGHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiFGHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:09:06 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD11F20192
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:09:03 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 680DB20009;
        Tue,  7 Jun 2022 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654585742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfGv0OL/piQpxMJzszkHBhvE9ywouf21874u1EEIDs0=;
        b=WPGHCQ2coYbcJho+/fJ5X+dPXDBV6uoIWxTUlvXLrZWAvxViSe9mRviRBckrd69Yt+r96o
        JWaW3/u4ivPSMN0bQWmEOaO7v8FcLbKoZjxiADddM60cfc6TTTpY16TrIa1LQ0pmWY//7H
        CBzUO/GYXylwthtBKH4on/rQ5hVwFA4ogaYNNmeIMInYoger/ivcmf8pgUCofsEoJFhU+I
        M+U7TOkUTInoO9878BiA0H3eM+HiC7jMtijXIX+nof+QrQFmRnKYoOf820DKfWw0sTL5UO
        /4vWzbqQsgpSbmTHAjpW0dTyTPcnDcDkuu5GGB3bc+lq0UWriGEKQ+CUSq1YYg==
Date:   Tue, 7 Jun 2022 09:07:59 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: add support to enter suspend
 using SMC
Message-ID: <20220607090759.3fc0b003@fixe.home>
In-Reply-To: <Yp5DpPpW5/3SnuJl@rowland.harvard.edu>
References: <20220606141802.165252-1-clement.leger@bootlin.com>
        <Yp5DpPpW5/3SnuJl@rowland.harvard.edu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 6 Jun 2022 14:12:52 -0400,
Alan Stern <stern@rowland.harvard.edu> a =C3=A9crit :

> On Mon, Jun 06, 2022 at 04:18:02PM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > When Linux is running under OP-TEE, the SFR is set as secured and thus
> > the AT91_OHCIICR_USB_SUSPEND register isn't accessible. Add a SMC to
> > do the appropriate call to suspend the controller.
> > The SMC id is fetched from the device-tree property
> > "microchip,suspend-smc-id". if present, then the syscon regmap is not
> > used to enter suspend and a SMC is issued.
> >=20
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > --- =20
>=20
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> However, this is a little weird...  You've written=20
> usb_hcd_at91_probe() so that the SMC is detected in preference to the=20
> regmap, but then you wrote ohci_at91_port_suspend() so that the regmap=20
> is used in preference to the SMC.  It's not wrong, but it is confusing=20
> to read.
>=20
> Do you want to rewrite the patch to make the two routines agree on which=
=20
> mechanism to use by default?
>=20
> Alan Stern

Hi Alan,

I'll rewrite that ! I did it in this specific order in the probe to
allow overloading the device-tree with a SMC ID without removing the
syscon property. This way, the regmap stays the default if no
"microchip,suspend-smc-id" property is provided.

Does it sounds good to you ?

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
