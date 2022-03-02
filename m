Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B054CA5AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbiCBNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiCBNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:16:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE0C3C2C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:15:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F13B81F16
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E57C004E1;
        Wed,  2 Mar 2022 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646226920;
        bh=Q4H0riTTWP2jL+cmFpHpBq4jbdqrA2hs5QRCXpPCZlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZzSCnDmB0RPLAN3jOn4eOtyld8lVAahCFIxPQZemiwSkmgsHs8PulyOqkC5mFBGjh
         Fg7MesUv2wL6EvccPozn7977rZ++P6NBj1TlBn+3qJaFtQLK5SdxxYY8eATUAKGnKh
         95gw5hlLaqAv8cUskRcQO73ZqerceqaA64k3eeULUrZny6KZT2CpLGP0BVKpB8leqz
         A8M/HAoxgbbuR1zeI10PIb7tvRH77OqGcJ2oVtkzBdyZ75MtemD7SUFx7wPafNynwF
         U1pa5I1mSRDgXyiOmhMs06SdkDopr/7gJrqWh56LJnymBPm208we7lUbhcoauuFWQt
         rYaka5pjdBQSQ==
Date:   Wed, 2 Mar 2022 14:15:15 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220302141515.51340cab@dellmb>
In-Reply-To: <Yh9ruVkK1gikOuA1@lunn.ch>
References: <20220218212526.16021-1-pali@kernel.org>
        <87o82r0zjh.fsf@BL-laptop>
        <875yoz0wpw.fsf@BL-laptop>
        <20220301092539.lru7hsaqxrjqz32r@pali>
        <Yh9ruVkK1gikOuA1@lunn.ch>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 14:06:01 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Mar 01, 2022 at 10:25:39AM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote: =20
> > > > Hello Pali,
> > > > =20
> > > >> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> > > >> device-tree in order to support legacy I/O port based cards which =
have
> > > >> hardcoded I/O ports in low address space.
> > > >>
> > > >> Some legacy PCI I/O based cards do not support 32-bit I/O addressi=
ng.
> > > >>
> > > >> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resource=
s from
> > > >> 'ranges' DT property") this driver can work with I/O windows which
> > > >> have =20
> > > >
> > > > Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
> > > > resources from 'ranges' DT property")" tag ? =20
> > >=20
> > > Waiting for your confirmation I tried to applied it but it failed.
> > >=20
> > > Did you base this patch on v5.17-rc1 ?
> > >=20
> > > Gregory =20
> >=20
> > Hello! This change is breaking booting of Turris Mox kernel with older
> > bootloader due to bugs in bootloader. =20
>=20
> Do you know what actually goes wrong?
>=20
> I've not been involved in the discussion, but looking at the comments
> above, not changing the space can result in non-working cards. So it
> does sound like something which in general we want to do. Does the
> current code assume the bootloader has initialized some registers with
> specific values? Can that be moved into the driver so it also works
> with older bootloaders?

No. TF-A may remap CPU PCIe window, and so U-Boot fixes these addresses
in device-tree. But the fixup function was at first written in such a
way that it assumes that the ranges propreties contains specific
values. The proposed DT change, together with the fixup function in
older U-Boot, will break ranges property to non-functional state.

See corresponding U-Boot patches

https://patchwork.ozlabs.org/project/uboot/patch/20200408172522.18941-5-mar=
ek.behun@nic.cz/
https://patchwork.ozlabs.org/project/uboot/patch/20210526155940.26141-5-pal=
i@kernel.org/
https://patchwork.ozlabs.org/project/uboot/patch/20220223125232.7974-1-kabe=
l@kernel.org/

The last patch is not merged yet.

Marek
