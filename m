Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D7E56516C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGDJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiGDJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:54:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05078DEB2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:54:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so5321639wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5OEPF06YG+R+5ZW0yjo5uKv8/e38xtFyRSfd8rSL5/U=;
        b=iWnJOtER2NaaLsbBoB0+Px3zo6/Ay8a1Tx7Tpv0T77HJg7B6MTzuireRG0B9U+fuAJ
         9UbuJNDuIh6p/REByNa+ODA5uMyc6Z63A+AwMzxBUb7wQDsfgW4ovI9iOEmEtOgoib2D
         is4YPKL7me/MkEd38NaByuGbU2cubsRzIWe5So5A4CYnP6FjgSYE2tBg31ZzhvYU5BR1
         Ylf1IWBeh40N7No/NiV2hAAYbAu1xe9+unEdAvOAof48LUiH6w/j8YMMxhwUshyabtfI
         WLzI930mHrjXWi3NaMDxptGBkhSJCZmUUrjxhkbrrFA7thG42Q9wnTTV13m/pXU+O217
         ANAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5OEPF06YG+R+5ZW0yjo5uKv8/e38xtFyRSfd8rSL5/U=;
        b=nv5rkkjtyOEl8OIENwFXIi1dF1IDp6CopUS/W60AXTB1mJUkEX/pFGt27LKA2gSDUS
         lacJO/g4GYq3TU9mFiOHt4WL/OwgKxAjhGJG+o3AejtYeqgaYo3zcpyxhdubUxTwJ7J2
         4oC1GzSQfoizFoQaFkrPVU70tEPTKNBCJ5/dFcJ8HULFW/CPzngHdaJcOKujyHVmxeQM
         ikewNFlsTcajtqYeJ45s9uIAMizhITSii3EKGLZmyag2ytU3jmKJ+dK852D5lbLrTr10
         lAzWFlCgIkLueJLS4xYwvcX6u0lfhbuY6YDNvq9JkCqjHjyk2q11eEw3PzCil25vVVZm
         ObSQ==
X-Gm-Message-State: AJIora+Le+qUBlC/zLZiTtPzC8RZvTTMNv0MrOeDkMs7itDRnmVIg9CI
        1/exOCUMfSh5thDYvpE+oOKbLQ==
X-Google-Smtp-Source: AGRyM1svy/vCXA649RppIhdoxQ//h/2ofd0wM3BTvLiHTMabydo4tf4xJZ3LiMzhyn9E3gWku6ATSg==
X-Received: by 2002:a05:600c:2298:b0:3a0:31a9:710b with SMTP id 24-20020a05600c229800b003a031a9710bmr30056672wmf.115.1656928483406;
        Mon, 04 Jul 2022 02:54:43 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n5-20020a1ca405000000b0039c587342d8sm15023400wme.3.2022.07.04.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:54:42 -0700 (PDT)
Date:   Mon, 4 Jul 2022 10:54:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: rt5120: Add Richtek PMIC support
Message-ID: <YsK44Dp3yZwqPi0H@google.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com>
 <Yrm9ObaltUiQUTqS@google.com>
 <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
 <CADiBU3838Mgi3sqv+R_=8g-ROTrbN45AKPaTS_9GCWVDYASMyg@mail.gmail.com>
 <Yr6kVg2OlHkm6+bB@google.com>
 <CADiBU396poOuzdGABzTazouM5MX=auZ9OdyT_sqWrKnZk3tFRw@mail.gmail.com>
 <CADiBU3_7MmPkfV7-B8rhxFRtZcrJ6BPocXzT4bs3cu36UR5XGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3_7MmPkfV7-B8rhxFRtZcrJ6BPocXzT4bs3cu36UR5XGw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jul 2022, ChiYuan Huang wrote:

> Hi, Lee:
> 
> ChiYuan Huang <u0084500@gmail.com> 於 2022年7月1日 週五 下午5:56寫道：
> >
> > Lee Jones <lee.jones@linaro.org> 於 2022年7月1日 週五 下午3:38寫道：
> > >
> > > On Fri, 01 Jul 2022, ChiYuan Huang wrote:
> > >
> > > > HI, Lee:
> > > >
> > > > ChiYuan Huang <u0084500@gmail.com> 於 2022年6月27日 週一 晚上10:56寫道：
> > > > >
> > > > > Lee Jones <lee.jones@linaro.org> 於 2022年6月27日 週一 晚上10:22寫道：
> > > > > >
> > > > > > On Wed, 22 Jun 2022, cy_huang wrote:
> > > > > >
> > > > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > > > >
> > > > > > > Add Richtek RT5120 PMIC I2C driver.
> > > > > >
> > > > > > Why a whole new driver?
> > > > > >
> > > > > > How different is this to rt5033?
> > > > > >
> > > > > > Looks like this could easily be woven into this existing support?
> > > > > >
> > > > > It's different with the function domain.
> > > > > RT5033 is most like as the SubPMIC that includes PMU (battery
> > > > > charger/gauge/led/few buck and ldo)
> > > > > RT5120 is a main PMIC with default-on power that follows the boot on sequence.
> > > > > RT5120 only integrates regulator and power key report module.
> > > > >
> > > > Since I have explained the chip difference, do you still think it's
> > > > better to merge this code into rt5033 mfd?
> > >
> > > I think it's okay to group devices which are similar but not exactly
> > > the same, if they can be.  The integration of this device into the
> > > other looks trivial to my naive eyes.
> > >
> > > A PMIC is a PMIC, main or sub.
> > >
> > M.. ok. I will try to group all chip changes like as devices
> > list/regmap_irq/regmap_config ..., etc.
> > Treat it as one set of chip config and use 'of_device_get_match_data'
> > to get the chip config data.
> >
> There's a question.
> As I know, it's not the same chip series.
> The rt5033 is submitted from Samsung at 2015.
> The driver data is also defined in header file.
> 
> Do you still suggest to do the merge?
> Even in our internal, it's difficult to find a rt5033 EVB for testing.
> 
> And one more question is the binding. If yes, for the binding, I need to add
> rt5033 related.....
> 
> Actually, it's a tough work.

If it's genuinely difficult to integrate, you can keep them separate.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
