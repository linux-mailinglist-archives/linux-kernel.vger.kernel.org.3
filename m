Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5152F119
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351818AbiETQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349426AbiETQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:50:56 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B417E2D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:50:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e5e433d66dso10936453fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=udeMWIeImL8Et9KO+nQSrMb5ZhN50mdpj9tL8FAbJ98=;
        b=dSjL9hAHlZbIAXLFy2vchTxfjAqvwKvgE1MNoILsPw9WyYz0+UXNWHA0Bk8DDpr+Yy
         ulkoazNolUDBiOy5AGpy+c7A4tJWN1T6GpN++geAI5LfyRvjbhacoj37KDkh7v4gfs1f
         OLnuxI8/tnHwDzPtXMc1iLSM2V3W+FnGQkyINXLRrhJfigGM8PkuZN8FgNNoLChZW/jn
         52BC/7Vg2ZYSvXmnO/mumTnDZcDxkO8zR4HcODOoI3HohQ5+2oDvQerdqLWXSs7c21Ui
         H3VBQs+lvfKAPGFoZgF+pilzfTFyb+VjwCY2EkAIlBdLxs7eYYaOr/FesMklva8Qn/NT
         iuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udeMWIeImL8Et9KO+nQSrMb5ZhN50mdpj9tL8FAbJ98=;
        b=K24uQznGH7tzSQWukYyHz/VNKz0M+gasa2t0dWBo5U91UJ19n2XhLzfIAjkmS+N1xj
         yOJ6uoKKLR5U14nu8kWF5im9kMGc/r8thfzMCFzye7GFYO9E9wwf3Kt6qBcpDUlptSji
         H68JC0IDpClrcIsIvkujcbuobdgHRTh7bXrgL5Tztg9ZUmOjO+SO01kRScmmhrDO7w9B
         HRN83ehn8oT9CpnMPu5cdaJQf82aqiOSK+1sf7ydgHDJ2mhPJxRI37d8n0tsGLH3CXuU
         iH2qG8OlxnytwaCqpM7h/pzi+n6B+lp67CHroOvdqHk975j7lWQgeUmss7jlrTAKDsoE
         YlHA==
X-Gm-Message-State: AOAM532bDPWndOJ8Otn9NWnxXXOAIJo8f/X7dD+SGITp6pd5P50ui9XT
        UPrsGySdtKleb3tBjFDCB6nSKg==
X-Google-Smtp-Source: ABdhPJygoccuSwJYhUd2CBzkd7UbxWWji/qDYdUC+b+SAmRANKb8lEqtNI/xUMGbleCdUTv+0fxA6Q==
X-Received: by 2002:a05:6870:5b89:b0:f1:d956:dee2 with SMTP id em9-20020a0568705b8900b000f1d956dee2mr6659444oab.72.1653065452505;
        Fri, 20 May 2022 09:50:52 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g6-20020a056870214600b000f1b1ff7b8bsm1071185oae.51.2022.05.20.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:50:51 -0700 (PDT)
Date:   Fri, 20 May 2022 09:53:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] phy: qcom-edp: add regulator_set_load to edp phy
Message-ID: <YofHdpcWJGQtERPy@ripper>
References: <1653064021-25400-1-git-send-email-quic_khsieh@quicinc.com>
 <1653064021-25400-2-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653064021-25400-2-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 May 09:26 PDT 2022, Kuogee Hsieh wrote:

> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..afd9e17 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -87,12 +87,17 @@ struct qcom_edp {
>  
>  	struct clk_bulk_data clks[2];
>  	struct regulator_bulk_data supplies[2];
> +	int enable_load[2];
>  };
>  
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>  	struct qcom_edp *edp = phy_get_drvdata(phy);
>  	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(edp->supplies); i++)
> +		regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);

The regulator framework only accounts for the load of enabled regulator
consumers, so you should be able to just call regulator_set_load() right
after devm_regulator_bulk_get() and not carry the enable_load array of
static constants.

Regards,
Bjorn

>  
>  	ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
>  	if (ret)
> @@ -635,6 +640,8 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  
>  	edp->supplies[0].supply = "vdda-phy";
>  	edp->supplies[1].supply = "vdda-pll";
> +	edp->enable_load[0] = 21800;	/* load for 1.2 V vdda-phy supply */
> +	edp->enable_load[1] = 36000;	/* load for 0.9 V vdda-pll supply */
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
>  	if (ret)
>  		return ret;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
