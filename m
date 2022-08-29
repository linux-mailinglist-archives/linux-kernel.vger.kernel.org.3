Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264F5A54F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH2Tze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiH2TzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:55:18 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07546201;
        Mon, 29 Aug 2022 12:55:09 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11c4d7d4683so11761346fac.8;
        Mon, 29 Aug 2022 12:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1Fx0hyhLEgesMduKS6YaoV8lOy13f0toONYZ7JFMUI8=;
        b=xWcRnmvzQOzyC2le2Z2jWPmXfRaYJZai4nf6TGGjOkJqtsXQ1d8jak2IOA/6jSeCt5
         dhrZhv5haTDYj1jqD8lLos3SIRU8pddIz0RdpT5Y1sKNXTIu9Uvtr2pyj1Tl8/1lcq2V
         clmRdzNj7jT5B0ZTNt3ZRG1fq9XwnNP9oFaw4+SXPMBzOkgSq+5pCzxFcrKt/AmlZShW
         pxRQD3GKykLjS6Ld2jR6LuSTHBMuO4U+yxyEvPpc17ogUbZpYHaWQmdDfJYRb/W+HfAB
         DUZnmRPYr4BhtngAOwWP7S3ofzPLagnqL5+Nli5QBQiuZrFgzPmiXLh4q0xxYhTFnYEL
         BnNQ==
X-Gm-Message-State: ACgBeo0zsPgtB4Qs4Iz5YHObywclq9KHP5yzKOFKGHZlElfbJ00JG5Nr
        efXD7FoalgZkR1ObBh14Gw==
X-Google-Smtp-Source: AA6agR79LCtTkBPjMXGth4L11I5KqYCZQN4ePEGJGOaoom7y5jjfLynZ1x4N82eBlETw0i+IO6OPwQ==
X-Received: by 2002:aca:d17:0:b0:344:bea0:8c83 with SMTP id 23-20020aca0d17000000b00344bea08c83mr7497679oin.104.1661802909040;
        Mon, 29 Aug 2022 12:55:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a16-20020a0568300b9000b0063975d170a8sm5068102otv.7.2022.08.29.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:55:08 -0700 (PDT)
Received: (nullmailer pid 2310401 invoked by uid 1000);
        Mon, 29 Aug 2022 19:55:07 -0000
Date:   Mon, 29 Aug 2022 14:55:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sean Paul <sean@poorly.run>,
        Andre Przywara <andre.przywara@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        linux-samsung-soc@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220829195507.GA2310372-robh@kernel.org>
References: <20220823145649.3118479-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-11-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 09:56:42 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/arm,komeda.yaml        | 1 +
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  Documentation/devicetree/bindings/display/msm/gpu.yaml           | 1 +
>  .../bindings/display/samsung/samsung,exynos7-decon.yaml          | 1 +
>  .../devicetree/bindings/display/samsung/samsung,fimd.yaml        | 1 +
>  5 files changed, 5 insertions(+)
> 

Applied, thanks!
