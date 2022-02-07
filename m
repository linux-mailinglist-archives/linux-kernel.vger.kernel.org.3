Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA544AB8AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiBGKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357045AbiBGKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:11:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9DC0401E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:11:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so9792186wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 02:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t1grJfuaAdS3B1XhyLaLbix7QKdpfthiiXC5enSQ1wU=;
        b=wPpS1R/uWVlqPEkanPeqJeH/0D36BtOQVNLC6MxnxsReockDsvWqZG0Z1ByYDDuvM7
         4wItKYbdClpjxyuOyRK9/gJfr5YryUe5EgYLsk6JfeJMCd3XkXMnnxdp9JqUXD/1UkV8
         t0mtIzGSIsgctau6xdm1KHCMbGvMNEL/JVAUQjalNg9u+oU7LrHc3Wn3uSNTw5lbgYUd
         DpByqvFXqb50PDV3lL8IoxrzzsNtFipGmOWCNjjpRAvXUMLeFiYICD19OtjrI4lXaS4R
         V0LkGJa1SmI6gGzOs8S5qtFDYA0i7YfRY+bvGhZQkICcuObnwhNHAjilL2KENHyKeg7s
         CLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t1grJfuaAdS3B1XhyLaLbix7QKdpfthiiXC5enSQ1wU=;
        b=R58i/sTEmxv2miTgW2+kBcH3vvE8JMZO+v7Zo/POWyiaYeeudqOLASmlpE4aGEyezv
         XYGtQr7vxLxpGAur59AUA1b4UNIcwNmuCpEYt1HgFCCQsS0AXYFMIKppln6l7SUr2h87
         ZZzLhi13LPfGd1mWTFQcjPQQBMPIh0KtGMROs1gOd23IFbp2+HBFr/hQJ801E2Wk25qZ
         ZgfUC46dkbW3PnrzksZ9PXbdHtPh1bdruk+msbc3UKMBJXO7xylwTwmJR0yG98wWw/f1
         76d7bU4ckfQMDaWTcUm8EW4F40Xcc1t8JBSB0xhqY3i6PqxsMqGo1LMJB1n0ZqS+ZfSo
         m/QA==
X-Gm-Message-State: AOAM530Yz6FVCv2YfptfFL7UCGOaY5o/v19dFzHRcN+kF/KQ4fFca4B5
        Y0oA4i2a1Ok8dMojfKG1SwhCMVqPQPFa2Q==
X-Google-Smtp-Source: ABdhPJyfPm5Ul6/cWxD2ilu20wXd7IFB/LmDVwLybcoxL+DwkSm+3qkAcNf1ZOyzjv+UAG62JG50qg==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr9155762wry.254.1644228667605;
        Mon, 07 Feb 2022 02:11:07 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c13sm9620833wrv.24.2022.02.07.02.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 02:11:07 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:11:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/5] mfd/extcon/regulators: max77843: add
 dtschema/bindings
Message-ID: <YgDwOWRpfVBfcXxs@google.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <1bebedb9-644f-783d-492c-84a5de91720d@canonical.com>
 <YgDnUNCNCO+JLyHU@google.com>
 <88fcdbe6-5fef-d9cc-a645-69e35230cdeb@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88fcdbe6-5fef-d9cc-a645-69e35230cdeb@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Krzysztof Kozlowski wrote:

> On 07/02/2022 10:33, Lee Jones wrote:
> > On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:
> > 
> >> On 11/01/2022 18:48, Krzysztof Kozlowski wrote:
> >>> Hi,
> >>>
> >>> The max77843 shares some parts with max77693 but it lacked bindings.  All
> >>> its compatibles were undocumented.  Add basic bindings for max77843,
> >>> matching existing devicetree.  These are not complete bindings, but
> >>> rather reverse-engineered to match current state.
> >>>
> >>> I do not have access to device with MAX77843, so if anyone else
> >>> volunteers to be the bindings maintainer, please join.
> >>>
> >>> Changes since v1
> >>> ================
> >>> 1. MFD: Use absolute path to schemas.
> >>> 2. Regulator: mention all allowed properties,
> >>>    additionalProperties=false, add min/max values for voltages and
> >>>    current, don't use patternProperties when not needed.
> >>> 3. extcon: Use absolute path to schemas.
> >>>
> >>> Dependencies
> >>> ============
> >>> 1. Patch 1/5 (dts): nothing depends on it, sending here so Rob's automatic
> >>>    checker won't complain about DTS.
> >>>    I will take it via Samsung SoC tree.
> >>>
> >>> 2. The patch 4/5 (mfd bindings) depends on regulator and extcon, so they
> >>>    should come together (2+3+4+5).
> >>>
> >> Dear Lee,
> >>
> >> This patchset was reviewed and there are no outstanding issues. Could
> >> you pick up patches 2-5 (skipping DTS patch) via MFD tree?
> > 
> > Are the subsystem maintainers not going to review/ack?
> > 
> 
> Would be nice to have them, but maybe since these are dt-bindings maybe
> they were skipped? 

Agreed, not required, but nice to have to avoid possible conflict.

> Or maybe it was the end-of-year holidays?

> I can resend hoping it will trigger more acks. Do you wish me to resend?

That shouldn't be necessary.

I'll give the guys a little while to protest/ack, then I'll merge.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
