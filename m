Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA2560F61
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiF3DBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF3DB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:01:28 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BC35255
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:01:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-fe023ab520so24040428fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCr9cRfs56yqMpVTk7a3xjU0D0ojSFJS/cwqqD+Mwz4=;
        b=ngUr5JbTktZVsE6b2wDE1emh5U9bmodR1UAxMTaBlSmDUGWfFYPF3wHBXMfWDLhXJP
         n/qR3sHWGifYOYsNOe74r8A7wqpV/cesxilsWLRghFsNRtAiSswOYuEwZCzpIZDM1mh4
         cKfY1eb1jLbJ2Np34J5VHv9VzLSC+4/6Dxq/YDe6t6A1x7fdJOPt+wSNTOqPxh82hKFg
         LnoP6om9Tnfe576LjxKLp0K278QRD3f4+Vip0mBihn04GR101VPqaq56NsBtiFAiPmQb
         WImKFM4Yyk0gySnNu8yRXroRN8EUYk49/CXhSQYtGjNmsbDqPrrFaYqTevr3ohwuwQnH
         G3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yCr9cRfs56yqMpVTk7a3xjU0D0ojSFJS/cwqqD+Mwz4=;
        b=v13EscJ8h4Hj9AeZQwoXTXmKJa0G7HqeUOgxGAVYWXM8/Y67GPQ/secyw5uarg5jVZ
         Rlk4I12NX6T4oEBgLrJ/7Fa1pRpcEC1yo5fHz6bImQ842Dq+JT67Ydp/8+syVirf2RYQ
         i19l+F2HYmGIBs6ouOz8g7XGMuxZrSm0Q1nsrTc3RkgR8Sxs4ZvfxhQmttbnOJ1s/Vrx
         O6Ynb2O/M8z+ikv05pu3lRNpxZLVyBfQj3WfhAo/+LyAj45xMQvw4KsrO27JhGBo7TNw
         GfrsIP1JHlPnJFC5dAXC33pJGpBSsojL3vnfdMDAOSxJmi+MsrpTAT0ZjS3Ag/9jIkvt
         8RDQ==
X-Gm-Message-State: AJIora/H9tnvxaCD1pVgfIs79UuEYG01/JM5uciPOEMavQUPS1rBJanF
        nOx/taObBw5/N9CvXAPcQsBzaQ==
X-Google-Smtp-Source: AGRyM1vxT3RmDtNp225rcfbgqMVN0MXLUHrf6ZTMF6e39DiFAQWayxlwxzX45ESPDVpd+TEJvUiPCg==
X-Received: by 2002:a05:6870:cd06:b0:108:c466:4c7e with SMTP id qk6-20020a056870cd0600b00108c4664c7emr3752591oab.62.1656558085963;
        Wed, 29 Jun 2022 20:01:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cm8-20020a056870b60800b00101d05c2245sm12219096oab.37.2022.06.29.20.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 20:01:24 -0700 (PDT)
Date:   Wed, 29 Jun 2022 22:01:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: add SC8280XP platform
Message-ID: <Yr0SAkPYoP5FD8r9@builder.lan>
References: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
 <20220629041438.1352536-4-bjorn.andersson@linaro.org>
 <Yryc8AUIPoWmeyB9@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yryc8AUIPoWmeyB9@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Jun 13:42 CDT 2022, Stephan Gerhold wrote:

> On Tue, Jun 28, 2022 at 09:14:36PM -0700, Bjorn Andersson wrote:
> > Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> > Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> > idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> > interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> > tsens.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > Changes since v2:
> > - Fixed include sort order
> > - Dropped a stray newline in &CPU0
> > - Renamed reserved-memory regions
> > - Dropped clock-frequency of the timers node
> > - Reduced #address-cells and #size-cells to 1 in timer node
> > 
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2142 ++++++++++++++++++++++++
> >  1 file changed, 2142 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > new file mode 100644
> > index 000000000000..c9d608ac87fa
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -0,0 +1,2142 @@
> [...]
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency = <19200000>;
> 
> Please drop the "clock-frequency" here as well (if possible).
> 

Sorry, missed that commend from your previous feedback. Will drop this
as I'm applying the patches.

Thanks,
Bjorn
