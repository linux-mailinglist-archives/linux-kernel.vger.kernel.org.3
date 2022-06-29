Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB615560C68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiF2WkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiF2Wjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:39:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774A1EC75;
        Wed, 29 Jun 2022 15:38:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd6so24145121edb.5;
        Wed, 29 Jun 2022 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXdOmJeXHtaZlahxIBSXtvIP/nraTJVi+AA0cztm3iQ=;
        b=n14f71DGBmg1G3uvuy+2WWM6dDXlbGzVXqPOaaM2KA0u81twHq40wXsHaNmk6JPWQl
         Cm8g9Y+pK6UuIVCeq6TKK94ZtbmNA4tqnX5ZSvOwG3xpC9uJ0MbN5WbwOpBPYRcokcA2
         Qn/64T9ZTlWTTdVEu7GNWYT3B9bYDNcF938fVVEz9wXvSj5ptTbvaLc8yMd7xS64acz3
         JRp5jxmCg4SucJEmIv54aEElhCw9GuNWiTgxRMETUfIWmsBWRBPzx7P4vAQ7C7x7gaR1
         193FyvtYoWRDa1v2dfxjDV+nRCB48QSv+auxMsyL3xDZ90q8OkJ0RKTGmWRP9GCglwNb
         GgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXdOmJeXHtaZlahxIBSXtvIP/nraTJVi+AA0cztm3iQ=;
        b=AOTvkkPCpDImgDEAWc3O+pUsofft0jGeiRJdr9k4rw74oemacQhNg9xxkDpqIKTXFm
         P8ixBrYcAQJwXVD3K94dsoVjjNU0DeISpLYhGLGWxlKKayAmqlTsKs+BQPOvLtqbt7b5
         MZ1UXwkEnHL6Sjn4ms8NDMk3ly9fJTwXHr5NNdDDS4SPxWL7QOZZ1UkgrKUn2Adb+iMG
         iMvtnFdN5eWgkFwERW+MRUfEhPsLaP8485nn3eMoLfrqeWqseBzDTUk/wQxH82tdpryQ
         98Sm1DU6jyep2rI3nwvdJfwHa/9RBvP2qo7XUyt4f4eHaZS8saCshCf9TpaPawopn3M1
         YWJg==
X-Gm-Message-State: AJIora9oL37ndt9gn6uMpUlc9OYX3mnBtXq4eZ3ooC6ZJ1ZY8Cwvt41Q
        VpPeDJYsRvKxwqq+yYZd1iE=
X-Google-Smtp-Source: AGRyM1tuKp0bukz+WEUON3F84eO2LuBvaY1XhLAn/zV+EyA81FQBLL0gtFV1FaDkRTjcILR+VJIbRw==
X-Received: by 2002:a05:6402:350a:b0:435:df44:30aa with SMTP id b10-20020a056402350a00b00435df4430aamr7056022edd.403.1656542306768;
        Wed, 29 Jun 2022 15:38:26 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00726dbb16b8dsm2518982ejp.65.2022.06.29.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:38:26 -0700 (PDT)
Message-ID: <62bcd462.1c69fb81.c8b67.4c9f@mx.google.com>
X-Google-Original-Message-ID: <YrzUYKmATOSq2Y9A@Ansuel-xps.>
Date:   Thu, 30 Jun 2022 00:38:24 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
 <20220629121441.6552-3-ansuelsmth@gmail.com>
 <1656542219.655280.1042481.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656542219.655280.1042481.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:36:59PM -0600, Rob Herring wrote:
> On Wed, 29 Jun 2022 14:14:38 +0200, Christian Marangi wrote:
> > Convert kpss-acc driver Documentation to yaml.
> > The original Documentation was wrong all along. Fix it while we are
> > converting it.
> > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > don't have any driver that expose additional clocks. The kpss-acc driver
> > is only specific to v1. For this exact reason, limit all the additional
> > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > v1 and also flag that these bindings should NOT be used for v2.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
> >  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 49 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> clock-controller@2088000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2088000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@2098000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 	arch/arm/boot/dts/qcom-msm8960-cdp.dtb
> 
> clock-controller@20a8000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20a8000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: '#clock-cells' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clock-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clock-output-names' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 
> clock-controller@20b8000: 'clocks' is a required property
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
> 

(fixed in the last 2 commit of this series)

-- 
	Ansuel
