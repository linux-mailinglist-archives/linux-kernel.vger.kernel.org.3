Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FE5A8A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIABKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIABKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:10:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BB3F320
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:10:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so491943wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CjZECOzLeXHOxYfgj/cZbdNFcui6wlKXTUVA8M7mEZw=;
        b=OfXRkpizalNa11ty/ObB0YE8gaF/KsLNqBZsvIPYzGvXkuJ7AH67EL6Y4tKg2Dkh+W
         v9LBxpJnSj1Q+sXGtF5fY2HpYJokJ5KVVV0SsvvAsTbvZNGqimFVp8h0IW8RoZi1AT+1
         bG6KqczJSSvK943d27EgjSUQonp5ruT9GB6xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CjZECOzLeXHOxYfgj/cZbdNFcui6wlKXTUVA8M7mEZw=;
        b=ajCsgIdbebVyFmN2l5gqkWGS5xvvnhj6vbHSmSvIDfgpB6Xuk46l0N4uxbnl3bmBFm
         l3bLsR+bHcn0qjYZ9ZQmfB40UkikUrI3FdOVuXBYDINh1ZSZcpPJguARTQ+IJrqLaVia
         Q9Zy1x6y4B9OBcTyE9UEPfCc9yykECtratDSObcTxZAzIilhhY5FA/1Lg0qDG9DNov4o
         TJFF6Fw2sazAb0os6xNBJpgkZdL3WsTG08uJqUah8QrAOTnEuFoh55BCRtqSm/ZvByok
         F688YfHhbGrJda7mR6pHuDQMTWusv/m/jQmCmc11GdSrnlkyLAPnkMRBAdzGazhX8GUH
         TpKA==
X-Gm-Message-State: ACgBeo2LgA1h57hphczoeZ54xYBAk7sE4XQWlGS9k/fTi2HSdVrwOvu6
        LLROC2lsjm3aaVBIK6LAUBhJj9if/PFRt1jaodj0TA==
X-Google-Smtp-Source: AA6agR6N/6ryjaE5oHG+JJHSEIkNANGb9HZ8fnEHslgyH9XeO5lh7HnK+/u10e87OwJ2YTLwPGJLovU1KnKa7mkOS9c=
X-Received: by 2002:a7b:ce89:0:b0:3a5:cefe:80f6 with SMTP id
 q9-20020a7bce89000000b003a5cefe80f6mr3659147wmj.113.1661994602969; Wed, 31
 Aug 2022 18:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-2-jwerner@chromium.org> <08d8807e-18cf-032e-90e9-e08023e7a6e0@linaro.org>
In-Reply-To: <08d8807e-18cf-032e-90e9-e08023e7a6e0@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 31 Aug 2022 18:09:50 -0700
Message-ID: <CAODwPW-UfvgbGaZtyu_g-8dv_rmz8Zk6Xb6M5DTtRah_1W2KVA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: memory: Factor out common properties of
 LPDDR bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +properties:
> > +  manufacturer-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Manufacturer ID read from Mode Register 5.
>
> Are you sure that register numbers (here 5, 6-7-8 later) are the same
> between LPDDR 2-5? The description should match the broadest case and
> specific schema can narrow or correct it.

Yes, the new LPDDR versions only ever seem to add new mode registers,
but the meaning of 5, 6 and 7 have always stayed the same. (For 8, the
bit fields have remained the same but the mapping of bit patterns to
values has changed.)

> > This also un-deprecates the manufacturer ID property for LPDDR3 (and
> > introduces it to LPDDR2), since it was found that having this
> > information available in a separate property can be useful in some
> > cases.
>
> Why do you need to un-deprecate them if you have this information in
> compatible? This was not exactly the previous consensus. My statement
> was ok for un-deprecating if you cannot derive them from compatible. Now
> you can. This should be the same as USB device schema.

Okay. I think there is value in having these as separate properties,
because it makes them much easier to read and use. If we don't have
them we always need to do all this string parsing first, and if
systems allow both kinds of compatible strings (auto-generated and
static) they'll need to be able to distinguish and handle both of
those when parsing... I think it would be much less friction if each
datum of interest could directly be read out of a property. I think
having a bit of redundancy is fine and common in device tree bindings
(e.g. most properties for most devices are really implied by the
compatible string because that same type of device is always built in
the same way, but that doesn't mean it's not useful to list them
separately for ease-of-access). But I can remove them if you disagree.
