Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC65188FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiECPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiECPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:50:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035D33E3F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:46:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i20so17723208ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmEYqT+9Ka7njk/TwR9G+Gdm+tqkABc7dcTcU/7kYZY=;
        b=IPLzFJvRDQ9r0mh8TcbmuNu1p2ZCdA+ba9sSjOT1tZkhVfsHcEFr2+YTCL1iNWL6fI
         2UmCRjoVIb5YpVcAKV+QVUbX4nNZeBM0yzyPY5NKn8pVRSa1OAvQJTqAPGL6I1tR9/7p
         o7JiIwX99eJ9jk7iN47UV8C2OJuigQEUnteBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmEYqT+9Ka7njk/TwR9G+Gdm+tqkABc7dcTcU/7kYZY=;
        b=MEh/qBETGJzfiV1GRB5WYkI+HPAEG168z0Dk9Xc99uNy9qF5jEKZ+Ivtz/RbjwKOeQ
         hiTd7UjHxmLBqQWdUsEvmy+dwxN7JnmSTtHsHriZbR3bzBsWxp9t5WneSQHWavw9ukOj
         LSBnn+SZRHMqWuxfSBaZH7rcpt98CgfBZ1HwaKLKccB5cj9Vns3WYIWmssvQfreMRQaX
         SWrFKWoS5TI/SFEm5Eig0UxDlSimIo8HGCb6zVpcwJI3igmFocustTETppusLyQLP6p9
         v+QlbV8odW7ViR3TrySJX99R94cYGVU7ogB6zKauOFVE0g6FwC0ynWLq8fO8r2bXLRet
         /nIA==
X-Gm-Message-State: AOAM531cEhqygg3cyqvsMS359snCnq67L6ceAKsYHIaZtrjJD63/y/l0
        oT5Ajn191ArJsDVb4WvkH30MQ3AMU39WPI5O
X-Google-Smtp-Source: ABdhPJwSDqDu5gzPwUtOvp2vuC/0m4i8s8GWFgbnz85lVn+i40s1HuWWpeld2lxRffCVlUKMPO2/yw==
X-Received: by 2002:a5e:d61a:0:b0:657:c106:6009 with SMTP id w26-20020a5ed61a000000b00657c1066009mr6151036iom.105.1651592798179;
        Tue, 03 May 2022 08:46:38 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id t14-20020a92c90e000000b002cde6e35305sm3304581ilp.79.2022.05.03.08.46.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:46:36 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id h11so5366610ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:46:36 -0700 (PDT)
X-Received: by 2002:a92:c263:0:b0:2cf:c0e:bd81 with SMTP id
 h3-20020a92c263000000b002cf0c0ebd81mr4741427ild.220.1651592796090; Tue, 03
 May 2022 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-2-swboyd@chromium.org>
 <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org>
In-Reply-To: <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 08:46:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
Message-ID: <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 3, 2022 at 8:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/05/2022 06:22, Stephen Boyd wrote:
> > If the ChromeOS board is a detachable, this cros-ec-keyb device won't
> > have a matrix keyboard but it may have some button switches, e.g. volume
> > buttons and power buttons. The driver still registers a keyboard though
> > and that leads to userspace confusion around where the keyboard is.
>
> (...)
>
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: google,cros-ec-keyb
> > +then:
> > +  allOf:
> > +    - $ref: "/schemas/input/matrix-keymap.yaml#"
> > +  required:
> > +    - keypad,num-rows
> > +    - keypad,num-columns
> > +    - linux,keymap
>
> else:
>   properties:
>     function-row-phsymap: false
>     google,needs-ghost-filter: false
>
> Because these are not valid for the non-matrix-keyboard case, right?

Isn't that implicit because this file has `unevaluatedProperties: false` ?

-Doug
