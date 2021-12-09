Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6746E1B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhLIEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLIEwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:52:15 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F596C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:48:42 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so1448622ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 20:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UzPrDz37TsbgctSbF3jQc1Www5xR/uLVIm/OIh4LH2s=;
        b=pAgQQ1bgUJN66G/xpqk6sN1Ime7Y0O4qp5cVTQJqayrV5KAFuoiw26TORvLt8r4csa
         EoT2O8NlRQwcYcI9nDJG5UZZZVUM7ObMEvrdQXrCuEPsDb9vpSO97e4ztjc72QBaljaV
         gdld3FSuEhonRopMY2va2tW0weV284CGbfPGkWVvXMohwl4RWtWTlhxRWzAhRJ5CuSYQ
         uo/faMw3tvgr/xMpAqlJYB3T8xPHft4qiZQ+fT//xwkTmMg7YB1tzM2fZ2n79Loqohyw
         g/fGDYCbZDkmqnsydUUi7rGFqjiWWGc7juN7Wh799PrdVt/HfrUS0CUp3tuUhg89Zl+S
         lYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UzPrDz37TsbgctSbF3jQc1Www5xR/uLVIm/OIh4LH2s=;
        b=k/qtbDTjoiVUwgNOVye92LOmNVDWEx3sIz3Y8bp6ps2nMB+W2FEvpXoyvIlnwMf1hf
         EpcWN/0qCof2+N7zVZdCs+FLdJ1imeEtY0+Q0LazAylreDpVBqRyYcmBXb6nJAZf2aUX
         xeazJG9ZkHryFi0qGqiiaP1Gd/Wpowe1A9YDAiAwMEd3i5ktAkJ+VIRhvrqiC/GrQN4V
         FFA10MZwM3ZRvP6X8NXmm8BS5sqbyNhnT9egnuHnNcEHFUxdJNNkA8QU5YyQvvo8ZPTN
         aYzpb6Iulz5hkRPaxFWpPKz+tjlEirUZEvkPg/TfRKdHklrLKy+vOFMwQQgot0VA5aIG
         mKVg==
X-Gm-Message-State: AOAM531dqwNAdP6RqAiIzbCGhzv4MywSh35AhfvFsBdK73SnQiMajHgJ
        Heg+Rwizb2EsjPsfj4rmen9ERg==
X-Google-Smtp-Source: ABdhPJzVriX9cyPCHvhpXlfeRj4kbtylQnj9PMKFLon2CWif8CeJ1hyJB5YbK8VCDsdi+6L5U4UZbw==
X-Received: by 2002:a4a:e155:: with SMTP id p21mr2592272oot.84.1639025321519;
        Wed, 08 Dec 2021 20:48:41 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l9sm805883oom.4.2021.12.08.20.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 20:48:41 -0800 (PST)
Date:   Wed, 8 Dec 2021 20:50:06 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] phy: qcom: use struct_size instead of sizeof
Message-ID: <YbGK/iNJYqtgF1kD@ripper>
References: <20211207131642.5313-1-guozhengkui@vivo.com>
 <20211209032114.9416-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209032114.9416-1-guozhengkui@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Dec 19:21 PST 2021, Guo Zhengkui wrote:

> Use struct_size() to get the accurate size of `clk_hw_onecell_data`
> with a variable size array, instead of sizeof(data) to get the size
> of a pointer.
> 

Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 17d5653b661d..a8ecd2e8442d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
>  	struct clk_init_data init = { };
>  	int ret;
>  
> -	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
> +	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -- 
> 2.20.1
> 
