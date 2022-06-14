Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1222A54BDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbiFNWlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiFNWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:41:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D0515BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y16so7620297ili.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvehCBfUTvgEUWe65S6hBli1BzVjPsVtPnt86add/kI=;
        b=A611+FifO5/wxtRT2yw4vt9ZxdMZMO1YdFrBzWAQZ+h2wb9x3Hm3GO3as3VS4HtzOD
         lKFKKkG+nF5VPBDTsFylpJVr5eMnvLGvlpZ2mG+grr6OXUAQwYkoo299LvMG7dVq35g4
         WjtxSCbzIgGtSimJ4tYsqPGIi5f61C2w9oVCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvehCBfUTvgEUWe65S6hBli1BzVjPsVtPnt86add/kI=;
        b=m23i9Pr57T22nZ/Xv1dHwodKU6KIG8Bhww/ekhvfwCmNKY07vLmNhl/DcHz5zjRqz5
         wFojxPxBGteFHFlaFshUPBpSnUVGnzpTt1zl7/XjiW1noD/DUVudtRygdc9Em1HTPF2d
         4upqY9CEei4hkJTqd4Sf4hVeDbprKAXw/d+ZAKBB+bgrio0uoZV/LpxUGZDvDgXE/gQw
         Fk3MGGNFKcog8UPsQcZBmuEemDE4z9IBtKm/Lo5+3cIfhTolNXx3J7eDzy/MMRawzSES
         A35euWzW8lwrg4M0FkJuUnw9c9MxuLP9iSiOP8hz+Cqkimy8I5ysDtkHFq6MQTZ4MBLS
         6fFA==
X-Gm-Message-State: AJIora898LXmomWBST9borv1NIJM3/EGIg8uEP6E1Gq9xCTJ551RhlYu
        kWgmIxgSnsKjvQZmfWKo5ZIRtbmT2h7Utqzj
X-Google-Smtp-Source: AGRyM1vLyfH717nzCbt8lUYFcQHFo4brF2AYmw5RVp74mTl0Dby2wFNVjPaLCGkja6cI2Ia+zvEtFQ==
X-Received: by 2002:a05:6e02:17c8:b0:2d4:dfae:edf4 with SMTP id z8-20020a056e0217c800b002d4dfaeedf4mr4258528ilu.8.1655246500139;
        Tue, 14 Jun 2022 15:41:40 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id r13-20020a056638044d00b003318c717b59sm5422511jap.39.2022.06.14.15.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:41:39 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id z11so7637492ilq.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:41:38 -0700 (PDT)
X-Received: by 2002:a05:6e02:20e9:b0:2d1:d151:3c53 with SMTP id
 q9-20020a056e0220e900b002d1d1513c53mr4443271ilv.220.1655246498060; Tue, 14
 Jun 2022 15:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220614195144.2794796-1-swboyd@chromium.org> <20220614195144.2794796-3-swboyd@chromium.org>
In-Reply-To: <20220614195144.2794796-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jun 2022 15:41:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
Message-ID: <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
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
> Add a binding to describe the fingerprint processor found on Chromebooks
> with a fingerprint sensor. Previously we've been describing this with
> the google,cros-ec-spi binding but it lacks gpio and regulator control
> used during firmware flashing.
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
>  .../bindings/chrome/google,cros-ec-fp.yaml    | 97 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  9 ++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
>
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
> new file mode 100644
> index 000000000000..48c02bd4585c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-fp.yaml#
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
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: google,cros-ec-spi
> +  required:
> +    - compatible
> +    - boot0-gpios

I've never personally used "select" before and I'm not sure where it's
documented. Without knowing anything, it seems weird to me that in
this file we're matching against a compatible that's not
google,cros-ec-fp. Randomly grabbing some other example that's similar
(panel-lvds.yaml) looks more like what I would have expected. AKA in
this file:

select:
  properties:
    compatible:
      contains:
        const: google,cros-ec-fp
  required:
    - compatible

...and then in the other file:

select:
  properties:
    compatible:
      contains:
        const: google,cros-ec-spi
  not:
    properties:
      compatible:
        contains:
          const: google,cros-ec-fp
  required:
    - compatible


Of course, if one of the dt maintainers gives different advice then
listen to them. ;-)

-Doug
