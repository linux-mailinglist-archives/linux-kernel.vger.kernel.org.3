Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77944D879B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbiCNPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiCNPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:01:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0D42EE0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:00:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so34020315ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8ChMeHs1gmArfnucgpkriuVOR26Jb1zf4qNR9jue60=;
        b=Xd/JQTW04jQNywrqYP3ucQ6KfNXrwza1nGJ6jTukKmXJ1Cn3i0sAVWlZKb/0+Z7Njj
         xFAWrE0ddX7bb/jhdWrcXzXTM3rfFXX+PybSmlM0ln4gv9ayJdHT9DMJZzUrHBzMrXo5
         pM2RfaF+i6hlfsRSYOTGUjcBJLnPvOsjYJKsQU4q8LJjJSwacytbJ3BMl0GmozKz3oMC
         rbDak6pg0eeqkhU9v9Ey5kpE8kR6xbM6y8DlL3qPeBsLT3YUdbGYEFKjXWiZ22T0n6Pi
         LxPg92IuvA+6KUvn3ZO5vt46SR2UErahQBKvNLsg/OE+UCZBD9otRkfNlJjyWrfE3v3f
         uZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8ChMeHs1gmArfnucgpkriuVOR26Jb1zf4qNR9jue60=;
        b=gfuJLrAGLTaiBSAc9pz5/yt+BMQ6mbjfMIKE0OYR4GPkpEICANminipMwSSMkq2n2L
         U1YL4tuuHrPSKJEMwJNEwqd8RRKgnhRU8FA4hK+b/72OgA3TygDGNIcj+pRqjMdZ06MN
         eiI95GVrYL6A4me4ofTJeTWqj5FPn62vAaEwzWszCmr0uZ1woWiz88vzMwHCa1AUO+55
         jh/7hvqsy3p3lGuDnhWcx/OiMhOD/kKfqoP29+xJb0hVBZsrXrYG622ALy4k3QOUP5Bt
         XwudxAxzibVgtvp5avwhf/W+VP+3xRWSWn9N9skb+Ym+zQfxDVLUK5xDplumY40SGZwB
         Wt8w==
X-Gm-Message-State: AOAM530mMuaeK7cHa8H3LAa7aKSwJkVbTzQtvjOB90dyfWdTfjNyQSpc
        C5QdFqEjzxLPRY4ZDRCO0WQOCGUqemNVA9QBGHA6ozEXGtA9PA==
X-Google-Smtp-Source: ABdhPJwdFe0t2HsEEZcogZOm9gFXReWaBWaHDIAOvvNYYjPfz0IM/StIEZscbYv3gVHaGZSMQOCbu2/0KiWRTaeM3u4=
X-Received: by 2002:a17:906:6a24:b0:6db:ad7b:9066 with SMTP id
 qw36-20020a1709066a2400b006dbad7b9066mr12474492ejc.697.1647270028467; Mon, 14
 Mar 2022 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
In-Reply-To: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Mar 2022 16:00:17 +0100
Message-ID: <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:09 AM Brian Norris <briannorris@chromium.org> wrote:
>
> CONFIG_DEBUG_GPIO has existed since the introduction of gpiolib, but its
> Kconfig description and motivation seem to have been off-base for quite
> some time.
>
> Description: it says nothing about enabling extra printk()s. But -DDEBUG
> does just that; it turns on every dev_dbg()/pr_debug() that would
> otherwise be silent.
>
> Purpose: might_sleep() and WARN_ON() should have very low overhead, and
> anyway, there's a separate CONFIG_DEBUG_ATOMIC_SLEEP for the
> might_sleep() overhead.
>
> Additionally, the conflated purpose (extra debug checks, and extra
> printing) makes for a mixed bag for users. In particular, some drivers
> can be extra-spammy with -DDEBUG -- e.g., with the Rockchip GPIO driver
> getting moved out of drivers/pinctrl/ in commit 936ee2675eee
> ("gpio/rockchip: add driver for rockchip gpio"), now some dev_dbg()
> calls are enabled in its IRQ handler.
>
> Altogether, it seems like CONFIG_DEBUG_GPIO isn't serving any good
> purpose and should just be removed. It can be supplanted by dynamic
> debug (which post-dates gpiolib) and atomic-debug facilities.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>

I like it. It's true we don't see many of those DEBUG constructs
anymore nowadays and overhead for might_sleep() and WARN_ON() is
negligible.

Applied, thanks!

Bart
