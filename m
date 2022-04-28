Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3E513E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352942AbiD1Wmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351569AbiD1Wmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:42:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1CC12EF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:39:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so68460567b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+3J8Tg1YKkO3lpTvYwXtrtSHWXSrNo91D9D4uubgfM=;
        b=V4XCWq+mmBEcJp2rd+FHj5x6PNMIWT8HPTMQAxnaI7951ksolZFoZlQx5xw2qhxxun
         3wrv9A+A1/uDRZxkAklPtdGFsTmIJzUm66fE+az8c8Gax6q/hs23FY+pEZC8O4aZUO3S
         uMmSpr23BPt1V4z9OSeskzAu1ySy4g+zOkCcm8hX+D27zAqd/vyzE4h5gddupLogEuyd
         fOXUvcQ+fFMJq3BV5SnS4BOv6O3Tsmh5FSjAtNXr7gltT+iSAkQTfLrR+hjxX9tQYq04
         aoWOUJlz7SPODt6wkBWOR5Bnac01p/Mbc2IGhBY1iD5s8ZkU7PSPCjH1Qn27aI3Yncv5
         oKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+3J8Tg1YKkO3lpTvYwXtrtSHWXSrNo91D9D4uubgfM=;
        b=suFlwhogjHc3eiKCkX+incMRA0LSG+Wn+Ji7IUY+JsEOS/jk56HzkWMvKOtlEg9RIc
         Nt2uCq9Bp2fDmnh0Vn3tcoTY88Q0yl0UXNQo8xJu6qfH4pquXbW1q1QfqpKdAW4vhOGv
         logXgEZPERzF47AI4cdQFMiZ/ftdvz4ia88eyirthdhi+sVRckv1eNCTeD6BDn9Mqvhv
         uOYM0qHFh4v/tMqtyZKdIubBMzhmN2m1/FMVLsEtYEPZ+xcngtrBuQktKnFxOtFCQYdp
         Zn+b1g9+SaVwBwEs2b3lD+7X7eWGfOr35FRLAW1hv/x5kQChrRj7/Tg+XWUzy2k80+oq
         AdzA==
X-Gm-Message-State: AOAM530VDEK6irL+VlzUPK0TfUbLrwnEoh4pIhAwrCVVqWpp+b90u50b
        KBbFJ9RYKAd+yH9EWHjQw/XEVXx9QS7LY6JvQ6F0LNkyJHg=
X-Google-Smtp-Source: ABdhPJxvhml9HFXPCwUVI0CwtNK5IaJmoBNDiEfCirpoYCazdVjbv6nJ3rx/3iOjPRgLySfwlGlZlM+lkxFFFgGvH8U=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr34374108ywd.118.1651185569522; Thu, 28
 Apr 2022 15:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220420191926.3411830-1-michael@walle.cc>
In-Reply-To: <20220420191926.3411830-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:39:18 +0200
Message-ID: <CACRpkdb2zuXpTkiXNtC6KKRO55Ks-yep-TBq9YD_x9yegZ-iyA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: ocelot: add shared reset
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 9:19 PM Michael Walle <michael@walle.cc> wrote:

> On LAN966x SoCs, there is an internal reset which is used to reset the
> switch core. But this will also reset the GPIO and the SGPIO. Thus add
> support for this shared reset line.
>
> changes since v2:
>  - use dev_err_probe(), thanks Horatiu

Picked this v3 version rather than v2.

Thanks!
Yours,
Linus Walleij
