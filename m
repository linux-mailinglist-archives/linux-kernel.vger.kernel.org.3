Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4901D46D4AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhLHNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:48:20 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33738 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhLHNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:48:15 -0500
Received: by mail-ot1-f47.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso2838496otf.0;
        Wed, 08 Dec 2021 05:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=d9pU8JusJ0nsIKbrfuBpVn2ASUUJN8eQS5WgDx97T70=;
        b=34OWtXuMG0DWKzzbk9UzuzYjynzPZNG6A4hNeNj4u4hxZ/zirsT4jGF1qMfpyMrGgd
         FxBWynTUR6HL8ww9X8EUnFTdaKxkeRsLh0Y7FgonvSbm2Jdho5iqodQ0GF3J7RsaRpAG
         eNryKKAtuSseRC9sS+8secUyDityxgDC/1qzltRMhrH7vpde9R7jbLJrHUjlYGn5wIBx
         t3Hck63KI6j1EVVcgDJbcK+cPOnM9z0wi7/kUca9tZGzA1GIMwpmObxv/AJAr8GbbWDO
         N4hgQFRF8Olfv1wEDX9DkG/M9Y7GZpJDdJwRDKVs4fb6sVAGA1jfyqIHshHY/N2XV5Tg
         DLsA==
X-Gm-Message-State: AOAM530n+dcgpp7Ml+ox7Xm7QRlyHzKcRRMj0LWG63Bblrm8LOMYFFMc
        6E/4zyIWcXs5zYhhO4it605JSUz0Hg==
X-Google-Smtp-Source: ABdhPJzklnesFyQINRJbzyMBRDzJZ0023nhrzxD3hZxHsZWpdpkix8DxjCFFAzRhCkjwB6GkAez0mg==
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr42325048otl.208.1638971083269;
        Wed, 08 Dec 2021 05:44:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w80sm633310oif.2.2021.12.08.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:44:42 -0800 (PST)
Received: (nullmailer pid 3857728 invoked by uid 1000);
        Wed, 08 Dec 2021 13:44:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Nancy Yuen <yuenn@google.com>, linux-gpio@vger.kernel.org,
        Tali Perry <tali.perry1@gmail.com>, openbmc@lists.ozlabs.org,
        Patrick Venture <venture@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Avi Fishman <avifishman70@gmail.com>
In-Reply-To: <20211207210823.1975632-2-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net> <20211207210823.1975632-2-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 1/8] dt-bindings: arm/npcm: Add binding for global control registers (GCR)
Date:   Wed, 08 Dec 2021 07:44:28 -0600
Message-Id: <1638971068.720448.3857727.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 22:08:16 +0100, Jonathan Neuschäfer wrote:
> A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
> be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
> WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
> version information.
> 
> This patch adds a binding to describe this node.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> ---
> v2:
> - Rename node in example to syscon@800000
> - Add subnode to example
> 
> v1:
> - https://lore.kernel.org/lkml/20210602120329.2444672-2-j.neuschaefer@gmx.net/
> ---
>  .../bindings/arm/npcm/nuvoton,gcr.yaml        | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.example.dt.yaml: syscon@800000: 'uart-mux-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.example.dt.yaml: uart-mux-controller: $nodename:0: 'uart-mux-controller' does not match '^mux-controller(@.*|-[0-9a-f]+)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mux/mux-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1564899

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

