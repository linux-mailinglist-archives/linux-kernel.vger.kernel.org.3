Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B85A0DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbiHYKec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiHYKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:34:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E70A5C50
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OrUQl1w8kI5QhSNqJvaa54vHHJ53i9OB8US51/YU1L8=; b=dOMzffQRsvnWHPkw7/v6LcBrWi
        Fs4kPn1BDYoqaCHOUup+EWXTomIN/ugf3YEy/b0tqx3vcq/It9CcoUIQFwwERPNzK+Nx6qXkM0lyu
        fdpsA8KxVNtaoKAk+S8cAnyphTWFVwg/bxqQznLXnHpxstaszQSDx2XC8nLEqj3TxJIrZAkyy5h/2
        JEH37D5VEthzUvRi0N/4KjHf4eSY6JxC4PZbnH06ghUBqQt9O3MHwO7tCYEjZ1VrM5z88L2Zc/l4e
        nGn/1OQc/X0dmhCfuELn0POm00309P1A6lE98689hrrlmdZGoJI9hwzwL/6Se15iREJbw0juaNZXC
        2QSyV31g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33926)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oRABi-00053G-BZ; Thu, 25 Aug 2022 11:34:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oRABg-00051w-Ve; Thu, 25 Aug 2022 11:34:12 +0100
Date:   Thu, 25 Aug 2022 11:34:12 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5/4] ARM: footbridge: remove custom DMA address handling
Message-ID: <YwdQJDMExcm4n0vQ@shell.armlinux.org.uk>
References: <20220821055326.GA25950@lst.de>
 <20220825091752.3535657-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825091752.3535657-1-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:17:52AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Footbridge is the last Arm platform that has its own
> __virt_to_bus()/__bus_to_virt()/phys_to_dma()/dma_to_phys() abstraction,
> but this is just a simple offset now.
> 
> For ISA DMA (floppy etc), the offset is actually zero, so the special
> hack to subtract the bus offset can be removed from common code.

No, the offset is definitely not zero for ISA devices. ISA devices have
the same view of system memory as PCI devices, since ISA devices go
through a southbridge and on to the PCI bus. So their view of the system
is exactly the same as any other PCI device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
