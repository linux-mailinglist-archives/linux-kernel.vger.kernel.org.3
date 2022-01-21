Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7593F49681B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiAUXIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:08:19 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40455 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiAUXIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:08:18 -0500
Received: by mail-ot1-f53.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so13634307otr.7;
        Fri, 21 Jan 2022 15:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=riTVZXDdFirHSqQYOJ8NhNlm44IGv5r1Q6vZ1IVXuTk=;
        b=h9hN5n74traH9vozu0V9iDZxMAwLzRLjXPLO92N55GCdsk/GD7+j9opXZxxuIX7F8v
         JSwPmWVO5rwHHbj0lZXKBe3aVL5MiR8sbVXkenu2SVkwY5lYGpkmN+7DzyXTol8/1ko7
         QjNFlNg8YSIA7NpMllTlPtRf4jI18zdhwjgEWx3wUaNdxv4wHCzvx+Lylo13Ez5W3E7W
         X06dqWg9Vl+Io4eIeDq60eS4iuJVyiYLUZs82Pe3o3ML7frgS1Y3qnj11P+ISzVkBnsb
         FJY/FUCjhh6Iba/IBZk5feKoFFc73YvA2ixyvQ4fX5imWrtdJUe8X0qnTVUy44m0KQqw
         eCEA==
X-Gm-Message-State: AOAM5315hTg06cgyKOt6OtsLfx5vbfYb/i3twkGPypdaR1sVNOPdvP4R
        Uc75943PqWCA7cDLriZGuQ==
X-Google-Smtp-Source: ABdhPJwGhLZDGPflDcwJnvSTrejxqDj5W3rP/J3cP4rNS/CI6GPpYV+L9BGUr/yHQCN3MX9CNcWpdw==
X-Received: by 2002:a9d:360b:: with SMTP id w11mr4298264otb.102.1642806497818;
        Fri, 21 Jan 2022 15:08:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl16sm1912752oib.2.2022.01.21.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:08:17 -0800 (PST)
Received: (nullmailer pid 1779915 invoked by uid 1000);
        Fri, 21 Jan 2022 23:08:15 -0000
Date:   Fri, 21 Jan 2022 17:08:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Nancy Yuen <yuenn@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>,
        linux-gpio@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4 4/9] dt-bindings: pinctrl: Add Nuvoton WPCM450
Message-ID: <Yes830dXetys05hV@robh.at.kernel.org>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
 <20220109173000.1242703-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220109173000.1242703-5-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 18:29:55 +0100, Jonathan Neuschäfer wrote:
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
> ---
> v4:
> - Small improvements around gpio node addresses, suggested by Rob Herring
> 
> v3:
> - https://lore.kernel.org/lkml/20211224200935.93817-5-j.neuschaefer@gmx.net/
> - Make changes suggested by Rob Herring
> - Fix lint errors
> - Simplify child node patterns
> - Remove if/type=object/then trick
> - Reduce interrupts.maxItems to 3: 4 aren't necessary
> - Replace list of gpio0/1/2/etc. with pattern
> - Remove nuvoton,interrupt-map again, to simplify the binding
> - Make tuples clearer
> 
> v2:
> - https://lore.kernel.org/lkml/20211207210823.1975632-5-j.neuschaefer@gmx.net/
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
>  .../pinctrl/nuvoton,wpcm450-pinctrl.yaml      | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
