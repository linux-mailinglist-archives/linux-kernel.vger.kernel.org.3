Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F0523577
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiEKO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiEKO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:28:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF308CCD2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XdwozKPcqTzwOXE+Ovf1o8hV0Egb8ylr4ZAv2wxgADs=; b=LBxwO6l24WTPEFmT7PduW4SHk1
        YaZvpRb2Z44mivsVnrdNHDFivsXGQkXWXGchFUTT5K+NqXxxKht8HA7TNWyZIUsNUqETqQpVzUuIA
        1yTjOmPTuFR3WUC1m8kFyO32xj0DdnH+JEBEZ7kt0YyUNBWTpdy9pZCVNQ6hsRVOANE8DpGvym78s
        5W1qAJOEUFIXCPQFQFT79LPO5H9U8Pv52BmtbWa8rnDrZ3M+kNNt0afpamuoasdFqoZvpNUlz70vE
        4EuWsH66cY00kb/rOSjVGBZiU+PIxiqM7mEwSdoceZ3p0Q9ypfzNFg643KRva0txISLteEzF8Xdsr
        24Cf/E7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60686)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nonKY-0006wD-1i; Wed, 11 May 2022 15:28:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nonKS-0007BR-Ib; Wed, 11 May 2022 15:28:40 +0100
Date:   Wed, 11 May 2022 15:28:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Will Deacon <will@kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Message-ID: <YnvIGOpL06ZtbJgR@shell.armlinux.org.uk>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
 <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck>
 <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com>
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

On Wed, May 11, 2022 at 02:45:27PM +0200, Arnd Bergmann wrote:
> If it doesn't work, then there is no point trying. You could try
> changing the exception handling so it searches the ex_table for
> Undefined Instruction exceptions as well, but that's probably more
> complicated.

What's the point when we have the undef hook?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
