Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE84C2305
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBXE1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBXE1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:27:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE05A08E;
        Wed, 23 Feb 2022 20:27:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1987961764;
        Thu, 24 Feb 2022 04:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA3CC340E9;
        Thu, 24 Feb 2022 04:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645676832;
        bh=U6t1JXGLE6rGWUED9HCNkR016w7OoipCOKw7Y4bwRqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT+TCs9s0C2HMW43NU8JLrtNIoK6PeVS3hEjxcd9DvpXaztUeekiRmTv9jEjbtmuL
         Efra83HROTiKaq/eWZcfUmb3h91ngRU3r4yn8/yHbGb6iX1STK9rgSHuWs/f8rvS5u
         4+50OpzewjWysnEMGt5zdhaOSP6xMEh50Wwk9HNJQd9sShI4CmB4IkT9XF6rMZFGhT
         F9DmYgZ1DltjIEKOM4kccw+q34WhL6KDL+zuwsTVWKGj/DaDA8r1moAyEhhTOegsLL
         4hzkC5zN2YhasteHlqkZ2nXme9e9w1qtcSx3irXbuNDcEsnEg/1YLidyGok2gM6hvo
         YQD+eC3pWLXBw==
Date:   Thu, 24 Feb 2022 09:57:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm GPI DMA Driver
Message-ID: <YhcJHGsdY/XQPOt8@matsya>
References: <20220222042409.1185564-1-vkoul@kernel.org>
 <Yhb7Q91cEdgayc6c@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhb7Q91cEdgayc6c@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-22, 21:28, Bjorn Andersson wrote:
> On Mon 21 Feb 22:24 CST 2022, Vinod Koul wrote:
> 
> > Qualcomm GPI DMA Driver is used for DMA transfers for Serial engines
> > like Geni I2C and SPI.
> > 
> > Enable this dma driver
> > 
> 
> Can you please include a motivation in the commit message why this has
> to be builtin?

Sure, traditionally DMAengine drivers are always initialized early on (typically most
of the drivers are arch init level) so that it is available to users
early on as well..

Current config has many dmaengine drivers as inbuilt...

Will add more details and send

> 
> Thanks,
> Bjorn
> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 30516dc0b70e..d73913f082d7 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -948,6 +948,7 @@ CONFIG_PL330_DMA=y
> >  CONFIG_TEGRA20_APB_DMA=y
> >  CONFIG_TEGRA210_ADMA=m
> >  CONFIG_QCOM_BAM_DMA=y
> > +CONFIG_QCOM_GPI_DMA=y
> >  CONFIG_QCOM_HIDMA_MGMT=y
> >  CONFIG_QCOM_HIDMA=y
> >  CONFIG_RCAR_DMAC=y
> > -- 
> > 2.34.1
> > 

-- 
~Vinod
