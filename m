Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00252015E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiEIPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:48:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912DF1BDAFE;
        Mon,  9 May 2022 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K4Ghe47wyHzJC/f9L6n0o6zagAWPzwTkrtr6pV97IUk=; b=WzlKZ7fSN/dBH8RKYd6m3bkXdD
        mv2quNMAOlbc7iJjqcQ8baqyyMWKBY7SGPOtekFffiAu/2nom/2/VhHi6WR1TOrtcF2cyWwfR3T7h
        2lFwN2xNQGxftqfKORZ4q5kFKqRc+ocL4CGJQn2wAbdHnJ56keASELf+ImYa6LzLvDn5OEmKZtbYU
        gS056gWixGDz+4cpZGEb6b5k0jTil/YgEIZKfmaMh8FsRtefyv8VqierKsOEZ9OspPyoDZyBbHqVQ
        vT3TLVn+TGbtwDV1mNqEgatoGHJHYUovpgac9W2DHkw0W6W78rmgXulI1bF6ph5lpq2gZ3s0KhMM1
        oiqoA+8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60642)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1no5YO-0003Gf-Lj; Mon, 09 May 2022 16:44:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1no5YI-0005Dn-Jw; Mon, 09 May 2022 16:44:02 +0100
Date:   Mon, 9 May 2022 16:44:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: fully convert arm to use dma-direct
Message-ID: <Ynk2wjRyH05uEJiO@shell.armlinux.org.uk>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:17:20PM +0200, Linus Walleij wrote:
> On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
> 
> > arm is the last platform not using the dma-direct code for directly
> > mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> > arm to always use dma-direct now (it already does for LPAE configs
> > and nommu).  I'd love to merge this series through the dma-mapping tree
> > as it gives us the opportunity for additional core dma-mapping
> > improvements.
> (...)
> 
> >  b/arch/arm/mach-footbridge/Kconfig                   |    1
> >  b/arch/arm/mach-footbridge/common.c                  |   19
> >  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8
> >  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4
> 
> I think Marc Z has a Netwinder that he can test this on. Marc?
> I have one too, just not much in my office because of parental leave.

Netwinder is just more of a PC-but-with-ARM - it doesn't make use of any
of the dmabounce code.

Assabet is what needs testing for that, or one of the SA1110 machines.
I'm away from home on my boat (and have been for the last two and a bit
weeks) so can't test. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
