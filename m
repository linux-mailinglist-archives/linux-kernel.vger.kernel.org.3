Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6A14AF5F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiBIQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiBIQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:03:04 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8995C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:03:05 -0800 (PST)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZCOl-1nmGTJ08sz-00VAKE; Wed, 09 Feb 2022 17:03:04 +0100
Received: by mail-wm1-f44.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso1934394wms.4;
        Wed, 09 Feb 2022 08:03:03 -0800 (PST)
X-Gm-Message-State: AOAM530akN/TDGCXa5H0nGdasan9Ro+71bb/LQDY1pnVcYUhawDwHwb9
        gq6rLjysbFb+UNGjvsAnhAHnYvcYyLQaK9OqEeg=
X-Google-Smtp-Source: ABdhPJxHAcHzTkMru4eEbqCHHWwDwZqYvTFbBt81TVOW87gLftYxW0tO+QQP3beMBCNrl8y6eFs1QMk5c63m/k04/W8=
X-Received: by 2002:a1c:f309:: with SMTP id q9mr3200865wmq.173.1644422583536;
 Wed, 09 Feb 2022 08:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20211218165258.16716-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211218165258.16716-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com>
 <042a2183-3f04-088c-1861-656de870337d@gmail.com> <CAK8P3a3owi7YWmq-tckD-C7NK5HaX+swGNW-QBkWQuQgVsVWrA@mail.gmail.com>
 <d74ab454-9337-d168-9b21-842569431b4a@gmail.com> <CAK8P3a20mwJXN4Mb063zQG+HAevj_Odpj58EzPHkX-p6pbtnGA@mail.gmail.com>
 <7c47ce67-88ee-9cba-3356-a530b0d3e657@gmail.com>
In-Reply-To: <7c47ce67-88ee-9cba-3356-a530b0d3e657@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Feb 2022 17:02:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0gf6TeK2vZ+u3NZ2VrrvrGUohAPz5WiZ4Mbk5QQg9FFg@mail.gmail.com>
Message-ID: <CAK8P3a0gf6TeK2vZ+u3NZ2VrrvrGUohAPz5WiZ4Mbk5QQg9FFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: sh_mobile: Use platform_get_irq_optional() to
 get the interrupt
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oOnrIzxPcdoamCYqgJO/oc+l7Sjc2zyhd85HLNkgXcpsHQkF/b5
 RQh6FcYRuouqCm/fB4eenwPLcJvQbZTwxqZyA2xQ23XoSWQfp5eMgeAT9BO9Y7fiL2itSCJ
 i8k1NyxUoTjzMc7H8usXDRkXVBOPXWi53tNF5LopqmentlqSKiOr6vVxu9DM6CUoOdqOAUI
 eSQQ0eg3GmWVBtrz5tLYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9HNKS2aIsc=:sf7z5ZBl7hPth9pwAT5VeT
 L9/Aq0bvqPBv6PUKl9OnsRFs1JNbUKfKCY8x88j5XLJITbSrC2nOM9zYxVHInzjj2BB6sHDfS
 So8+r37jxPhLAtUJp5oJ0oMbA/9007XIRZq6i9TWK9IPzZQOdq19hdF8vbBrnf5eUX0AzzIur
 Z7fK3iX/c3AY0Nt30rLthNQEELeHQL3FgzklpUlGRI6C5pEMzH2NYsW7LiJ206qM7VWPDKWBU
 J2UiVWzUxxdKM6QMEpOUnx8CqO7ilJE6NCP7Mf1cKL2PtH2HHsp4UTgLhT7OH8FkKlB83+Xlv
 HF6XR76NV8IaNDaMhfqyjltYmZYEz1ieeFHKmLlOYMtp0yGaC7+zyJwZrYX4rMbgYh0DMyTVk
 15muLCo/tUhx4Cs84i7s2z1mmIXjs7ydxiesxeYtZs4NPhQnqJBGF30ng6MBN1BabCMMDLTgV
 OiQDjF601PkNRBBTejnuSIrjOM5aVjtH/FZR/XeVQVq6xyYC77UzC3NwVs/JaZewl7dxXSUr0
 PG1R+JVwj7Ho2SVvNMRftyYdkEvpDKgai6PfoHOB3o2k1sLfmVw6vbMdd0zEvKcV8H0CBu2nl
 Ei4l8NUhUyoyAhtAdyqnVCstM5oNthrbkWH7QphbqMHtv5f8kTEl0Ig+bXEWN5leljhyN/FLe
 vzM9gkVEQyevgLsqG4UVwVXWMVl3B9VPuqEyaGklCBZ777Ki2Ka/L6wfdXEHgso9UcHZpW3lh
 Gr8e61uArRuPAKvD0Y23JSw93VVEULV5ZDQlFXVMiLSaXlBnBaq1ZPODp/GNE3kJjiqnSDr3l
 2xpPwtM7TP364g00qjHF9Tbj4sVXs5lNQ3wKUuX8/4l9wfCQ/4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:48 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 2/9/22 6:18 PM, Arnd Bergmann wrote:
> >>> since 2009 after 1e1030dccb10 ("sh: nmi_debug support."). On a
> >>
> >>    Mhm... this commit changes the SH3 code while SH778x are SH4A, no?
> >
> > This code is shared between both:
> >
> > arch/sh/kernel/cpu/sh4/Makefile:common-y        += $(addprefix
> > ../sh3/, entry.o ex.o)
>
>    Ah, quite convoluted! :-)
>    So you mean thet broke the delivery of EVT 0x200 when mucking with NMI?

Yes, exactly: If I read this right, the added code:

+       shlr2   r4
+       shlr    r4
+       mov     r4, r0          ! save vector->jmp table offset for later
+
+       shlr2   r4              ! vector to IRQ# conversion
+       add     #-0x10, r4
+
+       cmp/pz  r4              ! is it a valid IRQ?
+       bt      10f

gets the vector (0x200 for this device), shifts it five bits to 0x10,
and subtracts 0x10,
then branches to do_IRQ if the interrupt number is non-zero, otherwise it goes
through the exception_handling_table.

         Arnd
