Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE655A0DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiHYKgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbiHYKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:36:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE95B078
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hhhhz1AH1FzTabLIytBwW7lF1dPb2hdBcByPySDRX64=; b=hV/NygF8xqGU3kk38vQeNhzFBU
        0z3aL22WwsulcnCkCulwjSXv4nvZWtUlXMdKOKrLZ8e1VWDSw/YkYH9q/MoWcu18UsBumnLgNUHAe
        lZhyBSHPn86ITxWO/hY8QHceDI39pxkaIklKzi//BmE9b0uqzOrCckywssDuiO5rMWpdWae3GB6BH
        thDGF/EE9/iBE5qbNeC91Y0+nMUtFKU4YNcqKIEGP4zDrvhUGcyNnJhH9GnPd04yA9S8BHXlRI9IH
        wfngc0YBuAw+xa1AqsLNkrKPAkxnQ3qpZx+iDCqQrARRD6WOMD7EF0lqbfnU4LqLiO3C30oSGzyBl
        yoZymFdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33928)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oRADN-00053X-Fx; Thu, 25 Aug 2022 11:35:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oRADM-000524-To; Thu, 25 Aug 2022 11:35:56 +0100
Date:   Thu, 25 Aug 2022 11:35:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5/4] ARM: footbridge: remove custom DMA address handling
Message-ID: <YwdQjEJBUwGJB/YK@shell.armlinux.org.uk>
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
> -/*
> - * The footbridge is programmed to expose the system RAM at 0xe0000000.
> - * The requirement is that the RAM isn't placed at bus address 0, which
> - * would clash with VGA cards.
> - */
> -#define BUS_OFFSET		0xe0000000
> -#define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
> -#define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))

... and this tells you why that is with ISA devices.

So, one hell of a big NAK to this patch, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
