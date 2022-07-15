Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30E576584
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiGOQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiGOQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:57:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DC8239B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Cn4wcriowaGYu8eeMZByXT9E1O6xdgI/ywBqJ6L01LU=; b=MrXdNZ1HzYMugD8LROzBp1KGoC
        c60YYE5taT5clE4TIoJ0R9w7Y7d12nVBgjAvDJLTqwLieKtBUWQjmEEUeK19+/FcyhNF9iGQU2EqM
        ABe6bzkwRVTjOurdzgekjeOn7LHG/kEHLWG52GuCTumnBBXQz6fP8Hlmg8G0XKhOf8BWKFHu7fQM5
        VQfiqqOzJiOuY5Ql3iAb5TbFHzPwTXTMwLsjkr+58HzAj0WtAaK6Mk+vhjyx3S8G/3u2yV7gsnvQd
        btud61hrDXszi17iVnlCcP56a6cQIWBrNRGSLqsgqnCrmxTwvICoBiu8ZlaWLYVQPPZAwNlFSCx+m
        T+iSLTHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33360)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oCOd8-0007JN-Tb; Fri, 15 Jul 2022 17:57:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oCOd5-0007i5-3g; Fri, 15 Jul 2022 17:57:27 +0100
Date:   Fri, 15 Jul 2022 17:57:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <YtGcd2YXU24j3MB7@shell.armlinux.org.uk>
References: <20220714185700.6137-1-pali@kernel.org>
 <YtBy/318C/uNntUN@shell.armlinux.org.uk>
 <20220715080252.b5ofnrjdkubc4qkh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715080252.b5ofnrjdkubc4qkh@pali>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:02:52AM +0200, Pali Rohár wrote:
> On Thursday 14 July 2022 20:48:15 Russell King (Oracle) wrote:
> > On Thu, Jul 14, 2022 at 08:57:00PM +0200, Pali Rohár wrote:
> > > Custom ARM version of pci_remap_iospace() is implemented only for MMU
> > > kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
> > > 
> > > See compilation failures:
> > > https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> > > https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> > > https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> > > https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
> > > 
> > > Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > 
> > > PING!!!! Is somebody interested in fixing these compile errors? As nobody
> > > answered to my emails where I proposed this fix more than half year ago and
> > > asked for opinion...
> > > 
> > > https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> > > https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> > > https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> > > https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> > > https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
> > > 
> > > If nobody is interested then please STOP sending me these Intel "0-DAY CI
> > > Kernel Test Service" emails. Thanks!
> > 
> > It needs to be sent to the patch system to be merged, which has been
> > the process with 32-bit ARM for getting on the last quarter of a
> > century.
> > 
> > Thanks.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> I do not need this patch. It is bot who is complaining. So if you do
> neither, then please STOP sending me these emails.

I don't need the patch, but I'm not sending you those emails.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
