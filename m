Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2A585660
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiG2VIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2VIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:08:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5426B1EE;
        Fri, 29 Jul 2022 14:07:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so623765ejx.1;
        Fri, 29 Jul 2022 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnijszfNceP0fwRE0S8xAK/S1dlE8Lve0MOPfHF9xV0=;
        b=TI9PWFbrEKrjXRos/9Uo8Fvi8+uBVB871xSPksh4fZs05WK9/lANhyvc0xbCN6tHk/
         9dBct9Pt0lYPys6sF6tsmeWbbkabQDS+RKPHJjS/6+rSjoDY9js1grLMjcrlgo6FfzKO
         ekPVVXajRES1UZ17yhg11U37Z0c2MlzH3X0QdQktImVIyrgkQ9OuH9S+JkKtQAmscJyc
         mC18zyJf5bCY82iSZ6gsutlAayCQxof44H5aCu8ynT4WfBUitSS0KgrJomiycR8rk9xf
         +3FMiaHRsSxXuqi75mu3cBhiXJ9BVSahG+cCNAwbc34xeKaP323PmI6yqr3dkOlXpwyY
         hn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnijszfNceP0fwRE0S8xAK/S1dlE8Lve0MOPfHF9xV0=;
        b=d46danN7t0OHlC8YIfkjD0VPuZpnNyyIBgPAiHkOlnFD8yNnLAKs6wHJgNVUrxVanB
         iSUSKzbcX+30R2VLIr3oqFiNr5ck86JbD5uIBUnbFH2ZHTsdwEPAtZvnmuUv+obYCe8x
         GJc9NiY78BSoSB/qrcTLNVn8+v4JNMY3FfQ8TCM8U76b1h8NZRap+d/jdzndEQ0YQS7a
         gnnxm1rMJ4VNdIwQ/iwNHfWTJ1v+CUMw2d1TGkSYBEfn5yhrAvmJLP5ysQs1f5KSLDcb
         kGyalMD8Wvx7rmWqGAWCv/JcE1jWe0BwyonZUE8iK7Syfoy4qWYywC7LwpXNPjVOyUOb
         dh2A==
X-Gm-Message-State: AJIora8NJxR8byZhTOB0ZhdNfuqhgP/nDAOd8LlsIfhDEBL00oUfRNmc
        0qM1gyRVX1ZbWSCn5vCjiIo=
X-Google-Smtp-Source: AGRyM1s5LJD8uCF4WTdrT+orrBGrEqQdXLHZ5a3FoTVkc2Z91A5NB7j7CUbFczwBdb4cxLpFvRDo1g==
X-Received: by 2002:a17:907:1dca:b0:72b:3cb2:81f7 with SMTP id og10-20020a1709071dca00b0072b3cb281f7mr4046672ejc.567.1659128876170;
        Fri, 29 Jul 2022 14:07:56 -0700 (PDT)
Received: from calypso ([80.155.25.210])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0043a7293a03dsm2922061edv.7.2022.07.29.14.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jul 2022 14:07:55 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date:   Fri, 29 Jul 2022 23:07:53 +0200
To:     Mark Brown <broonie@kernel.org>
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Message-ID: <20220729210753.GA17925@calypso>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
 <YuEoLteLBgd+b8sg@sirena.org.uk>
 <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
 <YuJuzNiQczaYi1og@sirena.org.uk>
 <245f6090-9f92-8091-d8e6-735ab078c6c8@gmail.com>
 <YuPM6XqLBuA8A9eY@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPM6XqLBuA8A9eY@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/22 13:04:57, Mark Brown wrote:
