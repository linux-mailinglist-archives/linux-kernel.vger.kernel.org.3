Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564B507C28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354221AbiDSVyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiDSVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:54:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58803B3FD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:51:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ebf4b91212so187593907b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LhDtsOPaDlH3w6gyeu3mci7iJleTkKy6Uui9MQ6Hds=;
        b=TmJ0eiZYxAZdUE5sh6L1cK/xtUM2pWMJ2d6VLd7GncE5o2BPF8IhN74KoYLmbqhlqJ
         751S7YfxUmlLYCB/tgrlgHFmP1pOaZYQvNOegYyL7AEw/AvmbnEgaGsD6reGB657DSW5
         SLtQWdiI4av5zn9s6lCHbNTOxDNFgFbjdU2/ySPN/iks+s7ygV4PF2EChzm99R1Sj6fd
         uHkOK44JlKGAdcPmAK92pVDG8HfBkBMdNY8y7hgaIzSXq+dYT0pMiMXVOwmYskbMLIwP
         RdLXDObtdw0G6sxyzlQRmVRWV0d9Lzy0dn9bQ+kQB910wQWErhsL9r8ObnCdXEon9VKY
         xtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LhDtsOPaDlH3w6gyeu3mci7iJleTkKy6Uui9MQ6Hds=;
        b=AsTqCgrxPk2DFxpQZhLjJvpFx0Sq6ppsApvf+HSZFLLfZG9TLp1YZdKqYo9ck57/RI
         +aogxjHvH0rO1RATDLGMWKq14bftUF+lyhBJcL9pQPF8BYWY+XSk+cLb4+KXLp1U7sOd
         Qx0PdNYGYMHJKltewYOCYNRnzEdrULBiUO3SOF5A7IulVu6nF3jgWE2qOAqu8Lg7GlMi
         MXQti180OgJn2g1N+gasvxhFMCW27sor9zCUWwkBM8uY+g10HRrnNIVU9YR9+OmLTSbu
         YfWsU1Ncc1TRwvU8CtSqEfucDXKh+IKwSlEb04LJKMbfsTT5PwB1sJMM1FSxB+CVYX/2
         LXdg==
X-Gm-Message-State: AOAM530Nawki4p7QRI1lIhDzuBp9WHo2pmZqYP9qLCc3DzORqVBWuNum
        I4McEUIj3WD2P2kYGtFYANzdRxv7ozPZ2/jJdMrd0g==
X-Google-Smtp-Source: ABdhPJycEnrH7NVifO4MaU0HhRu9JHmy3mauXkWvCyOyFGBRyszpFOK/1t0vV+rQEn1AzyuIAhpReNnCvDyBl6IzkMs=
X-Received: by 2002:a0d:e813:0:b0:2ec:1e83:e5f0 with SMTP id
 r19-20020a0de813000000b002ec1e83e5f0mr18570099ywe.151.1650405089150; Tue, 19
 Apr 2022 14:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:51:17 +0200
Message-ID: <CACRpkdanmmwfMHHQsK+d_CXq92YkFj4Pw0EhsJStukL6C7Qa0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] gpiolib: more helpers and fwnode conversion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 9:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This is a spin-off (*) of the previous work of switching GPIO library
> to use fwnode instead of of_node. Here we introduce a couple of
> a new macro helpers, which allows to switch some of the drivers
> to use fwnode and partially fwnode APIs. As a result of this cleanup
> a few drivers switched to use GPIO fwnode instead of of_node.
>
> *) it's subset of it with a new (patch 1) helper.
>
> Marek, Martin, can you give this a try?
> This requires at least two patches for GPIO library to be applied.
>
> Bart, Linus, I can take it thru my tree with an immutable branch if
> it's the way you prefer, otherwise please suggest on how to proceed.

Hmmm that sounds best, patch 1 does not apply to the pinctrl
tree so I suppose there are already dependencies in the GPIO
tree?

FWIW, the series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm of course a fan of this nice refactoring series.

Yours,
Linus Walleij
