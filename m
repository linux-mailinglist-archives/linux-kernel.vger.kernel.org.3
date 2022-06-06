Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB7553E999
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiFFNqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiFFNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:46:17 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC201C2D60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:46:16 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso19154362fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTpWPSxN0cL0aVs3iLR/HmIswwTyMjklIN9jCgr7T+Q=;
        b=FcPDlAGsBBZqIo/U7deOp4+kp/FFXUkJnzTHVfhMBmEPyi9B3VzXHpf9gxN0z9WkZE
         zMex9FE2JL2CXklp11tM+RvrBj2sYpgTHD7by7BoUHU3pZmfwFqd8lcUpyC1rjyBO1bm
         YCd03N3WPWfcU+4W6kh7sCBKnMJnjOmWzjjWZWdg4XY4USYk6DjUd77G1FNecYHavaK9
         aGMnGYduuyWNrQl6bnFZuv9IHGX89Lrc6mq3xecc153xREDsJw++jqd/pn3Abtox+NkW
         wzKxonhke55kKh88L6qB9H87YfwIf04YwnblGT9+aG1335WeM4zWDlhR7pVeun0+kLQB
         ViWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTpWPSxN0cL0aVs3iLR/HmIswwTyMjklIN9jCgr7T+Q=;
        b=hBJSNMYX/cAVwGooToCkuWz+b8oFVQOIfERkGL2gscd9snP/CzUfZN3QS9Vex64REj
         T2LCwMrdt7D7wQ/innTVqAGHfPg/cTN8qtKvPPqjbvXf+VG31ujkAp4U7iT5vsExvNGj
         rtJKZx+cnfo5LAKiIasjblX4DD3E7LH3Tssim6DmQwy8tirXAEpLR0aEUNlp6CK1uMPZ
         gE1A0rp+yL2xKS+E524c0KV6mP+AY2sgSEb5NALt5ATqQ4/76oO4/ZBoIy98YDRQ6g4/
         SPGtbs96chBMYRTLVkpzZf4QLJlOm91pjoh+lQ2G0A51bVU+V5Y9OWAJTRNNBj2rIGm1
         spzw==
X-Gm-Message-State: AOAM533f8QC2+yU+MkFD0uRvET+CQgNT+91yR2bEJj+vDKtvCRHmmgTe
        v3ysbnVWfY0TksQewZI+mDKWyg==
X-Google-Smtp-Source: ABdhPJzjWkyxD1qfFKANpxzk990e+EpRbqV/OdMD73IIFh/8xr2wLPUb0uOpjWjw5mrkS+7u1j/ptw==
X-Received: by 2002:a05:6870:8184:b0:f5:dd95:7ef7 with SMTP id k4-20020a056870818400b000f5dd957ef7mr13883037oae.117.1654523174846;
        Mon, 06 Jun 2022 06:46:14 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id pu7-20020a0568709e8700b000f5e33aaa66sm6770625oab.0.2022.06.06.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:46:14 -0700 (PDT)
Date:   Mon, 6 Jun 2022 06:48:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/3] phy: qcom-edp: add regulator_set_load to edp phy
Message-ID: <Yp4FtznlEzNKmRPZ@ripper>
References: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
 <1653512540-21956-2-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653512540-21956-2-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 May 14:02 PDT 2022, Kuogee Hsieh wrote:

> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..7e357078 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -639,6 +639,18 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = regulator_set_load(edp->supplies[0].consumer, 21800); /* 1.2 V vdda-phy */
> +	if (ret) {
> +		dev_err(dev, "failed to set load at %s\n", edp->supplies[0].supply);
> +		return ret;
> +	}
> +
> +	ret = regulator_set_load(edp->supplies[1].consumer, 36000); /* 0.9 V vdda-pll */
> +	if (ret) {
> +		dev_err(dev, "failed to set load at %s\n", edp->supplies[1].supply);
> +		return ret;
> +	}
> +
>  	ret = qcom_edp_clks_register(edp, pdev->dev.of_node);
>  	if (ret)
>  		return ret;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
