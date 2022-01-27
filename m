Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80949DB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiA0H3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:29:00 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35382
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230054AbiA0H27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:28:59 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 210C63F1D9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643268538;
        bh=T0Cao9EYbGyGDdTGcr1ndXwb9FVrHnyvN3eX07tx2XQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Y714sbpD24iFULa9Qa+qGGI6rS4lQFEljp7Qrkmg8mIqnJxg51tkN8wfVC+VVTZg0
         y+Zs4fPW2wAHxXaDsEZLp3gFisvzMPTook5z7aLTDlOPRRCkcqTEVDmOXsml85ysm0
         xtwO77/BIGnpNylQRKMotayqcWln+0j9zGuC2Eh54Nne01LNw3GitSCyRnFEGKf4iL
         LcgmFn0ZrNhf8ElvySxmAoUnODIkEM6TA67MQjoh6ePSuc+6C9GrlUMBj9crqaJVzc
         J99sXkojApKJa4lgij3GDpCafu5vVPG3OjOiZda9/tgna7u5yheBZ50jDqOy1D7SwL
         4JMGgGtqgp3iA==
Received: by mail-wr1-f71.google.com with SMTP id r27-20020adfb1db000000b001d7567e33baso698976wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T0Cao9EYbGyGDdTGcr1ndXwb9FVrHnyvN3eX07tx2XQ=;
        b=X/28dpZKh2H/gOQt2vosXZyTASyQG4M2ayNyATatJuxAwL/PXmfb480q3MZRcwgMNe
         giD0xf4ytw2PF2DDcQ0mN5G3nhPdQb2bqQrs9+s83LejgFPyflG9VtJj7pKJCF/zPY8c
         V328yRHXjcc+sqni7XW6ZxrSEMRHn6RvqtICPF4PYf94n2vJouatTRI/kkEo2hFEwwWH
         WloDIfG3PVwYHe7lYmgXHOr5JGnLrWYKBEfOCk4kyB5D7TtwzBgHtt/fAUC4jtfeMMKO
         HI4v1A67IX4YM/Bf6WQy8AiW/vCqIOBwQx9lAntjDJu9GX1YBvOqUHQs1CtwZwRDxygr
         cwBQ==
X-Gm-Message-State: AOAM531tDnA4Itei3uqhl1u37Htp3u25LJTHHOsXPLOmdKBXbUM4WZP/
        uWi+l+TGPK6MKVLyUW0fzf5C6+pJrwuVXo84zSa12uh4eHmC8E+shv+rBT0KFyEzmiC9Brnq9nM
        8xyQiTx6aBL1GvTOVvD2EelbjeUCFq0GXUXnQi+Z+Ew==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr1845698wrq.613.1643268537775;
        Wed, 26 Jan 2022 23:28:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqClftY3Y8SR9yE9omjRxWnvEsOEI2w7cS7ER6+j2GDHexFol/gUHicZH4VStQR13iFWf6tg==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr1845674wrq.613.1643268537569;
        Wed, 26 Jan 2022 23:28:57 -0800 (PST)
Received: from [192.168.0.62] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g5sm1740182wri.108.2022.01.26.23.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:28:57 -0800 (PST)
Message-ID: <f0bd9681-c87b-a6bf-09af-05e45b0b9707@canonical.com>
Date:   Thu, 27 Jan 2022 08:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: dt-bindings: Centralize the 'sound-dai' definition
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220126231427.1638089-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220126231427.1638089-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 00:14, Rob Herring wrote:
> 'sound-dai' is a common property, but has duplicate type definitions.
> Create a new common definition to define the type and then update all
> the other occurrences to just define how many entries there are just
> like other phandle+arg properties.
> 
> The constraints on the number of entries is based on the examples and
> could be wrong.
> 
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack, this depends on commit abf0fee97313 ("dt-bindings: Improve
> phandle-array schemas") in my tree.
> ---
>  .../bindings/sound/amlogic,gx-sound-card.yaml |  4 ++--
>  .../bindings/sound/google,sc7180-trogdor.yaml |  6 ++++--
>  .../bindings/sound/imx-audio-card.yaml        |  7 +++++--
>  .../bindings/sound/qcom,sm8250.yaml           | 10 +++++++---
>  .../bindings/sound/samsung,aries-wm8994.yaml  |  5 +----
>  .../bindings/sound/samsung,midas-audio.yaml   |  2 --
>  .../bindings/sound/samsung,odroid.yaml        |  9 +++------
>  .../devicetree/bindings/sound/sound-dai.yaml  | 20 +++++++++++++++++++
>  8 files changed, 42 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/sound-dai.yaml
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
