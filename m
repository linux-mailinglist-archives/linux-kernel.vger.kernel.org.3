Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7153A9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355266AbiFAP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355408AbiFAP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:27:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1B266D;
        Wed,  1 Jun 2022 08:27:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n28so2675414edb.9;
        Wed, 01 Jun 2022 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL417cTm0c/3LvzBZMQF8QXVZcM9AZ2saBEadjHJh1c=;
        b=OClPeNNiHILAN/kba/wRU9fcAzcq61UzRxTdmqUBukIIOsd3DawrjjR9uIOQaSb7ll
         b1IM6+XVS8Qn05lGJ+Ht0Y+gqp/EwGpmVgb2CoDRbMpb+5cl4mub3QlLVwLbGS4SJCp2
         pcaIX3KesnTlIADPhIBA7wb9MWrCdI3rUJxnuf4gpsucsdU1h/Dqdf0W+TnGc1c2Lwlc
         JBF8kxYrnecRSeFhAn585qYTUwIUbdBBcbxnTZr7KjYnYEEpIVwHej1ZGIJ0X6G83tJq
         rHf5ADB20wCj/QbxWruCeWsuIGkNWv2zjmOVTDXdYt++GYcoV0BpDYCGFk49LpQfc1q5
         5ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL417cTm0c/3LvzBZMQF8QXVZcM9AZ2saBEadjHJh1c=;
        b=xi2M4XAIZjSsDsZbV5logChLddU6THHAIwmEcqshNdWA7kQgzclUI+adgRWH1ZiLW0
         8O9JVb6kCM3c3fNF7I8OxYVdHYl5bqtjhzeETV5ASq4rhC9A9eBSaYoI40SdlOqBtV46
         k6mFZVAYDdi6l/0iYvXl69J06pkoOff2QfbktpbzVol/9ne7engVSjJw/vOx5X42/Ncu
         xyqRwfZ4NfQBKs1hw3gjJI5kYHIKiwMDK2f0z2fOF2wfNEN1Y+dMDenDYzC8DAsH/xoS
         +3vXY4rfsbRjgXcPW6GSed8+EqVLmnWbrPhy5G9obJv/0W9ak+kMpiJ3+q5D2gT0Hu12
         czRw==
X-Gm-Message-State: AOAM531Hgr8nUOUyCpcZoLgluSL0zq095E1oEIbo/pJeIV9HfrOwTeOk
        sl65Dbl07nJahemP1Wob7ZDPoj6yE0dtGJav/g0=
X-Google-Smtp-Source: ABdhPJyHE8SKqKTms0IMlkl93/WJiZp+ecoqzUAwGHjNTUU2ljewX3CxWL10MK+FvugIRNCspLleTIOp0Q4q9T2kLo0=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr285755edq.54.1654097225973; Wed, 01 Jun
 2022 08:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220530082552.46113-1-sander@svanheule.net>
In-Reply-To: <20220530082552.46113-1-sander@svanheule.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 17:26:29 +0200
Message-ID: <CAHp75Vd_Z9MrqTzGKL+U1dCus3U09P3AeTBGx0J3LY56jHTDjQ@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: realtek-otto: always honor empty CPU masks
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        Robert Marko <robimarko@gmail.com>
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

On Mon, May 30, 2022 at 3:57 PM Sander Vanheule <sander@svanheule.net> wrote:
>
> On uniprocessor builds, for_each_cpu(cpu, mask) will assume 'mask'
> always contains exactly one CPU, and ignore the actual mask contents.
> This causes the loop to run, even when it shouldn't on an empty mask,
> and tries to access an uninitialised pointer.

It's too noisy traceback, I believe you may squeeze it out and leave
something like ~5-6 lines only.

...

> This patch is more of a work-around than a real fix, and ensures the
> driver runs properly on uniprocessor builds. My tests were done using an
> SMP-enabled build on a single-core system, which is why is missed this
> erroneous behaviour.
>
> The real fix would be a modification of include/linux/cpumask.h, which
> may take longer to finalise, but I would rather have the issue in this
> driver fixed in the 5.19 release.

Hmm... I dunno that cpumask fix should be hard or easy, but I think
you may try it simultaneously, so we will win one way or the other.

-- 
With Best Regards,
Andy Shevchenko
