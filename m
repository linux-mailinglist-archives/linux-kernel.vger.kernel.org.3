Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B44FF4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiDMKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiDMKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:41:00 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB362FD14;
        Wed, 13 Apr 2022 03:38:39 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id hu11so1246547qvb.7;
        Wed, 13 Apr 2022 03:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iDGAJ5ErJY5+DCJE/DoojvcRcjppzMgRco5mDjRgB4=;
        b=kaY6XLuwEAFBDNOjCAB8oqi5ESeZQbs5yNMQ5L2gZal6BXHpe5uhCN6fgcFynmFJvr
         ibuCKP7uiOOxBciOzV5AG2fDdwMdhQHGX2VlgZpHWrCh7pq/BohlfQ78ZNIh5om4Zq1v
         kzD+H+LSooNUMhKp4bEZX/+T7LnZgTpLefmGu7uh9fW0+MaSJZQJu8bHnDkTLgLaJn4C
         KURm2aMv1fik39+JrTvb0CWjMaMlHoG3eVQI1qqafgUbsoq1PlcByniuRQThzGfXjerH
         g0nesscccnsQo37bhNYZsoHpUZk0tBmu4YqnahzVOBh8ZNrDCNkbBrV39y1358GcnRfp
         2wKQ==
X-Gm-Message-State: AOAM530N8wu2k59LMwkHyCDKMM6cP0fTlqVR+O2hytgfpl35p796MM19
        A9REOFck6CSakCQuZUollgv1JEsTl+nECA==
X-Google-Smtp-Source: ABdhPJwH9WGiB6V28WrNKl8e26XvIltWhXAHuvBYiy/7DMuoY/LVGctXYYhYhVoCafCHbr606aAWSg==
X-Received: by 2002:a05:6214:2509:b0:446:f9a:c349 with SMTP id gf9-20020a056214250900b004460f9ac349mr3926195qvb.73.1649846318513;
        Wed, 13 Apr 2022 03:38:38 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b002ed08a7dc8dsm12896367qta.13.2022.04.13.03.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:38:37 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec05db3dfbso17073087b3.7;
        Wed, 13 Apr 2022 03:38:37 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr33591611ywi.449.1649846317128; Wed, 13
 Apr 2022 03:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220412162729.184783-1-javierm@redhat.com> <20220412162729.184783-3-javierm@redhat.com>
 <CAMuHMdUDxexqsGjb3B37jW_xZU1TBLq8gK5hctA+PKjL+LhQGQ@mail.gmail.com> <ddf107c7-5108-f366-45a8-e7244cdcd209@redhat.com>
In-Reply-To: <ddf107c7-5108-f366-45a8-e7244cdcd209@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 12:38:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTPquOXGwf3YcMDHYyW9=UjRyk7Qhy+HNVThbk355wcQ@mail.gmail.com>
Message-ID: <CAMuHMdVTPquOXGwf3YcMDHYyW9=UjRyk7Qhy+HNVThbk355wcQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: ssd1307fb: Extend schema for
 SPI controllers
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Apr 13, 2022 at 11:44 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 4/13/22 10:04, Geert Uytterhoeven wrote:
> > On Tue, Apr 12, 2022 at 6:27 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
> >> add to the schema the properties and examples for OLED devices under SPI.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> Acked-by: Mark Brown <broonie@kernel.org>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>
> >> Changes in v3:
> >> - Add a comment to the properties required for SPI (Geert Uytterhoeven)
> >
> > Thanks for the update!
> >
> >> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> >> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> >> @@ -38,9 +38,16 @@ properties:
> >>    reset-gpios:
> >>      maxItems: 1
> >>
> >> +  # Only required for SPI
> >> +  dc-gpios:
> >> +    maxItems: 1
> >
> > Actually I meant to also add a description, like for vbat-supply below,
> > to explain the meaning of "dc".
> >
>
> Ahh, sorry for misunderstanding you! Something like the following looks good ?
>
>   # Only required for SPI
>   dc-gpios:
>     description:
>       GPIO connected to the controller's D/C# (Data/Command) pin,
>       that is needed for 4-wire SPI to tell the controller if the
>       data sent is for a command register or the display data RAM
>     maxItems: 1
>
> If you agree with that, then can squash before pushing or add it to a v4
> if another revision is needed.

Thanks, LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
