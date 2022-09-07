Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B25B0F67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiIGVqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiIGVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:46:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835A82F8E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:46:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l14so9953468eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PXE/Z3HxiWt7F7e2RZWHNf3RUT/q51Qsliy5mCBtP5k=;
        b=pwly5T/gbB+J2hYRkrP61PLvO2E15PzaheurniFapDV4j5Yljugy9ue+NzJeYwWFQr
         smn4HDexLQykl6Z2dwZGeCawlT6PU3bAomGTY48GAtilnHRM1mlJ2aij6swYTnqVZdkI
         /PRQA+qfezkYjGe0hymquv5y0ZnQpssplarfnmru6RMYdAFsc0rfI+CyuPlrPtv5gH6n
         onMoxT644LVdC0XJnmfbomrdRIUi8fzHZe/JloIJwjPgtRg5nmJ8SJpkVXF9O3eBGtaY
         hEeHZMRGAoEfd3Q1vHqXnOLdX9PP8S1Wd7r6xQUT+h5hmiy8sBVO0Tdz4qGtldwM7fAY
         lnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PXE/Z3HxiWt7F7e2RZWHNf3RUT/q51Qsliy5mCBtP5k=;
        b=eQBH4TEtjF0G0gdFTGsiQ1geXjNdf88+nu+c7DYE68H+SSxyzZbQp0fX7Mc03L8NUW
         ohbHT4KudNsaBS9LPuCtdoZkqgzvj9oRg5iy9HQoR8SwK51LHj1s8540AM3Yz8iZ3XZW
         UUyXylhjL9nRq1F2n9eaGvF1sq9NTyxMS02WgnSH779AS0z0O49OklGOxCXgG6AERFpC
         bq01Th/6dzMG4hVvACdhbmqJPhE9q85TlNeDNZn3CWrWZltGFFLvAgsvEhpLD7QBun7s
         A7SY6YJWAyNI4bqxZ2e0/5AKCfXyFOLXAy/df6J11eQSvh8ttiL5omhLU+HiTtklwv0C
         NzoQ==
X-Gm-Message-State: ACgBeo3JuFA0yz42zKgSqKygVAm/DUWqESNLkYaV8+5Bqq8X6kcCA2KN
        R8n4/kSr6dg8FC/u19gPWu1WU+/iEZ6+yodWOcf5fA==
X-Google-Smtp-Source: AA6agR5osXxsf7Y/1KOb7R6nPfjHt592g98SobKcQv4OldFYmQfmcPeERB/7qZvkwp3xU+Asg7r52+qxMfzkVrFC+fg=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr3794491ejb.500.1662587201970; Wed, 07
 Sep 2022 14:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204922.3789922-1-dmitry.torokhov@gmail.com> <20220906204922.3789922-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204922.3789922-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:46:30 +0200
Message-ID: <CACRpkdbO9WSeyY279WwWxYjfRUUvnw3++BsZWYkAW+upm73GLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: ks8851: switch to using gpiod API
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

Yours,
Linus Walleij
