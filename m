Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDDC5138F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349633AbiD1Ptl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349620AbiD1Ptk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:49:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8C15A20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:46:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r1so5565259oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72XL9ljJSCpyh1igSvHXXmfQ5X9YflA33+3u5daUI/Q=;
        b=JkKdzH8ICBBnlV+qYWl8+s1yiWj+Sp1dn1ttrs9LsHxukOuc9DYojUjBHUB+7Emp+/
         qnLwofWO/Afewv1Up5imHJxgSUuKQs03JD4f3os1S88QdSlGuAEBi2MNfRlRd41cT0dB
         EY8x3xtSmZXYGE4R2FgC6lZB+I/VlOjR05czDNC6zsDQWfJ3VXFXEjWHEcDr4wcZAN2g
         UtSDjrRcU4sQiv5m2qQT7+/Vh99fT+FNLVeWVgHL13jaOdcs5hCW9f+cPnQkitW8g+5W
         +cxeGg5+nafAYEKN2h/zG39bmIF1pisSb1mRdxLAVBzhv/LFEMQR5LnBhUgnITIGMii/
         jbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72XL9ljJSCpyh1igSvHXXmfQ5X9YflA33+3u5daUI/Q=;
        b=cWihtA+yTeXgmlC4d9XAnRxYsltZwgJc4gFCmTUMNZ3Q0II2dMONCJyXqTSbbAT9PA
         y+qPWX76HQWRdB6nzWfFFw9jPT7X3IAGdyFof7Zzv1wFrqUq2W6ExByCpYxygIy0QIuD
         jw6Cgb/FZx5KWm9NX/FZOocLwwyog9MzwFIWsfX/oo+HyPBmKdlKrDh0G5nspqvqyY6D
         f3YJj3+FRFCo0jvN+od2B1zJ9W6eLMk2FCpToLOgg4wPSb+MAaV0yFRoEig2L2/JA+vT
         DUHFwih+AQpG3Nuotbe5PmriPXTKN3S0ZvxTOv0Qx93XJzSfGjulhgCDbxNXa9hj1kWl
         znAg==
X-Gm-Message-State: AOAM533FtxLq8IJmyq/DNZ4lE3RqE+CKFac7iNHUsQlHY1lwkTusUyNo
        9KZDYQD6NBCEQYnHlHLKAL1fIJp0Fi9h+JYZ
X-Google-Smtp-Source: ABdhPJzPU4DOMgYNbXIxKVtSpLb8juWKCap4L4LCdbY0DlEyzGnlKd+RKNZOlV4GT7Oa3YDWgx8nEQ==
X-Received: by 2002:a05:6808:1b14:b0:322:f715:a9d5 with SMTP id bx20-20020a0568081b1400b00322f715a9d5mr18929182oib.275.1651160783518;
        Thu, 28 Apr 2022 08:46:23 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870d58300b000e686d1389csm2146978oao.54.2022.04.28.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:46:22 -0700 (PDT)
Date:   Thu, 28 Apr 2022 08:48:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh
 power-domains
Message-ID: <Ymq3QfFnSplnEBRK@ripper>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
 <20220426233508.1762345-4-bjorn.andersson@linaro.org>
 <20220427123835.hmfdu66ut3uvvtjp@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427123835.hmfdu66ut3uvvtjp@halaneylaptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Apr 05:38 PDT 2022, Andrew Halaney wrote:

