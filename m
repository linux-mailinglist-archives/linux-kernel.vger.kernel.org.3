Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC74D913C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiCOAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiCOAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:25:27 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AE03CFC1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:24:16 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z85so19050955vsz.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+FOSvDg+ZUh5vunVEqGtFAxwPurKxeLhtmDXEkBmug=;
        b=OkbxfUcCvuK0TIeWEhVllcozSpDI+atGFo1gj7JDGcq7W/bia8MXWEnCfQbkKBF6NL
         nTPUUorDchFrNA5oATz4P5IbFvCHKqp6D61Hfor5tDNi/RjsQf3FPVrfqERdCy6+2DHE
         Zwyi+cOw/B7l0+TvugAGX8IRU7395eDn22VUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+FOSvDg+ZUh5vunVEqGtFAxwPurKxeLhtmDXEkBmug=;
        b=FA++RfcMmLSabXSpFaN+7UeM4jyJjkaSYzSu3JLQzEpxvIuOUeRGMgTp8h162s41df
         TSZmqCIyZSBvHZVo/YiT/Gbq6A5i00nQ5xDTqiL8NBUlKDujFR+4mJGwAMxTUx3ivwbt
         APVZnjSaum17d4bwkgcBFmzd2ZFRlZQq62edscoCgoJ9RSMx5rC9XPhNEDUpy3XSZNT3
         idcwR8ggC1myzNkqF2mRNxUe2zZwYNQW0LmUgyg32xHMAQzl6x+RZe/LRG6GYFZAQ2dZ
         fldgokuA3zfmChEOeacluuCvcHvkFJEylyDEJRSgi5f9FxmkH7gkeWfY79upzP7MKYCZ
         opXQ==
X-Gm-Message-State: AOAM533cHbGVFbiplKtJPP2R9OUP4vQc4+t/ZGEzFlxKp8wRL7auIXBM
        6ho7U7cLw5GtoqDyfTCMvR8LI31pQiLAoQ==
X-Google-Smtp-Source: ABdhPJzOjJ9NsVQ06bx/6Dt1Ca55iXu9ibiL2ZMw0GjWlZPQ6/yd03eovze0ijTrTuDZT2X+g42D9Q==
X-Received: by 2002:a67:e911:0:b0:322:f217:4c2f with SMTP id c17-20020a67e911000000b00322f2174c2fmr2759258vso.87.1647303855884;
        Mon, 14 Mar 2022 17:24:15 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a1f9e0e000000b00331eed549basm2449288vke.8.2022.03.14.17.24.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 17:24:14 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id b37so7321859uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:24:14 -0700 (PDT)
X-Received: by 2002:ab0:67d7:0:b0:345:6bac:4f15 with SMTP id
 w23-20020ab067d7000000b003456bac4f15mr9498820uar.43.1647303854018; Mon, 14
 Mar 2022 17:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220314232214.4183078-1-swboyd@chromium.org> <20220314232214.4183078-2-swboyd@chromium.org>
In-Reply-To: <20220314232214.4183078-2-swboyd@chromium.org>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Mon, 14 Mar 2022 17:23:38 -0700
X-Gmail-Original-Message-ID: <CAHNYxRwFYBbgxUqz79jYXbDxSd-r+NdHWQPucEyuNK83U577xw@mail.gmail.com>
Message-ID: <CAHNYxRwFYBbgxUqz79jYXbDxSd-r+NdHWQPucEyuNK83U577xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add a binding to describe the fingerprint processor found on Chromeboks
> with a fingerprint sensor.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/mfd/google,cros-ec-fp.yaml       | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
> new file mode 100644
> index 000000000000..05d2b2b9b713
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/google,cros-ec-fp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS Embedded Fingerprint Controller
> +
> +description:
> +  Google's ChromeOS embedded fingerprint controller is a device which
> +  implements fingerprint functionality such as unlocking a Chromebook
> +  without typing a password.
> +
> +maintainers:
> +  - Tom Hughes <tomhughes@chromium.org>
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-fp
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 3000000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: reset signal (active low).
> +
> +  boot0-gpios:
> +    maxItems: 1
> +    description: boot signal (low for normal boot; high for bootloader).
Maybe add "active high, same polarity as the fpmcu sees physically".

> +  vdd-supply:
> +    description: Power supply for the fingerprint controller.
> +
> +  google,cros-ec-spi-pre-delay:
> +    description:
> +      This property specifies the delay in usecs between the
> +      assertion of the CS and the first clock pulse.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - default: 0
> +      - minimum: 0
> +
> +  google,cros-ec-spi-msg-delay:
> +    description:
> +      This property specifies the delay in usecs between messages.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - default: 0
> +      - minimum: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - boot0-gpios
> +  - vdd-supply
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <0x1>;
> +      #size-cells = <0x0>;
> +      ec@0 {
> +        compatible = "google,cros-ec-fp";
> +        reg = <0>;
> +        interrupt-parent = <&gpio_controller>;
> +        interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> +        spi-max-frequency = <3000000>;
> +        google,cros-ec-spi-msg-delay = <37>;
> +        google,cros-ec-spi-pre-delay = <5>;
> +        reset-gpios = <&gpio_controller 5 GPIO_ACTIVE_LOW>;
> +        boot0-gpios = <&gpio_controller 10 GPIO_ACTIVE_LOW>;
This should say GPIO_ACTIVE_HIGH, since there's no inverting going on
either with a real inverter, or the convention (of 'N' being in the
pin name).

It might be easier to reason about if there's no invesion going for this signal.

Consider it like an enum instead of a verb (unlike active_low
reset-gpios which can be considered: in reset if it's set):

enum boot0 {
        normal = 0,
        bootloader = 1,
};

> +        vdd-supply = <&pp3300_fp_mcu>;
> +      };
> +    };
> +...
> --
> https://chromeos.dev
>
--
Alexandru Stan (amstan)
