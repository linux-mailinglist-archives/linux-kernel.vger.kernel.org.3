Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F655150EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiD2Qem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiD2Qek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:34:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827E1DA6E6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:31:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so16449698ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nw+YlCrCylKax0rwrziby2pzqjnCzgXqaGAQj14/FEI=;
        b=cmoLB6uO9PxqaqPypwrFW8YGlt7ClatqYTSlq5iyiVXxV1LWJkogwZIjIiBEj/ZTWb
         Ql4Q1WdT9KBNm9fCsTjjeqtBBYhwi3Ciq7STsT4lGiEvthpET6Bh4xcjHLtOuCNOTEE8
         0GPKsSlrX1YwAn0zCgP4wW0NDfcPxDZpALoXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nw+YlCrCylKax0rwrziby2pzqjnCzgXqaGAQj14/FEI=;
        b=qHqdvbDL3GXoGy8FJmZc9AP0touSwWtcACfeT7mJSUdiV1Jhm8+68/aQ7hCPPhMNzS
         gUmXDS34s2RDX1KDo2B4iTZyvrA7AygT8NXy3SYyMAGIjE+jF6HKr85NX/TX6Fz7ShKT
         R1oQpMdMb86zYu/Al9ilVcXtHMe1SSitraqeQ3SRhPsVOgIXp6jk0DeZC/6T04/v+vlU
         6dilZTqp39qSqlXmcOgoF147+2/neZ6edCm/9n/BeJRKNK+04oyV8z5QLrRIO+HQnAQf
         TAHXNi0ZRLy+Sj6JM4soiuVqUSPgW+MH0VtVWYm4od8454gvoEa2dsnLcMV9I3YNQP7o
         wbFw==
X-Gm-Message-State: AOAM531dtdxjq6tJgWtSwZh2mF8EFr2R5CDUJky2/H/IaXtqG/a/+QSX
        x5RGpOa9/sIQwC0Z5wXEdqbOAHfE7o8mB1nB
X-Google-Smtp-Source: ABdhPJySn+zRSyWQYp00SUxhEWKqUwLnfYQC/QT+Rqtli3h+dURB6ZlRCb1zna/jpBLbNZaFvZKxsg==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr170209ejt.8.1651249879838;
        Fri, 29 Apr 2022 09:31:19 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7d657000000b0042617ba639esm3143741edr.40.2022.04.29.09.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:31:18 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so6315900wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:31:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr3913552wmb.199.1651249878250; Fri, 29
 Apr 2022 09:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220427203026.828183-1-swboyd@chromium.org> <20220427203026.828183-2-swboyd@chromium.org>
In-Reply-To: <20220427203026.828183-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Apr 2022 09:31:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vtnj+8FYdBSvsud9fGEbo7N1HSjXA3rH3f8FMJsuVR1A@mail.gmail.com>
Message-ID: <CAD=FV=Vtnj+8FYdBSvsud9fGEbo7N1HSjXA3rH3f8FMJsuVR1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches
 only compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 27, 2022 at 1:30 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the device is a detachable, this device won't have a matrix keyboard
> but it may have some button switches, e.g. volume buttons and power
> buttons. Let's add a more specific compatible for this type of device
> that indicates to the OS that there are only switches and no matrix
> keyboard present.
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
>  .../bindings/input/google,cros-ec-keyb.yaml          | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index e8f137abb03c..edc1194d558d 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -15,14 +15,20 @@ description: |
>    Google's ChromeOS EC Keyboard is a simple matrix keyboard
>    implemented on a separate EC (Embedded Controller) device. It provides
>    a message for reading key scans from the EC. These are then converted
> -  into keycodes for processing by the kernel.
> +  into keycodes for processing by the kernel. This device also supports
> +  switches/buttons like power and volume buttons.
>
>  allOf:
>    - $ref: "/schemas/input/matrix-keymap.yaml#"
>
>  properties:
>    compatible:
> -    const: google,cros-ec-keyb
> +    oneOf:
> +      - items:
> +          - const: google,cros-ec-keyb-switches
> +          - const: google,cros-ec-keyb
> +      - items:
> +          - const: google,cros-ec-keyb

nit: if I come back and read this binding later I'm not sure it would
be obvious which compatible I should pick. Can we give any description
here that indicates that the first choice is for devices that _only_
have buttons and switches (the google,cros-ec-keyb is just for
backward compatibility) and the second choice is for devices that have
a physical keyboard and _also_ possibly some buttons/switches?

I could also imagine people in the future being confused about whether
it's allowed to specify matrix properties even for devices that don't
have a matrix keyboard. It might be worth noting that it's allowed (to
support old drivers that might still be matching against the
google,cros-ec-keyb compatible) but not required.


>    google,needs-ghost-filter:
>      description:
> @@ -50,7 +56,7 @@ examples:
>    - |
>      #include <dt-bindings/input/input.h>
>      cros-ec-keyb {
> -        compatible = "google,cros-ec-keyb";
> +        compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";

Feels like we should create a second example?
