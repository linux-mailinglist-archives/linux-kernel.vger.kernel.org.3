Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701C562A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiGAEk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAEk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF755A45F;
        Thu, 30 Jun 2022 21:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CE1622C2;
        Fri,  1 Jul 2022 04:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC97CC341C6;
        Fri,  1 Jul 2022 04:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656650454;
        bh=rJvxKCRY6pNJTLHwwaTNBEKYZptbJjR26nKtlLTh88U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoKxRKaekprA+Guftk9ZekoK3vUv8a8PdsOAYCo8yI3slM5ZKeutfBy6MjD1Xygep
         +xMkVxgRA0gCtdk9hyaBs34rt8xqyOaqrITwt5hXRfSF15Y3DU2ib8KXzJMyYbHGDS
         OiC0Zswf9htxutVpqrm65xhEBxgb4kzzQOdy21FH2LXGeflVtfIgf3jehvpsoFpxIA
         /9YWasWrB37txwHakTRaOHnLR3UiAvZylnrHTGZl9UcG7HWlXcc0ixuvWMiFs1BbVG
         a/QJGGoy69Ayj2fuNXXJ6LIKmYRDP0xar6/Da0x1k9kb56jP2Ir6ZRKlI3kDE4gyn0
         8E65552xrL3Ew==
Date:   Fri, 1 Jul 2022 10:10:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrey Konovalov <andrey.konovalov@linaro.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: fix default pinctrl settings
 for blsp1_spi1
Message-ID: <Yr56z//ZBcvj2wFb@matsya>
References: <20220611195713.131597-1-andrey.konovalov@linaro.org>
 <YrKmGfUrOw5awgNw@matsya>
 <Yr2wuHpedbS4RELd@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2wuHpedbS4RELd@builder.lan>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-22, 09:18, Bjorn Andersson wrote:
> On Wed 22 Jun 00:18 CDT 2022, Vinod Koul wrote:
> 
> > On 11-06-22, 22:57, Andrey Konovalov wrote:
> > > The current settings refer to "blsp_spi1" function which isn't defined.
> > > For this reason an attempt to enable blsp1_spi1 interface results in
> > > the probe failure below:
> > > 
> > > [    3.492900] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > > [    3.502460] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > > [    3.517725] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > > [    3.532998] qcs404-pinctrl 1000000.pinctrl: invalid function blsp_spi1 in map table
> > > [    3.548277] spi_qup: probe of 78b6000.spi failed with error -22
> > > 
> > > Fix this by making the functions used in qcs404.dtsi to match the contents
> > > of drivers/pinctrl/qcom/pinctrl-qcs404.c.
> > 
> > Right, I cannot find blsp_spi1 which is the only one which is missing,
> > not sure why...
> > 
> > Bjorn do you recall why SPI1 is treated differently...
> 
> Looking at the available pinctrl functions, I believe that blsp_spi1 has
> two possible mux options; identified b y blsp_spi_*_a1 and
> blsp_spi_*_b1.

Yes, so are we good to merge this?

-- 
~Vinod
