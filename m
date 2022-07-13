Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC557382B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiGMOAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiGMOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 834FC2CE22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657720810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVM/9+bL0Plqw8a52QPl3k4n9Q1+GAafg2rUTujh0Gc=;
        b=C7MeA/4Cvzux7KlM9poxwLLOphu8PWeg/WjqbwGM9Gufr63eGbZBsoRhWvCslo6Z+EpLod
        2VRMFcy9MGUROEnhQrxLp2+sSev16rE5TS32z7p5kLa+9bnRHqe+H6/5jpCUoAa6O2y/WE
        ztIGCHspJ+JGWN8iOAQD0YOPaHvpvZc=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-bVFDepwbPdegTMuD_8Ckkw-1; Wed, 13 Jul 2022 10:00:08 -0400
X-MC-Unique: bVFDepwbPdegTMuD_8Ckkw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10c071638bbso5942024fac.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVM/9+bL0Plqw8a52QPl3k4n9Q1+GAafg2rUTujh0Gc=;
        b=AvbkIedOsUt0cWtMO4/61rdpTt4d8VWsSwifgwW/ZJHkcBWc5l0pGg8p5pJd/gj4Gp
         k5QmxAqZZW//H9gWAy7kL3tXMoIyrP+644WfllBH1DGs3ZDndWpg9NExqqNNuVBaiTN7
         /2oFmqfpNOc1xfGx100SIPXwyR/W6cqh2t41u8RdXbgdoUPwDFQv7+WDMRLLFETSVRze
         sV6XM1KjD6y4xI+k0uhZXIXyeym475uNeEidxXeCms+pgaXx4nVI587Ls3ACXWxZwHwz
         Hcb+bLOO+KDWO80F8zZvTsl4ET4kgSSl/fKw6FG2vp80dDYZBd9oBMafBasgzeOy52ja
         gzzA==
X-Gm-Message-State: AJIora9DNiYSW9fUoMvdpesb1wXMuFwNkocMbZay6B/U6pZtViFZSjVh
        f1HGMrigGiw9+vhdbOREyqHlpFKOCfLn/y3psjEwpvt2l52ak5x84blYY+yQvRoVpGqUlDjWcdE
        afW9rBZwg2oiFOByq+w2FXRVH
X-Received: by 2002:a05:6870:f149:b0:de:e873:4a46 with SMTP id l9-20020a056870f14900b000dee8734a46mr1710710oac.286.1657720807873;
        Wed, 13 Jul 2022 07:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWU5P/M2v4yhf5rjgNK8fNjmlmpbF71huQvwUWO4e55Sg67LK3nJe2ebY/U445BU5Ynrdnxw==
X-Received: by 2002:a05:6870:f149:b0:de:e873:4a46 with SMTP id l9-20020a056870f14900b000dee8734a46mr1710691oac.286.1657720807684;
        Wed, 13 Jul 2022 07:00:07 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id h82-20020aca3a55000000b00339ff117f38sm3726085oia.53.2022.07.13.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:00:07 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:00:05 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: dwc3: qcom: fix missing optional irq warnings
Message-ID: <20220713140005.qw3nhjlin4vobhvd@halaneylaptop>
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713131340.29401-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:13:36PM +0200, Johan Hovold wrote:
> Not all platforms have all of the four currently supported wakeup
> interrupts so use the optional irq helpers when looking up interrupts to
> avoid printing error messages when an optional interrupt is not found:
> 
> 	dwc3-qcom a6f8800.usb: error -ENXIO: IRQ hs_phy_irq not found
> 
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 77036551987a..c5e482f53e9d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -490,9 +490,9 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	int ret;
>  
>  	if (np)
> -		ret = platform_get_irq_byname(pdev_irq, name);
> +		ret = platform_get_irq_byname_optional(pdev_irq, name);
>  	else
> -		ret = platform_get_irq(pdev_irq, num);
> +		ret = platform_get_irq_optional(pdev_irq, num);
>  
>  	return ret;
>  }
> -- 
> 2.35.1
> 

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

