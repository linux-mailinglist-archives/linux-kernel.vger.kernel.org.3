Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167E35B0F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIGVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIGVr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:47:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3560F8D3CE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:47:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z21so11540345edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PXE/Z3HxiWt7F7e2RZWHNf3RUT/q51Qsliy5mCBtP5k=;
        b=BupsZU9MRorQgeadC3YwFGWQYx9fb2Fy9r/vDrHdQVeUggh2yeESMXj5hMS6XzZHQr
         dCigHcTnmdH4a7TxwSaLYWCXshw/4qxaMEhBFpUbF86QnTmbNbP/S/bvrjnJTdSZWLbN
         EbXF4Qi0KyEyCj9FMLTiaupUEz3omETAZ7hzFhDbskfrKRlAdvC0iG3BzcsyYtvLlSZI
         /SlUVH7IlMc3kUIlVE2Auh2g7IMGpLLmMXoBkJhzmZOHinswEWRXnZ59aq5OEKMJPXiD
         iSfdB2y935d6mMGU9ngBegzQ/DVes+Skde7+j6Cd21aGmrOw9HrLXiP6wP7nb/mkBQdz
         dO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PXE/Z3HxiWt7F7e2RZWHNf3RUT/q51Qsliy5mCBtP5k=;
        b=1W/Ef8juG0mP+ETZBUYe8/qDzgzGmPS90Wnbo9Ue8VC2iDYK5wnJmacKDhJNMAAXKX
         MPnprmEtCnLFzFx80H3MhVl+SFzw2Xz7sq7ZwxQBwe+J/jo11fVipCE32xQS51/Cn3bJ
         Zx2IMzlqjw/JCHGsJJnsRWf3iDS6aqNqZsvATLAOFQnzj+o+oeEBGHicrQm0ZMli8fUj
         zji2wkpfYwfXu/3+xMRSy/GH8ZIwgEfNg8HIJBU27/3GdHfC1aU/MULUXai/zoWJmbjt
         ozoGGYBYLWxpm1zl1aUgB3zHBmnfvnTqSLkJZEhEoj2uSD7QSyb7yO1XZccI454aT8dE
         c4Og==
X-Gm-Message-State: ACgBeo3kg6MzVpKQCkmVlMG7tVHnLWg07SHHbPM43Wfa7h+6aA5FWx//
        KuVctZrEBcPckEdZz3HfW/6dUaEE42iTw3njIC//yQ==
X-Google-Smtp-Source: AA6agR4H+0LtaE/l9IUYQv5J2gdNc/o7vUZfMppIlkUSxMDfFZgbRcCHk/P5Eyht8zBUEEBtCX6GlMp6u95PQ2D8rpo=
X-Received: by 2002:a05:6402:51d1:b0:448:bed1:269c with SMTP id
 r17-20020a05640251d100b00448bed1269cmr4694671edd.205.1662587245680; Wed, 07
 Sep 2022 14:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204922.3789922-1-dmitry.torokhov@gmail.com> <20220906204922.3789922-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204922.3789922-3-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:47:14 +0200
Message-ID: <CACRpkdYAtehsCWLj7ht08y-SAXEhOKu1Abstsk1JXnj3bvU4xg@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: phy: spi_ks8895: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, netdev@vger.kernel.org,
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
