Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692A05267CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382658AbiEMRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382707AbiEMRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:00:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615BE2A73B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:00:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ch13so17343426ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNVOaJHWY8Riu+9WPnHNOiy+A9MzK1I1aBmjMYCZcaI=;
        b=PJhPlBJT6uXyV2dwAoJkXnRbHOUPfkcJ1Zrdw/D8tDB46vybU0WGRBD/HcJWY1jwJS
         KgiJHHqppcp50s1Y6YHNHOY3o6lhGnHiuuQy4r+dIxIsWQaenEgpM0ABYV2rO4jQqfU+
         12gqI+v9gC9SzD+YJNnJDYiuqReB0g0fhSYKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNVOaJHWY8Riu+9WPnHNOiy+A9MzK1I1aBmjMYCZcaI=;
        b=dScM2bP1oR6+t+tp9Eq1jHIRDlNC2RLNZQOZEVeNQcgbkOwH60MoYv77UmrVFhpZF4
         +gfRrEwMX0hI5WbSGfG+foh0XA6UPn7OvVXh/vXGAUMS0vN871YEuLD7RluwZWr6UmCJ
         0l7tB3hGquH7XBATZgY3JDtZB1ldIOnZ/grh3u5YYHWhbujKuZiRBJb9RXPyUEPRs6DD
         99KhgNNq9mEaJ/eESFXfk1aAYGx066HQvRxh24ffVpjeVWxBAOYh85aNSj401MstvV2J
         RwsRTd7/dNhgitvfFFJAteDDAbuJVI1NOc1g79FWyYZPgbbWpA8oUg3BhOTrkvbT71rc
         gPDA==
X-Gm-Message-State: AOAM530PY0Ag9fnd6XtCSOsXrUeAsWD1hAxLakTjiFnWQGikzBxFyX38
        fJeIILPvOmXUtiMWA+6koacpmJ4n0BVKd7BlPJs=
X-Google-Smtp-Source: ABdhPJz0M3FzfUgYb2ISN+t0u2aSYZqG9XXAroIwSUqNjN7HGmyS7AI4AMQdEHPyWXcco+X97Lumnw==
X-Received: by 2002:a17:906:2989:b0:6f3:a215:8426 with SMTP id x9-20020a170906298900b006f3a2158426mr5131012eje.725.1652461234480;
        Fri, 13 May 2022 10:00:34 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id h11-20020aa7c94b000000b00428a42815aasm1133744edt.0.2022.05.13.10.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:00:33 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id a5so8421151wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:00:33 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr4900541wrr.301.1652461232723; Fri, 13
 May 2022 10:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <828bc65f-e585-0fe7-c038-c750861c9446@linaro.org> <48d96a4e-ce1b-03a1-1831-36555efd7080@linaro.org>
In-Reply-To: <48d96a4e-ce1b-03a1-1831-36555efd7080@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 May 2022 10:00:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WNSv+kgTZwjHVq+YNQAG0uB42QUPaU-BPTV_W+j=5aYg@mail.gmail.com>
Message-ID: <CAD=FV=WNSv+kgTZwjHVq+YNQAG0uB42QUPaU-BPTV_W+j=5aYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, May 13, 2022 at 2:01 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/05/2022 09:57, Krzysztof Kozlowski wrote:
> > On 12/05/2022 18:04, Douglas Anderson wrote:
> >> This copy-pastes compatibles from sc7180-based boards from the device
> >> trees to the yaml file so that `make dtbs_check` will be happy.
> >>
> >> NOTES:
> >> - I make no attempt to try to share an "item" for all sc7180 based
> >>   Chromebooks. Because of the revision matching scheme used by the
> >>   Chromebook bootloader, at times we need a different number of
> >>   revisions listed.
> >> - Some of the odd entries in here (like google,homestar-rev23 or the
> >>   fact that "Google Lazor Limozeen without Touchscreen" changed from
> >>   sku5 to sku6) are not typos but simply reflect reality.
> >> - Many revisions of boards here never actually went to consumers, but
> >>   they are still in use within various companies that were involved in
> >>   Chromebook development. Since Chromebooks are developed with an
> >>   "upstream first" methodology, having these revisions supported with
> >>   upstream Linux is important. Making it easy for Chromebooks to be
> >>   developed with an "upstream first" methodology is valuable to the
> >>   upstream community because it improves the quality of upstream and
> >>   gets Chromebooks supported with vanilla upstream faster.
> >>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >>
> >>  .../devicetree/bindings/arm/qcom.yaml         | 180 ++++++++++++++++++
> >>  1 file changed, 180 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index 5c06d1bfc046..399be67eb5d2 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -214,11 +214,191 @@ properties:
> >>                - qcom,ipq8074-hk10-c2
> >>            - const: qcom,ipq8074
> >>
> >> +      # Qualcomm Technologies, Inc. SC7180 IDP
> >>        - items:
> >>            - enum:
> >>                - qcom,sc7180-idp
> >>            - const: qcom,sc7180
> >>
> >> +      # Google CoachZ (rev1 - 2)
> >> +      - items:
> >> +          - const: google,coachz-rev1
> >> +          - const: google,coachz-rev2
> >
> > The inverted pattern of old revision being compatible with the new one,
> > is done on purpose? You claim here every rev1 is always compatible with
> > rev2 ...
> >
> > I don't think we discussed such patterns in previous talk. I quickly
> > went through it and there were only skuX moving around, not rev1 being
> > newer then rev2.

Isn't this what we just had a whole discussion about?

Oh, I see. You're objecting to the fact that the order here lists
"rev1" first and "rev2" second.

I think the issue here is that for the purposes of booting Chromebooks
the order here doesn't matter. Certainly we can pick a fixed order and
we can validate that the order in the yaml matches the order in the
device tree, but for all intents and purposes it doesn't matter to
anything. The same device tree is compatible with _both_ rev1 and rev2
coachz devices. Neither of those two devices is inherently better
supported by this device tree than the other.

We can reorder them if it's important for some reason, but it doesn't
change the facts of the matter. You can't tell whether you've booted a
"-rev1" Chromebook or a "-rev2" Chromebook based on the most specific
compatible string.

As per the other discussion, we could "solve" this by making two
device trees that were exactly the same but one of them had the
compatible "-rev1" the other "-rev2". This would result in a big
explosion in the number of device trees in our FIT Image for very
little gain. It also fails to solve the "newest rev" problem.


OK, so I've written up a description of the whole system. Maybe it
will be clearer with that and we can continue the discussion in my v2
if needed.

https://lore.kernel.org/r/20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid

-Doug
