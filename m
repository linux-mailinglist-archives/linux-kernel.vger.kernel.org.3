Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD01573306
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiGMJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiGMJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:40:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38990F54F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657705218; x=1689241218;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=815LDDHeJET7o6zA0V9+5kqIbTL0axArBicw5uHazm0=;
  b=QF1TwcBya4ain1vu+q4OwDCcWbGL8kVbaduTSB3XGPYqtcFnnCfPnN7M
   c/2FwCvHcJfpCS+Mo+iT1Ge2koRZBlStdaKiAZ4lu4Sg3AkovOc6BSpBb
   b74zzYx7ZECkjTmjj20On297C1XaGS7tPhyLbnTfnWYVjSCr0hMaRrrJz
   TN2lmvAvwNNAaw/jQfvQEJ7u0kmZHzRMfSrZ3OwevADJD6ECdUafXGIYH
   nctgSFv5W2p9T7Cg8y3hhh/GsHwrj/5Sfd10yEFAawxd9kosGql2iCMY6
   GJi4wmxJAw/yFbHH8Ad0LFtpXx03wHFLHgtc3v1sMfOisx6/TPXXqdEMT
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="164520175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 02:40:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 02:40:17 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 02:40:15 -0700
Message-ID: <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Michael Walle <michael@walle.cc>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Date:   Wed, 13 Jul 2022 11:40:14 +0200
In-Reply-To: <73dc6fcedebcae098751bd093fe2d028@walle.cc>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
         <73dc6fcedebcae098751bd093fe2d028@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I am afraid that the exact list of affected modules is not available, so us=
ing the
RESET_PROT_STAT.SYS_RST_PROT_VCORE bit is the best known way of resetting a=
s much as possible, and
still continue execution.

This is what the Sparx5 datasheet has to say about the SYS_RST_PROT_VCORE p=
rotect bit:

The device can be soft-reset by writing SOFT_RST.SOFT_CHIP_RST. The VCore s=
ystem and CPU can be
protected from a device soft-reset by writing RESET_PROT_STAT.SYS_RST_PROT_=
VCORE =3D 1 before
initiating soft-reset.=C2=A0

In this case, a chip-level soft reset is applied to all other blocks except=
 the VCore system and the
VCore CPU. When protecting the VCore system and CPU from a soft reset, the =
frame DMA must be
disabled prior to a chip-level soft reset. The SERDES and PLL blocks can be=
 protected from reset by
writing to SOFT_RST.SOFT_SWC_RST instead of SOFT_CHIP_RST.

The VCore general purpose registers (CPU::GPR) and GPIO alternate modes (DE=
VCPU_GCB::GPIO_ALT) are
not affected by a soft-reset. These registers are only reset when an extern=
al reset is asserted.

BR
Steen

On Wed, 2022-07-13 at 11:03 +0200, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> [+ Claudiu, Kavyasree ]
> Am 2022-07-13 10:40, schrieb Philipp Zabel:
> > This reverts commit b6b9585876da018bdde2d5f15d206a689c0d70f3.
> >=20
> > This breaks MDIO on kswitch-d10, presumably because the global switch
> > reset is not released early enough anymore.
> >=20
> > Reported-by: Michael Walle <michael@walle.cc>
> > Cc: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Thanks!
>=20
> Tested-by: Michael Walle <michael@walle.cc>
>=20
> And maybe Microchip can chime in here and tell us what
> subsystems in the SoC will actually be reset by this.
> I fear this reset will affect almost every part of the
> SoC. So it would have to be bound to every single
> device? Or maybe adding that reset to the switch driver
> was a mistake in the first place?
>=20
> I mean, if it wouldn't be for the guard bit, it would
> also reset the CPU core..
>=20
> -michael

