Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07D50A1DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389049AbiDUOPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388301AbiDUOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:15:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5B3B022;
        Thu, 21 Apr 2022 07:12:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CD7068C4E; Thu, 21 Apr 2022 16:12:29 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:12:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 6/7] ARM: use the common dma_to_phys/phys_to_dma
 implementation where possible
Message-ID: <20220421141229.GB20492@lst.de>
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-7-hch@lst.de> <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:05:11AM +0200, Arnd Bergmann wrote:
> > -unsigned long __pfn_to_bus(unsigned long pfn)
> > +#else
> > +static inline unsigned long fb_bus_sdram_offset(void)
> >  {
> > -       return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
> > +       return BUS_OFFSET;
> >  }
> > -EXPORT_SYMBOL(__pfn_to_bus);
> > +#endif /* CONFIG_FOOTBRIDGE_ADDIN */
> 
> I have an older patch to remove CONFIG_FOOTBRIDGE_ADDIN
> completely, as it does a couple of other nasty things and there are
> apparently no users. Would that help here?

For this series it doesn't really make much of a difference.  The addin
case actually is simpler than the host mode for DMA,  But overall
CONFIG_FOOTBRIDGE_ADDIN seems to be a collection of special cases, so
if it is unused and can be remove that would probably be a good thing.
