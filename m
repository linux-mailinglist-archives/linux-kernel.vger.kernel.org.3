Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6B513999
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiD1QXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349894AbiD1QXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 390F35D1AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651162786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vq8RC9NK7ljExipax9OnZpDPFBAwe7JTpMhljndmQRY=;
        b=cM0oEUH8AtVPBpQ2kISTpmcxqOc9F2y8HTVj3jHYEcu6l+pXCbELA4HvLu/Azmwzq2aH1H
        XQJcY1YhdE1aVlDA0acSKvUmWcP4OoxAAXiPO3puxpJNErjM3h7imsO0QMV/XHJImGeZ0g
        it6096EDUV4H2KRkTcmW48rQbfSj3zA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-mbQBnuSlOcSLVpjC3O-Z2A-1; Thu, 28 Apr 2022 12:19:44 -0400
X-MC-Unique: mbQBnuSlOcSLVpjC3O-Z2A-1
Received: by mail-qv1-f70.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso4057072qva.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vq8RC9NK7ljExipax9OnZpDPFBAwe7JTpMhljndmQRY=;
        b=O44PWe5Vu3sm6Y35DlWA7HRnTgVhJhWcYnEJGmUDummLVk45yyXaqjXDnv1ZTMGAcj
         /TgT3ok0vq0nzi11kqZn9ZL37G+DqQQMZvQHIyLMeFzMY2c5U4phBnQFtpY+LOQhQMwO
         zTU6/t6KHbIcVC/6QDLE2cBdcn5fGBo25tOlI3OpNsWWUSJG+IxttpuSLwXSA+1BO8vy
         jCuukD/y8pOZmAxDMF8ilJleBgSjAYpzf6Iv37+BWppvWTfl6N5XARMnVWEYzV+kb3h6
         vRDuF5OtvjCMwjt2qSH71TP/5gwaQYL1Zq2+scIbfUW9Hu49QIWBiZIPqx+7YmarQlnt
         XhbA==
X-Gm-Message-State: AOAM532R/lzrpqDgMBHjND49k/vh4Cbn+UqREU5kHPdDuZyyjk6woLjp
        WetewNVHZaiRaBT4kEbVgxxhfshhTge7b+8/MAmAVSm0txcr/HHPjrzT0sziReRfhtSFsmtLkcF
        iNCogcQORfVSkKF0iphrjGVp8
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id c23-20020a05620a269700b00699cca7f8b2mr20439364qkp.738.1651162784400;
        Thu, 28 Apr 2022 09:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz89Zo8kITvvA07ZT8XsQZFb2wfFp3rudks9OXnYWZ3EAYrQs+0vm9GqeZHvObJXgK9VgXxMg==
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id c23-20020a05620a269700b00699cca7f8b2mr20439351qkp.738.1651162784135;
        Thu, 28 Apr 2022 09:19:44 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm197795qtk.37.2022.04.28.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:19:43 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:19:41 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh
 power-domains
Message-ID: <20220428161941.mp53l4puglpei6kt@halaneylaptop>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
 <20220426233508.1762345-4-bjorn.andersson@linaro.org>
 <20220427123835.hmfdu66ut3uvvtjp@halaneylaptop>
 <Ymq3QfFnSplnEBRK@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymq3QfFnSplnEBRK@ripper>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:48:17AM -0700, Bjorn Andersson wrote:
