Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669456C286
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiGHVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiGHVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:01:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19BF6B247
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:01:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i126so151497oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SQUHR8cqfec6xaCwS1slMaoEVFnhpSwFvJqKIFprcuc=;
        b=hYaiZ0ZlAM6D9t9CfTzB1qcI0NbhYGcnCJ3VHfnVF5DK2EP6dQDdQ7TFArVXvQ02Lr
         bdsIQbnTsUYUY88y73MVEmUCtNzrggYb8thic/FQCVb8v4iNrfly8ZmPqFpNvG6nRazL
         A6Dq+a7S1CrJecd8n/3ydmhRYIgZQ7cfRvmVRz4wx8mw/laLCkEY/Xh1UFdGqMhS/L4D
         rxoKiFJ4nIQ6lMFEzVDJuQhzfEvSZhGNBilDk3eXMfFAQSXfrZgHQAH3KVyEAz/OK/CW
         l78Md/Ows7IqBUHuLoiDssv/c8RgSNMZLi1k6SubjSow3j1xqD4Q0OyDiv7RzOX7IyNf
         aecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQUHR8cqfec6xaCwS1slMaoEVFnhpSwFvJqKIFprcuc=;
        b=Ub9H/pr05C2BZrlVRkH5IbbvJ3fVPmkySfOj6ipCoQv+vlAtKfxEh8YSPIbCp2AHIu
         X20myZ7whAAMT55psV29LflQXhAprPg88KMxmZsub+I1xzx5PC9y6voXz86H3hdtWMa0
         TdzfOjVeNLotLeS4zYAVmU9rN3KDy3XNuf/Wfe08Ajuldl7BXmVrd7m9597G/XpqrGAO
         94AjkhWCTDFwXUmwR9UEP2YUsWI+4fDNI9dYkWWW15dpPjZeh9CvUN6e6LEZJQTpHWHj
         MPGwQ5evWPiy5Nsrc2PnW06JyoxyFOf2JgDAiaq4i40919s2jHDyjEC98+7EU8KsC5IK
         78Hw==
X-Gm-Message-State: AJIora+YIcjX85748qLyvC6dwkNETksDeRoKNL930rk9DAv6p1PvQavh
        tNKDFGlysMeAkaQQ10Pjpj0GSA==
X-Google-Smtp-Source: AGRyM1tfDkomylt7OKStARhG3F6XT1w/Ga+GjAvIvazJt53EyhaACMtrmRWw3aqAwn75btHaMat/FQ==
X-Received: by 2002:a05:6808:1928:b0:335:6073:f96a with SMTP id bf40-20020a056808192800b003356073f96amr924497oib.249.1657314102152;
        Fri, 08 Jul 2022 14:01:42 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t11-20020a0568301e2b00b0061c266a1bf8sm11096otr.26.2022.07.08.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:01:41 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:04:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP providers
Message-ID: <YsibzePW58/DKWrI@ripper>
References: <20220707161014.3178798-1-bjorn.andersson@linaro.org>
 <CAA8EJpoZ4WKALrvtCtfHNTJ5FDBk-Qy=Mr4TNr8qfcc8=hSMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoZ4WKALrvtCtfHNTJ5FDBk-Qy=Mr4TNr8qfcc8=hSMjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jul 10:41 PDT 2022, Dmitry Baryshkov wrote:

> On Thu, 7 Jul 2022 at 19:07, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > The Qualcomm SC8280XP need the global clock controller, interconnect
> > provider and TLMM pinctrl in order to boot. Enable these as builtin, as
> > they are needed in order to provide e.g. UART.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/configs/defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index d2615b37d857..8e44f6a2172c 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -541,6 +541,7 @@ CONFIG_PINCTRL_QDF2XXX=y
> >  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> >  CONFIG_PINCTRL_SC7180=y
> >  CONFIG_PINCTRL_SC7280=y
> > +CONFIG_PINCTRL_SC8280XP=y
> >  CONFIG_PINCTRL_SDM845=y
> >  CONFIG_PINCTRL_SM8150=y
> >  CONFIG_PINCTRL_SM8250=y
> > @@ -1056,6 +1057,7 @@ CONFIG_MSM_GCC_8998=y
> >  CONFIG_QCS_GCC_404=y
> >  CONFIG_SC_GCC_7180=y
> >  CONFIG_SC_GCC_7280=y
> > +CONFIG_SC_GCC_8280XP=y
> >  CONFIG_SDM_CAMCC_845=m
> >  CONFIG_SDM_GPUCC_845=y
> >  CONFIG_SDM_VIDEOCC_845=y
> > @@ -1266,6 +1268,7 @@ CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> >  CONFIG_INTERCONNECT_QCOM_QCS404=m
> >  CONFIG_INTERCONNECT_QCOM_SC7180=m
> >  CONFIG_INTERCONNECT_QCOM_SC7280=y
> > +CONFIG_INTERCONNECT_QCOM_SC8280XP=y
> 
> = m? I see other SoCs build interconnect drivers as modules (well,
> except sdm845).
> 

I have interconnects specified for the UART and keeping the interconnect
provider as module means that the serial  until after late_initcall,
which in my testing implies that systemd doesn't find a proper console.

Perhaps this is something I'm doing incorrectly?

Regards,
Bjorn

> >  CONFIG_INTERCONNECT_QCOM_SDM845=y
> >  CONFIG_INTERCONNECT_QCOM_SM8150=m
> >  CONFIG_INTERCONNECT_QCOM_SM8250=m
> > --
> > 2.35.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
