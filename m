Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3254BDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353987AbiFNWl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiFNWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:41:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F53517E2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p128so10971337iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+kyzNbwL34JPEo3iqbzLbGd9UuckbxCXwZqzQQStRo=;
        b=kxZU4O5oWw0x6pDNeXPLnBAGs3Pgu48222c3blJk4xg8T3aZUo/tY4zJCYU8/9SHJc
         eqFiPRvDdjVxZPzHJ4Yr1mmtdWKKKeoKPFWWqMd1kR8Gw7kAq7NIgJhcIPmbG1qZz4OM
         yE/QC1aP/kCMscfKbNeK6lvJBePdJir4T9S6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+kyzNbwL34JPEo3iqbzLbGd9UuckbxCXwZqzQQStRo=;
        b=NwnZ4XzABgXlyD06MecW/FptxbIU7U0q6CH8L5kHTEyQKq7OMIaMzfcOfnaGLMd+9Y
         IWI7gggPOf20xxzy3CGYNVok4Dj+ds+MtXv9qIrH42L3JGU5QGhyeLKatx04mbMKd+aQ
         rL079/9qHpAlfCFesbTp8ADdBcFu812/CsTJ8S38kyanhx6+Q9xU6ETKY99cC7/15jc8
         /kBGgBUNjo85rDyusJXZowvkWHbFCDESujvgb8U+u/s4FoHbwJOiBDwR/2OXb7u67V7f
         YPZTqwfcZDNg1Wq7ANDWwMPKDiqq4JDwp8dChSzy+ZKoi4il4HkNhXw9IKTJD1jH5k6F
         +bhQ==
X-Gm-Message-State: AOAM530/7TNoy8q3obRmiybJ4UkmUsdc8UbidZvB6EVltxoMSSz7Yyn3
        ObKRTRg6B3yvlB1TIhLGKfAjfCAFIKMX201u
X-Google-Smtp-Source: ABdhPJw/LgsVH76ylnnULGRccyUgiSgr9J3moV3xG79n0FQl1N3wS2WKutq+2bqQQ2nepo6ihVzCvA==
X-Received: by 2002:a02:228d:0:b0:333:ffe9:864b with SMTP id o135-20020a02228d000000b00333ffe9864bmr4207706jao.277.1655246513762;
        Tue, 14 Jun 2022 15:41:53 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b0032ec5c47c17sm5316718jah.46.2022.06.14.15.41.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:41:52 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p128so10971292iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:52 -0700 (PDT)
X-Received: by 2002:a02:c6c4:0:b0:333:ecb2:fc7f with SMTP id
 r4-20020a02c6c4000000b00333ecb2fc7fmr3785042jan.184.1655246512053; Tue, 14
 Jun 2022 15:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220614195144.2794796-1-swboyd@chromium.org> <20220614195144.2794796-2-swboyd@chromium.org>
In-Reply-To: <20220614195144.2794796-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jun 2022 15:41:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUnMCj2GmMy2xRG8WOba1O4jzkXeUrrUic71eEA0aZrw@mail.gmail.com>
Message-ID: <CAD=FV=WUnMCj2GmMy2xRG8WOba1O4jzkXeUrrUic71eEA0aZrw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: cros-ec: Reorganize property availability
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 14, 2022 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Various properties in the cros-ec binding only apply to different
> compatible strings. For example, the interrupts and reg property are
> required for all cros-ec devices except for the rpmsg version. Add some
> conditions to update the availability of properties so that they can't
> be used with compatibles that don't support them.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml |  1 +
>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  |  1 +
>  .../i2c/google,cros-ec-i2c-tunnel.yaml        |  1 +
>  .../bindings/mfd/google,cros-ec.yaml          | 29 +++++++++++++------
>  .../bindings/pwm/google,cros-ec-pwm.yaml      |  1 +
>  .../regulator/google,cros-ec-regulator.yaml   |  1 +
>  .../bindings/sound/google,cros-ec-codec.yaml  |  1 +
>  7 files changed, 26 insertions(+), 9 deletions(-)

slight nit that from reading the subject of this patch I'd expect that
it was a no-op. Just a reorganization / cleanup. In fact, it actually
is more than a no-op. It enforces restrictions that should probably
have always been enforced. I think it'd be better if the subject was
something like "tighten property requirements" or something like that.


> @@ -158,12 +154,27 @@ allOf:
>                - google,cros-ec-rpmsg
>      then:
>        properties:
> +        controller-data: false
>          google,cros-ec-spi-pre-delay: false
>          google,cros-ec-spi-msg-delay: false
>          spi-max-frequency: false
>      else:
>        $ref: /schemas/spi/spi-peripheral-props.yaml
>
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: google,cros-ec-rpmsg
> +    then:
> +      properties:
> +        mediatek,rpmsg-name: false
> +
> +      required:
> +        - reg
> +        - interrupts

slight nit that think it would be easier to understand this bottom
section if you made the "SPI" and "RPMSG" sections more symmetric to
each other. I think it would be easy to just change the SPI one to say
"not SPI" instead of explicitly listing "i2c" and "rpmsg".

In any case, this overall looks pretty nice to me. My two requests are
both pretty small nits, so either with or without fixing them:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