> On Thu, Jul 28, 2022 at 11:59:03PM +0300, Iskren Chernev wrote:
> > 
> > 
> > On 7/28/22 14:11, Mark Brown wrote:
> > > On Thu, Jul 28, 2022 at 02:14:10AM +0300, Iskren Chernev wrote:
> > >> On 7/27/22 14:57, Mark Brown wrote:
> > >>> On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:
> > >
> > >>>> Add support for some regulator types that are missing in this driver, all
> > >>>> belonging to the FTSMPS426 register layout.  This is done in preparation
> > >>>> for adding support for the PM6125 PMIC.
> > >
> > >>>> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
> > >>>> +	.get_mode		= spmi_regulator_ftsmps426_get_mode,
> > >
> > >>> Why are set and get asymmetric?
> > >
> > >> Because the get method, only uses AUTO and HPM, which have the same value
> > >> for ftsmps3 and ftsmps426 (so there is no need for a new function).
> > >
> > > This needs at least a comment.
> > 
> > I agree, I think to add the function with the right macros, and comment
> > that it is the same now but might change in the future if support for mode
> > modes is added.
> > 
> > >>>> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
> > >>>>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
> > >>>>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
> > >>>>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
> > >>>> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
> > >>>> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
> > >
> > >>> The changelog said we were adding support for new types but this looks
> > >>> like changing an existing type.
> > >
> > >> The code, as written now does a different thing for BUCK, HFS430 (on
> > >> mainline (ML) and downstream (DS) linked in the commit message). Since DS
> > >> only supports newer stuff, to be on safe side, I kept existing behavior for
> > >> rev 0-3 on BUCK(3)+HFS430(10), so at least DS and ML agree on pm6125
> > >> completely.
> > >
> > > This needs describing in the changelog, probably you need multiple
> > > paches here since you are making a number of different changes each of
> > > which needs some explanation.
> > >
> > >> The commit [1] that adds support for BUCK+HFS430 might be wrong, or it
> > >> might be right for the time being (i.e initial revisions had different
> > >> behavior). I'm CC-ing Jorge.
> > >
> > > If that's the case perhaps part of this needs to be sent as a fix.
> > 
> > The Downstream patch is adding 3 logical types:
> > - LDO_510 -- these have new subtypes, so no existing PMICs are affected
> > - FTSMPS3 -- this has a new subtype (0xb), so no existing PMICs are
> >   affected
> > - HFSMPS -- this has the same type and subtype (BUCK+HFS430) as an existing
> >   mainline logical type (HFS430), both declaring 0-INF revisions.
> > 
> > So if we fully trust the downstream patch, I can make a fix for the
> > existing BUCK+HFS430+0-INF, so it uses the slighly modified mode values.
> > 
> > Currently the set mode fn differs in LPM mode (5 in the common2 case and
> > 4 in the common3 case), so if indeed downstream is correct it would mean
> > this regulator (when turned off) was set to an invalid mode (5 has
> > undefined meaning in common3 map) from 2019 onward.
> > 
> > On the other hand, if we assume downstream is wrong, then their code sets
> > 4, which actually means RETENTION (not LPM). I really don't know how this
> > could cause trouble. In fact downstream does a bunch of weird stuff, it
> > doesn't "just" set to LPM (like mainline), instead there is complex logic
> > per logical type and "initial mode". Or they're just masking this mistake
> > ;-)
> > 
> > TL;DR Jorge's mail is gone, so we can't get info from the original author.
> 
> Jorge moved to foundries.io, copying him in in case he remembers
> anything about this.

I am sorry, I really dont remember the details. I believe this was part of the
QCS404 upstreaming work so it would have been tested not just by us but also by
the release team working on the final product. Sorry I cant be of much help, it
has been a while.

> 
> > Another issue is I can't really test any other PMIC (and even my PMIC
> > I can't turn off most of the regs without loosing critical functionality,
> > and the BUCKs are kinda important :)).
> > 
> > So we can:
> > 1. politely ask for somebody with access to the secret sauce to say what is
> >    correct, at least according to the docs (with a timeout)
> > 2. assume downstream patch is right, and fix the existing HFS430 regulator
> > 3. maintain the current (patch) behavior, which likely won't affect older
> >    PMICs, but is still adhering to DS patch, because it adds support for
> >    this particular PMIC, so presumably it was tested and works with it
> > 4. drop the pmic patch and rely on SMD
> > 
> > Please advice.
> > 
> > In any case if we go with 2 or 3, I can split out this particular (BUCK)
> > part in a separate patch with more information/comments.


