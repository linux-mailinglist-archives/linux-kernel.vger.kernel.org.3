Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99D56C792
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGIGeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGIGed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:34:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FAF68707
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 23:34:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fz10so790514pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CxOr+riclyKEWE2OhzawzBmq6aO3+4Q2I0O0/fagluc=;
        b=h0kgstxqdqsy1+bErRwbfJwLJgRwr5nvAMXbxNuXPSEDbbIy3bIqXfjzD1OcIM3r0v
         xTp1p1IMbqPwVDtOOrNBYcMUtpdzkSbYc4749euFDD43eyR8GGHaJ6NO1puCaElR5GIc
         UKPGyvq1fhz1nXtDFYGpbrg76gXdNSMF/rWbLuTLtbVMPGFyhiUmpGFcDauRv7vjEmzR
         pkF8KyAQnNFHQ17F+7iPLkXO1iiN+VF/V9iiG2GPMrv0ysPzZ2hfjGXUo5lFcFhUpoZT
         wMz4wBaLRXkqGlhJZqpgAT3gnehOxaYyCj9ewi/utSJ3bxxtpIA2BcSulm/ulJI6aM88
         j4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CxOr+riclyKEWE2OhzawzBmq6aO3+4Q2I0O0/fagluc=;
        b=DIZbiWIMEw3Ur/OlaxOXyJJl71cyTrFSUlTZniXnTIwaoNbprQD/fqC5/hD8gGZZMa
         Zg2vWOqPQATfsm8j5F5E9Y9x7OtL/8MPhTA4/63XOZdxyytloFunXQZ/JJHQyVYdRwSy
         CxMjhXF6wGW2rXf1t8VUxzSMrgFQRecRBBotpUuOUDhAK0oNndGv2S86OUUqTvcu+kZn
         NQbedfD97dds7XaEGN4csYg90Gjttx881ld9VyN4N2bd8WMn6O79wwvPMJ3fR7tZsBVn
         iZhgrAUgXXJMMD8n0rtNYYfv0n6XCfCWfLMg0OusXio3IvpTQR8rLj8qHi1Osq7tgcul
         o7oQ==
X-Gm-Message-State: AJIora8y40yCvNucOjtTp9qetc25TFrAuykE4QXQlk/F+HCqhRH2lobe
        KZDaBw5Up+6aKSCmXxXX2ctV
X-Google-Smtp-Source: AGRyM1sb1goBS69YyRO2vHlXUwJMbzymaeqvB/t7EGLSS0HcSNIDcEuqTOl7TS64etDsrmEPGV7Mhg==
X-Received: by 2002:a17:902:efd5:b0:16b:ef4e:d40a with SMTP id ja21-20020a170902efd500b0016bef4ed40amr7495270plb.71.1657348471881;
        Fri, 08 Jul 2022 23:34:31 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b0016a3f9e4865sm579599plg.148.2022.07.08.23.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 23:34:31 -0700 (PDT)
Date:   Sat, 9 Jul 2022 12:04:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP providers
Message-ID: <20220709063426.GF5063@thinkpad>
References: <20220707161014.3178798-1-bjorn.andersson@linaro.org>
 <CAA8EJpoZ4WKALrvtCtfHNTJ5FDBk-Qy=Mr4TNr8qfcc8=hSMjQ@mail.gmail.com>
 <YsibzePW58/DKWrI@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsibzePW58/DKWrI@ripper>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:04:13PM -0700, Bjorn Andersson wrote:
> On Thu 07 Jul 10:41 PDT 2022, Dmitry Baryshkov wrote:
> 
> > On Thu, 7 Jul 2022 at 19:07, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > >
> > > The Qualcomm SC8280XP need the global clock controller, interconnect
> > > provider and TLMM pinctrl in order to boot. Enable these as builtin, as
> > > they are needed in order to provide e.g. UART.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  arch/arm64/configs/defconfig | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > index d2615b37d857..8e44f6a2172c 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -541,6 +541,7 @@ CONFIG_PINCTRL_QDF2XXX=y
> > >  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> > >  CONFIG_PINCTRL_SC7180=y
> > >  CONFIG_PINCTRL_SC7280=y
> > > +CONFIG_PINCTRL_SC8280XP=y
> > >  CONFIG_PINCTRL_SDM845=y
> > >  CONFIG_PINCTRL_SM8150=y
> > >  CONFIG_PINCTRL_SM8250=y
> > > @@ -1056,6 +1057,7 @@ CONFIG_MSM_GCC_8998=y
> > >  CONFIG_QCS_GCC_404=y
> > >  CONFIG_SC_GCC_7180=y
> > >  CONFIG_SC_GCC_7280=y
> > > +CONFIG_SC_GCC_8280XP=y
> > >  CONFIG_SDM_CAMCC_845=m
> > >  CONFIG_SDM_GPUCC_845=y
> > >  CONFIG_SDM_VIDEOCC_845=y
> > > @@ -1266,6 +1268,7 @@ CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> > >  CONFIG_INTERCONNECT_QCOM_QCS404=m
> > >  CONFIG_INTERCONNECT_QCOM_SC7180=m
> > >  CONFIG_INTERCONNECT_QCOM_SC7280=y
> > > +CONFIG_INTERCONNECT_QCOM_SC8280XP=y
> > 
> > = m? I see other SoCs build interconnect drivers as modules (well,
> > except sdm845).
> > 
> 
> I have interconnects specified for the UART and keeping the interconnect
> provider as module means that the serial  until after late_initcall,
> which in my testing implies that systemd doesn't find a proper console.
> 
> Perhaps this is something I'm doing incorrectly?
> 

Only couple of SoCs have defined interconnect providers for UART, so I think
it is fine to make it built-in. It will get extended to most of the SoCs in
future when they get optimized.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Regards,
> Bjorn
> 
> > >  CONFIG_INTERCONNECT_QCOM_SDM845=y
> > >  CONFIG_INTERCONNECT_QCOM_SM8150=m
> > >  CONFIG_INTERCONNECT_QCOM_SM8250=m
> > > --
> > > 2.35.1
> > >
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
மணிவண்ணன் சதாசிவம்
