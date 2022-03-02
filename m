Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701144CA594
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiCBNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiCBNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:06:52 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D85C2483
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=HAXyBFQgUVdxAmj2m4irVlIbi28ci3NyzG6w9FJrnpo=; b=ix
        3QAKfOb8taZ760/sB/w2raFHrsngAJA8L5gR74OL/nRn6OUBvjrWuYS32V+6EHZ0RKy1gA24JcdIL
        aTztDAnnTRSYOD0Knn8/3nqZ6LtPrUrfp0eILKXNhbjfDkcmA4gSM5qjvP08Tbkp+CDUL4MRQ/Y6m
        24+fWWWL/ZjBdPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nPOg5-008ux4-Vz; Wed, 02 Mar 2022 14:06:01 +0100
Date:   Wed, 2 Mar 2022 14:06:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <Yh9ruVkK1gikOuA1@lunn.ch>
References: <20220218212526.16021-1-pali@kernel.org>
 <87o82r0zjh.fsf@BL-laptop>
 <875yoz0wpw.fsf@BL-laptop>
 <20220301092539.lru7hsaqxrjqz32r@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301092539.lru7hsaqxrjqz32r@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:25:39AM +0100, Pali Rohár wrote:
> On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote:
> > > Hello Pali,
> > >
> > >> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> > >> device-tree in order to support legacy I/O port based cards which have
> > >> hardcoded I/O ports in low address space.
> > >>
> > >> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
> > >>
> > >> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> > >> 'ranges' DT property") this driver can work with I/O windows which
> > >> have
> > >
> > > Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
> > > resources from 'ranges' DT property")" tag ?
> > 
> > Waiting for your confirmation I tried to applied it but it failed.
> > 
> > Did you base this patch on v5.17-rc1 ?
> > 
> > Gregory
> 
> Hello! This change is breaking booting of Turris Mox kernel with older
> bootloader due to bugs in bootloader.

Do you know what actually goes wrong?

I've not been involved in the discussion, but looking at the comments
above, not changing the space can result in non-working cards. So it
does sound like something which in general we want to do. Does the
current code assume the bootloader has initialized some registers with
specific values? Can that be moved into the driver so it also works
with older bootloaders?

     Andrew
