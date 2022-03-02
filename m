Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404644CA5E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiCBN0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiCBN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:26:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F4C4849
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5423CB81FE8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD36C340F3;
        Wed,  2 Mar 2022 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646227527;
        bh=F6FIEVKpXfOXQzl6pfzkGq/Nkv1/7ozJxp/16CBPavo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bKlLlUxeTbIJkFL893+V2gUGl1DL2QjubHFyNVRwqacLLJGKHQM6MRsPo1IW+7EG3
         TYgVh9z/qbBSKTAiDwPDBbyX/6KHX5M6pKohaOqIeycDL+p2uqX8p76aWTPvaHNQir
         JXWmv+1YI5OGHfOE6cmnzwcCoi5k9dMoYgJ+lh3lAu0BiVXPXUURHOzPz2eKwiNFt9
         fJpjQ/9XkA4FxizbNcmIeeE266CatyOP0uSLbZDGW7zmNNGfQe8zWRkahyeylkXfPk
         jo3OghsPXfJxgTZqfEn3sKZffEqqiVmGisO4ViSnanMmaAdjHl/mY29KkDgrRN7TCd
         NCmCS4ECUEA+A==
Date:   Wed, 2 Mar 2022 14:25:22 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220302142522.029932c9@dellmb>
In-Reply-To: <20220302141515.51340cab@dellmb>
References: <20220218212526.16021-1-pali@kernel.org>
        <87o82r0zjh.fsf@BL-laptop>
        <875yoz0wpw.fsf@BL-laptop>
        <20220301092539.lru7hsaqxrjqz32r@pali>
        <Yh9ruVkK1gikOuA1@lunn.ch>
        <20220302141515.51340cab@dellmb>
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

On Wed, 2 Mar 2022 14:15:15 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> On Wed, 2 Mar 2022 14:06:01 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > On Tue, Mar 01, 2022 at 10:25:39AM +0100, Pali Roh=C3=A1r wrote: =20
> > > On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote:   =20
> > > > > Hello Pali,
> > > > >   =20
> > > > >> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> > > > >> device-tree in order to support legacy I/O port based cards whic=
h have
> > > > >> hardcoded I/O ports in low address space.
> > > > >>
> > > > >> Some legacy PCI I/O based cards do not support 32-bit I/O addres=
sing.
> > > > >>
> > > > >> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resour=
ces from
> > > > >> 'ranges' DT property") this driver can work with I/O windows whi=
ch
> > > > >> have   =20
> > > > >
> > > > > Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure P=
CIe
> > > > > resources from 'ranges' DT property")" tag ?   =20
> > > >=20
> > > > Waiting for your confirmation I tried to applied it but it failed.
> > > >=20
> > > > Did you base this patch on v5.17-rc1 ?
> > > >=20
> > > > Gregory   =20
> > >=20
> > > Hello! This change is breaking booting of Turris Mox kernel with older
> > > bootloader due to bugs in bootloader.   =20
> >=20
> > Do you know what actually goes wrong?
> >=20
> > I've not been involved in the discussion, but looking at the comments
> > above, not changing the space can result in non-working cards. So it
> > does sound like something which in general we want to do. Does the
> > current code assume the bootloader has initialized some registers with
> > specific values? Can that be moved into the driver so it also works
> > with older bootloaders? =20
>=20
> No. TF-A may remap CPU PCIe window, and so U-Boot fixes these addresses
> in device-tree. But the fixup function was at first written in such a
> way that it assumes that the ranges propreties contains specific
> values. The proposed DT change, together with the fixup function in
> older U-Boot, will break ranges property to non-functional state.
>=20
> See corresponding U-Boot patches
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20200408172522.18941-5-m=
arek.behun@nic.cz/
> https://patchwork.ozlabs.org/project/uboot/patch/20210526155940.26141-5-p=
ali@kernel.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20220223125232.7974-1-ka=
bel@kernel.org/
>=20
> The last patch is not merged yet.

To explain more:
- the first patch added the ranges property fixup. After that patch
  (which was applied sometime not long after 8th April 2020) U-Boot
  fixes the ranges property in a way that does not work with the
  proposed DT change.
- the second patch extended the fixup, but it still won't work
  correctly with the proposed DT change
- the third U-Boot patch will fix this issue, afterwards the DT change
  won't break PCIe. This patch is not yet merged in U-Boot

It is questionable how many users have updated U-Boot to the version
with first fixup. AFAIK we at Turris did not make an automatic update
for U-Boot yet for Turris MOX, it was done manually only for some
boards that had some problems or users wanted certain features.

But we can't change the device-tree because it will break the
functinality for some users.

What we could do is add another patch to U-Boot that would change IO
window address if certain conditions are met (for example if the ranges
proprety was not changed by the user and thus contains a specific
value that can be checked for).

Marek
