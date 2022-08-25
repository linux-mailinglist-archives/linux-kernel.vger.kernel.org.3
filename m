Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8915A186D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbiHYSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbiHYSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:10:25 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A430AFAC7;
        Thu, 25 Aug 2022 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wst73/cqMwGjmGOJVyTXlZ5/UsYnUHBn/q0HBx+aY7s=; b=cg3wfIx3/SAJL4Yd459Y6lAe/H
        SGTYmVSI4dZx78f7Y4jGujK9aM8Bns2ShgvhZuCixt4gDlc7kqtTZrxv9r98Jb/NrXytIPDpoMHLG
        ipPtV4XVokk8uocHif+fItWyFzFkt5Zls7VkpSOXgxx31l57HFzm4MVdw97pR9i+hBUGo27vYgrCf
        Y6sbMl8Iezqit1navLC1raBHcdSTyxIta7UWAJViJBVSIA5Zw3U6e65d1Qyfeo5/R2pWKqFZ3JSiu
        gfcUkZLBA4iCPxJCVp5C2G5xVC5xITcSD3yxZgljYHYU97tuvd3nKCCRQBpQBl7wZHVBTAzRDKGjh
        lBmHxf0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33936)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oRHIz-0005S4-JW; Thu, 25 Aug 2022 19:10:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oRHIq-0005J3-Pm; Thu, 25 Aug 2022 19:10:04 +0100
Date:   Thu, 25 Aug 2022 19:10:04 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     'Ard Biesheuvel' <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        'Alexandre Belloni' <alexandre.belloni@bootlin.com>,
        linux-samsung-soc@vger.kernel.org,
        'Tomer Maimon' <tmaimon77@gmail.com>,
        linux-omap@vger.kernel.org, 'Avi Fishman' <avifishman70@gmail.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, 'Tali Perry' <tali.perry1@gmail.com>,
        'Nancy Yuen' <yuenn@google.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        'Patrice Chotard' <patrice.chotard@foss.st.com>,
        'Patrick Venture' <venture@google.com>,
        'Vladimir Zapolskiy' <vz@mleia.com>,
        'Claudiu Beznea' <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        'Benjamin Fair' <benjaminfair@google.com>
Subject: Re: [RFC PATCH] usb: reduce kernel log spam on driver registration
Message-ID: <Ywe6/AKzVL/77Fhi@shell.armlinux.org.uk>
References: <CGME20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56@epcas5p2.samsung.com>
 <20220825170327.674446-1-ardb@kernel.org>
 <065601d8b8a7$6fee5850$4fcb08f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065601d8b8a7$6fee5850$4fcb08f0$@samsung.com>
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

On Thu, Aug 25, 2022 at 10:53:44PM +0530, Alim Akhtar wrote:
> >Drivers are typically supposed to be quiet unless they are actually probed,
> but
> >for some reason, USB host controllers seem to be exempt from this rule, and
> >happily broadcast their existence into the kernel log at boot even if the
> >hardware in question is nowhere to be found.
> >
> >Let's fix that, and remove these pr_info() calls.
> >
> How about just change pr_info() to pr_debug() instead? 

Do the messages serve a useful purpose that the initcall_debug kernel
parameter (that doesn't require #define DEBUG to be set while compiling
and thus can be used with any kernel) doesn't provide? 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
