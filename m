Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D08569F48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiGGKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiGGKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:14:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BB4F650;
        Thu,  7 Jul 2022 03:14:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n4so12284534ejz.10;
        Thu, 07 Jul 2022 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=YpAR7TmXPCDhHigczovOhgl9/VH0Cnby1owEkNjCg9I=;
        b=SwvhaF5LOCH8M0F2PMGiwu2lf/lSfdGEm1pFHoE8QbLM2ms/52S2A8YQ0yC5qu3v8U
         nfqWs+mCJkU+jOvy8hzDpB8viqqG6MXQainY48bLZbvdpsq7mzfkUjfuCCFAXoot27gM
         SO2VKA7HeVJOqm4raBG2dzBeN4rUlOoNwvVNc0BqGHsVnQm8OUVudk3xI102JEHa5Vx3
         Sc3coFKCDUOEW/uZ+DkVMsEzAnc3hA8GKDzTD2vbTS251e9SrIT2EYFOGKKiLJkNucI2
         FC4dwdz7NS04TL+qclbbSLjriqiiNsp4P9K1gmeplIcIo8nB2qsI4jobN4xUC5Z88hQS
         XYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=YpAR7TmXPCDhHigczovOhgl9/VH0Cnby1owEkNjCg9I=;
        b=s23dG3cZtEMIbGtT0t/KJs1BOBuJUoh0XY36zwI5fMbMgKBIXXCosDodVE4VvW5NWs
         ZBxfDpipyQOixmcJgxcS79rcukUNru8RRWd9T+x8eMZrk7oUIJ1ChO5IflocUxT16Vtk
         Bm4Auhn2fZ552pJy3Oi2Iv71WsG/T9L96R5yY+yEk8dTTrdnyAXe8qLTlH47/JepbK1S
         IRu1K/DiRly2Xa2VI84Sds2AbFilXpPvF2C07LFqG1cJxmhZVGlwcScBZCuZDvGFaD5F
         2ywpmCNYgPq8FMBBU3MvcKEIXYfsDtaX992BTjX2a3kPaR/vVY+rYoaB6FEo7HgVggat
         7XmQ==
X-Gm-Message-State: AJIora8XGZobklKDdYhPrAGU/oz351qbpK+icEsHUtkoLcEC/Otbv3hD
        T9C3zNYDW35LB78R8TtGZBY=
X-Google-Smtp-Source: AGRyM1v5Hrf3EpHZJdxZHIVTnsQVb10GKT40NRFtbM2eeJFI5601I9sLz3UPjwqi0yjaQPB8t46MZQ==
X-Received: by 2002:a17:906:9b93:b0:722:f3e8:3f5e with SMTP id dd19-20020a1709069b9300b00722f3e83f5emr44295102ejc.65.1657188889096;
        Thu, 07 Jul 2022 03:14:49 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709067ac500b006fee526ed72sm18711502ejo.217.2022.07.07.03.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:14:48 -0700 (PDT)
Message-ID: <62c6b218.1c69fb81.e948d.0de6@mx.google.com>
X-Google-Original-Message-ID: <YsayF4iu5PtG5bh1@Ansuel-xps.>
Date:   Thu, 7 Jul 2022 12:14:47 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] hwspinlock: qcom: Add support for mmio usage to
 sfpb-mutex
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
 <YsZKuUAc2iHWg9kN@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsZKuUAc2iHWg9kN@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:53:45PM -0500, Bjorn Andersson wrote:
> On Wed 06 Jul 20:30 CDT 2022, Christian Marangi wrote:
> 
> > Allow sfpb-mutex to use mmio in addition to syscon.
> > 
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/hwspinlock/qcom_hwspinlock.c | 32 ++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
> > index 364710966665..23c913095bd0 100644
> > --- a/drivers/hwspinlock/qcom_hwspinlock.c
> > +++ b/drivers/hwspinlock/qcom_hwspinlock.c
> > @@ -19,6 +19,11 @@
> >  #define QCOM_MUTEX_APPS_PROC_ID	1
> >  #define QCOM_MUTEX_NUM_LOCKS	32
> >  
> > +struct qcom_hwspinlock_of_data {
> > +	u32 offset;
> > +	u32 stride;
> > +};
> > +
> >  static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
> >  {
> >  	struct regmap_field *field = lock->priv;
> > @@ -63,9 +68,20 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
> >  	.unlock		= qcom_hwspinlock_unlock,
> >  };
> >  
> > +static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
> > +	.offset = 0x4,
> > +	.stride = 0x4,
> > +};
> > +
> > +/* All modern platform has offset 0 and stride of 4k */
> > +static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
> > +	.offset = 0,
> > +	.stride = 0x1000,
> > +};
> > +
> >  static const struct of_device_id qcom_hwspinlock_of_match[] = {
> > -	{ .compatible = "qcom,sfpb-mutex" },
> > -	{ .compatible = "qcom,tcsr-mutex" },
> > +	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
> > +	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
> > @@ -101,7 +117,7 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
> >  	return regmap;
> >  }
> >  
> > -static const struct regmap_config tcsr_mutex_config = {
> > +static const struct regmap_config qcom_hwspinlock_mmio_config = {
> 
> Any objections against me skipping this rename when applying the patch?
> Just to keep the patch to the point?
> 
> Regards,
> Bjorn
>

I will send v2 with the name reverted and another fix. 

> >  	.reg_bits		= 32,
> >  	.reg_stride		= 4,
> >  	.val_bits		= 32,
> > @@ -112,18 +128,20 @@ static const struct regmap_config tcsr_mutex_config = {
> >  static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
> >  						 u32 *offset, u32 *stride)
> >  {
> > +	const struct qcom_hwspinlock_of_data *data;
> >  	struct device *dev = &pdev->dev;
> >  	void __iomem *base;
> >  
> > -	/* All modern platform has offset 0 and stride of 4k */
> > -	*offset = 0;
> > -	*stride = 0x1000;
> > +	data = of_device_get_match_data(dev);
> > +
> > +	*offset = data->offset;
> > +	*stride = data->stride;
> >  
> >  	base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(base))
> >  		return ERR_CAST(base);
> >  
> > -	return devm_regmap_init_mmio(dev, base, &tcsr_mutex_config);
> > +	return devm_regmap_init_mmio(dev, base, &qcom_hwspinlock_mmio_config);
> >  }
> >  
> >  static int qcom_hwspinlock_probe(struct platform_device *pdev)
> > -- 
> > 2.36.1
> > 

-- 
	Ansuel
