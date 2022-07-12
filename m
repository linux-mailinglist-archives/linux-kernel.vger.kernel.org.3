Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D4571020
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiGLC0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLC0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:26:01 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58632BAE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:26:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w184so2668615oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0de4wabST6gWpJe4bl9FhiTG19f2KboMVUf/03W2w0=;
        b=mraQedEo53DaR20MLo/XD9DrgTYhhYat0NLG5gsVAVCUelBl4IzXidM28mWJ6N3mPn
         sO8nhuF2eGMkgaaK+eAvoUn5mu9cAUSbrlfLsRFYkqyw4lRIWdGKX7Y0MI3NnSQ452za
         hHJ3EEau+/9Do9yM7LbY7ohz0luiZTGJnAhjntkwo0Zbnoa+ghNx63duZ7UdSf9w7quB
         Z7QeBSLTdVS8nRj+dnnAwchZAvVoEXkUQ1QMF0sGz7hT1ReozJkpqRfdx4E+K0y5gURj
         9i4XToAngTm4uExrYuFg3P+67OuIw54aPas74adFfnz+SbqjGPl1nsV1Gcu10ZBRrYDs
         lewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I0de4wabST6gWpJe4bl9FhiTG19f2KboMVUf/03W2w0=;
        b=F2XShdTfMu5HEd3tre3h9GamfYycTtV0Hns5Rk7IpGNhjFroQpiKdjkKgXt8nd+cui
         Y06B8h8vtOff3/qNaekJNRB722bJwNskt4w7jPAaU2Yip+AtsWbFkiZ+qOs1C7ksvCZn
         coYYqvkjA7YA26r4Ryiojm/sJyy9KkmjljgZbfV3+7/fwXGJbhTSZPGqBFYYU2NJicdU
         sVWjT0JVXG/MSkV+8mD0nnd0Bl7ZSMzq4IWMjU49574SJ8enAzz2Randqekbvsx+wIjg
         DR1HYKCie8RHVwYILxgaV8VojOOvEsHipEFS5ZOVxhwj9FwhXNTbybsX+iSYvrxy67kX
         lTOg==
X-Gm-Message-State: AJIora8REMH6UdkkC0uvqceiBXOkT7JMKqaUuop4tVROPBy0kiDpsDDW
        xMP5E042hng8ukzXA4HIKaQyYQ==
X-Google-Smtp-Source: AGRyM1sUnWyKKpqKOCAUzmjP+LImn3c2NF8v1If++//vIw8Dp+7FY1nDpxC+6kiS9NJrt0tL8qi0ug==
X-Received: by 2002:a05:6808:1184:b0:322:4c18:2f7e with SMTP id j4-20020a056808118400b003224c182f7emr795922oil.109.1657592759573;
        Mon, 11 Jul 2022 19:25:59 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p2-20020a056870830200b0010be09dc797sm3985546oae.18.2022.07.11.19.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:25:58 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:28:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <YszcSgnSrbsncw0J@ripper>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
 <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Jul 01:56 PDT 2022, Johan Hovold wrote:

> On Thu, Jul 07, 2022 at 09:08:58AM -0700, Bjorn Andersson wrote:
> > The timer node needs ranges specified to map the 1-cell children to the
> > 2-cell address range used in /soc. This addition never made it into the
> > patch that was posted and merged, so add it now.
> > 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 2bdb42c88311..37a4cd6f85b6 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -1667,6 +1667,7 @@ timer@17c20000 {
> >  			reg = <0x0 0x17c20000 0x0 0x1000>;
> >  			#address-cells = <1>;
> >  			#size-cells = <1>;
> > +			ranges = <0 0 0 0x20000000>;
> 
> While addressing the current issue, this looks odd to me. Why not use a
> non-zero parent bus address here instead?
> 

I guess we could express the frames relative the timer range, but that
would imply that anyone porting downstream dts snippets would have to
translate these addresses - or more likely would end up just copying the
existing cases.

> And please use hex notation consistently for the addresses.

That seems like a reasonable ask, I can fix that up. But on both
accounts this matches what I merged for all the other platforms in:

458ebdbb8e5d ("arm64: dts: qcom: timer should use only 32-bit size")


So I guess we'll also need to go back and fix up the style of all the
other platforms - just because we're not allowed to express the frames
in 64-bits according to the binding...

Regards,
Bjorn

> 
> >  
> >  			frame@17c21000 {
> >  				frame-number = <0>;
> 
> Johan
