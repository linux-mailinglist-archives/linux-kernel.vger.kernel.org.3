Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77049C925
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiAZL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:56:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiAZL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:56:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89EB261857;
        Wed, 26 Jan 2022 11:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE0AC340E3;
        Wed, 26 Jan 2022 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643198214;
        bh=AIril9v7tE8y6x77I8YDt8M9H1P7L5vpXmUl0SfJWNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d17fmk1LEayEdOGlbjpvNGW8dTzgKTltoBiSIHiCPJw2leW5RvAIzT9KTm8SUGmMg
         WBUe4wT8JO8yVEn4a1l6cdX9cAeuaiGOtqJ4BgH/u8LdPdMX9S2SoCqPRCbfjAAg4t
         ksR/HhJEMfU6doKKyXcB20fIXWc8Xts8zhTOgoZry1bxJImoXwF7AtvGKpKnQ9Gipv
         hCq3dsZE8qHpuQs16a0evjdXXS7wAhO8fk7j77FR4gyBzh9FSOnPQL0LrEqCE0W0no
         XxAMNjP61mx4egkzzuedrxnv55psqDY3rDw/KE8pCp7igHf5Nmx2L3sIZHPfSOud2g
         mg8puBSqwBxGQ==
Date:   Wed, 26 Jan 2022 19:56:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-venice-gw7902: disable gpu
Message-ID: <20220126115646.GM4686@dragon>
References: <20211216161227.31960-1-tharvey@gateworks.com>
 <20220126093558.GL4686@dragon>
 <d5a15039255d13cf4321bf1c18f49a9cdb666607.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a15039255d13cf4321bf1c18f49a9cdb666607.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:58:56AM +0100, Lucas Stach wrote:
> Am Mittwoch, dem 26.01.2022 um 17:35 +0800 schrieb Shawn Guo:
> > On Thu, Dec 16, 2021 at 08:12:27AM -0800, Tim Harvey wrote:
> > > Since commit 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
> > > imx8mn-venice-gw7902 will hang during kernel init because it uses
> > > a MIMX8MN5CVTI which does not have a GPU.
> > 
> > I do not quite follow on this.  i.MX8MN integrates a GPU, and
> > MIMX8MN5CVTI is built on i.MX8MN, correct?  If so, how comes
> > MIMX8MN5CVTI doesn't have a GPU?
> > 
> It's a fused-down variant of the i.MX8MN that has the GPU disabled by
> fuses.
> 
> > > 
> > > Disable pgc_gpumix to work around this. We also disable the GPU devices
> > > that depend on the gpumix power domain and pgc_gpu to avoid them staying
> > > in a probe deferred state forever.
> > 
> > Is this an indication that GPU should be disabled in imx8mn.dtsi and
> > enabled board by board?
> > 
> There's a trade-off here: most boards will probably use the full
> variants that include the GPU, so probably less boards will need to
> disable the GPU, as done here, than boards that need to enable it when
> the base DT disables the GPU.
> 
> Same story as with the i.MX6 where there are some SKUs that disable the
> VPU by fuses: we enable it in the base DT and if you happen to build a
> very low-cost board that uses the fused-down version you need to
> disable it in the board DT.

Thanks, Lucas!

Patch applied!

Shawn
