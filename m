Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A75117F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiD0MmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiD0Mlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C6BE59949
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651063120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5T2mzcnLGwMqpeR6jrzAYwjw0tWje8edHf2UQdVa4A=;
        b=Co1fUC3eP2z3cPzZqRomEKsHLwo7ufTz9gmlWjLK0E1b/zXXhIBxdYFeJYOJcZaEx+cm5u
        Q09vqVahsz6+fw3B17gOEaHRipBY7n1oKyr4kE+y+7fFTCG1Gkh0hM5LTHA+ByijyRt0hG
        ahQgf5hYE0JFjlyQjEU0FQQD7NUj18c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-gNE4EU4GO22Y9MhOwi-UAw-1; Wed, 27 Apr 2022 08:38:39 -0400
X-MC-Unique: gNE4EU4GO22Y9MhOwi-UAw-1
Received: by mail-qt1-f198.google.com with SMTP id bb32-20020a05622a1b2000b002f1f41e6caeso977508qtb.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5T2mzcnLGwMqpeR6jrzAYwjw0tWje8edHf2UQdVa4A=;
        b=qnqhj3d2waPkGID5t0x35gN1mgOCB/5jiFrNWCb3CbWgIMfo7a6Mpmggj0KGG9MHDk
         QOzR7dM1e2zunZ2YwMSctFPPSX5Bz/eLQqN07+nGw8DLqqYRH+A4p9RI65KThzpKBLS3
         fwMTDxdDr5tSbgwA+vwtrpCSeFHpw66Y5PVnsQ8doyN0/J+bsarDS5RU9dOa7SlU1F00
         55mOhG5ufeOIVg/s6nbiJ7QN8YcVvH7GVZb1YhD86Md4eGZg9o4fkvF/RPDOa+rQpJ+j
         3nw2wzbcuvKFvWVp27bR8c/yFwu07HiFgF2yO0V83DuL5F9vcSvdOkritg/LCzvgQ+uy
         Flrg==
X-Gm-Message-State: AOAM533QWBr3t4x25waNlP2y+C/ClhvD3+tk66hb7iG4W4g5iSpVcFgz
        iWy+fEMP+JhWuWnmMPqO3nxDfQlwO0T2a72FRwtCEa5/rZCh3YWuJPqh8zrrtZodWhIMOB3jyw7
        sp9UmY8j03vMN/+sC1BiLUPqc
X-Received: by 2002:a37:9c2:0:b0:69e:c2b3:7120 with SMTP id 185-20020a3709c2000000b0069ec2b37120mr16241123qkj.150.1651063118418;
        Wed, 27 Apr 2022 05:38:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGDRMFfPx3BNBiON+Vbt8m+O9ygcWAUz2DFQIfNuuFEMKm5cj6DQH71r3jcUKRi5p2wmmBJA==
X-Received: by 2002:a37:9c2:0:b0:69e:c2b3:7120 with SMTP id 185-20020a3709c2000000b0069ec2b37120mr16241113qkj.150.1651063118186;
        Wed, 27 Apr 2022 05:38:38 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id 186-20020a3707c3000000b0069f9a8cbec2sm149714qkh.131.2022.04.27.05.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:38:37 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:38:35 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh
 power-domains
Message-ID: <20220427123835.hmfdu66ut3uvvtjp@halaneylaptop>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
 <20220426233508.1762345-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426233508.1762345-4-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:35:08PM -0700, Bjorn Andersson wrote:
> The Qualcomm sc8280xp platform has 13 and the sa8540p platform has 11
> power-domains. Add compatibles, the typically used ones power-domains
> and their relevant active-only variants, to the RPMh power-domain
> driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Added QPHY
> - Split out sa8540
> - Sorted the entries alphabetically
> 
>  drivers/soc/qcom/rpmhpd.c | 53 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index f8d28e902942..05fff8691ee3 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -180,6 +180,36 @@ static struct rpmhpd mxc_ao = {
>  	.res_name = "mxc.lvl",
>  };
>  
> +static struct rpmhpd nsp = {
> +	.pd = { .name = "nsp", },
> +	.res_name = "nsp.lvl",
> +};
> +
> +static struct rpmhpd qphy = {
> +	.pd = { .name = "qphy", },
> +	.res_name = "qphy.lvl",
> +};
> +
> +/* SA8540P RPMH powerdomains */
> +static struct rpmhpd *sa8540p_rpmhpds[] = {
> +	[SC8280XP_CX] = &cx,
> +	[SC8280XP_CX_AO] = &cx_ao,
> +	[SC8280XP_EBI] = &ebi,
> +	[SC8280XP_GFX] = &gfx,
> +	[SC8280XP_LCX] = &lcx,
> +	[SC8280XP_LMX] = &lmx,
> +	[SC8280XP_MMCX] = &mmcx,
> +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> +	[SC8280XP_MX] = &mx,
> +	[SC8280XP_MX_AO] = &mx_ao,
> +	[SC8280XP_NSP] = &nsp,
> +};
> +
> +static const struct rpmhpd_desc sa8540p_desc = {
> +	.rpmhpds = sa8540p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8540p_rpmhpds),
> +};
> +
>  /* SDM845 RPMH powerdomains */
>  static struct rpmhpd *sdm845_rpmhpds[] = {
>  	[SDM845_CX] = &cx_w_mx_parent,
> @@ -378,10 +408,33 @@ static const struct rpmhpd_desc sc8180x_desc = {
>  	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
>  };
>  
> +/* SC8280xp RPMH powerdomains */
> +static struct rpmhpd *sc8280xp_rpmhpds[] = {
> +	[SC8280XP_CX] = &cx,
> +	[SC8280XP_CX_AO] = &cx_ao,
> +	[SC8280XP_EBI] = &ebi,
> +	[SC8280XP_GFX] = &gfx,
> +	[SC8280XP_LCX] = &lcx,
> +	[SC8280XP_LMX] = &lmx,
> +	[SC8280XP_MMCX] = &mmcx,
> +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> +	[SC8280XP_MX] = &mx,
> +	[SC8280XP_MX_AO] = &mx_ao,
> +	[SC8280XP_NSP] = &nsp,
> +	[SC8280XP_QPHY] = &qphy,
> +};

The commit messages mention sc8280xp having 13 power domains, but here I
only count 12. Good chance I'm just missing something obvious (not
familiar with using power domains or rpmh) but I thought I should
highlight it in case that was an error.

I attempted to find where this sort of thing is defined downstream, but
failed :(

Thanks,
Andrew

> +
> +static const struct rpmhpd_desc sc8280xp_desc = {
> +	.rpmhpds = sc8280xp_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
> +};
> +
>  static const struct of_device_id rpmhpd_match_table[] = {
> +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
>  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
>  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>  	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
>  	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
> -- 
> 2.35.1
> 

