Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C0515017
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378707AbiD2QC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378709AbiD2QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:02:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF08A9F2;
        Fri, 29 Apr 2022 08:59:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so16288027ejd.5;
        Fri, 29 Apr 2022 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFofsZTrxzYW8g6YUhhQeEdV8aFgV5toOyemA0wEyeo=;
        b=C1T5dB6hi7U6pTSrjv6swEvw3cKJfbF/qLcR3RQWeut5cPamNKokJimmmheEgPlWme
         YhLG1gvP8efrP/7tMPVKf+xVQs2czDC5zN4ZYJnxWoO1gHLoxBc8QWMR3lFI90LYQ8yH
         fQCj28jDmiK1VuQCoK5EoOCANhe/WCHl9j8GHQV/A4Xl8Q1opeoAIcJbiaOVwynM3S4S
         3HTFpaTxyYWvEWNW/3yr5295gY4zN2rUI3gy3tGCfV8Hbdsz77I4GBBpaCCvcwP51De0
         3k7zBeevh1t01OZgNmiTI+2opiStvubt/3Fiq7sqdh/jChNPfSbUX90AXjuRQUNAbYax
         edhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFofsZTrxzYW8g6YUhhQeEdV8aFgV5toOyemA0wEyeo=;
        b=dEUXNf17EgTIBi1aB8MhZzAGTPe5ZhaUIbHb/dvp2qIwFgahE+TckXDJminsjU/AzI
         Xp+xicplSYy3vEjfo09tRZwNj9bDtqluxWhKDPvytaRdPLVl4ZSB1p5iENUXuBVCcdkb
         Y+5DnpZ7Gt1QR4DmU9iPN1xPvcY/rIRqiMjKYFliv6F5QqHojgr7vtpcngHfWpMd4AFl
         bx12kqSvBHEcqfE8mAkuvxG9NcGG/QpqOIyX9dn1VEIPGD4IrAPeBu+llu8kN4oubq34
         FUcn32oMsCW1pIZhTZjwMJGcpppOMdCTguH+823xZHTIUseVS7+EY5ddjL1ePeOkS+x6
         jHmQ==
X-Gm-Message-State: AOAM530APwPK8XfxZuAxLp/bb9xh+nfe+cG3MyBAzvM8yVPRgJRMXHPb
        1KfvwaLOFDMmTvB32/ORh0w=
X-Google-Smtp-Source: ABdhPJxUyrv8UAISq1M4lIXdSzVcLopFibiDLcBRyirwaUmJsMXKf5WYWap0qDwxSikXnmaJhmpYpA==
X-Received: by 2002:a17:906:7307:b0:6da:92db:c78f with SMTP id di7-20020a170906730700b006da92dbc78fmr36910751ejc.35.1651247972842;
        Fri, 29 Apr 2022 08:59:32 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id ia5-20020a170907a06500b006f3ef214dffsm756699ejc.101.2022.04.29.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:59:32 -0700 (PDT)
Message-ID: <626c0b64.1c69fb81.1b1e9.4fe6@mx.google.com>
X-Google-Original-Message-ID: <YmwK0aa8u7lU6lct@Ansuel-xps.>
Date:   Fri, 29 Apr 2022 17:57:05 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
References: <20220429121739.28584-1-ansuelsmth@gmail.com>
 <20220429121739.28584-4-ansuelsmth@gmail.com>
 <1651247596.124069.2344494.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651247596.124069.2344494.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:53:16AM -0500, Rob Herring wrote:
> On Fri, 29 Apr 2022 14:17:39 +0200, Ansuel Smith wrote:
> > Convert kpss-gcc driver Documentation to yaml.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 -------------
> >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 +++++++++++++++++++
> >  2 files changed, 63 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'

Erm how to fix this? I can't do a 1:1 conversion if the source was
wrong and also have no bot warning.
Or I should just push an additional patch to fix this error after the
conversion?

> 	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml: ignoring, error in schema: properties
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb: clock-controller@2011000: '#clock-cells' is a dependency of 'clock-output-names'
> 	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/clock/clock.yaml
> Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb:0:0: /example-0/clock-controller@2011000: failed to match any schema with compatible: ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc']
> Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.example.dtb:0:0: /example-0/clock-controller@2011000: failed to match any schema with compatible: ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

-- 
	Ansuel
