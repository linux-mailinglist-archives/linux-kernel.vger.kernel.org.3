Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52B574996
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiGNJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGNJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:50:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A973FA3F;
        Thu, 14 Jul 2022 02:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72EBB823F5;
        Thu, 14 Jul 2022 09:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF1C3411C;
        Thu, 14 Jul 2022 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657792153;
        bh=TzdN4DW2zFgPK53RvV6YP1Fyg+vTq626K43wM14TO7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNRI8whqBTxPxnNMo+ZG1kdWF69F0pxEyEYPF0058tE1b9Wo3QuFfvqFem6LxIwVQ
         4vvIvFYg9lkWJSR+kAvzddzpz+nRCAEBBDq2EXUtayFOjf42KPUQyWBPO71V1G3glF
         BttOZh0IoLtrdfQpcqqNuA+nFx6umTrZDLYphdzRfMf6iSN4uPuKSfjjMkZPiAr4Vy
         RnQ6zqZszhQ5vY1ZXYPx29SZjvEEpQch/CtpWZThh9lq4E8Kmu8tVWdCYhZxK98HO0
         LSwnhGptJn19CwOvuyoe+Y2KKeGo2sXxrIWlJ5z/11bD4xR8/MgOKOPwFy+FGQXtAa
         FdRbZk6+6+wgA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBvTB-00059C-R1; Thu, 14 Jul 2022 11:49:17 +0200
Date:   Thu, 14 Jul 2022 11:49:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/30] phy: qcom-qmp-pcie-msm8996: drop pipe clock
 lane suffix
Message-ID: <Ys/mnU/092nTIiom@hovoldconsulting.com>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-29-johan+linaro@kernel.org>
 <a2706253-41c1-84fa-2e17-053759888214@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2706253-41c1-84fa-2e17-053759888214@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:30:36AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2022 15:47, Johan Hovold wrote:
> > The pipe clock is defined in the "lane" node so there's no need to keep
> > adding a redundant lane-number suffix to the clock name.
> > 
> > Update driver to support the new binding where the pipe clock name has
> > been deprecated by instead requesting the clock by index.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> > index 812d14afb5ec..af2f14a53b38 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> > @@ -872,7 +872,6 @@ int qcom_qmp_phy_pcie_msm8996_create(struct device *dev, struct device_node *np,
> >  	struct qcom_qmp *qmp = dev_get_drvdata(dev);
> >  	struct phy *generic_phy;
> >  	struct qmp_phy *qphy;
> > -	char prop_name[MAX_PROP_NAME];
> 
> Wait, it looks like your patchset is not bisectable. Be sure each commit
> compiles cleanly.

Ah, crap. I apparently fixed up the wrong commit when I noticed the
unused prop_name variable.

Will fix in v3.

Johan
