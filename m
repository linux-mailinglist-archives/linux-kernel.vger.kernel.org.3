Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6C56BDEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiGHPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiGHPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:14:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9230F46;
        Fri,  8 Jul 2022 08:14:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p129so8549625yba.7;
        Fri, 08 Jul 2022 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0qR0/WRFp+dSGfUNqNNESrvV3EATxxD7VgxKv3r2KA=;
        b=CqgxYBea7Xw8XvBT6EpataJvt/NaLXh1Uxm9wsKrINnwqJX3Gbz56Df6QnJgWZbcaU
         dTzBYOavgJ8q6MdQf4bgCfsZhy24Y2CjLnWKjfhmXuSpl+gfbDPsrVLGTCijWOvI7VVW
         OuRlwZmYd0mN37Dzrf3Kner0I7hXKzgLj4G9okLcUbchcICzwsWM3QtqTsE6v4vKw/ZE
         liT8laDllBnSuA2LSkq0IxnT7ar0xNj4TBgCD/AScz536LD+AYFqmnqf80O9HrQV0F8o
         VrURbpzS8hamWc6dvmqn/vydN0p+9cbeKAvvSu/x9u3YD1nyNc8NZKDzTjD/l2nJc27n
         7CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0qR0/WRFp+dSGfUNqNNESrvV3EATxxD7VgxKv3r2KA=;
        b=p0aCCWO2uASzVIzpRCrCcaw7JYlq8EymExqdMIpFwa780EQqez/AaTWqbviOJRqluR
         jYdw4WXT/jMCeMv3uSr3UheuFxO2tT18BvILmMKwqOrRA31ulnTWutkicw4smgkj0e1T
         AktS03DEf5zqU6IhQQ0CBdIOdJzjww4kWM4408cmVNypV6Fd/3iRQDvuPxVa24cpbt5f
         XB6HBG//BeGJOw0nub0Ze/zZT5zZsPR769OU0Hr7yHRnkmueIlFY8/94YFa9BD8xsWsS
         daa7aSp5XGQzEIXoCIgd8bGz/8fa6LRoBKg3ysgCg72N7ESqyIqV1NfXlV3bUWehwFb3
         NC1A==
X-Gm-Message-State: AJIora/UxcgdXlTsq84IwMuo62K/BIxiQXksas+7juv8TWkqeNbBGl7v
        /t4dy+g3VBXjhgRoPG4eCTIbSLaFBO5gvqontKY=
X-Google-Smtp-Source: AGRyM1saoM2+5oEj3fiXHKMiUuO+fy8OeA39Dff92b/anSd471hPJoxxEr02uRCnKwb+GctLJrfZr3s8YDh6Nob616I=
X-Received: by 2002:a05:6902:154c:b0:66e:8254:146e with SMTP id
 r12-20020a056902154c00b0066e8254146emr4447945ybu.570.1657293251579; Fri, 08
 Jul 2022 08:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <585795d19c13a7136bc4b61307114591af2aea69.1657279521.git.viresh.kumar@linaro.org>
 <CAMRc=MdHAZ=OE+jjxx5BV_4Z2L4g0WmEVaiyifN+nu2JnMx82g@mail.gmail.com>
In-Reply-To: <CAMRc=MdHAZ=OE+jjxx5BV_4Z2L4g0WmEVaiyifN+nu2JnMx82g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:13:34 +0200
Message-ID: <CAHp75VdWe_EaJB3Bqz13rb362uDBTJAGaVh7Sjeq874tm=wrgA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Don't access uninitialized descriptor
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Fri, Jul 8, 2022 at 3:32 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Fri, Jul 8, 2022 at 1:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

...

> Kent beat you to it with commit c8e27a4a5136e7230f9e4ffcf132705bf56864cc.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c8e27a4a5136e7230f9e4ffcf132705bf56864cc
Notice: this object is not reachable from any branch.

Rebased?

-- 
With Best Regards,
Andy Shevchenko
