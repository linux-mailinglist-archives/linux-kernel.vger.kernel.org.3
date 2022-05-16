Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA45287D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbiEPPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiEPPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:01:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B800614D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:01:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so29226915ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEqS5ZEhQmVUdoC6xbuUtm7a+R7vLA0emT1o0rRL2Y8=;
        b=hVAXAfbNeapxizRmUQEDfgkCglJKN1YxB+0CNOJNUgDR/4Ap6MWrzfo3hPzZxfh6uC
         FZdoJJaxoAqia+BvHGcB+k+fsvDmLt96Y11l9HrEFKST43bFAa1qIlPs2ZL96M4RM7wa
         tmiWX4Pb60695Wk1xZrmbiQkVEJhCqEGaXN6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEqS5ZEhQmVUdoC6xbuUtm7a+R7vLA0emT1o0rRL2Y8=;
        b=RdEYYBIRSWx9aHk6sbQIVsCuc4WTdguUV8eeCIReth3jCgD6pv0kl8PvFyc+cUjyfd
         vMcMhXyak4wuEC1527O+I0uyHKcL4s13vXiG9a7cCAsitvJpVxQUdFUA0ndXEknQpEun
         egGRgHItEhkbluz+5i3w5ym4EeU0sd9+LgrICfyvKryOewIoD0CzQ8UBuEKUvdVyBXas
         NKU/RBMFNmLzCj+jxaMPCw9VfAY0zLNX0t3rvdRuAs9tSwg0V2oOC1BL+guLAYOonzl/
         P3XRB03vGq5Zuot3M/fMlZS+PL6tHG8me4wY33P7oxndCawAjdqsbED8tamgNN0Zz4nT
         Ixkg==
X-Gm-Message-State: AOAM530Xy+/cS4b9o7wXx0cKktT2uw4VwX0ubOodOnyOCJWVsETk2er8
        7JJwVC9r6Di0/a4ac6hw1BkouGnZWOJyjFU0
X-Google-Smtp-Source: ABdhPJz3sOZ5oAeBN5HIfpgDYdBXPNbANDF673NRhFR2IEOSrDVxT9n/rjk30jnTl1nS8C7QZ3z9LQ==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id mp27-20020a1709071b1b00b006e47fac6ce0mr15469761ejc.617.1652713301521;
        Mon, 16 May 2022 08:01:41 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id el9-20020a170907284900b006f3ef214e22sm3731235ejc.136.2022.05.16.08.01.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:01:40 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id j25so19915372wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:01:39 -0700 (PDT)
X-Received: by 2002:a5d:5009:0:b0:20d:846:f4da with SMTP id
 e9-20020a5d5009000000b0020d0846f4damr4917393wrt.301.1652713299036; Mon, 16
 May 2022 08:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.2.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid> <d4e031d0-8a43-e458-6535-1044d43a2b63@linaro.org>
In-Reply-To: <d4e031d0-8a43-e458-6535-1044d43a2b63@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 May 2022 08:01:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfNKqca5XHX7aWZmxvPmKNikA-=X0Hv5v0MbumnB-W8Q@mail.gmail.com>
Message-ID: <CAD=FV=UfNKqca5XHX7aWZmxvPmKNikA-=X0Hv5v0MbumnB-W8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: qcom: Add sc7180 Chromebook
 board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, May 16, 2022 at 12:01 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/05/2022 18:59, Douglas Anderson wrote:
> > This copy-pastes compatibles from sc7180-based boards from the device
> > trees to the yaml file so that `make dtbs_check` will be happy.
> >
> > NOTES:
> > - I make no attempt to try to share an "item" for all sc7180 based
> >   Chromebooks. Because of the revision matching scheme used by the
> >   Chromebook bootloader, at times we need a different number of
> >   revisions listed.
> > - Some of the odd entries in here (like google,homestar-rev23 or the
> >   fact that "Google Lazor Limozeen without Touchscreen" changed from
> >   sku5 to sku6) are not typos but simply reflect reality.
> > - Many revisions of boards here never actually went to consumers, but
> >   they are still in use within various companies that were involved in
> >   Chromebook development. Since Chromebooks are developed with an
> >   "upstream first" methodology, having these revisions supported with
> >   upstream Linux is important. Making it easy for Chromebooks to be
> >   developed with an "upstream first" methodology is valuable to the
> >   upstream community because it improves the quality of upstream and
> >   gets Chromebooks supported with vanilla upstream faster.
> >
> > This patch also adds a link to the Chromebook boot flow documentation
> > to explain that Chromebooks don't use the scheme described for the
> > Qualcomm bootloader.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > The link added here will (obviously) not function until the
> > documentation patch makes it to mainline. Presumably folks who want to
> > read it in the meantime can find it pretty easily. If there's a better
> > way to link this then please let me know.
> >
> > Changes in v2:
> > - Add link to doc about how Chromebook devicetrees work.
> > - Use a "description" instead of a comment for each item.
> > - Use the marketing name instead of the code name where possible.
> >
> >  .../devicetree/bindings/arm/qcom.yaml         | 187 +++++++++++++++++-
> >  1 file changed, 186 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > index 5c06d1bfc046..8ec0805f4996 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -90,6 +90,11 @@ description: |
> >    A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
> >    foundry 2.
> >
> > +  There are many devices in the list below that run the standard ChromeOS
> > +  bootloader setup and use the open source depthcharge bootloader to boot the
> > +  OS. These devices do not use the scheme described above. For details, see:
> > +  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/chromebook-boot-flow.rst
>
> Absolute path within Linux repo, please, so
> "Documentation/devicetree/chromebook-boot-flow.rst" (assuming that will
> be the final location). There are tools which check them for validity.

Got it, thanks!


> Actually this change should be rather part of that other commit...

I'm not sure I understand. Which of these are you suggesting?

1. You want me to squash the two commits into one, so we add the
generic doc in the same patch as the one adding sc7180 Chromebooks.

2. You want the generic doc to come first in the series and it just
adds the little blurb into
"Documentation/devicetree/bindings/arm/qcom.yaml" even though
Chromebooks aren't actually added until a later commit in the series.

3. You want to add the sc7180 Chromebooks first in the series with no
documentation and then later add in the generic documentation and the
blurb into "Documentation/devicetree/bindings/arm/qcom.yaml".


I'm also interested to know if you think the generic documentation
patch should land through the Qualcomm tree. I think it would
absolutely have to if I take your suggestion, right?


Thanks!

-Doug
