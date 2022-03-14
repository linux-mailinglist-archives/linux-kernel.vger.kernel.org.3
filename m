Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEA4D8F98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbiCNWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245643AbiCNWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:36:23 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905C3207B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:35:12 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so22273963ooj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmDLKBrRipGnc7l3tDB+5DfeG4oY5ivAq5+t1BERDT0=;
        b=L3qOmjWQ1MWVtgiZMAiP3nZ2hTnJAmm2jnoq0xYkNh5MapEGfF3GFG64HSjRwbgIHb
         TYvNa3SGykb76Jk/YwioYxw9nq3lYO3tS/V950JAHkbFzcJHp+opL6VI4PKZlyTjcszW
         /VKjv6ZOc6XQKS31KzRYN1cIwNkwQVLpsaaYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmDLKBrRipGnc7l3tDB+5DfeG4oY5ivAq5+t1BERDT0=;
        b=1GKal7X5ndPNsQ0sHU/Q6CWGqG+TVP6A/IGl/qlgLijpV7Mcu2viS8JWfkgT9KqaSd
         fdVafrT2baw6EJ47umRkI2FDALg0gWIf/MOHt9uhkc3VdZjkMUvrsf539dOExjxwQL8e
         23TiQ6JBKLTEQDik41JY/7CVltAspa+/vF5Hlc5flicIHBwShrky6N5Ee090A1Z8m6Ps
         aTh75n72ave5yHVZ4P/jS15Mypq68cYX2x6tftHygl2hyXVid7UnOY6k8KXAgigeaS7G
         zgAvawnXZTc3ab3/1519WELMPyiaGNzLRyU9crMVpciOu6nMfpkZF1dxMFwi/MPgxBKL
         Xx0A==
X-Gm-Message-State: AOAM5313yjswCNBrBVPsyJfAIqQSfmC6ebsaIWfI8nxlxCxggCLP6Y9H
        ZDUUYDd2aOZ15OPY9murr897AJ4N56ivOA==
X-Google-Smtp-Source: ABdhPJyYZbKZMHMhLGp+jn2daSqT8tvefAhwmsBYTVa7AhnWWfec/pRznOjGuvboaCVeIPN0rJwL7w==
X-Received: by 2002:a05:6870:e989:b0:da:c099:7939 with SMTP id r9-20020a056870e98900b000dac0997939mr532085oao.206.1647297311783;
        Mon, 14 Mar 2022 15:35:11 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id bb15-20020a056820160f00b0032404d7a88esm4856885oob.27.2022.03.14.15.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 15:35:11 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so4374436oou.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:35:10 -0700 (PDT)
X-Received: by 2002:a05:6870:f104:b0:da:b3f:2b62 with SMTP id
 k4-20020a056870f10400b000da0b3f2b62mr459367oac.257.1647297310247; Mon, 14 Mar
 2022 15:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com> <CACRpkdb-W10YAQff_dTUL7B-DH01Z9nn7cE71Zv5xjALtDGQ1g@mail.gmail.com>
In-Reply-To: <CACRpkdb-W10YAQff_dTUL7B-DH01Z9nn7cE71Zv5xjALtDGQ1g@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 14 Mar 2022 15:34:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOOzECbCBoehKjmFjLTtsssk9AH1NabA=FSRvoVWp8KMQ@mail.gmail.com>
Message-ID: <CA+ASDXOOzECbCBoehKjmFjLTtsssk9AH1NabA=FSRvoVWp8KMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 3:23 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Mar 14, 2022 at 4:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > I like it. It's true we don't see many of those DEBUG constructs
> > anymore nowadays and overhead for might_sleep() and WARN_ON() is
> > negligible.
>
> I agree.  I have something similar for pinctrl, maybe that needs to
> go too.

Huh, yeah, CONFIG_DEBUG_PINCTRL does look awfully similar, and I just
didn't notice because we don't happen to have it enabled for Chromium
kernels. We happen to have CONFIG_DEBUG_GPIO enabled though, and the
"new" rockchip-gpio log messages triggered me :)

I guess one difference is that CONFIG_DEBUG_PINCTRL is almost
exclusively (aside from some renesas drivers?) about extra logging and
less about interesting checks that one might want to enable in more
general settings. So it's a clearer call to make that people generally
want it disabled.

In other words, a -DDEBUG construct in itself isn't necessarily
terrible (even if it's a little redundant with dynamic debug?), if
it's not conflated with stuff that might be more generally useful.

Regards,
Brian
