Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42D516F30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384835AbiEBMFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiEBME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:04:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82001BA4;
        Mon,  2 May 2022 05:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41A05B816B3;
        Mon,  2 May 2022 12:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BB5C385AC;
        Mon,  2 May 2022 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651492886;
        bh=BO6LwlJ2aRePANHThfcAB5WN+7rxFLdfIADusHG87Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3nv69OLpF4JRUNJ+6tQKk6DcF4x3kMtBy8oBhs2HLXx7cObZlFh9tgr/7iN5PaZY
         0MaI2nnU5ErUChjOmVXixJ8G+fpkGguNEMX/+ZSVHRXXD437zBKfOLb/kU8JMsHONW
         SMJ+s9B7A9ezyajNrWVYusXbyLP221nNOnVrjGstwnm8fpVfsfl//46AfBtAh0CSnR
         EeRN8mpqIOx/k2YBzKBXKwo3cM71vEm6ePvC+Q4UImZNAd13jPX0IMpdruuL8tSRBr
         RKiP3fn8atVK21MldTQBrXliNfX4I6M2igG6vLXfqA3/B5hGv22QSNiyxICVSlbxRV
         HEWcyL9YF+VLA==
Date:   Mon, 2 May 2022 17:31:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 2/2] phy: qcom-qmp: fix pipe-clock imbalance on power-on
 failure
Message-ID: <Ym/IEbrYRXIxFPV5@matsya>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
 <20220420152331.5527-3-johan+linaro@kernel.org>
 <Ym+t5YVL8HdJaBl4@matsya>
 <Ym+yGa0xT82d9XOf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym+yGa0xT82d9XOf@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-22, 12:27, Johan Hovold wrote:
> On Mon, May 02, 2022 at 03:39:41PM +0530, Vinod Koul wrote:
> > On 20-04-22, 17:23, Johan Hovold wrote:
> > > Make sure to disable the pipe clock also if ufs-reset deassertion fails
> > > during power on.
> > > 
> > > Note that the ufs-reset is asserted in qcom_qmp_phy_com_exit().
> > > 
> > > Fixes: c9b589791fc1 ("phy: qcom: Utilize UFS reset controller")
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > index 8c2300bfe489..7d2d1ab061f7 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > @@ -5375,14 +5375,14 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
> > >  		if (ret) {
> > >  			dev_err(qmp->dev, "lane%d reset deassert failed\n",
> > >  				qphy->index);
> > > -			goto err_lane_rst;
> > > +			return ret;
> > 
> > This can be skipped if we retain the err_lane_rst label
> > 
> > >  		}
> > >  	}
> > >  
> > >  	ret = clk_prepare_enable(qphy->pipe_clk);
> > >  	if (ret) {
> > >  		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> > > -		goto err_clk_enable;
> > > +		goto err_reset_lane;
> > >  	}
> > >  
> > >  	/* Tx, Rx, and PCS configurations */
> > > @@ -5433,7 +5433,7 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
> > >  
> > >  	ret = reset_control_deassert(qmp->ufs_reset);
> > >  	if (ret)
> > > -		goto err_lane_rst;
> > > +		goto err_disable_pipe_clk;
> > 
> > this is the actual fix...
> 
> Right, but with a one-line fix this would read
> 
> 	goto err_pcs_ready;
> 
> which makes no sense at all. Is that really what you prefer?

Yes I feel for a fix we should always have the minimal changes.. makes
porting easier

> 
> Renaming just this one and the below one, would leave the error labels
> named using two different schemes, which also isn't very nice, but
> perhaps ok.
> 
> > >  
> > >  	qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
> > >  			       cfg->pcs_misc_tbl_num);
> > > @@ -5472,17 +5472,17 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
> > >  					 PHY_INIT_COMPLETE_TIMEOUT);
> > >  		if (ret) {
> > >  			dev_err(qmp->dev, "phy initialization timed-out\n");
> > > -			goto err_pcs_ready;
> > > +			goto err_disable_pipe_clk;
> > 
> > same rename here
> > 
> > >  		}
> > >  	}
> > >  	return 0;
> > >  
> > > -err_pcs_ready:
> > > +err_disable_pipe_clk:
> > >  	clk_disable_unprepare(qphy->pipe_clk);
> > > -err_clk_enable:
> > > +err_reset_lane:
> > >  	if (cfg->has_lane_rst)
> > >  		reset_control_assert(qphy->lane_rst);
> > > -err_lane_rst:
> > > +
> > >  	return ret;
> > 
> > while I feel the names given by this patch are better, they should not
> > be in a fix patch. We should just add the one line fix here and do
> > renames later
> 
> I'll respin if you prefer, just want to double check that you really
> want a one line fix (i.e. goto err_pcs_ready).

Yes please


-- 
~Vinod
