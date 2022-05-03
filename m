Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA965187FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiECPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiECPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:12:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F13A72B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:09:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so34038148ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tccEYmP1Up3dLXDN+1M0rIsKvh0911h46EMldmvN7I=;
        b=b9ShGJ5SZTplKe0QbTIy+x0O2zCSuwbYR2O/20m2BPYhSQDrLmIGDywLO0FRQQrwcH
         Ly89HKMYQuR7uMZPvGFDet7K7qr1mGKyVs/NixIsXhg6ywD3joeB7yiiDXuwPkVn61HR
         yH5tjEQ+qoNKZohYEhk8radCiM3/+7F2b2k8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tccEYmP1Up3dLXDN+1M0rIsKvh0911h46EMldmvN7I=;
        b=2HQPf9t0vSaKGWQ3d+fAYv3dQIgWNI2MPME9j9lsKB8+Fn+1h2x2KI7QFotTZ8n5es
         c7f62Sy/hFiGiiFrHVF1D96GcOm1R0aHVG9afT4tSUiBeNGLP3EmviW77U9o2xOYIjn1
         IAdqwmKTEPaa9GSHUkjuivFBkee75gdlBf04nUZyg0oOhGPZFkvW4RkMaisyftzeMARC
         4fWZgMKSGL5DjVXcvl2Q+Oa1sswRt/guGjxVAsKaZh2hHWDg90HkI0KgqKKqdplH9Dsh
         U39eD1JWiAEb8sybefx2LoHGwBaevpf+FG0iRXVISwXQoxOx43VHipac6ia1A9kySuXs
         7ycw==
X-Gm-Message-State: AOAM5335khuteu3Iwa7cuynasC55cN1kH6YbQzahzkto08mFtUR8ltFh
        0Z+dQa0lqhbEIcwkQatJp30W5ZVa0lJPRDbn
X-Google-Smtp-Source: ABdhPJxXMDKgwKQ6uTlV9nu3o6uiBiqfEpDVdouJqY4k11plqd9lF0JjBIyO/koW3eeLFrvXvwPV6g==
X-Received: by 2002:a17:906:5d0c:b0:6f3:dce6:a69a with SMTP id g12-20020a1709065d0c00b006f3dce6a69amr16635542ejt.23.1651590558508;
        Tue, 03 May 2022 08:09:18 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id og31-20020a1709071ddf00b006f3ef214da2sm4703586ejc.8.2022.05.03.08.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:09:17 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id az27-20020a05600c601b00b0039431ba4905so1205656wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:09:17 -0700 (PDT)
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id
 g8-20020a7bc4c8000000b0039426c5b79emr3744035wmk.15.1651590556954; Tue, 03 May
 2022 08:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-2-swboyd@chromium.org>
In-Reply-To: <20220503042242.3597561-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 08:09:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8kfRYidvQRmx_XmGm8X3XHR_GxTkKvxkqUHdqJ5CMNg@mail.gmail.com>
Message-ID: <CAD=FV=V8kfRYidvQRmx_XmGm8X3XHR_GxTkKvxkqUHdqJ5CMNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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

On Mon, May 2, 2022 at 9:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> @@ -113,3 +135,56 @@ examples:
>              /* UP      LEFT    */
>              0x070b0067 0x070c0069>;
>      };
> +
> +  - |
> +    keyboard-controller {
> +        compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";
> +        /* Matrix keymap properties are allowed but ignored */

nit: s/allowed/required/

This now looks reasonable and well explained to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
