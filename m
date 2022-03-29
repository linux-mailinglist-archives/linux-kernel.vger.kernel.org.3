Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2BE4EAC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiC2Lso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiC2Lsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:48:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A12498B3;
        Tue, 29 Mar 2022 04:46:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o10so34601238ejd.1;
        Tue, 29 Mar 2022 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRngf1q0EFM6rom/iKOZPRpCu2Uxx4RUodzTRd2XqH0=;
        b=WgNXgj6IODvZ0ruJkrZOu+JdIy1hw9TvcQv7A0RD8viHok4sFD+oGv6YD2cLd9wTmv
         Slicxb43u88ALlG9StdQ+0TV3HaowS/WOqSeYhPIYZsmuOOcdwm8R8c2M7oFoZXYuOMm
         ETrWnKFxzhvIliJhki7fOxBBrbZrt4fh8P9wh4ac1vkuAq3UiwQD2fCBoukFKuwZx0i9
         ulv88Y82xNQt6QL0kcUFvHqblGmPm7yW8xUqYrPY8Z9Xx/HzbcfQPdp6gzUbvj7fMkdP
         WKS6rIXGFoI48A2iZGPcekAByOTVykYDiOz5z/rFPqzcTj9Akd3v5S+FZbv3u5W97pS+
         rCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRngf1q0EFM6rom/iKOZPRpCu2Uxx4RUodzTRd2XqH0=;
        b=28cCL9jVnJoiAHsa71XIjs+BRBpE8r6bgW8sO16FJCqEidP/H8Agl1jArULHb1X+Qn
         sAVz7MycV0W7AMzm/5pZFvl5o0HSjttqJvP/EpvNIbp/x5KUGAODRyMKAUcBGZOG2C2X
         EFZcNzRGg6tBT4OFmJ8W60NlhdmLesgxMg96lP6zL16kk2tepS0MYwyr/hnwDxbxBaJy
         f2W936Uhx08huLWOrJ9hM925mOXkWXj/zn8uz7XAhlfTiJlERDVAJGIpYO527XVHcU2v
         Yu21DKTKEL+JqbOUzS/LE9/ye00Kyon7rDSq1VF0r4USMlUMuzqrgNv+x1jpSUJq0Syo
         /Gfg==
X-Gm-Message-State: AOAM531HTElBk3Ix8wN6V65tGOH9TdnUYxKcmNqeFzmkUV0etMcOokKk
        qw9V9p4yg9NVJZMV+Fda47loRhM/NtH5mxI0k50=
X-Google-Smtp-Source: ABdhPJx/6reFSq090fKogP1Ks4j6J7VZmEyzGgY7WdOuKDaet1Sb3sUw3Z0pqfqiUFERLgss+aj1ra+CFGiWqYNdTtA=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr33912764ejc.132.1648554417310; Tue, 29
 Mar 2022 04:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
In-Reply-To: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Mar 2022 14:45:50 +0300
Message-ID: <CAHp75VdwLPkzE9AHkXg=+vsagh4SGam40vz8uRdSRUpr6Cyv7A@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: ralink: rt2880: Check for return value of devm_kcalloc()
To:     QintaoShen <unSimple1993@163.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Yan <yanaijie@huawei.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
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

On Tue, Mar 29, 2022 at 11:36 AM QintaoShen <unSimple1993@163.com> wrote:
>
> The memory allocation function devm_kcalloc() may return NULL pointer,

may --> might

> so it is better to add a check for 'p->func[i]->pins' to avoid possible
> NULL pointer dereference.

...

> @@ -266,6 +266,10 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
>                                                 p->func[i]->pin_count,
>                                                 sizeof(int),
>                                                 GFP_KERNEL);

> +

Stray change. Also it seems it has trailing space character(s).

> +        if (!p->func[i]->pins)

> +            continue;

Why is 'continue' the proper choice here? No clarification is given in
the commit message.

>                 for (j = 0; j < p->func[i]->pin_count; j++)
>                         p->func[i]->pins[j] = p->func[i]->pin_first + j;

-- 
With Best Regards,
Andy Shevchenko
