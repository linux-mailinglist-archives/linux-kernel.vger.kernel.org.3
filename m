Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445C557CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFWNRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiFWNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:17:03 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A60393FE;
        Thu, 23 Jun 2022 06:17:02 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c1so29446937qvi.11;
        Thu, 23 Jun 2022 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=24+UZDm+bboxj7ZmXKARXy52D/6fP2+29qM9adAHJQ4=;
        b=J2q2PpDWZT/XG3kN+Z0MZyGzkZ1IoQg9qGfmPigxNXhO33ieQ/7lU/jHGk6LrR+5ev
         0NPd6cZ+hp3lmjeBc/XTklO3zfgt2v5H1VAQoYDcTUwHrEgpaenjvXcR0GsH0piLkA52
         p8Uy3PRzyQgj/cX8Zeiv+khK0zP4s4BPwjN6PgmH00wqKn2rQCus1mTQ32QoOSOvu4jZ
         dUgRIJ+1cZmtwdkXWjvGzYnVqyK9NmTSYqOB9l3gAMxqkZem/7Gv2w/2g0sMiO7zl67D
         6S6ylcqaVaBmjkDnJYEjtVCisEVeNO9zA26KRkH6E8fmeqd+ryvZqdIIQ1cflpUGlx56
         TeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24+UZDm+bboxj7ZmXKARXy52D/6fP2+29qM9adAHJQ4=;
        b=npSiSa5+WJmf4FaEFKyALpBLi7MDBRq1AuX8GnTYhb4r50lamfpquJpMe7aJzdNMuT
         B16jtLsxHN6VPOWLAt649TT4Hv6OATF5HOy0RkkMnnyii6+EFVkEYaqTef7rF8WHiDK0
         jmj7dNaPWfRsTISwcMt9oOjWLblqVVgmXkwU1ciSMNBkEQzmUI8ZvzQKKcwxFkksVLXo
         3XKPDh2elLd33b7BViHHJl5QGAnbZ+bWeCMOlH+I+GtkIrf01Qw8Kk6o8EMtz5hKD2n8
         BvLhB7sSIsNv8E8RDAOJMLztZMlv3GHsySRhduWLxgkKt7Q10J8xV/qRY7nhbeQaciTV
         D/fA==
X-Gm-Message-State: AJIora83yNMmmY1EHGzP7f1UqULgLy5kaldTBTpQNIQRopQd/SmZrMCZ
        s+Y/DMjR0pV5geKBvobWWiw=
X-Google-Smtp-Source: AGRyM1txIMaEVLgdPcHWGOvqHfkJqRf4fC0njW+U8dzkSZ9CnGAFNz+qzQMCuEb729NqDeTnCZBqjg==
X-Received: by 2002:a05:622a:60c:b0:307:c887:2253 with SMTP id z12-20020a05622a060c00b00307c8872253mr8011201qta.216.1655990221818;
        Thu, 23 Jun 2022 06:17:01 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a77940be22sm18717176qkp.95.2022.06.23.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:17:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:16:59 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v3 05/14] dt-bindings: backlight: Add Mediatek MT6370
 backlight
Message-ID: <YrRny9TPqMUW7Yr/@spruce>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-6-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623115631.22209-6-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:56:22PM +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add mt6370 backlight binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 
> v3
> - Rename "mediatek,bled-pwm-hys-input-threshold-steps" to
>   "mediatek,bled-pwm-hys-input-th-steps"
> - Refine "bled-pwm-hys-input-th-steps", "bled-ovp-microvolt",
>   "bled-ocp-microamp" enum values
> ---
>  .../leds/backlight/mediatek,mt6370-backlight.yaml  | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> new file mode 100644
> index 0000000..26563ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6370 Backlight
> +
> +maintainers:
> +  - ChiaEn Wu <chiaen_wu@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  The MT6370 Backlight WLED driver supports up to a 29V output voltage for
> +  4 channels of 8 series WLEDs. Each channel supports up to 30mA of current
> +  capability with 2048 current steps (11 bits) in exponential or linear
> +  mapping curves.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-backlight
> +
> +  default-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  max-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  enable-gpios:
> +    description: External backlight 'enable' pin
> +    maxItems: 1
> +
> +  mediatek,bled-pwm-enable:
> +    description: |
> +      Enable external PWM input for backlight dimming
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-enable:
> +    description: |
> +      Enable the backlight input-hysteresis for PWM mode
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-input-th-steps:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [1, 4, 16, 64]
> +    description: |
> +      The selection of the upper and lower bounds threshold of backlight
> +      PWM resolution. If we choose selection 64, the variation of PWM
> +      resolution needs over than 64 steps.

more than?

Thanks,
Joe

> +
> +  mediatek,bled-ovp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OVP level triggered
> +    type: boolean
> +
> +  mediatek,bled-ovp-microvolt:
> +    enum: [17000000, 21000000, 25000000, 29000000]
> +    description: |
> +      Backlight OVP level selection.
> +
> +  mediatek,bled-ocp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OCP level triggerred.
> +    type: boolean
> +
> +  mediatek,bled-ocp-microamp:
> +    enum: [900000, 1200000, 1500000, 1800000]
> +    description: |
> +      Backlight OC level selection.
> +
> +  mediatek,bled-channel-use:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      Backlight LED channel to be used.
> +      Each bit mapping to:
> +        - 0: CH4
> +        - 1: CH3
> +        - 2: CH2
> +        - 3: CH1
> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - mediatek,bled-channel-use
> +
> +additionalProperties: false
> -- 
> 2.7.4
> 
