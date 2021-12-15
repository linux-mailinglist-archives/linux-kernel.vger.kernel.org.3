Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60358475BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbhLOPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:21:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46794 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbhLOPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:21:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 357FDB81FBE;
        Wed, 15 Dec 2021 15:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2423AC33CF2;
        Wed, 15 Dec 2021 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639581615;
        bh=iV9y8WX18pADcC4QTmY9Es2S3Ox/ct9sA+YFJ4++suE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5zy0R1xSIP7q6y3HNK8lmGyXjkmA88xqFMM8bEynhZp1VapNobnTQM7R90JsBDqL
         yQ4oXr20idIdtI+4vz7oW/32vhuQoj8f9lN7dTOmG8lVTyC1bk6gKYqzvxh0Wu/jqs
         LBba4gf+X0fpVFeWihIYFYK1NrAxrjKoJrYT+FqYhESUMcKHHhCVayrnVi/vvX1O5F
         wFpS86A23mRlDcOV8wHhjf8S7VS4/Gt3ncfVA4r7iJ8yor3OVnV6PVFozoqRIW2VMr
         yG7oabIHTWDiJLcPeQ3i52UYG0qalcHex/0H6KYbfoUqhrCH9ANL/ebaZkVe7VmlB5
         0SPm5bsla1BDg==
Date:   Wed, 15 Dec 2021 20:50:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Message-ID: <YboHpPfynVmOP+ac@matsya>
References: <20211215134915.3622957-1-broonie@kernel.org>
 <82dcdd84d9111dcde3fb43504ffec5592e2c8356.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82dcdd84d9111dcde3fb43504ffec5592e2c8356.camel@toradex.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-21, 14:14, Marcel Ziswiler wrote:
> On Wed, 2021-12-15 at 13:49 +0000, broonie@kernel.org wrote:
> > Hi all,
> > 
> > After merging the phy-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> 
> I admit I never tried building any of this as a module. I assume neither did Richard (now on CC) or anybody
> else.
> 
> > /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c: In function 'imx8_pcie_phy_init':
> > /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37: error: implicit declaration of function
> > 'FIELD_PREP' [-Werror=implicit-function-declaration]
> 
> Hm, that should come from include/linux/bitfield.h. However, that seems not explicitly included. Likely, in the
> module case it no longer finds it. That's a problem.
> 
> >    41 | #define IMX8MM_GPR_PCIE_REF_CLK_EXT FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
> >       |                                     ^~~~~~~~~~
> > /tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:85:7: note: in expansion of macro
> > 'IMX8MM_GPR_PCIE_REF_CLK_EXT'
> >    85 |       IMX8MM_GPR_PCIE_REF_CLK_EXT :
> >       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   1aa97b002258a190d77 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> > 
> > I have used the phy-next tree from yesterday.
> 
> Yes, I also noticed it having been applied there now.
> 
> Anyway, let me cook up a fix for this. Thanks for reporting.

I have fixed it up: https://lore.kernel.org/all/20211215060834.921617-1-vkoul@kernel.org/

will push now

-- 
~Vinod