> On Wed 27 Apr 05:38 PDT 2022, Andrew Halaney wrote:
> 
> > On Tue, Apr 26, 2022 at 04:35:08PM -0700, Bjorn Andersson wrote:
> > > The Qualcomm sc8280xp platform has 13 and the sa8540p platform has 11
> > > power-domains. Add compatibles, the typically used ones power-domains
> > > and their relevant active-only variants, to the RPMh power-domain
> > > driver.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > > 
> > > Changes since v1:
> > > - Added QPHY
> > > - Split out sa8540
> > > - Sorted the entries alphabetically
> > > 
> > >  drivers/soc/qcom/rpmhpd.c | 53 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > > index f8d28e902942..05fff8691ee3 100644
> > > --- a/drivers/soc/qcom/rpmhpd.c
> > > +++ b/drivers/soc/qcom/rpmhpd.c
> > > @@ -180,6 +180,36 @@ static struct rpmhpd mxc_ao = {
> > >  	.res_name = "mxc.lvl",
> > >  };
> > >  
> > > +static struct rpmhpd nsp = {
> > > +	.pd = { .name = "nsp", },
> > > +	.res_name = "nsp.lvl",
> > > +};
> > > +
> > > +static struct rpmhpd qphy = {
> > > +	.pd = { .name = "qphy", },
> > > +	.res_name = "qphy.lvl",
> > > +};
> > > +
> > > +/* SA8540P RPMH powerdomains */
> > > +static struct rpmhpd *sa8540p_rpmhpds[] = {
> > > +	[SC8280XP_CX] = &cx,
> > > +	[SC8280XP_CX_AO] = &cx_ao,
> > > +	[SC8280XP_EBI] = &ebi,
> > > +	[SC8280XP_GFX] = &gfx,
> > > +	[SC8280XP_LCX] = &lcx,
> > > +	[SC8280XP_LMX] = &lmx,
> > > +	[SC8280XP_MMCX] = &mmcx,
> > > +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> > > +	[SC8280XP_MX] = &mx,
> > > +	[SC8280XP_MX_AO] = &mx_ao,
> > > +	[SC8280XP_NSP] = &nsp,
> > > +};
> > > +
> > > +static const struct rpmhpd_desc sa8540p_desc = {
> > > +	.rpmhpds = sa8540p_rpmhpds,
> > > +	.num_pds = ARRAY_SIZE(sa8540p_rpmhpds),
> > > +};
> > > +
> > >  /* SDM845 RPMH powerdomains */
> > >  static struct rpmhpd *sdm845_rpmhpds[] = {
> > >  	[SDM845_CX] = &cx_w_mx_parent,
> > > @@ -378,10 +408,33 @@ static const struct rpmhpd_desc sc8180x_desc = {
> > >  	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
> > >  };
> > >  
> > > +/* SC8280xp RPMH powerdomains */
> > > +static struct rpmhpd *sc8280xp_rpmhpds[] = {
> > > +	[SC8280XP_CX] = &cx,
> > > +	[SC8280XP_CX_AO] = &cx_ao,
> > > +	[SC8280XP_EBI] = &ebi,
> > > +	[SC8280XP_GFX] = &gfx,
> > > +	[SC8280XP_LCX] = &lcx,
> > > +	[SC8280XP_LMX] = &lmx,
> > > +	[SC8280XP_MMCX] = &mmcx,
> > > +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> > > +	[SC8280XP_MX] = &mx,
> > > +	[SC8280XP_MX_AO] = &mx_ao,
> > > +	[SC8280XP_NSP] = &nsp,
> > > +	[SC8280XP_QPHY] = &qphy,
> > > +};
> > 
> > The commit messages mention sc8280xp having 13 power domains, but here I
> > only count 12. Good chance I'm just missing something obvious (not
> > familiar with using power domains or rpmh) but I thought I should
> > highlight it in case that was an error.
> > 
> 
> The "typically used ones" in the commit message "captures" that. Further
> more _AO is just a variant of the non-_AO resources, referring to votes
> that should only apply when the CPU subsystem is not power collapsed.
> 
> So what you have in this list is 10 power domains.
> 
> I added defines for all 13 in the DT binding, so comparing with that
> you'll see that the missing ones are DDR, MSS and XO. I don't see how we
> would use these from Linux today. So let's postpone adding them until we
> have a use case.
> 
> > I attempted to find where this sort of thing is defined downstream, but
> > failed :(
> > 
> 
> In direwolf-regulators.dtsi you'll find entries with qcom,resource-name
> of "*.lvl". These resource names are matches against the Command DB
> registry, which you can dump using the cmd-db file in debugfs.
> 
> Regards,
> Bjorn

Thanks, I really appreciate the explanation. This makes sense to me.

> 
> > Thanks,
> > Andrew
> > 
> > > +
> > > +static const struct rpmhpd_desc sc8280xp_desc = {
> > > +	.rpmhpds = sc8280xp_rpmhpds,
> > > +	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
> > > +};
> > > +
> > >  static const struct of_device_id rpmhpd_match_table[] = {
> > > +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
> > >  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
> > >  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
> > >  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> > > +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
> > >  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
> > >  	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
> > >  	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
> > > -- 
> > > 2.35.1
> > > 
> > 
> 

