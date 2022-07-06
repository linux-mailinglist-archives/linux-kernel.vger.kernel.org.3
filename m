Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C8568944
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiGFNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGFNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:19:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561E5F96;
        Wed,  6 Jul 2022 06:19:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eq6so19239548edb.6;
        Wed, 06 Jul 2022 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=4XLe7zW1SnFhJBynn+dzzylqg9TZLd8+lQL8sfIiDAw=;
        b=jTzJDJ8gaO6pMDhJ3bEENI4SJUPSyAfgj4SB2xeoJFB0/cqHZtGy6yiRhIzE1FTOzG
         lg6k1TdfN/GL11Nf0lJCKe/+f1cZYiCR9c1SzopMevCvku5YC5SLHrypIQmmHNf/EwEH
         u1lnL7N3kcPv5ELETlzUUDK47k9bj9MW/tajYcDgWGg3QJghg3SyeQioOqwlAg/paQdr
         BFQRFAl5jnZQfpbDQ6pGSjd4Afc56sxe58wc6K2XK3t1DxFP0vpbd1V6CcWd/BWEPPej
         ai/OBs+d44Pb+QkhihM6Y0pxYWBW5Tu+AXorAoLfuxsi3Uiy3DeNymlNfrj0CC6M8BwZ
         2veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XLe7zW1SnFhJBynn+dzzylqg9TZLd8+lQL8sfIiDAw=;
        b=maMf2uRgJJdAI6OdK0gTAPwVFPK1wp6inDL0W2waBHzrTMTP9V40pyKA0jZwC+u69c
         iw/z7ITD1+qgDmdIR2/L+p86FElpotTloDIcUNVIuAHHBEO2Sp4etZcQQVS6qJ0bxodX
         MFSOCGrx7iv0DN4IRdfoJx/J/EnJ88cIdlPH+vpln/fC2hiGvWjezIwihU4GLUNwXT+z
         SAndIPxBsdx6fWotepzzEMEF1X5xKrSJgR7F/6jIIO1go0972PCTfuZP2yGEHxKMkrzC
         8RbMSbOIxrW1erY321e7KIF6H/uKylwg5GmtYIvQlffq9iHioEsm2tUCGWLoblZfr/BL
         mTBw==
X-Gm-Message-State: AJIora++U6eitg/1vnJa453gYTpAG+t2MIkboeFz6/sNHh+PU+/qN5Nn
        6rG5BDqCTnBnSApUPr1n55U=
X-Google-Smtp-Source: AGRyM1vYI/zIcvw/ZNo7wuYxyoa6YMBNat69TMvMy+L9FAhFRGGUiJ7l7eqncvdnNE9aRXO4WGNNpA==
X-Received: by 2002:a05:6402:5299:b0:435:61da:9bb9 with SMTP id en25-20020a056402529900b0043561da9bb9mr54821086edb.21.1657113587254;
        Wed, 06 Jul 2022 06:19:47 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402520300b0043a84dfbf06sm2124739edd.15.2022.07.06.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:19:46 -0700 (PDT)
Message-ID: <62c58bf2.1c69fb81.f5075.3309@mx.google.com>
X-Google-Original-Message-ID: <YsWIDsZ28KCPhUII@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 15:03:10 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-10-ansuelsmth@gmail.com>
 <a56f2941-b386-19f3-a6ad-b5a0738c8458@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56f2941-b386-19f3-a6ad-b5a0738c8458@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:11:05PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 15:39, Christian Marangi wrote:
> > Add missing smem node for ipq8064.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> I can't find a downstream kernel for these router SoCs, but
> I wonder if the 8x64 family DTs couldn't be somewhat
> unified? It looks like they share quite some code..

Mhh don't know they have some peculiar changes so unifying them would
make more harm than good IMHO.

> 
> Konrad
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index b5aede3d7ccf..98527a7d885e 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
> >  			#reset-cells = <1>;
> >  		};
> >  
> > +		sfpb_mutex_block: syscon@1200600 {
> > +			compatible = "syscon";
> > +			reg = <0x01200600 0x100>;
> > +		};
> > +
> >  		pcie0: pci@1b500000 {
> >  			compatible = "qcom,pcie-ipq8064";
> >  			reg = <0x1b500000 0x1000
> > @@ -1332,4 +1337,17 @@ sdcc3: mmc@12180000 {
> >  			};
> >  		};
> >  	};
> > +
> > +	sfpb_mutex: sfpb-mutex {
> > +		compatible = "qcom,sfpb-mutex";
> > +		syscon = <&sfpb_mutex_block 4 4>;
> > +
> > +		#hwlock-cells = <1>;
> > +	};
> > +
> > +	smem {
> > +		compatible = "qcom,smem";
> > +		memory-region = <&smem>;
> > +		hwlocks = <&sfpb_mutex 3>;
> > +	};
> >  };

-- 
	Ansuel
