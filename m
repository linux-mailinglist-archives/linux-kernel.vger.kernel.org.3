Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1875804A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiGYTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiGYTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:46:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C471F2D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:46:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z132so3091984yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lY+1yfeH/k1eux5Oe0YusyRsTu8qiRzbYPN4fFrCgzE=;
        b=HdiPl6dXjNF6LPf7HkcGS4YZoh5aBgx4nIkbOH/OfLLBBjsKXGqHDIB+hC4jZYE9N/
         GGBmWWQBCnqabbkdrY0Iks11LQ6J2Sg+Cf94dZaXH9hC4WZhZdREtroR/NnZ4n69032q
         mLlTn3GK+cvkdV6aef5Sfa2lcO4ZXTDw8d0rBjOHFDooKliuR5xjmDDeaUc68CN29IbP
         MvSZSRf5rGvvjEj3glkszn0ACaXMepK3ImRRKfVqlvgIgJ0ctR5GG21B1wT9KRPJEBjW
         AdiUsUTDJv8GUcjkLu8ygLRoOQkOtjX6ajKZOywDX4xJVM14aN36sQsaJz6eSFYoJ7f+
         5d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lY+1yfeH/k1eux5Oe0YusyRsTu8qiRzbYPN4fFrCgzE=;
        b=IXxyIXgdVpeqhqAUqqoZbWtQQxMcuHcxt7Ywz3Smj8tIkcfG5KP//ok+k1AO1YHHNq
         78Zle6KhiyIT933UZDzOxE0lWNlJ/fUngxhURE2w220cpgi3Do47e2pFn4kSpQ80zMKK
         IWh+xNDsjkoL7zo2Kc6Cvr4kPIdCB+cCH+bqrbHbj3MqEEEtspAK7RaHGeP2PBXibhCP
         Rr9hbYXIo7mRZidoajd9zn2XnN4Maqm+q6J2WDQsKHFzYZbTMGH0PFGje6EORATrzlL8
         LCv9FuQI+Fkwthhwwln3xeY75WOzp6gqP1Z+RLE7KC5pYZugi7kajPnFgQHIaunMve1z
         EvAQ==
X-Gm-Message-State: AJIora/6yF/zkjer5uVc14PGE5ndE+qv5lfIz3LnYmRK5w9kFgUUMbJr
        X5k9l+kazhkJMMrxnExly/V+xVzxEKm4YTex3K4=
X-Google-Smtp-Source: AGRyM1vMUtIDndWYNe5OZY7OOkwWLUzuvCOFcfFBRUrr0Ae03QgWFj/BLZ4lP8rZuLVJji3skuyl0+5BRrNy8T76GiI=
X-Received: by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr11093199ybk.452.1658778400804; Mon, 25
 Jul 2022 12:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220705022032.281665-1-windhl@126.com>
In-Reply-To: <20220705022032.281665-1-windhl@126.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Jul 2022 21:46:30 +0200
Message-ID: <CAFBinCC1x-655H2LbbUhiVGmgXL+tdSRnCPV0a-NJcZKOFJZuw@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: meson-pwrc: Hold reference returned by of_get_parent()
To:     Liang He <windhl@126.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, inux-amlogic@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for your patch!

On Tue, Jul 5, 2022 at 4:20 AM Liang He <windhl@126.com> wrote:
[...]
> +       struct device_node *np;
>
>         int i, ret;
>
>         match = of_device_get_match_data(&pdev->dev);
> @@ -495,7 +496,9 @@ static int meson_ee_pwrc_probe(struct platform_device *pdev)
>
>         pwrc->xlate.num_domains = match->count;
>
> -       regmap_hhi = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
> +       np = of_get_parent(pdev->dev.of_node);
> +       regmap_hhi = syscon_node_to_regmap(np);
This works but I had to read the code twice because I thought the
wrong struct device_node was used.
Other drivers typically use "np" for whatever the code section
currently refers to. In this case the code section is about the power
controller, so I thought that "np" was the same as
"pdev->dev.of_node".

I think the code would be easier to understand and the likelihood of
someone making the same mistake as I did if you could rename "np" to
"parent_np" (just like you have done in your other patches).

[...]
> +       struct device_node *np;
same as above, I suggest renaming this to parent_np.
