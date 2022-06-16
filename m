Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01CE54D644
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiFPAuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFPAuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:50:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663757125
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:50:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso2056ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2n+TFof2POThL99hyq/41irwfqDc3AvWFjRglyLstd8=;
        b=kkakXjBt/V6u5jkZ8lAGtuG5THuUQOXAXhQ5t7xxQ1bZ867DsPsh6EImLphuq5fs9m
         dHRWyw92ps+4aK9S0iOh5TyCmBMusc0rU7T4dyZ0VTB+re06qoqjCAQlmmn6Bhtq/gEV
         GPzw26VRwLnqQDp/o+uv6K1dgu9zqduUnfe38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2n+TFof2POThL99hyq/41irwfqDc3AvWFjRglyLstd8=;
        b=rgU30s610lNlkb/KO3kiH2txD5j2VMKv3I9kupM9IPBAfjToaEoKQUWB4UVudUPxeg
         6qVN5+CZD+6yWYZkDharOS44Ak28axcQP2d+3LuFg6etd8qwdqOO67LrayIFCwN876T8
         afaCXGdXqCSpSZbyNa3pfn5ymL0Yb2D2iqcYeH6ZnrHoRboKrUnzSCx3M+0TK13LeOPC
         mx1boJKaUwgp7BdwBSa+Tlm67r1+qVmjHeuWuqN6UBPw6AuSXPZ//RT9tFiSth19vfzs
         krbNRd3Io32ABwIqtPHfTv/liQZS/dST2l5eP82Kpp7VPQ9lEA1tDH526TAjyzSaNugQ
         Z1VA==
X-Gm-Message-State: AJIora9cXcKGSrIHoZDSLPyFtbAzvJ18+1E/tfLAvg8sl0Xz2c5JcnKc
        ct+pC+NrMLX7fd+HoHr1dbiAyAtGzc2nWTmrSR10gw==
X-Google-Smtp-Source: AGRyM1sFQjWy7A0wLfGZw6Rskgi/CnY4DvjLwxEzj4DpBc8R4s8j8PtToCS9MtRb3a/yZKR0osG6MihBhJdqDZBQNVI=
X-Received: by 2002:a9d:6484:0:b0:60b:eb0b:4054 with SMTP id
 g4-20020a9d6484000000b0060beb0b4054mr1106041otl.159.1655340609475; Wed, 15
 Jun 2022 17:50:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jun 2022 17:50:09 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
References: <20220614195144.2794796-1-swboyd@chromium.org> <20220614195144.2794796-3-swboyd@chromium.org>
 <CAD=FV=UU-AENyChCvVAKH709E4hFtgo4Txa8zFDY=JM1UifA0g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 15 Jun 2022 17:50:09 -0700
Message-ID: <CAE-0n53v4Ts0D=FUZwCHa-q0gkQnujPWvvq+_8zZmYaAozcVAw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
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

Quoting Doug Anderson (2022-06-14 15:41:25)
> On Tue, Jun 14, 2022 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: google,cros-ec-spi
> > +  required:
> > +    - compatible
> > +    - boot0-gpios
>
> I've never personally used "select" before and I'm not sure where it's
> documented. Without knowing anything, it seems weird to me that in
> this file we're matching against a compatible that's not
> google,cros-ec-fp. Randomly grabbing some other example that's similar
> (panel-lvds.yaml) looks more like what I would have expected. AKA in
> this file:
>
> select:
>   properties:
>     compatible:
>       contains:
>         const: google,cros-ec-fp
>   required:
>     - compatible
>
> ...and then in the other file:
>
> select:
>   properties:
>     compatible:
>       contains:
>         const: google,cros-ec-spi
>   not:
>     properties:
>       compatible:
>         contains:
>           const: google,cros-ec-fp
>   required:
>     - compatible
>
>
> Of course, if one of the dt maintainers gives different advice then
> listen to them. ;-)
>

I followed a pwm example, see renesas,tpu-pwm.yaml, but I suspect this
works just as well. I don't really care either way so I'll defer to DT
maintainers here.
