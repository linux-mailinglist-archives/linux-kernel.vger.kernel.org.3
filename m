Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295EC4E41D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiCVOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCVOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:42:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E78930C;
        Tue, 22 Mar 2022 07:41:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x34so20762162ede.8;
        Tue, 22 Mar 2022 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzyTaasiO8jKwxHbdxBCj4qwgrblVvgvVf/SVRqTgd0=;
        b=ekdWaU3QDKePVgnBed2hzRqhGz5Qeu/183EdI12go49UJyJ1bFqc57tT9tW5TaDytI
         3s82S4vVZoTzakk/CpjzL4O75/EzxiAWdzEwMiWgf2Lta4QhLu0Lsl0j3znXGlkTOIaf
         srM79z7DK/H/SNs2gRUYhVno/Gvozxqee6t0KB99t3/7+V8GPQKq8/jwpq9aaATb7Jjl
         ZokV6pTht5oV3wdv07eko4EOO2yhKue98E8Xfh3eQVki0CcUj1/rESZmGMC5Ny4dsbRk
         oASc4jJIhraUepd+cQpasQWk+8w/EqIgDIuvgIpZIe1EQhb70HABDGOk3J4pOOPX1zu4
         Eelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzyTaasiO8jKwxHbdxBCj4qwgrblVvgvVf/SVRqTgd0=;
        b=WneydY55qWXO2Bj06IhFHOJsKfPlBhBOhXhN+EHXn7A6gPov3NsTO+NlpPKGbG1LTM
         ZcsdpHDq/cgYBunBzBGekbRHgJY46AQ+PmIPmC8KISoxSytRkjP4hJHmM4JQ7F17Jfti
         gNTX0icOnQGshDJ8k9DTrillPzwDpetj8QSnvMJ/mLcDRBJ9Ailylj10uNJwmdLTonGv
         /WXVl+UJFmGXMOaLUfsIl7Dhk7mMh+00u3MOKhbyRbt8MIrxKo+dj1qIWRaG06nNtP1L
         SoT/2fes3O4afU8XVHg1t75eI+rXob+QFDBvJmA39ILPzXbmcj6QVf3gW8A15UIbNqLp
         9pMA==
X-Gm-Message-State: AOAM533rJUpK0Dr5HTkr7hC300pl2/gDGv8HP4oCUcWDdJiCx3LYPtii
        Lw5x8axWUOLAM/f5SA0tlZBcCyoMzazCYXAjdSM=
X-Google-Smtp-Source: ABdhPJzdAIkFASoexhx9ghd9uoqOIfZ4rY1nnGow0Ezbv59oe8/Dpew/t5rSUL6LsutpjDZX15IsCS0wdmCoxBamQiw=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr28858146edu.29.1647960067499; Tue, 22
 Mar 2022 07:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
In-Reply-To: <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:39:57 +0200
Message-ID: <CAHp75Vf8ktdCYTAULz2j-3CPON75707TpwV0FDL36V_GQ4Ttgw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 6:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Fri, Mar 11, 2022 at 12:09 AM Brian Norris <briannorris@chromium.org> wrote:

> I like it. It's true we don't see many of those DEBUG constructs
> anymore nowadays and overhead for might_sleep() and WARN_ON() is
> negligible.

I don't like the part about removing -DDEBUG at all.

> Applied, thanks!

Shall I send a partial revert?

-- 
With Best Regards,
Andy Shevchenko
