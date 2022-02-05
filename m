Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205724AAAD7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380868AbiBESX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiBESX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:23:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794CC061348;
        Sat,  5 Feb 2022 10:23:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id st12so4579080ejc.4;
        Sat, 05 Feb 2022 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hljRiwUaJx2liFaatlBcu9XFcu5/tSdIbOS8E9f9SGI=;
        b=m3DxUyXJ4COw4ctXg46SjnWBzhy9ruHWy3IU0xJw5i73uhbAgQtKXqr1M3nM+Ue9B9
         r0F+nqvCecE9j4qe5ym1utGedfl2WssmKCtl0qLOWVjPZB1titxt0XeEpWLSxshHsCpa
         3ux9lbn96pCStJY25KstP9Ab7jlOyEF8PPxE5ZVEXw6mlnm4iIKTse8WPKZbHg+UTRBo
         15VUQgtQ4JlYpKlHwrWbfX5iVei0Qk8zeW+Bm/ubdnGQETEU6zUAsor+fBIJw/GiUs6W
         yaYI8uCPqo1koAnQ6KYjyFTk+OPVYQ3SlPokg04cAH5YU95P3edSAwjO/zGP9h3Ez7HO
         wk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hljRiwUaJx2liFaatlBcu9XFcu5/tSdIbOS8E9f9SGI=;
        b=tg87tnKuZU9Ge30U1Vgf8rno1p+aE2bcMpmsRZjhdmH+j3b9yA9j77t8zVkmKt9vhn
         O3600oSeyZwBBFK8nv5OaamgyB5EayKFsAbWGmT1ad5H7R/FTrdQM+8Y69ElKbcKAXwr
         xnrIyqVg8EkgzlGCBoO/BJdphZMsdLtJNYIyHShqVPJ+ysGTYnq4Bz+o6me8MQD/2tZ5
         ZYy/HjCW6zvbHLEfx1tKFocu++DQ4qziXXL/0Uz8Ly2ItsUrqrnffAhD/sPGvpeyLQ0C
         AEShJmMg3X3PLayUys0d6oi58utBeGjjSjZyNCnbuKxDvjd+DGdGCiSV0I1Zptf8GjZc
         TGkg==
X-Gm-Message-State: AOAM532IFajV3l3nvkEHVsXyjbFwKRNUqFHChh9tw1+GYGf3XGphhVLl
        oYh+GS1XKK4y7Ap5HmWulmglqU3YSRqeKSuhmWgogjDOR/g=
X-Google-Smtp-Source: ABdhPJy/lJ3b38JmZK6y60u22QFoOwviNN2J4Xvpqrsr/7wLlXmuly0rLTFOWcJ+IcReW7di/+P1bIYfg64Q0WXd73s=
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr4056889ejc.77.1644085434229;
 Sat, 05 Feb 2022 10:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-7-liambeguin@gmail.com> <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
 <YfmJ3P1gYaEkVjlY@shaak> <20220205175404.451c5c56@jic23-huawei>
In-Reply-To: <20220205175404.451c5c56@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 5 Feb 2022 20:23:18 +0200
Message-ID: <CAHp75Vef4kYqQsd+4A=MQANhEQwvO7N53aB0ypPO-QwDuUZJ8w@mail.gmail.com>
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
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

On Sat, Feb 5, 2022 at 7:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 1 Feb 2022 14:28:28 -0500
> Liam Beguin <liambeguin@gmail.com> wrote:

...

> Not sure if it would help but maybe it's worth a local define
> of something like
>
> #define MULT9 1000000000LL
> to loose the association with any particular SI basis and
> just indicate it's a bit number being used to retain precision
> in some maths?  Would need a comment to stop people sending
> patches to replace it with GIGA though ;)
>
> My ultimate preference here is for whatever works for Peter and
> Liam as the people who are mostly likely to have to deal
> with any changes to this driver in the future.

SI multipliers are for values with the physical meaning. While Peter
found them confusing, it's a pretty much win in my opinion when we
talk about data from nature. For the pure mathematical scale it may be
confusing.

-- 
With Best Regards,
Andy Shevchenko
