Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8C568636
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiGFKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiGFKy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:54:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396827CC9;
        Wed,  6 Jul 2022 03:54:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j22so153622ejs.2;
        Wed, 06 Jul 2022 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=9iLfp3rSvq5HD4T1obBpdS6jjmeDrv6o8UGa12ZUzfc=;
        b=H72fofPdYrTAe5CoRu1qcLDQQNXcOf4IHWV7YVu9Pbc2lXn40BGIO0WYtnqS0JTXac
         E9QPyR+kORnd438aaOwOL7NKA7VTd7zm5c6Q0L+hhjG5uYdUiiMe+G789TICkpFnrLbf
         1JuG/0MecqLV8tF34PF4mt2km54fN/QaHGya4RGTRbZnzpKl4bnPKchHZf7xsixv/cNH
         0E/7NivY/AOyd1Zn9p+/OHDNTU43BWDIPd09tWYE6Quq2sYPtjjaljHFMNAtA1IT3to8
         qOd58Bxduoe845txFG9kZWrjdOv+7Q3vkE2gMQx6kFqDYWm1Z646aGn1D5RibrHx5/DV
         rvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=9iLfp3rSvq5HD4T1obBpdS6jjmeDrv6o8UGa12ZUzfc=;
        b=Ml8gm+bo9Ve6bJcKuej6LBv6n3lfBr3PUY/gcXciHJYriSifjdnElvctvGY9sm4WRd
         VnZoJT7dlAPqtTB02qHbRqGyI8dARJlOrWIklRzCZE90nD3mh5O7s9jkMV4qhh1/G9sg
         l+cv0ELZo2idiriKMhh6xi8BzLVluWlO0C55B5B+TDi0PWGz5qgLVL3WzNQKFwdBQMHl
         L1OefVgREzIjwxQ89P9zXIIRfqMY7kxGn/djMoy049RQEP/zTBNEfNX+Ujc6+vQhPPUL
         No+RITFl7l80FHXlM5fh254C+x58Fsv3S+d2rOrGSNVnBRyEVNlLtaXDslZg0526eS/1
         aCmA==
X-Gm-Message-State: AJIora/pGrDxiF/JPLIK4DhiTpcrU9WXp2cbsonTC82K3Z3HsGAF/5r5
        Q1z/UjWhzjMy5FS4IW3Eo2k=
X-Google-Smtp-Source: AGRyM1sV36e8JK8dqGp1E+M2/fik9hmkeJb/JD4LABvWsvPg/GD2XDc0bg4y0QXlpUdYCkF8C73GMA==
X-Received: by 2002:a17:906:2086:b0:712:1257:77bf with SMTP id 6-20020a170906208600b00712125777bfmr40111648ejq.655.1657104864099;
        Wed, 06 Jul 2022 03:54:24 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906292900b00722e50dab2csm486351ejd.109.2022.07.06.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:54:23 -0700 (PDT)
Message-ID: <62c569df.1c69fb81.9be2b.0cd0@mx.google.com>
X-Google-Original-Message-ID: <YsVl+uXAVdEkMiFs@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:37:46 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-10-ansuelsmth@gmail.com>
 <c5bf6246-a350-8a87-71bc-bc13d502a8af@linaro.org>
 <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:14:42PM +0200, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 10:39:16AM +0200, Krzysztof Kozlowski wrote:
> > On 05/07/2022 15:39, Christian Marangi wrote:
> > > Add missing smem node for ipq8064.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Tested-by: Jonathan McDowell <noodles@earth.li>
> > > ---
> > >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > index b5aede3d7ccf..98527a7d885e 100644
> > > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
> > >  			#reset-cells = <1>;
> > >  		};
> > >  
> > > +		sfpb_mutex_block: syscon@1200600 {
> > > +			compatible = "syscon";
> > 
> > syscon alone is not allowed.
> >
> 
> Mh... This is problematic. How this should be handled?
> This should be put in sfpb_mutex and change the driver to use regs if
> present instead of syscon?
>

Found an alternative solution used in ipq807x so I can drop the syscon
only node.

> > > +			reg = <0x01200600 0x100>;
> > > +		};
> > > +
> > >  		pcie0: pci@1b500000 {
> > >  			compatible = "qcom,pcie-ipq8064";
> > >  			reg = <0x1b500000 0x1000
> > > @@ -1332,4 +1337,17 @@ sdcc3: mmc@12180000 {
> > >  			};
> > >  		};
> > >  	};
> > > +
> > > +	sfpb_mutex: sfpb-mutex {
> > 
> > Generic node names, so hwlock
> > 
> > > +		compatible = "qcom,sfpb-mutex";
> > > +		syscon = <&sfpb_mutex_block 4 4>;
> > > +
> > > +		#hwlock-cells = <1>;
> > > +	};
> > > +
> > > +	smem {
> > > +		compatible = "qcom,smem";
> > > +		memory-region = <&smem>;
> > > +		hwlocks = <&sfpb_mutex 3>;
> > > +	};
> > >  };
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> -- 
> 	Ansuel

-- 
	Ansuel
