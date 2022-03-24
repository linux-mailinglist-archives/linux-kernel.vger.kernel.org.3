Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC44E6344
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347509AbiCXMZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349138AbiCXMZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:25:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB87B57E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:24:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b188so4681653oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDPX0+3GMlf6QJlR+ewe/Ogxr+oTRBt5Zt4FhKaxj2E=;
        b=slsIM+02eON3vkvBU5snLTTy6X05KNjNLFO23kfcaqzwJk6o2OemvfwWUtXgr3EYeW
         vvz7w9oCB2vWi6KhbksERa8zbbE9SssEW7KzEE4U97bjMQKcqYtdrRchrrOZqL8xAOwJ
         ni6iALOyZlKWmt9lj5Af9s5yr5VUQvjWnk6LJTNyvWicZTPxXswHJIhKgA7wIIoz8CzL
         Uu2e7d7ULvLgqr71qf2qVV+9JRNROLnfAZRh93AtVqFyOYsNuK9Y6RdTFpwWDJdfYkps
         GRIRpMM0jGaBOUXvC4RPrShIU5mwVQPwz2qvH84FlhQARe3w6YgLLuNExsDl9WA9sgmd
         Tsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDPX0+3GMlf6QJlR+ewe/Ogxr+oTRBt5Zt4FhKaxj2E=;
        b=0gcdb67E1+hzxVMz1VFnZDnHbFscZi4DUBLu2kJ2952wrRarbNO8jR5pSe+GsNRxeV
         MpvAfqyVk8dteB49aVo1RblMU4LfWUgaUOT9yTXWtqsFY3QbqTwUC2ZTJir35sK4F4Me
         QGxw5DSKjY/pPQulRoAiSp2t96iDfIdj2eSI4RFd5ZfvjsuTGboy7oNDaYbQ1j1Bzhy7
         +6b2zFrqH3nabqObmgxWhGEfXGBrLiJbkUE8wfspojM0iKdnBenjDBNF+QNgCQRAoPwH
         b0UMF3/wOazFM/LLonrQ3E08C3QpFu2V86wjE2n5BqdiSVmg2WoGCrOI1QIlFZDfX9od
         h+Zg==
X-Gm-Message-State: AOAM530sZaEZOIaz2//UJvsW0FZu2ExL6gcH+tFevStfgS/+YiaDRuq0
        zylDFHD5/FGC5QG12bwPqi8wrQ==
X-Google-Smtp-Source: ABdhPJxFC30LckdJgrfBJ4HLWRxwSgGQLgzu1DyMb/xfn/cVcj96ffS5bhy/z6vtp9khRXkMmYLZkQ==
X-Received: by 2002:a05:6808:18a4:b0:2da:5b12:840a with SMTP id bi36-20020a05680818a400b002da5b12840amr7135895oib.241.1648124654388;
        Thu, 24 Mar 2022 05:24:14 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s41-20020a05683043a900b005cdb244c9c3sm803803otv.47.2022.03.24.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:24:13 -0700 (PDT)
Date:   Thu, 24 Mar 2022 05:25:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8150: Add pdc interrupt
 controller node
Message-ID: <YjxjQNAjWBwpiTgE@ripper>
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
 <20220226184028.111566-4-bhupesh.sharma@linaro.org>
 <YjC8bfY2U1WyV8FY@builder.lan>
 <CAH=2NtzHfqiFi8NKqQ=m24buzVsMT392ObOQ6ahT5BXB=fv6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtzHfqiFi8NKqQ=m24buzVsMT392ObOQ6ahT5BXB=fv6Hw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Mar 22:51 PDT 2022, Bhupesh Sharma wrote:

> Hi Bjorn,
> 
> Thanks for your review.
> 
> On Tue, 15 Mar 2022 at 21:48, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 26 Feb 12:40 CST 2022, Bhupesh Sharma wrote:
> >
> > > Add pdc interrupt controller for sm8150.
> > >
> > > Cc: Maulik Shah <quic_mkshah@quicinc.com>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > index 6012322a5984..aaeacd379460 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > > @@ -1626,6 +1626,16 @@ system-cache-controller@9200000 {
> > >                       interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> > >               };
> > >
> > > +             pdc: interrupt-controller@b220000 {
> > > +                     compatible = "qcom,sm8150-pdc", "qcom,pdc";
> > > +                     reg = <0 0x0b220000 0 0x400>;
> > > +                     qcom,pdc-ranges = <0 480 94>, <94 609 31>,
> > > +                                       <125 63 1>;
> >
> > When I look at the platform documentation I get the impression that this
> > should be: <0 480 94>, <94 609 32>;
> >
> > Can you confirm that the last signal is correctly described?
> 
> Yes, I confirmed by double checking the entries in downstream 'pdc-sm8150.c'.
> The pdc pins in the 2nd range start from 94 and end at 124, so a total
> of 31 entries, but both 94 and 124 pins included.
> 
> Or, am I missing something?
> 

Thanks for double checking, let's follow the downstream kernel.
I will merge the patch as you proposed it.

Thanks,
Bjorn

> Thanks,
> Bhupesh
> 
> > > +                     #interrupt-cells = <2>;
> > > +                     interrupt-parent = <&intc>;
> > > +                     interrupt-controller;
> > > +             };
> > > +
> > >               ufs_mem_hc: ufshc@1d84000 {
> > >                       compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
> > >                                    "jedec,ufs-2.0";
> > > --
> > > 2.35.1
> > >
