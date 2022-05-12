Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF305258AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359623AbiELXpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbiELXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:45:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B17289BD0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:44:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l18so13114602ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tUe0F63ZYrn0Y1fh/u+GXJuGNWxIjIBVNzjlEOaooc=;
        b=UcB1On1JxLd4Xr6oYtsXWZupWxYqMCZH1DBzRfH5Xtc4P7FFr1vR6KaXACJwSe1f/g
         KvqeAf29DU3OTlhjJ5j9Hh/gjB7I2d4tZVR10BKtMkVIaQP0pXjgWy/sN2EtFKps8mL6
         Y+T5mwgLwBToRztodmGegISZ3vYDIqtuHQ3is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tUe0F63ZYrn0Y1fh/u+GXJuGNWxIjIBVNzjlEOaooc=;
        b=HEyngs2V46HWimn6KLZCHt3w8LM/8Ux3PMfn3RyFNz9xGKYw18u13Xl6mONrR9SNCR
         JpDsQCROheBE5B3ilBpUt/kpwbZ3H8tdRWABXk5p9P/UIXJFtGrh64wLgFmj9jCodiM5
         TQ4QuEH30mQJL655nSLbVFCy4c8FlUmhIwnCGSC5dM6YqHo0EVpdRy4wDxohdyLy98M8
         pI/dBxvuobooKkfsY4+Wclv+sY8P+sGx4m2IPL4urACLNzwt+vvymZofafp8O4ryiYEQ
         zmO3xji0cANn3IRcGLgZ8E/MpBADPslOFpYr9VZMm1jkEeqecndTS0pfp6wkFTTETcHs
         lGjA==
X-Gm-Message-State: AOAM533bq1W96cYxlBr2czSqx8EP62nm8Y2Em8hP0vJkn34G7U0v0wu9
        DunT0LfL60aob2uf7BsGnPWjfyo99T5BzZKuZNg=
X-Google-Smtp-Source: ABdhPJy+3yKC03mIeXbMvjejyl93S1XEpaLo11PdlVXxp95Qo/nxBDG54wn02dsRZMeqK51UHOrPQg==
X-Received: by 2002:a17:907:a042:b0:6f3:b4fc:be3d with SMTP id gz2-20020a170907a04200b006f3b4fcbe3dmr2005530ejc.318.1652399097104;
        Thu, 12 May 2022 16:44:57 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id hz15-20020a1709072cef00b006f3ef214e11sm208615ejc.119.2022.05.12.16.44.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:44:56 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso6032468wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:44:56 -0700 (PDT)
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id
 g8-20020a7bc4c8000000b0039426c5b79emr1988820wmk.15.1652399096143; Thu, 12 May
 2022 16:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220512013921.164637-1-swboyd@chromium.org> <20220512013921.164637-3-swboyd@chromium.org>
In-Reply-To: <20220512013921.164637-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 May 2022 16:44:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfmU1GhXZPvUMoh9dqs8iei6s+0gu6Mve-aQ33A+7m3g@mail.gmail.com>
Message-ID: <CAD=FV=XfmU1GhXZPvUMoh9dqs8iei6s+0gu6Mve-aQ33A+7m3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: cros-ec: Reorganize property availability
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
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

On Wed, May 11, 2022 at 6:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Various properties in the cros-ec binding only apply to different
> compatible strings. For example, the interrupts and reg property are
> required for all cros-ec devices except for the rpmsg version. Add some
> conditions to update the availability of properties so that they can't
> be used with compatibles that don't support them.
>
> Cc: Rob Herring <robh+dt@kernel.org>
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
>  .../bindings/mfd/google,cros-ec.yaml          | 39 +++++++++++++------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 99eda9ab0651..409ecef967ce 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -148,18 +148,33 @@ patternProperties:
>  required:
>    - compatible
>
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - google,cros-ec-i2c
> -          - google,cros-ec-rpmsg
> -then:
> -  properties:
> -    google,cros-ec-spi-pre-delay: false
> -    google,cros-ec-spi-msg-delay: false
> -    spi-max-frequency: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: google,cros-ec-spi
> +    then:
> +      properties:
> +        controller-data: false
> +        google,cros-ec-spi-pre-delay: false
> +        google,cros-ec-spi-msg-delay: false
> +        spi-max-frequency: false
> +
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

Is it worth having an "else" clause here? to explicitly make
"mediatek,rpmsg-name" required for mediatek?

In any case, this seems right from my (albeit) limited yaml knowledge
and seems like an improvement.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
