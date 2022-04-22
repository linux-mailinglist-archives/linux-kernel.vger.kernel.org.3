Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557AB50BD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449853AbiDVQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444743AbiDVQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3755F276
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650646267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RP65Uj7WP6EZyZBfeufvI+9bp/deJnrcdnu1tws0K2A=;
        b=Sh+RI4qzipwvz36dpAQno5dGL6bHP5Q/1mVC/ZfMmAmGmFFbVM+TwpMa6S3KHgapEzTWt/
        U5hnDs1CJWiJn/34X0jmA+GDFugOUrqST+39vRBnlAVea3TvdvXPN+buD8jdfEuqvCyGG2
        mil2XxTZQ6Fak5AS5fxOFkF6vWJSHuo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-VIR_kJDlMziqi_bD4qr2Lg-1; Fri, 22 Apr 2022 12:51:06 -0400
X-MC-Unique: VIR_kJDlMziqi_bD4qr2Lg-1
Received: by mail-qt1-f200.google.com with SMTP id r16-20020ac87950000000b002f34f162c75so3067048qtt.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RP65Uj7WP6EZyZBfeufvI+9bp/deJnrcdnu1tws0K2A=;
        b=UfuyrPRWxePWrShY1Ax3UJdMaL6BOiGZkk222PQQv7Mtb0T6VtCu0hIeQLd1BIHEsv
         dAdrlZTB3HpbqadObBLiV6kVnhkYK3MEVe4uFMxWBKF31i0jzwAp43ZUUL/oAwNRyjIJ
         WTGbUPdOJZLL21laizsu9Re6mQD+s7hy3rrkfckHuNZEq9YzYyIhLUXhu+xCVpyJsvxQ
         8vDVcdJ9u2FqkyZ0vO92D9zSAPQOHZx/+DzDPX78rdttUK8ut0JQWCe4YIBHMm9SQjoe
         uXH9Jb4ol7H5yaihUeIDfjOVqdStbPD7RHsRhbas80UAHttaR2dXdtgSrVatGsbz+Ba2
         CS3A==
X-Gm-Message-State: AOAM531gK04+RprRIyYhlaHWAsXSr6hDCOQSYPoDPeKNL8nxF2RZO9Rs
        qdE8BlXwcz3lAwgz98Nz/cAJIHKGsPwx5GaT0hVqXA56bGWiYyheUlvld3iE2qb7ceX5sNCEnJ5
        GcbzeTePXzp85aYNjUoI3jtnX
X-Received: by 2002:a37:6181:0:b0:69e:7b8a:e72c with SMTP id v123-20020a376181000000b0069e7b8ae72cmr3255238qkb.388.1650646265968;
        Fri, 22 Apr 2022 09:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGjpvtzYiKxHawYsICXnZfMhkhwABbqQn0p9KPy6KU0/ydqClvRwXk3Olfd1QtTvoihYpO3g==
X-Received: by 2002:a37:6181:0:b0:69e:7b8a:e72c with SMTP id v123-20020a376181000000b0069e7b8ae72cmr3255217qkb.388.1650646265599;
        Fri, 22 Apr 2022 09:51:05 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id e16-20020ac85990000000b002f33eb4523asm1542421qte.18.2022.04.22.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:51:04 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:51:01 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] scsi: ufs: qcom: Simplify handling of devm_phy_get()
Message-ID: <20220422165101.uy23jf3conuxr2iw@halaneylaptop>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
 <20220422132140.313390-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422132140.313390-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:51:37PM +0530, Manivannan Sadhasivam wrote:
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
> index 5db0fd922062..5f0a8f646eb5 100644
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
> +				dev_err(dev, "Failed to get PHY: %d\n", err);

Risking sounding like a bad broken record, but I think this too could
use dev_err_probe().

Looks good to me otherwise!

>  			goto out_variant_clear;
>  		}
>  	}
> -- 
> 2.25.1
> 

