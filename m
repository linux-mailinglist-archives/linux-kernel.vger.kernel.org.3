Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5118F49A800
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315810AbiAYCyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:21 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34791 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3409082AbiAYAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:24:55 -0500
Received: by mail-ot1-f46.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso24618688otf.1;
        Mon, 24 Jan 2022 16:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKgu9rmUk95J97wO8FZCJYIlIG/PvU+dGhgzBVkVwN8=;
        b=MZE5ndUCCOr/b4NI4VHdNhqVZNbcnfNVW+pUDQlubdmhX9/QaRvzE1/y6iiu5Kr/a0
         NbYQPtaQPHFxKq2RPmErQsxnl/ur1plF+nnuPyA7HnGTOm4Vurflsqrvtbt2NO0qQs26
         d0pj8unzscOwT1TKYeqbKyBD8BI7I7HC5ZOrExMbGN8ORAeTa4CPVl7QG1ivPvz2a7yh
         CK0HLgtFgFZHhr8+3ysq6JiHwv8AnkbjR8Frte41Oh5ZSSYhMsSJlyEwkhgPcrkkGclS
         +2oMOy6k4xTyOWkdIaTYGlPP+UFUudAT/mJoGuRxLvwsmibBlbH5r6AnIZnkb1Nh3WLv
         EUCQ==
X-Gm-Message-State: AOAM531oUs1mqAOcvcdIDosnWbAY5WmN6j6q2ZEx5AE3dHR7brRSihDT
        wQcoL//ydUwFDYNYDfxFbQ==
X-Google-Smtp-Source: ABdhPJwBQlZsDWkm3dE9/hvTrL4jN/68Lxk+HhTDBRoQqFgYwJwB6VNNcUYx1ZcvnXNEAfY0RZ18Zg==
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr7103969oti.163.1643070291812;
        Mon, 24 Jan 2022 16:24:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a19sm2751280otf.27.2022.01.24.16.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 16:24:51 -0800 (PST)
Received: (nullmailer pid 809305 invoked by uid 1000);
        Tue, 25 Jan 2022 00:24:50 -0000
Date:   Mon, 24 Jan 2022 18:24:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/6] ASoC: dt-bindings: samsung,snow: convert to dtschema
Message-ID: <Ye9DUjVGWDmhvPtu@robh.at.kernel.org>
References: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
 <20220124170336.164320-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124170336.164320-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:03:35PM +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on Google Snow boards with Samsung Exynos SoC
> to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> TODO: The DTS do not pass cleanly. cpu/sound-dai should be fixed.
> ---
>  .../bindings/sound/samsung,snow.yaml          | 78 +++++++++++++++++++
>  .../devicetree/bindings/sound/snow.txt        | 31 --------
>  2 files changed, 78 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,snow.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/snow.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung,snow.yaml b/Documentation/devicetree/bindings/sound/samsung,snow.yaml
> new file mode 100644
> index 000000000000..df969b384839
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,snow.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,snow.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Snow audio complex with MAX9809x codec
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - google,snow-audio-max98090
> +      - google,snow-audio-max98091
> +      - google,snow-audio-max98095
> +
> +  codec:
> +    type: object
> +    properties:
> +      sound-dai:
> +        description: List of phandles to the CODEC and HDMI IP nodes.
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        items:
> +          - description: Phandle to the MAX98090, MAX98091 or MAX98095 CODEC.
> +          - description: Phandle to the HDMI IP block node.

Thinking about this and the issue you raised some more, we should make 
sure there's a common definition for sound-dai. And then here, it should 
just be the number of entries ('maxItems: 1').

Rob
