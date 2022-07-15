Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0526575CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiGOIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:02:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627747E00E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71BBCCE2CEE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19D4C3411E;
        Fri, 15 Jul 2022 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872174;
        bh=bEwLS0WPpRaJCy/NQFycQ8oRhKH1oJkzD1mvx9El+Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEvGx9jq/tHQuJbANG33G6mQf5R1/o2AFFS8PDDL4Km7P+yTZocmGDJphNvoOXyIs
         gvEFT9vjtViwQxk15X71C95lNX5LoODhrv8rJIY2D7GOJtxxSCyvjiMrSlwWA8dmH/
         aGBic5OKtejnPfr7jHamDGiCna1hW+JqQA6lXANeasgzVFPcCsyS8ZcceTiiFzQ8my
         us1f3YssZbWXTCPe0AWlKZTAuMXz/SSdU+OZjf8eYbTlsfCDcZxxoNwxMJ3gcA401X
         BswSdQimQm3pgFrlUW3ciHDHQBnrXc6IkpzcCmkfJ8AQPbEAtTl7KCzfHldNJbH77y
         rCQYSbPbHihLA==
Received: by pali.im (Postfix)
        id 36803A32; Fri, 15 Jul 2022 10:02:52 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:02:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220715080252.b5ofnrjdkubc4qkh@pali>
References: <20220714185700.6137-1-pali@kernel.org>
 <YtBy/318C/uNntUN@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtBy/318C/uNntUN@shell.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2022 20:48:15 Russell King (Oracle) wrote:
> On Thu, Jul 14, 2022 at 08:57:00PM +0200, Pali Rohár wrote:
> > Custom ARM version of pci_remap_iospace() is implemented only for MMU
> > kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
> > 
> > See compilation failures:
> > https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> > https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> > https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> > https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
> > 
> > Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > 
> > PING!!!! Is somebody interested in fixing these compile errors? As nobody
> > answered to my emails where I proposed this fix more than half year ago and
> > asked for opinion...
> > 
> > https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> > https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> > https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> > https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> > https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
> > 
> > If nobody is interested then please STOP sending me these Intel "0-DAY CI
> > Kernel Test Service" emails. Thanks!
> 
> It needs to be sent to the patch system to be merged, which has been
> the process with 32-bit ARM for getting on the last quarter of a
> century.
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

I do not need this patch. It is bot who is complaining. So if you do
neither, then please STOP sending me these emails.
