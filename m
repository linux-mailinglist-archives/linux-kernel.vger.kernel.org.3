Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662346D4B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhLHNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:48:26 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34350 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbhLHNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:48:18 -0500
Received: by mail-oi1-f176.google.com with SMTP id t19so4222343oij.1;
        Wed, 08 Dec 2021 05:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eIDyK7IaEt6AWxSPZLft57NpyzGJfPRgZj/kMkxWENE=;
        b=qFcpwEg5l6IsbqJLG6SuXUdjbKREtc3lHgvUTEXtM+kMbOGyoR7rKmzngAFt/Ea2OR
         i1fxRtelh88+/WFQ0Mh8CWmCYz8/JAIfHjgRXqPCuebBjQLwu7O0BP8QesDtx9a376nb
         iFcs7X/gDq73HBfy3bhtS2MSJG1y4lET8ULudiYsQdbSxB3F39qg3Zz9fkFeX5BSf27d
         TFyyuZT8XLj3T30yu5I9KbKwuEFPwhtf6LllJ4R0RYM8r6kzHO5BOV5LjR/wORoTLZfu
         pGcEh3jHVtpdp5UMt3adimo7x+Jo1NdMZmh3zotU1k8mwnzMtxcNEfl5xaKhDYrjAsLK
         oaow==
X-Gm-Message-State: AOAM531iKLq0BOBHyCPywVJiy+9/m9GrX0QusPZgOWXSjWsGwmQ3LZkk
        9NsAljlc+Q6cT/93JNx99w==
X-Google-Smtp-Source: ABdhPJz9YvJWuibEYQzebm5H3zO4j8sZZJym7m5fdDKQt86UCjfwAiPutT7QpChbFcbNbWW9u//YRQ==
X-Received: by 2002:a05:6808:1885:: with SMTP id bi5mr12257718oib.54.1638971086359;
        Wed, 08 Dec 2021 05:44:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w4sm665805oiv.37.2021.12.08.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:44:45 -0800 (PST)
Received: (nullmailer pid 3857730 invoked by uid 1000);
        Wed, 08 Dec 2021 13:44:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org
In-Reply-To: <20211207210823.1975632-5-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net> <20211207210823.1975632-5-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 4/8] dt-bindings: pinctrl: Add Nuvoton WPCM450
Date:   Wed, 08 Dec 2021 07:44:28 -0600
Message-Id: <1638971068.731875.3857729.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 22:08:19 +0100, Jonathan Neuschäfer wrote:
> This binding is heavily based on the one for NPCM7xx, because the
> hardware is similar. There are some notable differences, however:
> 
> - The addresses of GPIO banks are not physical addresses but simple
>   indices (0 to 7), because the GPIO registers are not laid out in
>   convenient blocks.
> - Pinmux settings can explicitly specify that the GPIO mode is used.
> 
> Certain pins support blink patterns in hardware. This is currently not
> modelled in the DT binding.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> 
> ---
> v2:
> - Move GPIO into subnodes
> - Improve use of quotes
> - Remove unnecessary minItems/maxItems lines
> - Remove "phandle: true"
> - Use separate prefixes for pinmux and pincfg nodes
> - Add nuvoton,interrupt-map property
> - Make it possible to set pinmux to GPIO explicitly
> 
> v1:
> - https://lore.kernel.org/lkml/20210602120329.2444672-5-j.neuschaefer@gmx.net/
> ---
>  .../pinctrl/nuvoton,wpcm450-pinctrl.yaml      | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.example.dt.yaml: pinctrl@b8003000: gpio@0:interrupts: [[2, 4, 3, 4, 4, 4]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.example.dt.yaml: pinctrl@b8003000: mux_uid: Additional properties are not allowed ('phandle' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.example.dt.yaml: pinctrl@b8003000: cfg_uid: Additional properties are not allowed ('phandle' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.example.dt.yaml: pinctrl@b8003000: '#address-cells', '#size-cells' do not match any of the regexes: '^cfg_.*$', '^gpio@.*$', '^mux_.*$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1564902

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

