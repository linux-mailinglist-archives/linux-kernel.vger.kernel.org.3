Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5639514EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbiD2PSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiD2PSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:18:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128ED4C4D;
        Fri, 29 Apr 2022 08:14:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z99so9439431ede.5;
        Fri, 29 Apr 2022 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=EbtxbOJ1CS59r6WrWpZSN0c1L+UbT9eVGmvmTgjvhcM=;
        b=AZJb9vMd/ct6885yCM5BV85EznfI7aiq+/eYTkD5CSjyymz+Tjwd1PSMC4SfrRLQ60
         kyxqw1lBFLjdiq3RZavN4/kOQEINq9E59HMsAVb6MiMu9BG+aYJnkeMFgxYqqYo9Miqn
         exfc95bL964UI7AcY0OffRRC9UwSepiNlI68QaKQrG2q1STsKAZqIQm3lPhctfI8AUpk
         pJUbUuGortQ7nnow+ib0WaCtMr2Q763uVzeO9A1cGok6wVEHjD+6qzhzD0NFyG+uTdVi
         qqNAGlD4b3vsABpdYUEWwGMLGLypnZnc7a9bAdqzLe9SMC7j9k4/q3p4qTcSY3rL1lq6
         C6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=EbtxbOJ1CS59r6WrWpZSN0c1L+UbT9eVGmvmTgjvhcM=;
        b=R5m2/3pCiyJyknNjb6fPLKGAPpW+eYOuXe7qvIPTpM2VQhN6bFXIrMoDJRK5trDxt5
         6gWH2xvrOXbpNO5Da/Aql4++GD/tZ+PgJ8tZmrXCxHetCsfbo5S22DowwF27T5Ck6h2B
         VlaYuCilPdAMVv8YnT2J8/oieuCbu1qjWMc36y5yHQXdi3aA2HZSoA1O9gjQSzReSZsZ
         D0ezniDwHh3omvBqVA6isuZSOIPEjrdAK5ziSy9tOfPulkyuAlejv4b1ESQaXlfFsloq
         2XrX/lLuZ8vNBm962OBLnzMaCg6o6BANIzi6cejveHdp5cyGt2XKQQXaNu49BeaI5ard
         KJ8Q==
X-Gm-Message-State: AOAM530nypExt/7/Ms0gS/GwLKgplVPIJaHTQ9q9wBKxn+3pSkTXHX9l
        7+FkavTjpl/64G5k3LQ+QKlNWOkF1b8=
X-Google-Smtp-Source: ABdhPJxZ8x2QNACsc1KrtQe/rLXHoh0RG6NB5Vk0qGwuytaWut/I3HaFqvFaoj3TAS9hLjvGsEIF9w==
X-Received: by 2002:a05:6402:50d0:b0:426:3f36:b43a with SMTP id h16-20020a05640250d000b004263f36b43amr3283083edb.91.1651245280298;
        Fri, 29 Apr 2022 08:14:40 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id w14-20020a170907270e00b006f3ef214e3bsm709993ejk.161.2022.04.29.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:14:39 -0700 (PDT)
Message-ID: <626c00df.1c69fb81.a5445.4d7c@mx.google.com>
X-Google-Original-Message-ID: <YmwATb+baBLo969m@Ansuel-xps.>
Date:   Fri, 29 Apr 2022 17:12:13 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: qcom: replace gcc PXO with pxo_board fixed
 clock
References: <20220429122951.13828-1-ansuelsmth@gmail.com>
 <20220429122951.13828-3-ansuelsmth@gmail.com>
 <f260cf81-9db9-710b-1242-45a232e7c7c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f260cf81-9db9-710b-1242-45a232e7c7c4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:11:21PM +0300, Dmitry Baryshkov wrote:
> On 29/04/2022 15:29, Ansuel Smith wrote:
> > Replace gcc PXO phandle to pxo_board fixed clock declared in the dts.
> > gcc driver doesn't provide PXO_SRC as it's a fixed-clock. This cause a
> > kernel panic if any driver actually try to use it.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> Fixes: 40cf5c884a96 ("ARM: dts: qcom: add L2CC and RPM for IPQ8064")
> 
> It would be nice if you add Fixes tags to your patches in future. Fixes tags
> allow picking up patches for stable/LTS trees.
> 
> For these two patches I'd suggest reordering them. A fix should go first
> (you'll have to define pxa_board label in it). It can then be accepted into
> other kernel without dependency on the other patch.
> 
> The gcc patch will come next, it will define cxo_board label and use both
> clocks in the gcc node. It is not fixing a bug, so there is no need about
> backporting it.
> 
> Generic rule: fixes go first (in the patch series), so that they have
> minimum inter-dependencies.
>

Didn't know about this. Thanks for the hint! Will do the change.

> > ---
> >   arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 9817448cfa95..ad30f7c8a5a7 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -784,7 +784,7 @@ tcsr: syscon@1a400000 {
> >   		l2cc: clock-controller@2011000 {
> >   			compatible = "qcom,kpss-gcc", "syscon";
> >   			reg = <0x2011000 0x1000>;
> > -			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> > +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> >   			clock-names = "pll8_vote", "pxo";
> >   			clock-output-names = "acpu_l2_aux";
> >   		};
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
