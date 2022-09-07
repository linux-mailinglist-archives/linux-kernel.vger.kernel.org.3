Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324A5B0F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiIGVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIGVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:44:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC32ACE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:44:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so33462042ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3pnUp/O3nCFTGVRKMfL8coYqAMVPLL9TVgrg8/J7HSQ=;
        b=k85w1q5phtAxY2JdDKBchTuTrp7f8cuBZHnB0GNLY4vTTmoIWb8h1xMLTShffXHqHE
         C7XA/cIZAPUKNwq7yalamijKSt1h3a0JIn3no5MuSU5pk2G45aQMQILVw90o60Ai7cbu
         EK/wb0eDvWx5J3pA0oktiNEJxMI8Owe8FTm9T9rFU4jrG/GiPLa9fuSWLdnKIbbRMbcs
         YrZfePuShMINH1nOoCvUunS7afwXQ/54giWIWPlfAgxvCPCWCF4n2z3zNDkPfoc5S/La
         1+driF7u4YBUzpOO4DFBCW0rbxna5TW4mk+6ZfwIUTtbph57Hr7PrKChd9N5DDsI8IJj
         SsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3pnUp/O3nCFTGVRKMfL8coYqAMVPLL9TVgrg8/J7HSQ=;
        b=4s9y0i6H2TDw1busq9vO0yFT9Jrf8Q8BkbHjDdIRi4PBKfWXdD5pKiG9QrxjPujf29
         hgb/qFRRmwTezIbzmhDXc1+wMb1XZmfMJcyAJF7XOkU9DPpRQ9hyL2e7bwQhlaOkJezq
         2kBh7Ear19Tf+Sn0ZgmFFrBwHzk8zYvnrvALPclUbzuy3U2fJopMykoaHzVLftrqe76a
         +t+imxMub2tWUCxa/m4k4rKFgWNks9kkwVdj98zoEHKMR8ob1j/5FrMc6DE/8uy5rwX8
         7pu611KJjpBC8MsNQC1vBb8ck54bCbzvexz99E8csjA8Y4Gn2nK/4iSgcjgWw+tJX2NY
         cUGA==
X-Gm-Message-State: ACgBeo3yVNxfnngwrTjHRJaB0w1rVik+Uk9yRen4RC7JFGOQhWpq+9FN
        Rn5m/6Quz0H/Sr7csbWDMRw0LSqkevWKWgGPsBaJ2g==
X-Google-Smtp-Source: AA6agR7AS8guzfQWCaB5iUTGxlD02rExzxmOMdaHtY7277E5gWoghjzg+64zoE48PMAx7P/AzSOgkPao4qsA9zpFyKQ=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr3777313ejc.440.1662587069099; Wed, 07
 Sep 2022 14:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204603.3762756-1-dmitry.torokhov@gmail.com> <20220906204603.3762756-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204603.3762756-3-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:44:18 +0200
Message-ID: <CACRpkdYrrN-nfCFsivK6sNFEVhXvXy_aZ71pX0Axa+D41NMYJA@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: i2c: s5c73m3: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 10:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I already converted this driver to gpiod:
https://lore.kernel.org/linux-media/20220830211927.398242-1-linus.walleij@linaro.org/

Already sent the patch twice too, I don't know what's up with media
patches not getting applied.

Yours,
Linus Walleij
