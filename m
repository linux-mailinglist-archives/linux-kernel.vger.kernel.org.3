Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B64FF54B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiDMK6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiDMK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:58:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24D5A09C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD993B820DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0085EC385A3;
        Wed, 13 Apr 2022 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649847357;
        bh=x/DfLNP13aIWRhDPgt4OxLhq9Lscy/vrCAdzrghAUD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBDZlrcL3OH4FgQG5F7z2lQUDB+gPyPZaGXcu82pYB9HDtmnkNsSAdm3NW8AO3YzI
         FD0Q3h9yAdoFUkwnxNQsVZTyiPIM4BAqepDs0ay1drtJWLvnPhqBI/xUBQLeYQqv3w
         o6v+LK+ExnVXnaAYtOV32BG6eGg7AOdLrUQBdy8LsJ8h3WfgbA16H65unJqXDf0r6I
         jrekv56LtA22lV4sI9q559KPh/Xuq+W+R1oj0dB3D47394bACWWKn0OP7uADadD7HB
         1kkA6OaVlLTG3LEXckuX2s47jcKIry57Y9t3q4D0B1zK+qF1hoR+ra2Vi13bds8ROk
         XrF0SVKuUVVoQ==
Date:   Wed, 13 Apr 2022 16:25:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy/motorola: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-ID: <YlasOb7q7ocMJ54i@matsya>
References: <20220413093627.2538442-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413093627.2538442-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-22, 09:36, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code

Can you explain why is it more appropriate?

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

where is this report?

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> index 5172971f4c36..8738d512131d 100644
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -253,12 +253,9 @@ static irqreturn_t phy_mdm6600_wakeirq_thread(int irq, void *data)
>  		return IRQ_NONE;
>  
>  	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n", wakeup);
> -	error = pm_runtime_get_sync(ddata->dev);
> -	if (error < 0) {
> -		pm_runtime_put_noidle(ddata->dev);
> -
> +	error = pm_runtime_resume_and_get(ddata->dev);
> +	if (error < 0)
>  		return IRQ_NONE;
> -	}
>  
>  	/* Just wake-up and kick the autosuspend timer */
>  	pm_runtime_mark_last_busy(ddata->dev);
> @@ -601,10 +598,9 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(ddata->dev,
>  					 MDM6600_MODEM_IDLE_DELAY_MS);
>  	pm_runtime_enable(ddata->dev);
> -	error = pm_runtime_get_sync(ddata->dev);
> +	error = pm_runtime_resume_and_get(ddata->dev);
>  	if (error < 0) {
>  		dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
> -		pm_runtime_put_noidle(ddata->dev);
>  		goto cleanup;
>  	}
>  
> -- 
> 2.25.1
> 

-- 
~Vinod
