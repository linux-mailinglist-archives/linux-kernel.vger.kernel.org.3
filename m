Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C650CB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiDWPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiDWPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:17:54 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70B1D4A4D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:14:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w23-20020a056830111700b00603c6d1ce73so7582199otq.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22eenijkFNhaFMADi9ElotDWSOkFn1tnTr48x0vYVAk=;
        b=GVdoeLER62JBuMZ1/XSDwKSXWJkTrASzMX5GiiwdNPfJpMt3lNuHKyAGznJg8Jj4YD
         Y0OgdPH+yHPluQvdKK3tdKlA4FhK00j6P8A+eVTuWE62F0BA+1BT9iPrsiEQhdeB0Lyv
         Mp55lWoI9zECwZV1oVFZ44zoPfl0NGOMvxjTvQzy57f8uBYv9cxvyEVwOAonr4A0dTy/
         FylA5e256esQ4NvjSDMgX+7TWx3tRd5+MhV6m1R/JrsoaVFNS4Zknfl56tfhL248WpNR
         ORX4eiJMnfEkp8WGVALV2vSEcA9fQNUvChHieI4oGExC8+50/kh7o16ztg8T6y4QK1w/
         OjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22eenijkFNhaFMADi9ElotDWSOkFn1tnTr48x0vYVAk=;
        b=qTm0cgL5HNQRdK06c4gAmMLKZV0wulBhAr/31g/SfIWIsnOXXgwfIavUallEdR58ut
         5Mb6BJhjag7E6Xh+QPQ4qqygqIU1jXFci3LHft5FLZOV2rWzKGbgbHOeqENwi4dyJNvw
         MlWoH6mHJbMPIA6NNErqcF2qbpR5NP4105PJaACbcZXh725O6dt8ur5yFBr39+ysiQSb
         aeuINGPIhiOIV5lGScg0SkD03uLHHPa9nGlW4T6D1WlAbmgaf5LLXBZTE+49TPxw7PDQ
         817zmhqjIxphsjsq1MSgt14GJE42wTiVH4VR0AABoS06a258N/wTVebcfRyMnxjmm+uX
         wOQA==
X-Gm-Message-State: AOAM531M5OA0z3jYY+hjSXYv8IkYnnZnbM7HRUebBXra92s7ZiJ4GTVx
        3+6kdiqONYHqERQflo5/63Zz4g==
X-Google-Smtp-Source: ABdhPJyb/SfQ9fd+qfhl32OUbxio3UtCSvHIoOgBXrvsGqMSbnLd4vidbHe+NzwDUCm28o1ezpfXrQ==
X-Received: by 2002:a9d:3624:0:b0:5e9:5778:d0c6 with SMTP id w33-20020a9d3624000000b005e95778d0c6mr3657575otb.367.1650726895781;
        Sat, 23 Apr 2022 08:14:55 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 1-20020a05687011c100b000de98359b43sm1684551oav.1.2022.04.23.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:14:55 -0700 (PDT)
Date:   Sat, 23 Apr 2022 08:16:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        linux-arm-msm@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        ahalaney@redhat.com
Subject: Re: [PATCH v2 2/5] scsi: ufs: qcom: Simplify handling of
 devm_phy_get()
Message-ID: <YmQYZ8l+QOsz11ld@ripper>
References: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
 <20220423140245.394092-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423140245.394092-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 Apr 07:02 PDT 2022, Manivannan Sadhasivam wrote:

> There is no need to call devm_phy_get() if ACPI is used, so skip it.
> The "host->generic_phy" pointer should already be NULL due to the kzalloc,
> so no need to set it NULL again.
> 
> Also, don't print the error message in case of -EPROBE_DEFER and return
> the error code directly.
> 
> While at it, also remove the comment that has no relationship with
> devm_phy_get().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index bee81b45299e..6ee33cc0ad09 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -1022,28 +1022,12 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		err = 0;
>  	}
>  
> -	/*
> -	 * voting/devoting device ref_clk source is time consuming hence
> -	 * skip devoting it during aggressive clock gating. This clock
> -	 * will still be gated off during runtime suspend.
> -	 */
> -	host->generic_phy = devm_phy_get(dev, "ufsphy");
> -
> -	if (host->generic_phy == ERR_PTR(-EPROBE_DEFER)) {
> -		/*
> -		 * UFS driver might be probed before the phy driver does.
> -		 * In that case we would like to return EPROBE_DEFER code.
> -		 */
> -		err = -EPROBE_DEFER;
> -		dev_warn(dev, "%s: required phy device. hasn't probed yet. err = %d\n",
> -			__func__, err);
> -		goto out_variant_clear;
> -	} else if (IS_ERR(host->generic_phy)) {
> -		if (has_acpi_companion(dev)) {
> -			host->generic_phy = NULL;
> -		} else {
> +	if (!has_acpi_companion(dev)) {
> +		host->generic_phy = devm_phy_get(dev, "ufsphy");
> +		if (IS_ERR(host->generic_phy)) {
>  			err = PTR_ERR(host->generic_phy);
> -			dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
> +			if (err != -EPROBE_DEFER)
> +				dev_err_probe(dev, err, "Failed to get PHY\n");

I believe the idiomatic form is:
			err = dev_err_probe(dev, PTR_ERR(host->generic_phy), "Failed to get PHY\n");


But as with the previous patch, please remove the condition and you have
my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  			goto out_variant_clear;
>  		}
>  	}
> -- 
> 2.25.1
> 
