Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1E4D4C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiCJO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347930AbiCJOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:51:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8B193;
        Thu, 10 Mar 2022 06:49:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so12584076ejc.1;
        Thu, 10 Mar 2022 06:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNVjl9qTHjv9OQ7hbwu1GBKuQO2O5pzbolI+xiOegY8=;
        b=Txj7jN686DsD59G5Y+3M7504nOagG4PHsHO0Cf2XKJjpZvcCR/bM8ND4Y63//Gikr6
         +JWKW3947FN1SzpZIipH9CmaM9BYShZHnbxbTS71KQUlLFggltHn4JhyY1xcKcTCOgAQ
         pdSIFWIFs7nkHkaio4ti8ERhv/RDOETYJ5uK+WO0miVAUK4ry16es6SOYRwFIj1h3RlK
         StUfVNDNge0cgtxyax/JYkKjKuicB1FEtaaQldnfIKxNQkOh3G381fXnM/TiXB39qH0T
         xaa6kkJnoxk0okcWmIsvZN1SUTWIyVU4BOYWfaEHnTScEOTXSsYkEo6jJLOp5tYNnFhk
         IKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNVjl9qTHjv9OQ7hbwu1GBKuQO2O5pzbolI+xiOegY8=;
        b=WSvN4MPF0lRFMH3YHIPVgZzHcWD33YkTH7LXuYz92zcMarUwmUTG/QcJS/ZXhWi79F
         6g2uf90eFDOOsr1k5Q4+Do3ZqHtKGMhPw2iKkWtR2dWtael4uIwsYrSHKJ9FN42/Kgpn
         qCukBiKA7dVeEI6GaqCQVY73KHcgkjciU/+SI+ZtEA0iYdhFjdcGTs3FjF0HWS/cbiAF
         lDXMGxKDAL6wWdgOjk/k3DX/yITwnuChfk81P3SQ6ytlb5UN0VCQ6V48A0jbg0+UYVIh
         1WvMF59e0oPPdGhBciFdR82/DWbLHX3eIby8xVE93b8CiAm/0DGTdkO2r8fkGP0g3ydC
         +QIg==
X-Gm-Message-State: AOAM5318qezp16CQN6NLxVWAYJTBaxHmhgAt9B6PjBFzrSojb4/CSjsl
        9zfKxzvRkFCZ3WEwlBQV6JtPIT7t1lQxyI8ChYncdpPDuzY=
X-Google-Smtp-Source: ABdhPJzoyHI+zS/vaRnHv+51EqVDRvenxlXuJ6/WLn8emPWQLYy8fZ0gYt6TEeXGA3BmERWuOOwbiZUuBMcqeTsRGlM=
X-Received: by 2002:a17:907:7243:b0:6db:7521:afc7 with SMTP id
 ds3-20020a170907724300b006db7521afc7mr4752051ejc.44.1646923778317; Thu, 10
 Mar 2022 06:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20220310011617.29660-1-kris@embeddedTS.com> <20220310011617.29660-2-kris@embeddedTS.com>
In-Reply-To: <20220310011617.29660-2-kris@embeddedTS.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Mar 2022 16:48:22 +0200
Message-ID: <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
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

On Thu, Mar 10, 2022 at 2:22 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> From: Mark Featherston <mark@embeddedTS.com>

Same comments as per v2.


-- 
With Best Regards,
Andy Shevchenko
