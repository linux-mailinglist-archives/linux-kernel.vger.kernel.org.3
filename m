Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9195C5B0F74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIGVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiIGVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:48:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B093C480A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:48:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so33481123ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+/R8XTGRvXQTqvAr8XML9xdzybq9kmOE4MfJixg2MLI=;
        b=BTcxONqs0yhXF+8dWjfiLFdOKd/xUabSvAO7NqrhEHtZGoYQ2KGmDrVRbsynKidinm
         JEl8FINmdPf4Tq54yiD9FWNgsAzRf4/kuC+9ExmgscTOpEqMq/PttvPNuuDyxQmt83ng
         SLsZ9j55agxBr/StLo4iPYaJK4rP4owe/bJT3f7m1CXVc+euPeTii0VulvZnOut4dd9j
         xtJLgk2j4oe8HF/WqJlR2A845oq9NsdBssjoS/ULF0Rkr4i2w/7ex4m3IIHKYKzvl9QH
         RTk86241OLYvGKkn1daSEwLN5wnH4IGEN13w7WyHhg5G0+D5jg7Y9mgWqHjfXi82i4Es
         hF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+/R8XTGRvXQTqvAr8XML9xdzybq9kmOE4MfJixg2MLI=;
        b=UrZ9UQiHkNifcgibBL+5isSoNRHFxFJWx97ZEHL5hVsM8RExHAeMNB/KdmfqiwX9Y7
         gAFB0OydeS9tVzSzXtPOtO9sLj091bu8tKuaDkcvriEOsVIjJ5zVhggfPIjUZhtbw56p
         RZSehRH3YBiEgPEvXgF85Rcm9QgXRTjJuLt48Nvc2Atq7isPvofAatQBNa+/BX4UsG7y
         MpIF3gPuS6VGfeye9GLBEUGbvwu3M8dlpVUP3gyvXCfl7CrKitINWbvAu4qUuWwfRPuz
         91xhc10CJqZtHKMgi5AfmoogBaDusUui/Pd+d0BaCOXVFg92kJX8QGzsuokGNBh3h/95
         8Qog==
X-Gm-Message-State: ACgBeo0nye3r7t1xW+5EKWvS5w3bdegrS10DxIL45Wos/+llWENYdqLb
        oRUHzmPSxaCMxDH7ZP87KTo17sq/N4HxdxH4RomHQg==
X-Google-Smtp-Source: AA6agR45YzgOvEABURG6+iYvf+WmW5H2jNOcAjhQrckuIdcu1V6NSk2KkiOw4zMEqgoSv6z8gP2a8acsKlEO6ez6f1o=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr3800336ejs.190.1662587299605; Wed, 07
 Sep 2022 14:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <Yxe20ehiOnitDGus@google.com>
In-Reply-To: <Yxe20ehiOnitDGus@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:48:08 +0200
Message-ID: <CACRpkdaDc1YwdS+Z4R1LEM=tzuMvCoy1qxWix-WaLRHsrZ=SUQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] remoteproc/keystone: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 11:08 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Note that there is a behavior change in the driver: previously the
> driver did not actually request GPIO, it simply parsed GPIO number out
> of device tree and poked at it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