> On Tue, Apr 26, 2022 at 04:35:08PM -0700, Bjorn Andersson wrote:
> > The Qualcomm sc8280xp platform has 13 and the sa8540p platform has 11
> > power-domains. Add compatibles, the typically used ones power-domains
> > and their relevant active-only variants, to the RPMh power-domain
> > driver.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Added QPHY
> > - Split out sa8540
> > - Sorted the entries alphabetically
> > 
> >  drivers/soc/qcom/rpmhpd.c | 53 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > index f8d28e902942..05fff8691ee3 100644
> > --- a/drivers/soc/qcom/rpmhpd.c
> > +++ b/drivers/soc/qcom/rpmhpd.c
> > @@ -180,6 +180,36 @@ static struct rpmhpd mxc_ao = {
> >  	.res_name = "mxc.lvl",
> >  };
> >  
> > +static struct rpmhpd nsp = {
> > +	.pd = { .name = "nsp", },
> > +	.res_name = "nsp.lvl",
> > +};
> > +
> > +static struct rpmhpd qphy = {
> > +	.pd = { .name = "qphy", },
> > +	.res_name = "qphy.lvl",
> > +};
> > +
> > +/* SA8540P RPMH powerdomains */
> > +static struct rpmhpd *sa8540p_rpmhpds[] = {
> > +	[SC8280XP_CX] = &cx,
> > +	[SC8280XP_CX_AO] = &cx_ao,
> > +	[SC8280XP_EBI] = &ebi,
> > +	[SC8280XP_GFX] = &gfx,
> > +	[SC8280XP_LCX] = &lcx,
> > +	[SC8280XP_LMX] = &lmx,
> > +	[SC8280XP_MMCX] = &mmcx,
> > +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> > +	[SC8280XP_MX] = &mx,
> > +	[SC8280XP_MX_AO] = &mx_ao,
> > +	[SC8280XP_NSP] = &nsp,
> > +};
> > +
> > +static const struct rpmhpd_desc sa8540p_desc = {
> > +	.rpmhpds = sa8540p_rpmhpds,
> > +	.num_pds = ARRAY_SIZE(sa8540p_rpmhpds),
> > +};
> > +
> >  /* SDM845 RPMH powerdomains */
> >  static struct rpmhpd *sdm845_rpmhpds[] = {
> >  	[SDM845_CX] = &cx_w_mx_parent,
> > @@ -378,10 +408,33 @@ static const struct rpmhpd_desc sc8180x_desc = {
> >  	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
> >  };
> >  
> > +/* SC8280xp RPMH powerdomains */
> > +static struct rpmhpd *sc8280xp_rpmhpds[] = {
> > +	[SC8280XP_CX] = &cx,
> > +	[SC8280XP_CX_AO] = &cx_ao,
> > +	[SC8280XP_EBI] = &ebi,
> > +	[SC8280XP_GFX] = &gfx,
> > +	[SC8280XP_LCX] = &lcx,
> > +	[SC8280XP_LMX] = &lmx,
> > +	[SC8280XP_MMCX] = &mmcx,
> > +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> > +	[SC8280XP_MX] = &mx,
> > +	[SC8280XP_MX_AO] = &mx_ao,
> > +	[SC8280XP_NSP] = &nsp,
> > +	[SC8280XP_QPHY] = &qphy,
> > +};
> 
> The commit messages mention sc8280xp having 13 power domains, but here I
> only count 12. Good chance I'm just missing something obvious (not
> familiar with using power domains or rpmh) but I thought I should
> highlight it in case that was an error.
> 

The "typically used ones" in the commit message "captures" that. Further
more _AO is just a variant of the non-_AO resources, referring to votes
that should only apply when the CPU subsystem is not power collapsed.

So what you have in this list is 10 power domains.

I added defines for all 13 in the DT binding, so comparing with that
you'll see that the missing ones are DDR, MSS and XO. I don't see how we
would use these from Linux today. So let's postpone adding them until we
have a use case.

> I attempted to find where this sort of thing is defined downstream, but
> failed :(
> 

In direwolf-regulators.dtsi you'll find entries with qcom,resource-name
of "*.lvl". These resource names are matches against the Command DB
registry, which you can dump using the cmd-db file in debugfs.

Regards,
Bjorn

> Thanks,
> Andrew
> 
> > +
> > +static const struct rpmhpd_desc sc8280xp_desc = {
> > +	.rpmhpds = sc8280xp_rpmhpds,
> > +	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
> > +};
> > +
> >  static const struct of_device_id rpmhpd_match_table[] = {
> > +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
> >  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
> >  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
> >  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> > +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
> >  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
> >  	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
> >  	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
> > -- 
> > 2.35.1
> > 
> 
