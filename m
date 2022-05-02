Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80ED516DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356543AbiEBKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEBKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:13:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5E236;
        Mon,  2 May 2022 03:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D91C2B8136B;
        Mon,  2 May 2022 10:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2D2C385B1;
        Mon,  2 May 2022 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651486186;
        bh=eeqZLYnN/1wfZnDKzK6bSzgVXoLjuy6VTAHe1gNkj8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsc67eFIgRE7zQI8bJj/bWCd3viDNCuupn72WdNqIh++Rl3YiVQDwYJanG8HxO7b5
         FBswIPm3WwF7+07yGmXLqxYIaC465p/QHQ+B1cXVwdjnDRnSgmx5RA17P8jbjGNYFz
         2Mdtodt7TsFdfPeuBw/Qw63VkapSVAv+jCasPJWK2d/2rQIVXSL5NQfNz7sQQtfwRd
         LSO1+3umf7xkx/TZ2pXmXtUsCDDYWDv5XdxMH68+k7oRDsJe+fTz0m9nv04H5E+32l
         nqGgS1FNlkPPpEJs9bS6NbQaxYVZ96tBcukCbCoekgklvkLejMr5EjojUvgQmQYsXo
         Zv0VqyzgaUi9Q==
Date:   Mon, 2 May 2022 15:39:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 2/2] phy: qcom-qmp: fix pipe-clock imbalance on power-on
 failure
Message-ID: <Ym+t5YVL8HdJaBl4@matsya>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
 <20220420152331.5527-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420152331.5527-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-22, 17:23, Johan Hovold wrote:
> Make sure to disable the pipe clock also if ufs-reset deassertion fails
> during power on.
> 
> Note that the ufs-reset is asserted in qcom_qmp_phy_com_exit().
> 
> Fixes: c9b589791fc1 ("phy: qcom: Utilize UFS reset controller")
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 8c2300bfe489..7d2d1ab061f7 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -5375,14 +5375,14 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
>  		if (ret) {
>  			dev_err(qmp->dev, "lane%d reset deassert failed\n",
>  				qphy->index);
> -			goto err_lane_rst;
> +			return ret;

This can be skipped if we retain the err_lane_rst label

>  		}
>  	}
>  
>  	ret = clk_prepare_enable(qphy->pipe_clk);
>  	if (ret) {
>  		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> -		goto err_clk_enable;
> +		goto err_reset_lane;
>  	}
>  
>  	/* Tx, Rx, and PCS configurations */
> @@ -5433,7 +5433,7 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
>  
>  	ret = reset_control_deassert(qmp->ufs_reset);
>  	if (ret)
> -		goto err_lane_rst;
> +		goto err_disable_pipe_clk;

this is the actual fix...

>  
>  	qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
>  			       cfg->pcs_misc_tbl_num);
> @@ -5472,17 +5472,17 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
>  					 PHY_INIT_COMPLETE_TIMEOUT);
>  		if (ret) {
>  			dev_err(qmp->dev, "phy initialization timed-out\n");
> -			goto err_pcs_ready;
> +			goto err_disable_pipe_clk;

same rename here

>  		}
>  	}
>  	return 0;
>  
> -err_pcs_ready:
> +err_disable_pipe_clk:
>  	clk_disable_unprepare(qphy->pipe_clk);
> -err_clk_enable:
> +err_reset_lane:
>  	if (cfg->has_lane_rst)
>  		reset_control_assert(qphy->lane_rst);
> -err_lane_rst:
> +
>  	return ret;

while I feel the names given by this patch are better, they should not
be in a fix patch. We should just add the one line fix here and do
renames later

>  }
>  
> -- 
> 2.35.1

-- 
~Vinod
