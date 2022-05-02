Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F5517545
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353113AbiEBREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386464AbiEBREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:04:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA4425F7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:00:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so28893990ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pw2/oXmpaIHCVTryeNN1ZqUEyp67KQCQZki+AHhMtg4=;
        b=WFLlqSaRxtRM1eXCMOy3bfOnfmy/O0CNxC/Kvxvq/ZIAe6jSq6QKKTxR2533G2Ma+M
         cJ7mlkEywoFDQhZG7+kRn8mhBuqtd3heRlnY0oV+pOFJG3vEXsS/ZpfmMuuJ838fRTyq
         Xk6I4ysRfS7pCyUZj4MDQtXlPkIN333kbsYkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pw2/oXmpaIHCVTryeNN1ZqUEyp67KQCQZki+AHhMtg4=;
        b=RYhf4/Q5YT+g3XccJquruic3bp6OWO7g+k+ZKVcmvwaC6452iXRXLD78EzMGCuTI4K
         MFJLFXIoErG1xLWN+28fRgT74pvcSBFOnZt6XPK9MMJnaAaJD7SZoIxkn59dgzUbCWT7
         zQWKxoRfxkniJyuiUuBXuWl+qRMsRfeYBsa1hetK8u8OIjquqXd5gwlP6R1xpxhVDo6w
         cmlDN8l/lfEYFVGyPzpqJyzWCu7YIJUNcoJmf6NzgxHWcmjBIGZ7W4rs45EHxGFaJ5Jy
         xBU/FQsnayBZMsSYxDv9AF5eYg1KwWVPVhTqZQV6tQ6H6vrw2O9bZe11+WV8ZbL0mtLt
         u8yw==
X-Gm-Message-State: AOAM5300vNXwhBmLUFhY5la68ErHWzY5VYaPYR/x68KdU88reUmFLYbi
        ZYbC8KZZDetxM6EcfuEtEy9e9Ef9u1l6qZke
X-Google-Smtp-Source: ABdhPJzXJBmbCAhIYzuXYO5JSbPNqAkkp1zp+lqt9HQHdD9KgA8gMv/zGzlBZR8bZ2MBmoeERNXGLQ==
X-Received: by 2002:a17:907:3fa6:b0:6f3:a758:73b3 with SMTP id hr38-20020a1709073fa600b006f3a75873b3mr12143791ejc.108.1651510857164;
        Mon, 02 May 2022 10:00:57 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006f3ef214e7bsm3793006ejc.225.2022.05.02.10.00.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:00:56 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id k126so5184219wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:00:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4e44:b0:394:46b4:7b0e with SMTP id
 e4-20020a05600c4e4400b0039446b47b0emr57531wmq.29.1651510855777; Mon, 02 May
 2022 10:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
In-Reply-To: <20220429233112.2851665-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:00:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
Message-ID: <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 29, 2022 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the device is a detachable, this device won't have a matrix keyboard
> but it may have some button switches, e.g. volume buttons and power
> buttons. Let's add a more specific compatible for this type of device
> that indicates to the OS that there are only switches and no matrix
> keyboard present. If only the switches compatible is present, then the
> matrix keyboard properties are denied. This lets us gracefully migrate
> devices that only have switches over to the new compatible string.

I know the history here so I know the reasons for the 3 choices, but
I'm not sure I'd fully understand it just from the description above.
Maybe a summary in the CL desc would help?

Summary:

1. If you have a matrix keyboard and maybe also some buttons/switches
then use the compatible: google,cros-ec-keyb

2. If you only have buttons/switches but you want to be compatible
with the old driver in Linux that looked for the compatible
"google,cros-ec-keyb" and required the matrix properties, use the
compatible: "google,cros-ec-keyb-switches", "google,cros-ec-keyb"

3. If you have only buttons/switches and don't need compatibility with
old Linux drivers, use the compatible: "google,cros-ec-keyb-switches"


> Similarly, start enforcing that the keypad rows/cols and keymap
> properties exist if the google,cros-ec-keyb compatible is present. This
> more clearly describes what the driver is expecting, i.e. that the
> kernel driver will fail to probe if the row or column or keymap
> properties are missing and only the google,cros-ec-keyb compatible is
> present.
>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/input/google,cros-ec-keyb.yaml   | 95 +++++++++++++++++--
>  1 file changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index e8f137abb03c..c1b079449cf3 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -15,14 +15,19 @@ description: |
>    Google's ChromeOS EC Keyboard is a simple matrix keyboard
>    implemented on a separate EC (Embedded Controller) device. It provides
>    a message for reading key scans from the EC. These are then converted
> -  into keycodes for processing by the kernel.
> -
> -allOf:
> -  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  into keycodes for processing by the kernel. This device also supports
> +  switches/buttons like power and volume buttons.
>
>  properties:
>    compatible:
> -    const: google,cros-ec-keyb
> +    oneOf:
> +      - items:
> +          - const: google,cros-ec-keyb-switches
> +      - items:
> +          - const: google,cros-ec-keyb-switches
> +          - const: google,cros-ec-keyb
> +      - items:
> +          - const: google,cros-ec-keyb
>
>    google,needs-ghost-filter:
>      description:
> @@ -41,15 +46,40 @@ properties:
>        where the lower 16 bits are reserved. This property is specified only
>        when the keyboard has a custom design for the top row keys.
>
> +dependencies:
> +  function-row-phsymap: [ 'linux,keymap' ]
> +  google,needs-ghost-filter: [ 'linux,keymap' ]
> +
>  required:
>    - compatible
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: google,cros-ec-keyb
> +    then:
> +      allOf:
> +        - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: google,cros-ec-keyb-switches
> +    then:
> +      required:
> +        - keypad,num-rows
> +        - keypad,num-columns
> +        - linux,keymap

I think that:

1. If you only have buttons/switches and care about backward
compatibility, you use the "two compatibles" version.

2. If you care about backward compatibility then you _must_ include
the matrix properties.

Thus I would be tempted to say that we should just have one "if" test
that says that if matrix properties are allowed then they're also
required.

That goes against the recently landed commit 4352e23a7ff2 ("Input:
cros-ec-keyb - only register keyboard if rows/columns exist") but
perhaps we should just _undo_ that that since it landed pretty
recently and say that the truly supported way to specify that you only
have keyboards/switches is with the compatible.

What do you think?

-Doug
