Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4915A28C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbiHZNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiHZNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:42:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA1DC0B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:42:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy31so2829467ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dcIpKiF2QxlFlDqi1p/45q/upk2pY1SQqeEPPhn9EJA=;
        b=KsU/0MWsbKjCd94cPcpLGDlqG5PgnQ6tcDMi/oFYjTwms/KXJ0byuSlnfu8OlnGpFW
         CA7F2gHK6I6V+2AXC0fYG+E3Vf9KvuoC9YDFEsHq9LN3fMA/6qKMIu4fDYACLyFfMBIB
         AkjpsVEICNC290p4aVBt+V4pD9E1FM1McapseupoDkKoiyQKU6WC6GLiVqGzGkvzQ1+D
         cIPlnj+nUibTCZE40OP3wqresGNw5NXBW8RsS2XpSHaaApFsVqeek3CyQqgRYx38CRiP
         Dv9OSVWOnS/R59EyAd9nZjRdTdgibbKX+qtFb5rGJOeGIvOxRh/603HLFTWZLgZ+GLSY
         m+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dcIpKiF2QxlFlDqi1p/45q/upk2pY1SQqeEPPhn9EJA=;
        b=kvexgH/UbTDgrmC8WStG/cihyewhLQdZsCixZnJ1PUlKXXelwrhVlgcBWgiTqILvZU
         F0QIUf64xXEvKViPZlnDEe2RQrb3T0IMRJ1Nz2+XWli+G5e+27IQL074rqVUWJTtV5Bf
         x02MnLsUCT4Da3vyIj3tAwEfbjIdkP5W2wT6XHljfgixgpZ92Jmbc+cEY+2q1os8qoI7
         yY8c17J3qd/FHSJddFZ9vt0XCMisU26/+MMqClVLFgVgTGndB8ZLaNJjVLz2+1dd6nuJ
         gzOhNvPCjIpBTAOTVDZvhATip2csey89Aqp0lp9K4Bfz/DQcGVla8wUkgXhG2L+t9KGw
         h0ZA==
X-Gm-Message-State: ACgBeo3+mfwB0RB2bK6KijAYd1y6rRvZMzW6HuLjp6QgyHzd8uHSb0eW
        ARYI7tIYjmPc3sKngaj8DR5aH44IAr94sFB79YmcSg==
X-Google-Smtp-Source: AA6agR4N+jAsTYj5e1lAFGX1/sUkgsjRPz8smfQ9XZjUfRp9wgZb1w5oMVWikgX/uSo09vhlvgi3bZYLWPPCYxscq/U=
X-Received: by 2002:a17:907:1dec:b0:741:3cf2:47d9 with SMTP id
 og44-20020a1709071dec00b007413cf247d9mr348515ejc.208.1661521373875; Fri, 26
 Aug 2022 06:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220825094132.1268174-1-s.hauer@pengutronix.de> <20220825094132.1268174-2-s.hauer@pengutronix.de>
In-Reply-To: <20220825094132.1268174-2-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:41:59 +0200
Message-ID: <CACRpkdZboPe5DTkO7HuouAW92cE9NC-dOZ0_zwPTRCOM+pJ8sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: Add gpio latch driver
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
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

On Thu, Aug 25, 2022 at 11:41 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Take a close look at the other forwarding driver:
drivers/gpio/gpio-aggregator.c

Especially (as pointed out by Marco) the sleeping/non-sleeping calls.

There was a lot of discussion around that patch before we got the
forwarding of GPIOs into a nice working shape.

Also get Geert to review this because he knows what you need to
do. :)

Yours,
Linus Walleij
