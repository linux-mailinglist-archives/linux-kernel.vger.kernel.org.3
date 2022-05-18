Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D552C3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiERT4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiERT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:56:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25435DE7E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:56:18 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l9-20020a056830268900b006054381dd35so2110148otu.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=q6k7TwXQDY275UxkUuTVNtao4TZzazR5moehWbU13Bc=;
        b=g5/fbsGkOpFvl3DvRZPpEo8jogun8jSOWCLsALy94X/VCP6ncGUUeLsIqnLGqdKEzW
         P8/cLn9bNiLprBIroXErfdY4WYJFHqO/bdJITBfN50ZhToYrp0ye5UhOb1QKEHoifbq8
         OKiURvgnNxPbcMitcPLkdDI96p+slNJxk/9w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=q6k7TwXQDY275UxkUuTVNtao4TZzazR5moehWbU13Bc=;
        b=Tps4D6IXc7Y9a9AzMrRba59LX+fHLnMoLedSDYtVJCs9z/AEU0LZNYw7xX0fx2rXos
         h/f9nfPDO9ngBg8RR+xRrU2shZ50pUZuMu5rQ5hyFQVTdjuEqDen2gkasN7/jyrheTCY
         qg/Pp1gTB6uG1L7qKI/7qHXwQ/thW4wggitD3rmncOcyw1oKURaT6Xmm+bCB9dhsJzXH
         VrFzFCst3mKIXRVODd/8adEcZhmblYJ6DeozjiVRbucN8etWERb3R0NG1TED84DfMBfD
         DmTAOZuApqDPZgXQtUHGpeXKh0thqqulFxsbZSEPzHvxJ+eCZMwI9suqpfHxE4sn6tF1
         OPwA==
X-Gm-Message-State: AOAM531IjNDusA/rqbwXXL/OPbFl76ckDUXh8aECjRR/4fLuBarx8eHE
        6ryiSuwgc2lOemKseuKPbKheI1E0xxlZL4X3XAjnbw==
X-Google-Smtp-Source: ABdhPJwLifvJOWX3yKWzLoGN0MnHOdrbsoJrvUWC4w9Xr9cAvIQorp5Y2A947/vh4RjZprkumyYkzxKdHOHmmWcv7uE=
X-Received: by 2002:a05:6830:13ce:b0:606:702b:87f0 with SMTP id
 e14-20020a05683013ce00b00606702b87f0mr541140otq.159.1652903777929; Wed, 18
 May 2022 12:56:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 May 2022 12:56:17 -0700
MIME-Version: 1.0
In-Reply-To: <20220518161348.GC3302100-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org> <20220512013921.164637-4-swboyd@chromium.org>
 <20220516152003.GB2659134-robh@kernel.org> <CAE-0n53p1mKME=vfed2SB7UXrg9K+-vbp6JPHJBchJc-Pp1Hgg@mail.gmail.com>
 <20220518161348.GC3302100-robh@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 May 2022 12:56:17 -0700
Message-ID: <CAE-0n53CMwtCY6XqYRXBpY5g21cFKyr8BF34t79JfK3dKg8cEg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
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

Quoting Rob Herring (2022-05-18 09:13:48)
> On Mon, May 16, 2022 at 12:23:03PM -0700, Stephen Boyd wrote:
> > Quoting Rob Herring (2022-05-16 08:20:03)
> > > On Wed, May 11, 2022 at 06:39:21PM -0700, Stephen Boyd wrote:
> > > > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > index 409ecef967ce..e5fe60beb9fe 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > +      - items:
> > > > +          - const: google,cros-ec-i2c
> > > > +      # For implementations of the FPMCU connected through SPI.
> > > > +      - items:
> > > > +          - const: google,cros-ec-fp
> > > > +          - const: google,cros-ec-spi
> > > > +      # For implementations of the EC is connected through SPI.
> > > > +      - items:
> > > > +          - const: google,cros-ec-spi
> > > > +      # For implementations of the EC is connected through RPMSG.
> > > > +      - items:
> > > > +          - const: google,cros-ec-rpmsg
> > > >
> > > >    controller-data:
> > > >      description:
> > > > @@ -176,6 +189,37 @@ allOf:
> > > >          - reg
> > > >          - interrupts
> > > >
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: google,cros-ec-fp
> > > > +    then:
> > > > +      properties:
> > > > +        '#address-cells': false
> > > > +        '#size-cells': false
> > > > +        typec: false
> > > > +        ec-pwm: false
> > > > +        keyboard-controller: false
> > > > +        proximity: false
> > > > +        codecs: false
> > > > +        cbas: false
> > > > +
> > > > +      patternProperties:
> > > > +        "^i2c-tunnel[0-9]*$": false
> > > > +        "^regulator@[0-9]+$": false
> > > > +        "^extcon[0-9]*$": false
> > >
> > > Is the list of what's allowed shorter? If so, you could list those
> > > properties and use 'additionalProperties: false'.
> >
> > Yes.
> >
> > >
> > > Or maybe this is a sign that this should be a separate schema document.
> >
> > I couldn't figure that out. I tried to add new properties here but it
> > didn't work.
>
> Like this?:
>
> then:
>   properties:
>     allowed-prop-1: true
>     allowed-prop-2: true
>     allowed-prop-3: true
>   additionalProperties: false

It doesn't seem to combine constraints?

I get this error:

	Documentation/devicetree/bindings/mfd/google,cros-ec.example.dt.yaml:
	ec@0: Additional properties are not allowed ('$nodename' was unexpected)


with this interdiff. I added the spi properties to reduce the additional
properties that aren't allowed.

---8<----
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 04b847fd5070..d47c7a273026 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -18,24 +18,21 @@ description:

 properties:
   compatible:
-    anyOf:
+    oneOf:
       - description:
           For implementations of the EC connected through I2C.
-      - items:
-          - const: google,cros-ec-i2c
+        const: google,cros-ec-i2c
       - description:
           For implementations of the FPMCU connected through SPI.
-      - items:
+        items:
           - const: google,cros-ec-fp
           - const: google,cros-ec-spi
       - description:
           For implementations of the EC connected through SPI.
-      - items:
-          - const: google,cros-ec-spi
+        const: google,cros-ec-spi
       - description:
           For implementations of the EC connected through RPMSG.
-      - items:
-          - const: google,cros-ec-rpmsg
+        const: google,cros-ec-rpmsg

   controller-data:
     description:
@@ -200,19 +197,14 @@ allOf:
             const: google,cros-ec-fp
     then:
       properties:
-        '#address-cells': false
-        '#size-cells': false
-        typec: false
-        ec-pwm: false
-        keyboard-controller: false
-        proximity: false
-        codecs: false
-        cbas: false
-
-      patternProperties:
-        "^i2c-tunnel[0-9]*$": false
-        "^regulator@[0-9]+$": false
-        "^extcon[0-9]*$": false
+        reset-gpios: true
+        boot0-gpios: true
+        vdd-supply: true
+        interrupts: true
+        compatible: true
+        reg: true
+        spi-max-frequency: true
+      additionalProperties: false

       required:
         - reset-gpios

>
> > And then when I tried to make a different schema document
> > it complained that the example for google,cros-ec-spi in here had a
> > problem.
>
> You probably need a custom 'select' so that both schemas aren't
> matching. Otherwise a schema is applied if any of the compatible strings
> match.

I see. Maybe that's better vs. jamming it all into one file.

>
> > Can properties be defined in this section?
>
> Yes, but discouraged for vendor specific properties. The if/then should
> really be just additional constraints.

Ok.
