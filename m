Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CF5A7F43
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHaNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiHaNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:51:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF0D34F7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9jNNNZj2QWLvrPf5qUgDVYXz8CN/57+L72lv9cMQiTw=; b=qjR/COqnuEQu8DH0tE2MDA+c/r
        FT6d4i7N6AXTHOLxrOSrr51/tFxiVCanz6N/HhV0xLa57+GHdGFQTaLGe8aCRheWtmrWV83Lg0FXp
        XCEi1cIIpKu46bqGTmc0xs2l8q9sRFUz1D82oeIH9iL7GMoDEhZ0oTQLqKqz/xlhfVwg9AQUb6gV+
        0fmchRiq0AA6/EKTu9Q2rqClhmCUdqrXLF/Ru6Dq/UZe6g11yZvtUICtV1Vtuhr4322n7OsGz1IZE
        jWXivZBnbS/5KZ9xj02/482oOR+6vQmlWqwCwwaV4Ymwtc9KbivUiBbAavEnayXXChN+6AbcLPkk/
        v7Uou4vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34020)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oTO7h-0004PK-94; Wed, 31 Aug 2022 14:51:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oTO7X-0002Yx-8l; Wed, 31 Aug 2022 14:51:07 +0100
Date:   Wed, 31 Aug 2022 14:51:07 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Victor Hassan <victor@allwinnertech.com>, linus.walleij@linaro.org,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Message-ID: <Yw9nS0GXOPCGUWbn@shell.armlinux.org.uk>
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 01:52:57PM +0200, Marek Szyprowski wrote:
> Hi Victor,
> 
> On 16.03.2022 03:33, Victor Hassan wrote:
> > earlycon uses fixmap to create a memory map,
> > So we need to close earlycon before closing fixmap,
> > otherwise printk will access illegal addresses.
> > After creating a new memory map, we open earlycon again.
> >
> > Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> 
> This patch landed in linux next-20220831 as commit a76886d117cb ("ARM: 
> 9223/1: mmu: fix access to illegal address when using earlycon & 
> memblock=debug"). Unfortunately it breaks booting of all my test boards 
> which *do not* use earlycon. It can be easily reproduced even with QEMU.
> 
> With kernel compiled from multi_v7_defconfig the following setup boots:
> 
> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append 
> "console=ttyAMA0 earlycon" -M virt -smp 2 -m 512
> 
> while this one doesn't:
> 
> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append 
> "console=ttyAMA0" -M virt -smp 2 -m 512

That's the second patch to drop from my merge yesterday... not good.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
