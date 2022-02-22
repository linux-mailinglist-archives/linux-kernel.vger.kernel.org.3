Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488CD4C0111
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiBVSOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiBVSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:14:48 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794D172898
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:14:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y7so15462304oih.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LVnQOEdOfsSROklcR4dN5XSqlK3ehHzd57yMiFQiZEw=;
        b=gACc9RkTQBgrInQOVXfQ1pKbHWcF+vW7yEcgUKHfbJNaSRgH0VSAeKEPmgvoPrsGtM
         1OHOpOzefMJ6TeAtuAiFsTjcl2Z9l/sYaFMYHKdbQPiC1OAZZrnJ783k277cmUAHT3Ak
         cpk2Wqa53ywX5ZF0emDkit0q3oOUM3KphJLlH5nz/ouLpXXye4c+4fATKRJl6SNpHWGk
         BiqWCZVClbCg7zcgsHIHRxq8t0cu1KJSPZT06YHqjR46WEnl8XruiaDoUWfA1ygDLGUh
         j3BYR4yVxu5WbWo7sy10d0FagAti8sZxg5eSabztkpnrb6Tsoa782kR5Ws+gEaC70TFs
         Cj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVnQOEdOfsSROklcR4dN5XSqlK3ehHzd57yMiFQiZEw=;
        b=IFIstDVxg7dQ9N1X4o9TvO56l5deB9snfekYbjxXvpUB+Q8bgTmRu8o9KmDbfKbHqc
         0C4T8lv2iDsrTj+satTTHAaL68k2oEFHTRuXmEQZ6G2uC3PTOuJBSA7j0mACjML/zoYL
         rzz14CFk7GHx/FrmCIeRj5QXzHzqMCv2CHEDRDpifm1hkwMtAVzU0TZaY1Z/og7nz4+e
         XxdjwSKoqKCkxUept4TLKS20k+4ItpTMmjf4lW0poy/Kl/8Upi/e9h4NT7/WX8p/bNjF
         zlw+sC9sA+ugg6yj+5wvEGPJA/LtObLwtfFHheUgpepXEKD6yh7JH6NJAWth09QRzAP8
         C2Rw==
X-Gm-Message-State: AOAM531wvVROMGRaxBXZODHpUN5NV3Rgj+/0dKmAbiSnYjzFIAVzvT57
        Hca+EKqC73v687BMvMlEboZ1oQ==
X-Google-Smtp-Source: ABdhPJx7kZEQxrj35Gmb41f+nvIkI4s49gKjv/NLrazcdAlObCeL+cSnEQ3LUMdDYmBlxChh3xHItg==
X-Received: by 2002:aca:ba83:0:b0:2d4:13f1:8530 with SMTP id k125-20020acaba83000000b002d413f18530mr2556490oif.169.1645553661373;
        Tue, 22 Feb 2022 10:14:21 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id c14sm7909698ots.71.2022.02.22.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:14:20 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:16:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 09/15] scsi: ufs: deprecate 'freq-table-hz' property
Message-ID: <YhUodbzxx4wbr+gy@ripper>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-10-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-10-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Feb 06:58 PST 2022, Krzysztof Kozlowski wrote:

> The 'freq-table-hz' is not correct in DT schema, because '-hz' suffix
> defines uint32 type, not an array.  Therefore deprecate 'freq-table-hz'
> and use 'freq-table' instead.
> 

Patch looks good in itself, but why don't we use opp-table to describe
the performance states?

In particular looking at the two columns of frequencies for various
Qualcomm boards they require different performance-states.

A concrete example is sm8350.dtsi, which specifies 75MHz and 300MHz as
the first frequency pair. The lower level requires the VDD_CX power rail
to be at least &rpmhpd_opp_low_svs, the higher frequency has a
required-opps of &rpmhpd_opp_nom.


As this isn't possible to express in the current binding we've just been
forced to always run at a higher voltage level and kept this in the todo
list.

But rather than migrating freq-table-hz to freq-table and then having to
introduce an opp table to express the power constraints, could we
perhaps skip the intermediate step?

Or would you have any other suggestion about how we can represent the
required-opps level together with the freq-table (if that's what we want
to stick with).

Regards,
Bjorn

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 87975d1a21c8..2b192477d158 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -47,8 +47,9 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  	if (cnt <= 0)
>  		goto out;
>  
> -	if (!of_get_property(np, "freq-table-hz", &len)) {
> -		dev_info(dev, "freq-table-hz property not specified\n");
> +	if (!of_get_property(np, "freq-table", &len) ||
> +	    !of_get_property(np, "freq-table-hz", &len)) {
> +		dev_info(dev, "freq-table property not specified\n");
>  		goto out;
>  	}
>  
> @@ -57,7 +58,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  
>  	sz = len / sizeof(*clkfreq);
>  	if (sz != 2 * cnt) {
> -		dev_err(dev, "%s len mismatch\n", "freq-table-hz");
> +		dev_err(dev, "%s len mismatch\n", "freq-table");
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -69,12 +70,16 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  		goto out;
>  	}
>  
> -	ret = of_property_read_u32_array(np, "freq-table-hz",
> +	ret = of_property_read_u32_array(np, "freq-table",
>  			clkfreq, sz);
>  	if (ret && (ret != -EINVAL)) {
> -		dev_err(dev, "%s: error reading array %d\n",
> -				"freq-table-hz", ret);
> -		return ret;
> +		ret = of_property_read_u32_array(np, "freq-table-hz",
> +						 clkfreq, sz);
> +		if (ret && (ret != -EINVAL)) {
> +			dev_err(dev, "%s: error reading array %d\n",
> +				"freq-table", ret);
> +			return ret;
> +		}
>  	}
>  
>  	for (i = 0; i < sz; i += 2) {
> @@ -99,7 +104,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  
>  		if (!strcmp(name, "ref_clk"))
>  			clki->keep_link_active = true;
> -		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
> +		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table",
>  				clki->min_freq, clki->max_freq, clki->name);
>  		list_add_tail(&clki->list, &hba->clk_list_head);
>  	}
> -- 
> 2.32.0
> 
