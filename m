Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C750920B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382494AbiDTV00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbiDTV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:26:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD84831B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:23:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r189so5238885ybr.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNoFOy4a3bgPkQVqzY9jvHwandHXVY61/sg4Zfz5i3w=;
        b=Seo2bThqdCMjzWqjYXZ0xLFOhHtVm9bLdX6O0DJ3+v0DymcUaqJLYUJHsrSy7ma5N/
         JlVJ0OZTTGsMCajqR1C1ddy1D4vS+VEeKR/c9a5WUnkg0ZXm03NLiKP7YuhrHQubTSej
         JkIQfWxFY8vFlSnuAiJlRc7WgvOZLOIRtOVTYjgNsNSRM0KoADLyAgDS9bZZpVXMOcdl
         v7cCprLixK+YvYKgcKX5ezBFGGa9ak++pc79Hs4qO9dJpJxwzjJwxLF+RaFm62gtNZXb
         um/uwTJpGhmkQ1Mt75SuC6yIm0m4r0uxD7tUnrYpwWE+GINkJy6pGCdzcWi2oBhV0Cx2
         2R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNoFOy4a3bgPkQVqzY9jvHwandHXVY61/sg4Zfz5i3w=;
        b=TlYa47NFHZh212CO9vrbgVXLsU5uQjFGtf562GbBahFs9RZqykHPZd3UMXCkQOWeqY
         IINHQALSfZbqgQkXXaTK10o14p7NDnQXnzfOCUCAjLky30KO4PANVObNCh/uV4Sa9CQr
         HS32FORqIxUKTUEkfX54D9hlGKEaodJZB5H43WpiOe3Zj8vP4MY/eXx7c/VE8XDgiBAY
         R+orMoTky/fANo+zZFBY7HgZYrsduh7waJX3n92R49SBGhvnujdHm4UXF8I7URxMp8x1
         nQ1/BUSrGvoDYHwxGQf+Q7P8JJrViFq1mXVZLwVS2i2ZpRHiwoUAuwFNQ4dgcCPDK5FA
         oSSw==
X-Gm-Message-State: AOAM530NvfBIjfwS7Ippx2q6CL42DQGvFVk+F+Wya8rfnSvwvHXGMN4/
        LQPcYnQ7ReA6SPmPCYhnfIOcIBvbStiPnWMK2vDDdw==
X-Google-Smtp-Source: ABdhPJxiHDq05p9pdRKqWJQxsx5s+4OOdYxBG0GepwCxgjP4lZMjN5+fEEckXfW9Nwt6Rn8+Qcb9CqFq5moxgaXyirU=
X-Received: by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr21879860ybq.533.1650489816614; Wed, 20
 Apr 2022 14:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220329054521.14420-1-dipenp@nvidia.com> <CACRpkdbGyrRU9DDTmNDpU52rECAKY3wfi2y3jo9FMypDG=pmJQ@mail.gmail.com>
 <YmAPBG6IknkLotJp@orome>
In-Reply-To: <YmAPBG6IknkLotJp@orome>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 23:23:25 +0200
Message-ID: <CACRpkdY_R+kJr9KppVBENzav_tJ_XToubs8mvtHmvCz9HokeUA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Intro to Hardware timestamping engine
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dipen Patel <dipenp@nvidia.com>, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:47 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Apr 20, 2022 at 12:46:43AM +0200, Linus Walleij wrote:
> > On Tue, Mar 29, 2022 at 7:45 AM Dipen Patel <dipenp@nvidia.com> wrote:
> >
> > > This patch series introduces new subsystem called hardware timestamping
> > > engine (HTE). It offers functionality such as timestamping through hardware
> > > means in realtime. The HTE subsystem centralizes HTE provider and consumers
> > > where providers can register themselves and the consumers can request
> > > interested entity which could be lines, GPIO, signals or buses. The
> > > HTE subsystem provides timestamp in nano seconds, having said that the provider
> > > need to convert the timestamp if its not in that unit. There was upstream
> > > discussion about the HTE at
> > > https://lore.kernel.org/lkml/4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidia.com/
> >
> > I like this.
> >
> > Can you put it in a public git and make it eligible for Stephen Rothwell to
> > pull into linux-next and ask him to do so, as we intend to merge this for
> > v5.19?
>
> Do you intend to maintain this as part of the pinctrl or GPIO trees with
> Dipen as a sub-maintainer? Or would you prefer for this to be a separate
> tree?

It has nothing to do with pin control but a bit to do with GPIO and IIO.
I think it needs to be its own tree just like regulators or clocks.

Yours,
Linus Walleij
