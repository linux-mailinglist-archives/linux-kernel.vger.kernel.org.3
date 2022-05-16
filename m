Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44D528800
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiEPPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiEPPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:06:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDA3B3DA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so29257032ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3adrsX+uhZAXoth7knDMjvKgEG3AVzl2RqEOStCFFU=;
        b=WUC5Xg+4w97H+b3njqlusYipF4b7Bqzncvyv3eg4yB93mgKI/DfXQo99MRIvkX7ysm
         UbxSikcZHAC7DZafAgPC0PmJIZzdAlQ4kZlG1mvRtBK4iw/VAKUpEYYK7q1asUPtmc1H
         2sDcNSDhZsnI80IGowjrZiyMN0Dy8GI6NTfK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3adrsX+uhZAXoth7knDMjvKgEG3AVzl2RqEOStCFFU=;
        b=eRotj/VM4Av1yTgbkyMBqgufHcPNWopFzEzRmfmI+O81RiN4PTl5QNk7fC6EN6qEYI
         ta0PbxTFTVxBltn6YXOEOCwSr4pT8ZauVdgP2rIQY5e+xCB/ZV/VAVht1/wYds+iQpsq
         Cz//Hde/qpD+APIGFhxFxmQCugOlh/FgXXPm49Iw2FPvspkbRCRf9BxkesEvJ9dWoMlA
         4Ei+qg/TPVl0BgT27/aOVl09FSxoAg5fUkD2fLxDipLrwCY1UV8JXpcNjVk7srjNcrQt
         TD2S88P2pnurPoOxfazWOLjOoXxyuQ0ngJk0x3+7oC+Kmpb/x4xKnrCOZrulnNmoum/7
         Jjvg==
X-Gm-Message-State: AOAM533FssmzDjU1uCdQA51ukEXEn6n8mYxmd8n0WggIN9zWz8HO5Lw/
        WsoXHsaqpavdudeTih5cdlDI7R6dGdyKwd+M
X-Google-Smtp-Source: ABdhPJygDULPkrW7AZfWdh+Weq+1LJwHY4UBLe1HIFn7p4DIl+yFYMh+za2akOjSdfsXcB009EfnHA==
X-Received: by 2002:a17:907:3d92:b0:6f4:5ddd:94d with SMTP id he18-20020a1709073d9200b006f45ddd094dmr15536467ejc.268.1652713585450;
        Mon, 16 May 2022 08:06:25 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id jx1-20020a170907760100b006f3ef214da1sm16551ejc.7.2022.05.16.08.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:06:24 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso11127938wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:24 -0700 (PDT)
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id
 g8-20020a7bc4c8000000b0039426c5b79emr17514279wmk.15.1652713583816; Mon, 16
 May 2022 08:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <d5438d2e-f387-170a-cea1-d5936cc8e15a@linaro.org>
In-Reply-To: <d5438d2e-f387-170a-cea1-d5936cc8e15a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 May 2022 08:06:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNGS+H8biOOigt=drUCYCWY1VBKN=ZFD74T-3RSeWBxA@mail.gmail.com>
Message-ID: <CAD=FV=VNGS+H8biOOigt=drUCYCWY1VBKN=ZFD74T-3RSeWBxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Document how Chromebooks with
 depthcharge boot
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 15, 2022 at 11:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/05/2022 18:59, Douglas Anderson wrote:
> > This documents how many Chromebooks pick the device tree that will be
> > passed to the OS and can help understand the revisions / skus listed
> > as the top-level "compatible" in many Chromebooks.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - ("Document how Chromebooks with depthcharge boot") new for v2.
> >
> >  .../devicetree/chromebook-boot-flow.rst       | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/chromebook-boot-flow.rst
>
> This is not a Devicetree (generic) document, so it is not the best place
> for it. Maybe regular vendor place, e.g . Documentation/arm/google/ ?

I can put it there. ...but taking your two pieces of advice together,
you're saying:

1. Don't add this under the devicetree directory.

2. Don't refer to this by URL but instead by a relative file path.

I can do both of those two things, but I always had it in my mind that
the device tree was supposed to be "Linux agnostic". In other words,
you could refer to Linux as one OS that boots with device tree, but I
thought that the device tree docs were supposed to stand on their own.
With the above two suggestions, it seems like an extra piece tieing
the two together and assuming that both Linux and device tree docs are
living in the same place.

In any case, I'm happy to do what you request but I just want to double-check.

-Doug
