Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1570514F05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377963AbiD2PTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378276AbiD2PTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:19:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F4240A1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PLXUVQiV7tikz3YNBMnVyAjxTBooCtamS/BcdAwgm1c=; b=YICZspGI9E6FIZ2AFbKUKz+xsP
        FS5Dji1YinHJh1pOrKjcscS3Hst7bhQa/f4W/7D3nsngsYMaZ8NdoDBSR2CQ7e7wjot+AmpaNiL98
        vHLPr3wG9o1OWVzEqdsiegQMQz1SveLe7UUy1Q9y8QfvbNRFAFdbiBiAQkYtWgNXrZTsByc5t26Po
        Idgv6LpfC23p85e+5E6h+vZZduGPLxInEkVTXD/jVrNrQHh5xhqlqohQ5gt5BtweG8+paKpK+WWZK
        IZjr4YstZ6jcMZYYUmNx/FaqMPUnzT2oXBzYOtQi5YNErX5X5j+kAtoqxwqM/PtI4ksRS2ryuTvJ9
        376nWAXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58440)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nkSLM-0004Ak-NE; Fri, 29 Apr 2022 16:15:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nkSLK-00022a-RO; Fri, 29 Apr 2022 16:15:38 +0100
Date:   Fri, 29 Apr 2022 16:15:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linus.walleij@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/2] ARM: Fix off by one in checking DMA zone size
Message-ID: <YmwBGh5mvuNIgyRY@shell.armlinux.org.uk>
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
 <20220324175417.1014562-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324175417.1014562-2-f.fainelli@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:54:16AM -0700, Florian Fainelli wrote:
> The maximum DMA address is PAGE_OFFSET + arm_dma_zone_size - 1, fix this
> by doing the appropriate subtraction.

The question is... is MAX_DMA_ADDRESS inclusive or exclusive. The answer
is rather indeterminant, unfortunately.

drivers/net/wan/cosa.c: if (b + len >= MAX_DMA_ADDRESS)

So, if the buffer address + buffer length is equal to MAX_DMA_ADDRESS,
then the buffer is not DMA-able. To me this looks completely wrong.
It's also completely wrong because 'b' is a "unsigned long" which
means on 32-bit, this can wrap.

drivers/parport/parport_pc.c:
	unsigned long start = (unsigned long) buf;
	unsigned long end = (unsigned long) buf + length - 1;

	if (end < MAX_DMA_ADDRESS) {

So, "end" is the last byte of the buffer. If MAX_DMA_ADDRESS is the last
byte of the virtual address space that supports DMA, then if the two are
equal, we do not use DMA. This seems wrong to me, and points to it being
an _exclusive_ value - it's the last byte plus one.

there's a bunch of memblock allocation functions that use
__pa(MAX_DMA_ADDRESS) as the "min_addr" and if this is a minimum
address, then surely this means that it is also an exclusive value.

So, I came to the conclusion that MAX_DMA_ADDRESS is supposed to be
exclusive. In other words, where PAGE_OFFSET + sizeof(ram) if
sizeof(ram) is the size in bytes of the RAM, limited to the maximum
addressable virtual address that RAM can be mapped to.

I don't see an inclusive value being correct, at least not for the cases
I've looekd at.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
