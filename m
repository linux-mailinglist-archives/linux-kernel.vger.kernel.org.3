Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087A4A74A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiBBPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:34:57 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41627 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiBBPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:34:56 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E298410000A;
        Wed,  2 Feb 2022 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643816095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udh0XHWQaOuEVGcPinmtV33kWRGTQJdx9kgSeb7ptEA=;
        b=TANoPNZIlK9r9D4RAA6u4ohMIJi2bQzFP5OjFcV7SWY0g1o94ix/w1URlsTW3IJp2TSbol
        JSKRQDtH4fHVudiBCo8FKdrTJS7+tHHdel0nHhRIeAeLxuCJ6daNOu8JLdwoudsk9qwU1u
        uCCUTiTx42KqS21ONHO3XLNeOYRmbdgmGLNIpbUVuUWtMMkLgzLw4cQLmOD+5Kabm+BwR2
        nZOhcjfcf1JlVjarU/n4C8MWoce6Aj+0rI4SMIqHzomoTxcD+UFfmMFuEoSB7ZI5MC/xbW
        +x8sXaAGX4a5x4cCE+0yDGI5As0z7J05bOUMFvTipKN5n1HLsPNR9m59eK8+oA==
Date:   Wed, 2 Feb 2022 16:34:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <20220202163452.746d50ca@xps13>
In-Reply-To: <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
References: <202202011308.a6RlPiGp-lkp@intel.com>
        <20220202154504.7737deed@xps13>
        <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


broonie@kernel.org wrote on Wed, 2 Feb 2022 15:20:05 +0000:

> On Wed, Feb 02, 2022 at 03:45:04PM +0100, Miquel Raynal wrote:
> 
> > I've failed to prevent faulty configurations with regular depends
> > on/select keywords, so I've come with a new solution which received a
> > successful build coverage test from the 0-day robots.  
> 
> > In order to still be able to use the spi controller driver (=y) while
> > mtd is =m or =n, I need to add an IS_REACHABLE() check in a couple of
> > headers. This way we can just imply the right MTD symbols from the
> > SPI_MXIC Kconfig entry.  
> 
> Isn't this just a case where we shouldn't allow MTD to be built modular?

How would you do that in a nice Kconfig way?
