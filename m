Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180B5A7A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHaJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiHaJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:31:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF06C6FF4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:31:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lx1so27110239ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mTMJgxNUn3NdL2Te+hOt7Np5Z6vrIBnPT95qbu1ijYo=;
        b=z3JWHYIEKt1HnNwSz7g2jiDwM7uqhF3iqPTxL23i2Z/5BSDL75qHHMgDA9viIprqHf
         kTQy0DiTPJI6k36aeUKIs9Gz22Q7CCKMCLRHUTKEdtzA4p1A7ViQuHlQPerO6xE7ZARL
         pYQYPJOOuFtFmp0Lm2cn8WE9RMA0bqD/XgVpj0sa/g5itUZoaI4ln99bwcFDKCk2PKpH
         4cNpt3T1uNlC4iwXS+fO87q8yKpMPu8yPGXTo3rEpyHyzc2eh2dof91JZkBJr9P6rkUR
         T3sd8wAmR/ugyXz/4lwOGUiMr5v+nWKBjK2Cw8XJIP7tMrunvUr3IWn90MtjwmNRey1A
         HANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mTMJgxNUn3NdL2Te+hOt7Np5Z6vrIBnPT95qbu1ijYo=;
        b=una9yRkEB6NhWYbfnkiGUy/hU3kT9kAnpwwXhKwi4D/xzonZrGHKYL++cxQJVZfWWf
         qA6ve2JSbF0dBLQnhQDxNfw0xB9CRX4/GTZytOa/K7T5LufKL8McXg+McER6LAkYA1uk
         q4qiLw1qyb7Gr8yii0ZZ6/oeouj3hKU7yDa+gJ9XCklTADS1Wsy9p8SvKMYo0WOfdFNh
         3RTO5hqCQrPbvyYleqAoEm+CkahQN0II0qieGIMQd/2N0Eb3BHbogp8h0RKuadIh+C9L
         pbQPnAIur+16dsBuInrIvvSoNGzk0ayYk7EePyuiaEkbXphAA2+aMTndzcYAkkqZtl0j
         /8wQ==
X-Gm-Message-State: ACgBeo2w5LTfsX3Krqofkvn6kfD655+C13ZHIlgYJS6qnPD+oWTK1FCw
        b2C9wJ13LVLzVSDyDj185BhiDKZQP0CLULNAj5lxaQ==
X-Google-Smtp-Source: AA6agR60poVSGtXV5i87R9W5U/zvb+IbanL3O5vxUgelECuvxfH2YElvH/FP63zo5xJofgcng1oFmxEAl5kN685SJYI=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr19921832ejc.440.1661938265272; Wed, 31
 Aug 2022 02:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 11:30:53 +0200
Message-ID: <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com>
Subject: Re: [PATCH] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 27, 2022 at 11:32 PM Alexander A Sverdlin
<alexander.sverdlin@nokia.com> wrote:

> -       create_mapping((void *)MODULES_VADDR, (void *)(PKMAP_BASE + PMD_SIZE));
> +       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) && IS_ENABLED(CONFIG_MODULES))
> +               create_mapping((void *)MODULES_VADDR, (void *)(MODULES_END));

So the way I understand it is that modules are first and foremost loaded into
the area MODULES_VADDR .. MODULES_END, and then after that is out,
they get loaded into VMALLOC. See arch/arm/kernel/module.c, module_alloc().

If you do this, how are the addresses between MODULES_VADDR..MODULES_END
shadowed when using CONFIG_KASAN_VMALLOC?

> +       create_mapping((void *)PKMAP_BASE, (void *)(PKMAP_BASE + PMD_SIZE));

(Splitting this in two steps if probably good in any case.)

Pls keep me on CC for Kasan ARM patches, thanks! (Maybe I should add some
MAINTAINERS blurb.)

Yours,
Linus Walleij
