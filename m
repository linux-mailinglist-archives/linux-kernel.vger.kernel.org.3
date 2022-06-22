Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544025554D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358681AbiFVTmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbiFVTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:41:34 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283E3DDCF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:41:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s124so22552476oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qQgALAi2wVXgabuqYRv/Dghd+oQEz58M6MZz7MxqqrY=;
        b=P+OxY6J0Y4ToESliTs4NpNX9arOEpoPUKm12pXVZHA1IIMSz+3hGp9EMFCNQjeGoKJ
         WTzbIL17quGNmJtW4dn2bqD4kSBLpIL0HaLXUMNZh1mTLFQBAfdPpLF91xJVmVGJ/Ykz
         /YH4Nj6XCrfRcZguxBUCn5b5p6muhQaRYBviWUR0mbcQtYXZqtfKRHfNubxq8s0QxPWS
         LnaVr3j1Mf3eT4gUSYFRM5Y6YPKJQiS1fnKPHhbsv3wWrtySmrGcesW4FTUUjo1s4s4P
         OFxzdAdnuU/2g0v2syPjxo2KOTDLZiJC5Kg5wee1/PvelupDi95Z9EFtZetfevfFl/4h
         oH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qQgALAi2wVXgabuqYRv/Dghd+oQEz58M6MZz7MxqqrY=;
        b=u2R5Q7tMkVHaak7ez9DAgf5B3Wom7XdI2kHqnZkRckBoxgbvLzzQKUe5wjw8HmCbct
         sjA/mU0igg16n6DxahJPrbvItBOnZVzFH3uCHlOtRIWHi6cKa8PgKS3fcAQeC4Mi0vra
         cvdva+1GvQZYsBhto9WrJYrM5kfLONOwiSTxrkVtpC3TJfifT7l8hpEWDdM/1kprTEId
         lc9HmD1vG0rrL6iYJ8wMIkNyNmU2ijbwcYhsRhp7fPyQjOkn6DEnQ3hy2ST4HbXyLuqG
         pPKV55kT6KP3N7lpnghNDXR+QatcoNQD7YZ7hHJ13twQ9hneAeKMxRpXRQL8jGBORQ+K
         m4Bw==
X-Gm-Message-State: AJIora9EGBOOTo2rXi0paAgc2Bvdsg+sUOgCPh2KKlbjgZr292J+aY31
        drmJ1xrg1w5RCQybWP+uG15iDQ==
X-Google-Smtp-Source: AGRyM1uCM2nsUqojnEb3efZ6zb/TnSiIXLMQDdoG0Z4BWMkU1uo9akeZVzd2iHCb93LRc0uXctDRGA==
X-Received: by 2002:aca:6088:0:b0:32f:7c9:a89f with SMTP id u130-20020aca6088000000b0032f07c9a89fmr2967745oib.129.1655926884657;
        Wed, 22 Jun 2022 12:41:24 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a13-20020a056808128d00b003342a70fd59sm2396236oiw.10.2022.06.22.12.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 12:41:24 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:41:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrNwYsbKG+ai5vFT@builder.lan>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-4-bjorn.andersson@linaro.org>
 <YrNl2jS3Stcl2DP8@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrNl2jS3Stcl2DP8@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jun 13:56 CDT 2022, Stephan Gerhold wrote:

> On Tue, Jun 21, 2022 at 09:12:21PM -0700, Bjorn Andersson wrote:
> > Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> > Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> > idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> > interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> > tsens.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2145 ++++++++++++++++++++++++
> >  1 file changed, 2145 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > new file mode 100644
> > index 000000000000..ac13965a181e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> [...]
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		memory@80000000 {
> > +			reg = <0 0x80000000 0 0x860000>;
> > +			no-map;
> > +		};
> > +
> > +		cmd_db: memory@80860000 {
> > +			compatible = "qcom,cmd-db";
> > +			reg = <0 0x80860000 0 0x20000>;
> > +			no-map;
> > +		};
> > +
> > +		memory@80880000 {
> > +			reg = <0 0x80880000 0 0x80000>;
> > +			no-map;
> > +		};
> > +
> > +		smem_mem: smem@80900000 {
> > +			compatible = "qcom,smem";
> > +			reg = <0 0x80900000 0 0x200000>;
> > +			no-map;
> > +			hwlocks = <&tcsr_mutex 3>;
> > +		};
> > +
> > +		memory@80b00000 {
> > +			reg = <0 0x80b00000 0 0x100000>;
> > +			no-map;
> > +		};
> > +
> > +		memory@83b00000 {
> > +			reg = <0 0x83b00000 0 0x1700000>;
> > +			no-map;
> > +		};
> > +
> > +		memory@85b00000 {
> > +			reg = <0 0x85b00000 0 0xc00000>;
> > +			no-map;
> > +		};
> > +
> > +		pil_adsp_mem: memory@86c00000 {
> > +			reg = <0 0x86c00000 0 0x2000000>;
> > +			no-map;
> > +		};
> > +
> > +		pil_nsp0_mem: memory@8a100000 {
> > +			reg = <0 0x8a100000 0 0x1e00000>;
> > +			no-map;
> > +		};
> > +
> > +		pil_nsp1_mem: memory@8c600000 {
> > +			reg = <0 0x8c600000 0 0x1e00000>;
> > +			no-map;
> > +		};
> > +
> > +		memory@aeb00000 {
> > +			reg = <0 0xaeb00000 0 0x16600000>;
> > +			no-map;
> > +		};
> 
> Doesn't memory@ still cause the dtbs_check warnings? Similar to
> 
> > soc/qcom/qcom,smem.example.dt.yaml: memory@fa00000: 'device_type' is a required property
> >         From schema: dtschema/schemas/memory.yaml
> 
> as in [1]. If I understood it correctly there Rob said that memory@
> shouldn't be used for reserved-memory. Perhaps even reserved-memory@
> might be better then.
> 
> The device tree specification on the other hand suggests using the
> purpose of the reserved memory, like we did on older SoCs:
> 
> > 3.5.2 /reserved-memory/ child nodes
> > Following the generic-names recommended practice, node names should
> > reflect the purpose of the node (ie. “framebuffer” or “dma-pool”).
> 
> [1]: https://lore.kernel.org/linux-arm-msm/CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com/
> 

Thanks for the pointer. I stared at these for a while given that we
"shouldn't use memory@", but like with the other platforms I figured we
could fix it later...

I'll update these accordingly.

> > +		timer@17c20000 {
> > +			compatible = "arm,armv7-timer-mem";
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			reg = <0x0 0x17c20000 0x0 0x1000>;
> > +			clock-frequency = <19200000>;
> [...]
> > +		};
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency = <19200000>;
> > +	};
> 
> Is the "clock-frequency" really needed for these two?
> 
> The binding docs are pretty clear that this should be configured by the
> firmware instead:
> 
> > Should be present only where necessary to work around broken firmware
> > which does not configure CNTFRQ on all CPUs to a uniform correct
> > value. Use of this property is strongly discouraged; fix your firmware
> > unless absolutely impossible.
> 
> I hope Qualcomm's firmware is actually improving on newer platforms
> and not making big steps backwards. :-)
> 

I believe I inherited this from somewhere, will check if it's actually
needed.

Thanks,
Bjorn
