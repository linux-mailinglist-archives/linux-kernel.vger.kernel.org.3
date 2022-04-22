Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E050C13C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiDVVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDVVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:41 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED84179C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:10 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id az19so3131812uab.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JRCh/BqOi4YkLGUiJfecYURU86aNbte4r9osUN03Ek=;
        b=CBGTb4d3eS7HJsTVlLbQoizdcgj00FRfmsbMjOINCCIgO/lh/nw8HFb5PtXjHizyAi
         BYZ+XVlLA6yn5KwojjjMps9Uw9kqcWQDjdEkeaNPwRettOULYGjgSkpIY7XNeOVgjp4A
         FIE3gEgnj+PkohreuAOunK9gW7Al2WCCKjSjTUSlVHG/1U5fxBJSxNvMJGAczW6PjXoh
         y4AV9yCqVYPPG6eAHwjn1K7OVRJaWNnRZmQ5k+B+yQJzKfxtyAomy7dOiJ4j6TfHe3jQ
         knLd0SPuH892Kmh/jfFnbYPiifqBIPHRECqY5lA5x4ux6cXe213gkYziWEoSlo2BOORF
         LlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JRCh/BqOi4YkLGUiJfecYURU86aNbte4r9osUN03Ek=;
        b=aVCmuO2UzaxgBChV7oscAMSpcHUyugRoV9W/yPcLK/yt8SqX21UUbJZjf4C/Rtdl5Z
         OpinoCPfb06/3zACHjGRuP3Zo6fVwwMHSA5ONrtFanBURYm1bwKI0cA6w1w0GBlSGK8C
         1/hWBd52g3eWPJGGevWywO/xDiFMaC4cL5kelaeRBHfZevh4WYVwo5W4P1wVIgdhg6ms
         h9Waj0zYf9obax3YH8V9FKTYOSraFNdaplV8pWKNVlZ8KjylL20+t7ibIumsHnSyjQMT
         aJkHiKzNJMY0ovgkOB880vpYePrFH+pOdQKuqc1VJ7rI/Dj1ytuzn0gcWalRYUdz5NPz
         ustQ==
X-Gm-Message-State: AOAM533nG5gXZlI1dJ1sy3tFfQYRRT1Fc1QLGni3szYLMraSyZ0TTb9K
        ohAEGHGGsO+fWhImntxfDU6g40/LdvQunx8P02UsD/txihY=
X-Google-Smtp-Source: ABdhPJw9gNNFIjL44oXwYR0XZt26gSCXKZ91nXCIwqis42lHTyFg4ODQiziVUiiGspHnYemb6VnQASFqhnYF8zKxMxw=
X-Received: by 2002:a0d:f0c3:0:b0:2f4:d291:9dde with SMTP id
 z186-20020a0df0c3000000b002f4d2919ddemr6790754ywe.437.1650659758236; Fri, 22
 Apr 2022 13:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-15-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-15-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 22:35:47 +0200
Message-ID: <CACRpkda-yLgH7mC6GkMgh5e3+c+4cBrRc9Ryist+zYJh2z9_Sw@mail.gmail.com>
Subject: Re: [PATCHv1 14/19] gpio: rockchip: add support for rk3588
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 7:09 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> From: Jianqun Xu <jay.xu@rock-chips.com>
>
> Add V2.1 rockchip gpio controller type, which is part of the
> RK3588 SoC.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This looks like something that can just be merged to Bartosz
tree as there are no dependencies on the other patches.

Yours,
Linus Walleij
