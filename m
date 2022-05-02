Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0F516E73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiEBLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiEBLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:02:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F5B39;
        Mon,  2 May 2022 03:58:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so27083873ejd.3;
        Mon, 02 May 2022 03:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=94vn6QxCatU8SdwHnwlVFIAEM6kk0iWhQcT6gEzd07o=;
        b=gIBigXRWRP2bwFWuVaRSpDB2XK5tmhst9NbbZAKxjzpxZ57dRDRuhB46XoS4fChnGH
         AfmhiEWPWkHnIsdl2+uETGhLw+jDKVnZne+9aEhxND5jB3Uf2VEMfhVSxTUb8URewf+R
         9yak+DM1mxKZ/azkdttalqJS8mezrEiIUsC3XPQZmuUF6rYTAanG/tv3Yf867xzx0f38
         xZUNaFAqUe2knvK48Xl2Mudjw48BV/xtFyjb19c74borxpX3yoql620dC7rPBgImci9p
         F9vYZ50KABB5DMsailubtBdEds6kOlwUi1cCSRP9CY3R3e420YM3whMl1xlOfblsCw9m
         Xacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=94vn6QxCatU8SdwHnwlVFIAEM6kk0iWhQcT6gEzd07o=;
        b=GBpnpnyvcxvQrz9hwd5XtGq7dUkpyn621tUI50pKyeYfwcfDCMM1u1WtLCIHPjgDp3
         6giUiZslQNPnaGgcFB8dT+xnWFR0XKPzGI4hh9bcJwnVsbcaRnZ9QYnrwiGpPr2bjfHx
         mNx2aDsRysNvKUPdj+WIrCdXDpThaHyvQ7vhYbvC/pR06jjntinMMQsxHArP8eOWB9Fi
         787FaqCdelmBGI0BXriTqrQGlK9z4TAXIvJcIwrVXMlHbtTTbr4teTGES6ksM/H7igOO
         EM4ENVD+hp0y5ltjFJ+o119+iMiJ/gVku1k8a56VJoXeoIlnaux/j527e8LqjZQePv9F
         R3gw==
X-Gm-Message-State: AOAM530nPcp+kTRMJ07pwPORDPfjcP4hpqcrilGbf3GwZzAoq/W6Phcu
        1wOH2tsy2VlZUkUH3mtkQgI=
X-Google-Smtp-Source: ABdhPJxPUVektfI6QlOweHtlDjKawi2DznTY/c8J0WmbTy3aNTOdjpiML6izXDS8jIbBZBWL5NL6BQ==
X-Received: by 2002:a17:907:d28:b0:6f4:6375:5245 with SMTP id gn40-20020a1709070d2800b006f463755245mr2281563ejc.12.1651489138048;
        Mon, 02 May 2022 03:58:58 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id n6-20020a056402514600b0042617ba63bcsm6596291edd.70.2022.05.02.03.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:58:57 -0700 (PDT)
Message-ID: <626fb971.1c69fb81.fcab0.5f71@mx.google.com>
X-Google-Original-Message-ID: <Ym+1BPrdj2qz/SmT@Ansuel-xps.>
Date:   Mon, 2 May 2022 12:40:04 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
 <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
 <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
 <0711b822-506b-7b90-6b63-50c5c0ce4f6e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0711b822-506b-7b90-6b63-50c5c0ce4f6e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 10:26:47AM +0200, Krzysztof Kozlowski wrote:
> On 30/04/2022 09:42, Ansuel Smith wrote:
> > On Sat, Apr 30, 2022 at 04:40:54PM +0200, Krzysztof Kozlowski wrote:
> >> On 30/04/2022 08:01, Ansuel Smith wrote:
> >>> Convert kpss-gcc driver Documentation to yaml.
> >>> Add #clock-cells additional binding to required bindings and example
> >>> as it's a required binding for clock-output-names.
> >>>
> >>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> >>
> >>
> >> (...)
> >>
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - qcom,kpss-gcc-ipq8064
> >>> +          - qcom,kpss-gcc-apq8064
> >>> +          - qcom,kpss-gcc-msm8974
> >>> +          - qcom,kpss-gcc-msm8960
> >>> +      - const: qcom,kpss-gcc
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    items:
> >>> +      - description: phandle to pll8_vote
> >>> +      - description: phandle to pxo_board
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: pll8_vote
> >>> +      - const: pxo
> >>> +
> >>> +  clock-output-names:
> >>> +    const: acpu_l2_aux
> >>
> >> It does not make sense having a constant output name. What is the
> >> meaning this property in such case? The original binding did not enforce it.
> >>
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Mh. Should I just drop the const and put a description referring to an
> > advised name? The driver with the kpss-gcc hardcode the name to
> > acpu_l2_aux that's why I thought it was a correct conversion using a
> > const but I assume this is another problem of not making a correct 1:1
> > conversion and adding fixes on pure conversion.
> 
> Hard-coding a name by implementation is not a reason to put that name in
> DTS. DTS is not a place for values stored in the driver.
> 
> > Think I should drop it and put a description to it. (and then later fix
> > it when I will push the other series with all the tweaks)
> 
> The driver kpss-gcc does not use this property at all, so I am not sure
> if there is a point to even keep it. Any other user of bindings makes
> use of the property?
> 
> 
> Best regards,
> Krzysztof

The idea is that you put the clk name in 'clock-output-names' and the
driver needs to have support for it (and set the clk name based on the
name defined in the dts)

This driver doesn't have support for it and is actually hardcoded.
So you are right and I should just drop it.

But now another question... Since #clock-cells was added as a
requirement for clock-output-names, should I drop also that?

In theory #clock-cells should always be declared for clock providers, is
it right to add it in the conversion commit or I should put this change
in another commit? (since it's now an addition and now something required
to fix a bot warning)

-- 
	Ansuel
