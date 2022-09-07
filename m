Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581285B0F64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiIGVqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIGVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:46:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550627F110
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:46:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dv25so4156018ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FzI+NYgLreNdRpGLkfDnamsfShBf0ZKTlM17YZgua3A=;
        b=I0TddPEPV0fFbnI0v9AXqC9cgbCPCcRzvdkDFi1tHIr/t6gPXSniK8XYygCGv8baS0
         HQisqd6PLa82tyoBTLwft7iOGUk3TvDgpGPWX+viFekQ8sCQUHgaSIuo8qB3KU17qhtp
         wFEvofiqWUkmYIndOucyu9zvfiLodemHnIcLTTtQF2/QwF3F8Jt2EAIRgmw+zDRP3V6Z
         l9NZH6OTENqGNA8wcqdtb+qdw/4WaWzYvr8jMY0mRFdAF4Hy4WNSokwJVepExjON+HO8
         uij/kJGSeXOjgMiKhmRiFJ/zafP5c8QB7rgPpMFtQIKT3KdsTillvRUKMgFt4qt4jlzX
         NlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FzI+NYgLreNdRpGLkfDnamsfShBf0ZKTlM17YZgua3A=;
        b=TMltQnrujTG91N98d/9cX5c10hB8OJCizVRYvBySFXRknAk3DObhgW88EDoDB0mELc
         xOj1UiWx0f6/ElKrrErZnRIUoFpQ6dFw7OAaytFURtE+q0zrWpRq0+FddFJvwR81a2wO
         E9CxaxNn3ZQIBbc4Mgx60eArbSu6xkeIqAmtrVV2ShQMxlC0bdqHgWtJUf+YUPJrJzwi
         By1NjLRuPQlEu0HdxfCes2+eQtmbhXuc4o9T9A98hJ2Bq0/FyPx1QCpQuB4WMkMRvArn
         kR50OZnQvmV+heuL+YdtV7XWM8XLByLlRtGTpJk2H2GzPM4Ih4D4Ok9w+zFL81W9ASh9
         0RoA==
X-Gm-Message-State: ACgBeo1EwDQlh7e68oJY94k48Bgj1aABu0uu7G8Y4p9BVuYmtpZHLKt9
        BT2E8XBGitFlw7a6MNJK4YyCCjs+5tzKmgXW/cwyZw==
X-Google-Smtp-Source: AA6agR66HDLg6KtgJAD6Rmh/HlSzioiDi0XVXWaEsGvWZykm0m7HBw7EcFTDJSLMaeYUZU7JZCorEivpZFO4E/pPwMQ=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr3780632ejc.440.1662587159927; Wed, 07
 Sep 2022 14:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204922.3789922-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204922.3789922-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:45:48 +0200
Message-ID: <CACRpkdaUK7SQ9BoR0C2=8XeKWCsjbwd-KdowN5ee_BU+Jhzeqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: davicom: dm9000: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 10:49 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think net patches need [PATCH net-next] in the subject to get
applied.

Yours,
Linus Walleij
