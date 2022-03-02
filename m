Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2814CA5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiCBN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiCBN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:26:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C312458F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:25:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68AFACE21A9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8265CC004E1;
        Wed,  2 Mar 2022 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646227528;
        bh=rb6OGp6luwsYjaP0ulEc9FqmXK4fUkMStzFbsE0sajE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QY0/5d5WZQEmZ752BWWsTyYg6k8GimK363AzDispI/fhVAcMjhjvIPZKkwn9axaHw
         vK4t+I/NpuWn2h82LvtVDOUpsDbEncmR0haVI7mKnRgaNWEI50B0kqIEAsCUp0nzET
         eHypbLA6hdebxckKjQiF82zANHc0YAPAzsFkB8VxV8audF3PEBRou18wqe+/X6R8KP
         j613qK5wWpLj7XJBnvcz3Ekln71KxORQM1KZ5sFN8vlHTLMu3lf+2LBj/RXfWJH+F5
         HZJiq7s5G9JhsmOJexQXdo+buBfLqnWOd1u0LD2u4uqai79CF5aMCAO5Z9sSfDxtnT
         FBk9/PX9z/TCw==
Received: by pali.im (Postfix)
        id ADC24677; Wed,  2 Mar 2022 14:25:25 +0100 (CET)
Date:   Wed, 2 Mar 2022 14:25:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220302132525.lg5ko5s2smti5pbt@pali>
References: <20220218212526.16021-1-pali@kernel.org>
 <87o82r0zjh.fsf@BL-laptop>
 <875yoz0wpw.fsf@BL-laptop>
 <20220301092539.lru7hsaqxrjqz32r@pali>
 <Yh9ruVkK1gikOuA1@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh9ruVkK1gikOuA1@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2022 14:06:01 Andrew Lunn wrote:
> On Tue, Mar 01, 2022 at 10:25:39AM +0100, Pali Rohár wrote:
> > On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote:
> > > > Hello Pali,
> > > >
> > > >> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> > > >> device-tree in order to support legacy I/O port based cards which have
> > > >> hardcoded I/O ports in low address space.
> > > >>
> > > >> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
> > > >>
> > > >> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> > > >> 'ranges' DT property") this driver can work with I/O windows which
> > > >> have
> > > >
> > > > Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
> > > > resources from 'ranges' DT property")" tag ?
> > > 
> > > Waiting for your confirmation I tried to applied it but it failed.
> > > 
> > > Did you base this patch on v5.17-rc1 ?
> > > 
> > > Gregory
> > 
> > Hello! This change is breaking booting of Turris Mox kernel with older
> > bootloader due to bugs in bootloader.
> 
> Do you know what actually goes wrong?

Yes! There is already pending fix for U-Boot which will fix this bug:
https://patchwork.ozlabs.org/project/uboot/patch/20220223125232.7974-1-kabel@kernel.org/

But because older U-Boot version is already in production we cannot
change this.

> I've not been involved in the discussion, but looking at the comments
> above, not changing the space can result in non-working cards.

And changing it would result in non-bootable kernels or crashing
kernels... So possible non-working card is better choice.

Note that non-working cards are only those which do not support 32-bit
I/O ports, which is probably only some ancient PCI or ISA cards. I have
checked 3 random mPCIe SATA controllers which use I/O ports and they
support 32-bit I/O addressing, so I guess these cards should not be
affected at all.

> So it
> does sound like something which in general we want to do. Does the
> current code assume the bootloader has initialized some registers with
> specific values? Can that be moved into the driver so it also works
> with older bootloaders?
> 
>      Andrew

Yes, by converting DTS to board platform data, stop using DTS and
dynamically fill board platform data by kernel code... hehe :D nothing
which we want.

Probably it could be possible to write drivers which would ignore
address resources in DTS and fill kernel structured dynamically from HW
registers, in similar way how old platform data on arm32 worked in the
past. But this is too much work for which I do not see real usage. I'm
really not going to use ISA card connected to PCI-to-ISA bridge
connected itself to PCIe-to-PCI bridge and this connected to A3720 SoC.

If somebody is really want to use this setup, then it is easier to
upgrade bootloader (patch is already pending) and manually edit DTS file
to remap I/O space to bus address 0x0. This edit can be automated by
U-Boot script (or U-Boot driver).

It is really easier to do upgrade+fix bootloader and modify DTB on the
fly than hacking kernel to support older bootloaders which are already
in use.
