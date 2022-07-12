Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F7571036
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiGLC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiGLC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:29:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6BD32443
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:29:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso5267302otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVUeMOT6CxdYKQvRRpgploiMAFLvvgb73Ly7V1pXLtk=;
        b=w5ImoHPEOa/orzfpbfnqn4nL6QRHkFGjjNQZYmkUBkWlQWVHk+DWOP6XqkSi6t1KB7
         oV3KAKH8llKXrEeE02drFReEMOKZfAPbgdso7aLtE5CW6Tzeu+wJMs1QJMi4gpCRnk8Z
         FmwYm1x8aNDd8Xa5JszYSJ5+ccl8QwZ5W/AEhQqCoJjAT1j+dMoU7ImlJyYR7b+ldiWn
         S7GWPKzQN6Q3YHuKvGXFQ1RG7xy7EeZzXVgN7cwP6ou0DFjie/FVcgA4TV+JU/jKV2pC
         LUC4uOKaiG5H40npL04prEQO0rx9gX0o/2LI+t1/0Hob/qmCb+in1KwYpwKp8M1yWs2d
         8ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVUeMOT6CxdYKQvRRpgploiMAFLvvgb73Ly7V1pXLtk=;
        b=7GTR1QxWUuvn3jDTehDf78GtPsyekFUyq3YH6BqQ3FVlXYPbi/Utx9LbfEa57gEmer
         ovhtFUfU5Vocf3IUoLGUwNjwrgd/Zuxku/8dAXBeOCCA0qY+gCl2Uxa/3wcLuuNU+goi
         EbTDDc9UUO7xl6elQdJh5tPNPVzWDSMbQFnThx/4pZ/L5/cgpMXhsIGUGaXORzjtfleY
         5w0NDvgMVmD1tt5BGNFcTnTtdo25vVRBACUYWuWWa6FgY6U5WLdflNHh9lEtcmcrPaHV
         13uAa0X9y0hx8cPbt/VSRMI3y6bqjmnUbd1e/fGg+8rHlmErCbaXXvfCcdvOHLm0sxOV
         Wv1g==
X-Gm-Message-State: AJIora9L9m+PSSd9q2+meMVofcTCHXiD4t4sAd2wdtWIg7c4xsOKYu/L
        Y721gOJIZFrQwWpquAFIVAzNKw==
X-Google-Smtp-Source: AGRyM1vYCldoBiX82cDLOxQEYA7mJU1VsMRs9GX5SixmhPO1n9olIa7E47iMVVuAsmvScqtcp0HjtQ==
X-Received: by 2002:a05:6830:314b:b0:61c:148c:4f34 with SMTP id c11-20020a056830314b00b0061c148c4f34mr8352234ots.283.1657592969782;
        Mon, 11 Jul 2022 19:29:29 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k18-20020a056870819200b0010c5005d427sm3998996oae.33.2022.07.11.19.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:29:29 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:31:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <YszdHHms/0yOzKCf@ripper>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
 <20220709065915.GG5063@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709065915.GG5063@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jul 23:59 PDT 2022, Manivannan Sadhasivam wrote:

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
> Even though this looks correct, I'm wondering why other SoCs are defining the
> child addresses in 2 cells. I don't think the timer frames can go beyond 32bit
> address space. Should we fix them too?
> 

Neither addresses nor sizes used for mmio need more than 32 bits, but
ranges and dma-ranges are expressed in #size-cells. So unless these
cells are 2 there's no way for us to express the fact that (most of) our
busses uses 36 address bits.

And we need to be able to do this, because the SMMU on multiple
platforms claims that the bus is 40 address bits, so we end up running
into issues with the upper 4 bits of IOVAs being truncated.

Regards,
Bjorn

> But for this patch,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> >  
> >  			frame@17c21000 {
> >  				frame-number = <0>;
> > -- 
> > 2.35.1
> > 
> 
> -- 
> ??????????????????????????? ????????????????????????
