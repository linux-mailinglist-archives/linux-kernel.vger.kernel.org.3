Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8C4CF8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiCGJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiCGJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:40:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73536BF49
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:37:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x15so22174941wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dedx0S9GHW+zCkwbwjAj7WEO1ltayYGHp0V6c4kJEK0=;
        b=dOMdB7J6brgJ2xzB+wrppTiKJ6RjnpcClkRhOIwSfpgp+0jrJe2ORFPVEtMFRHrs9f
         l7thIuzhh+jnrFKTDyLqsNLOdlRxEP8WMe22XbXC33fFvUdp4jwvpXmaEiiHvXaUIiFr
         80NN8JS7ySADo621LVmJwOnq5GYHUkoRFL1hfn/0JliTL7fzwZAI1h9FP1JThlFJTpcR
         szVt580bgl/aqI1RqcSQOFGjsvArGvodGKQrzZ/2rGGrIQN6GaOURjZ/eqn3l1hvyms7
         CzR2V81RHFlGyBhVZ7S7r/Ejd99U+h5CfZFdtmB4WG/VbXN25a5NOyemfnlhmyA9LZM5
         NWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dedx0S9GHW+zCkwbwjAj7WEO1ltayYGHp0V6c4kJEK0=;
        b=Zu6f+OqmVEF3LnRuf1e/lUH9Iq7pbxuB4IKNseCB3wClBonGO+Ipiuw1AbG+zR82NC
         k4yL4Dh/qe8n1YmqNN6c3V1dgYsZf1SEcaN46U2Cyog0t+mpDMXr9dQhB6MR0EWVKfjR
         NM+gmfjzDqE/Z3iwTMA85Xijhp3UUipTwWV9Z31+ZW35jJ25zPlJ70SKCjRClJf9olyP
         U7bh6B4ugyIVIKXaQkq/Fqryw8stx9SPNznwdGbHnXsnkXCHTUENKly9RNbLnUSyjPGH
         Bx73GfRrHCZ7MS/JGWzuuK25m64K1oRe5NV04P9y6mvVW+Z0VgpduMFjJ9fCFloJZfy2
         SvMw==
X-Gm-Message-State: AOAM532prhlfgphOfHlm/9sQvZf7KNTa9dNtvhryH++BpjK2qxQ0wo6e
        7hxpoHPhRasOrlN6Iur0akBP7A==
X-Google-Smtp-Source: ABdhPJy1wHUzClgICXkLnTzjIevPBASUICHgXeFLBM/lOyLrfWzfrHSUqPuD86sAw3lLzcZ8afaSTw==
X-Received: by 2002:a5d:6046:0:b0:1f0:4973:142f with SMTP id j6-20020a5d6046000000b001f04973142fmr7563737wrt.538.1646645853633;
        Mon, 07 Mar 2022 01:37:33 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm14826354wmb.3.2022.03.07.01.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:37:33 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:37:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: maxim,max14577: convert to
 dtschema
Message-ID: <YiXSWzuy9xAXpUMv@google.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
 <20220215074759.29402-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215074759.29402-4-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Krzysztof Kozlowski wrote:

> Convert the MFD part of Maxim MAX14577/MAX77836 MUIC to DT schema
> format.  The example DTS was copied from existing DTS
> (exynos3250-rinato.dts), so keep the license as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
>  .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 196 insertions(+), 148 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
