Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE0516FED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385132AbiEBNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385133AbiEBNEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:04:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93084167E3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:00:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 12so15072480oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvMAXXFuk42m4Zm5D1wvVDv7JZNalHrdw6XJOnjlZdQ=;
        b=g7PLjRJKRkitPqkdOGdclqkVcy2SPLaj1hzwwFuVS/mmJaYuoiq6vSSSp2XQ1oDGoO
         4aEcHRh56GZ60usCMXN66WpfzCpLm6wtyCHODWR9AXSuUOw5Iwd32+KfXJ82cR5ZT/9C
         7whkA/IzXe4Z+wN+k5YWqzrFedFHBBpLyzOu3hl5AVjbyRhYGA0TiPYAtWTs7HqM44xF
         M2TGevjkcpd7FEef4PzH0lgUJ+Yal2ehi4O9oqK9U1oxp7I7khIoUfJxVcjVpAW8qYEi
         H4uD8Wnyec4M2gHklp79iJPWxjcABYh215HbknoCfmw/SM0rUyW+FijHXSNmqr1Hk2L2
         muFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvMAXXFuk42m4Zm5D1wvVDv7JZNalHrdw6XJOnjlZdQ=;
        b=11nWq76IgrzlAbHgUM4MYrXH2HgvWb7mUEeYXGoxmkwefd0WMumRfUsPT6LhGxeW5q
         BQvgE5FR+EdGVogBebQ1eXpr2r+RWug7lKY8CiXWB65YhXzOiPRAeEVb62tESf/huuMQ
         H7CB74ET9aPzYMsgVqmn4kDuyqbOdGtkX5ZVJ8A8Xpa3E1DlSxpyjZOlEhSjTWlxffWM
         V+S68/VXwENZ+JoY/Q/8j4zhKoQ3E/rnxlzGC2QTRBcEyR9J5nsgy5GnKsWYIo1HIpg7
         WQE5GW2Qamkk7PhM81H1TRJYOO1CZ8f6hiiy9fRZAsdoyZX/9N1VENjLk9MEwvZ2vaBF
         zb/g==
X-Gm-Message-State: AOAM533KU5ilw9MGbwoqxnmsosrYCgh8IPgIcKR0dDomay/oe+ifOSAX
        fSuk3ev56+zHactFw2H2J+gSjw==
X-Google-Smtp-Source: ABdhPJyXKWTBYdyocOV4fnfAvovDbuReb0l3NAWGAkYnVWGjsah8Vm2D6BAsjkjLHEGDuw8kiHpH3A==
X-Received: by 2002:a05:6808:181b:b0:325:a076:7389 with SMTP id bh27-20020a056808181b00b00325a0767389mr5532540oib.146.1651496446714;
        Mon, 02 May 2022 06:00:46 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o24-20020a4ae598000000b0035eb4e5a6d0sm3814410oov.38.2022.05.02.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:00:46 -0700 (PDT)
Date:   Mon, 2 May 2022 06:02:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom-qmp: switch to explicit reset helpers
Message-ID: <Ym/WZ/rftlUGgF6q@ripper>
References: <20220427063243.32576-1-johan+linaro@kernel.org>
 <20220427063243.32576-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427063243.32576-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Apr 23:32 PDT 2022, Johan Hovold wrote:

> Switch to consistently using the explicit reset-controller API which
> makes it clear that the reset controllers are used exclusively by the
> PHY driver.
> 
> Note that the deprecated of_reset_control_get() and
> devm_reset_control_get() are just transitional wrappers for the explicit
> API so there's no functional change.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 3f77830921f5..160d723fc773 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -5701,7 +5701,7 @@ static int qcom_qmp_phy_reset_init(struct device *dev, const struct qmp_phy_cfg
>  		struct reset_control *rst;
>  		const char *name = cfg->reset_list[i];
>  
> -		rst = devm_reset_control_get(dev, name);
> +		rst = devm_reset_control_get_exclusive(dev, name);
>  		if (IS_ERR(rst)) {
>  			dev_err(dev, "failed to get %s reset\n", name);
>  			return PTR_ERR(rst);
> @@ -6099,7 +6099,7 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
>  	/* Get lane reset, if any */
>  	if (cfg->has_lane_rst) {
>  		snprintf(prop_name, sizeof(prop_name), "lane%d", id);
> -		qphy->lane_rst = of_reset_control_get(np, prop_name);
> +		qphy->lane_rst = of_reset_control_get_exclusive(np, prop_name);
>  		if (IS_ERR(qphy->lane_rst)) {
>  			dev_err(dev, "failed to get lane%d reset\n", id);
>  			return PTR_ERR(qphy->lane_rst);
> -- 
> 2.35.1
> 
