Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287385146C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357487AbiD2K3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357526AbiD2K3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:29:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE3888FF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:25:41 -0700 (PDT)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18996488;
        Fri, 29 Apr 2022 12:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651227940;
        bh=1Xnk+9h8L/Uh9EPmBELuWhe3TE/MnwgMo8Cl0drwiSs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aN2FBRRqYbFGc2+KSsTRrmeegGxNSY6OtHnE6t6d5GSlEZYG84YDtzr22IlCAmmWt
         yjOttGB+euSvxEWzJywGe8SdPRxW7SNSYwgRcdGGBBGdQHs4OGxVFPIjoleUcCG7Fm
         gE9DKVsV+yE5XUzN3ecwHI8REqIrX4KHK+9ISxNI=
Message-ID: <3deffccf-1708-60bf-2b63-7a77305ec7e6@ideasonboard.com>
Date:   Fri, 29 Apr 2022 13:25:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] omapdss: HDMI: simplify the return expression of
 hdmi_init_pll_data()
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220429090135.3852817-1-chi.minghao@zte.com.cn>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220429090135.3852817-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 12:01, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> index eea719243eaf..10c6b3e492d3 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> @@ -131,7 +131,6 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>   {
>   	struct dss_pll *pll = &hpll->pll;
>   	struct clk *clk;
> -	int r;
>   
>   	clk = devm_clk_get(&pdev->dev, "sys_clk");
>   	if (IS_ERR(clk)) {
> @@ -151,11 +150,7 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>   
>   	pll->ops = &hdmi_pll_ops;
>   
> -	r = dss_pll_register(dss, pll);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return dss_pll_register(dss, pll);
>   }

This is a rather pointless change, and I personally like the current 
style better.

  Tomi
