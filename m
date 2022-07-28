Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5195847C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiG1VeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiG1VeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:34:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3D7478C;
        Thu, 28 Jul 2022 14:34:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so3743799edj.2;
        Thu, 28 Jul 2022 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sfhAPvUqiK+ahJIK5HzVSgFOB2P6RbW6XTzzWiwiFLw=;
        b=fVyLD/jB/U3ZH4vlsOCCa7SAgidqs3WoGTs2yYuUbMkIx+VeSSE3CXlAWzZtkinn39
         3JEx1p8BvOWurmVpxPUVm7pV11IpReVju3Qoc4NSYRiDOPYc4BzsjBV4JgAF9aVBgjKO
         1MyfTkHU3WFl838onrI2rVHc8fh4ichxN0SFcJLvUwqrhXzyiAf7bzqWnQvAOEeO1CgQ
         hkTTwUinZ3ikQVPt8i+1RyrkF9lNT/ADOghFK7LbY37/RJIwFHe4XlLR2h9tuGtHX+JS
         QPVKqFi6g4A3ZaDnjz/IzGH0Rp7s5wEPsZEYz5082ADMizn24I/xOrGJ3s0iIkxJX+Iw
         PHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sfhAPvUqiK+ahJIK5HzVSgFOB2P6RbW6XTzzWiwiFLw=;
        b=4SBDYvSeYw1GWmOrRre0sE+n4OKQGxEeUE55JhOiutobZovsYEi/pSaW72AeyDbfnI
         0CMoFWH/h6nCiD5pBUpxifOjl9OLDFtFldS+fZbyzLsN4WlfnIkRUSoN5a8GVSHPHKVH
         92PsbXiyH4+H4RlrgkzAQ8YdzdmgqX//WHHUzrEA6fqako0xfLWe+nDl0f37lY+HnSSD
         e/E4o3mmBp7cI00ernfVfpjph9JklqBmUQ3SP52/dzVztUQtp6TqRJl9JYj6slZt91Vi
         PvhRbECSwLI4mHgBiwLLl5AolehfoDCDVnxFoFaaruvC7izaAfQZVYpMR4bIQZMBv9eh
         /lNg==
X-Gm-Message-State: AJIora89RKe85sYjrefSruM1iauCTYr8EotZUThFgwVLKMYqReZONf2Z
        kmdJ3NSv6gRZRFCtPH/mK6dClIitj2NSBKIRtJ8ay2dT
X-Google-Smtp-Source: AGRyM1tuZx5fIO0oLk+zmQvpGf/QKNyFnnQBG0ztolnolC6QnxIT+cJzJdQ1cWR9KNG1NlR0S3OUZVjiL7+QnJaD/3o=
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id
 h11-20020a056402280b00b0043b5d75fcfamr863417ede.114.1659044052761; Thu, 28
 Jul 2022 14:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220728155652.29516-1-henning.schild@siemens.com> <20220728155652.29516-2-henning.schild@siemens.com>
In-Reply-To: <20220728155652.29516-2-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 23:33:36 +0200
Message-ID: <CAHp75VcOHxJDBpnLrMQOWRED-WfJebRrYPtJZ35-8_B6wHAi1w@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 5:57 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> very similar to the ones from Fintek. In other subsystems they also
> share drivers and are called a family of drivers.
>
> For the GPIO subsystem the only difference is that the direction bit is
> reversed and that there is only one data bit per pin. On the SuperIO
> level the logical device is another one.

...

> +#define SIO_GPIO_ENABLE                0x30    /* GPIO enable */

I don't see how it's being utilized... (But okay, it might be good to
have as a hint for a reader who has no access to the documentation).

...

> +       if (sio->device == SIO_LD_GPIO_NUVOTON) {

Everywhere else you use `device == SIO_LD_GPIO_FINTEK`, perhaps here
for consistency? However, I would rather see a field that clearly
states that it's an inverted value. Then you can use

  if (sio->dir_inv)
    ...do something...

> +               if (dir & BIT(offset))
> +                       return GPIO_LINE_DIRECTION_IN;
> +
> +               return GPIO_LINE_DIRECTION_OUT;
> +       }
> +
> +       if (dir & BIT(offset))
>                 return GPIO_LINE_DIRECTION_OUT;
>
>         return GPIO_LINE_DIRECTION_IN;

-- 
With Best Regards,
Andy Shevchenko
