Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207C5258AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359637AbiELXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbiELXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:45:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36B289BE4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:45:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so13115415ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8uYgTXib/6BjhyAwPvyH9p+W39RRdBBH4HTP3NeUrE=;
        b=NkK5kPK5fIrUVGWgs+G9GyiaTiTnt5AJgzEKT+dmRktub3KA9K295ltiHCVtsmJ/t/
         x4Z76G4eFJ4PCnRDRHT4mBC/tPRg7JhJc5QIiBfjq8rb6o3pR4E8xPOCHPfXsVBXObaP
         IJjabM2xCsvBa3UCWB37Mr/RUrFPgxrNSwGFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8uYgTXib/6BjhyAwPvyH9p+W39RRdBBH4HTP3NeUrE=;
        b=kYO4pInaXw4tA38Xp0E7cZGflxVtzjBj/JbApGup3BzkFeantgdocEWkI75R5go1O9
         8ApVOQlpeRgz6Or+37v1Oa0ZgErBQ/2t/MFAzyUvngzNhnd5KplSaq4G2dk9NF+gR0i4
         QaJQlsoQrDyOGZlQz/+lc9L3fBgkJ/pr455EAUT5wa+/nW1/aF/pKMItm37PX9ynbjE+
         Ep0p2Y6XrxeU92MKyCpPktczEUmF0YEXZXZqJSS9sezsTLi2jkoAqNMn/ml25FkQRpJ4
         tgnqWa7JL8PjgFElFeqmt4Ysxw16T6cax3HjqJ/NcCi8IbqFWzLfdvHn4gfoUStIu42L
         3nwg==
X-Gm-Message-State: AOAM531dtDasXMPvtoeFf1amawJA5HQqS5fKmnwxyZdfsGfqlKjLmVp3
        IcqfGWwmpGIxtPFtlg1nTpV8XMq8o5GZo+5ip4c=
X-Google-Smtp-Source: ABdhPJx4m5qKom3xRVGrJaAM7L04az7kf0XKEtFbKbXQYbO3ko6Wy6SG2O93YDifQ8DmhtW3u3odyQ==
X-Received: by 2002:a17:907:72c5:b0:6f4:678:8742 with SMTP id du5-20020a17090772c500b006f406788742mr1973459ejc.607.1652399105098;
        Thu, 12 May 2022 16:45:05 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090674cf00b006f3ef214dd1sm219855ejl.55.2022.05.12.16.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:45:04 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so6034323wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:45:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr12323884wmb.29.1652399103788; Thu, 12
 May 2022 16:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512013921.164637-1-swboyd@chromium.org> <20220512013921.164637-4-swboyd@chromium.org>
In-Reply-To: <20220512013921.164637-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 May 2022 16:44:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4k8-Ab+diBic5rbannRr1ZKB=cdHNEOC3Emr0nyzQjQ@mail.gmail.com>
Message-ID: <CAD=FV=W4k8-Ab+diBic5rbannRr1ZKB=cdHNEOC3Emr0nyzQjQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
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
> @@ -176,6 +189,37 @@ allOf:
>          - reg
>          - interrupts
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: google,cros-ec-fp
> +    then:
> +      properties:
> +        '#address-cells': false
> +        '#size-cells': false
> +        typec: false
> +        ec-pwm: false
> +        keyboard-controller: false
> +        proximity: false
> +        codecs: false
> +        cbas: false
> +
> +      patternProperties:
> +        "^i2c-tunnel[0-9]*$": false
> +        "^regulator@[0-9]+$": false
> +        "^extcon[0-9]*$": false
> +
> +      required:
> +        - reset-gpios
> +        - boot0-gpios
> +        - vdd-supply
> +    else:
> +      properties:
> +        reset-gpios: false
> +        boot0-gpios: false
> +        vdd-supply: false

Wow, that's a huge pain to have to specify it this way, but I don't
know of any other way to make things happy and still have the
"google,cros-ec-spi" fallback that we decided on having in previous
versions.


>  additionalProperties: false
>
>  examples:
> @@ -231,4 +275,22 @@ examples:
>              compatible = "google,cros-ec-rpmsg";
>          };
>      };
> +
> +  - |

nit: all the other examples have a little "# For <blah>" comment
before them. It's not really necessary, but do we want one here to
match?

In any case, it seems OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
