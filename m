Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589C24CFDEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiCGMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCGMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:16:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290F7F6C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:15:58 -0800 (PST)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEFnP-1nGyzo1WRZ-00AD3o for <linux-kernel@vger.kernel.org>; Mon, 07 Mar
 2022 13:15:57 +0100
Received: by mail-wr1-f49.google.com with SMTP id j17so23015229wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:15:57 -0800 (PST)
X-Gm-Message-State: AOAM533d7G2hr0e29uMTux1Z91h14yGRxU9qE9e7IsLtXos6T7OEvcsw
        RkHU6k6XWSVi6MQwwSa3tNQQ5sE5O1lE4Ed4xps=
X-Google-Smtp-Source: ABdhPJzNbCW5MCgkAEc6w/6rfhakKXY2iokn4ld+TrSCnF0MZ5rMVpS6zuPqmGXxamU+wmw9I/jafDo9KFHWltyWkzQ=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr8504005wrh.407.1646655356966; Mon, 07
 Mar 2022 04:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com> <20220307105810.1747024-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220307105810.1747024-1-alexandr.lobakin@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 13:15:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
Message-ID: <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:s6FhnVSjMfCR5LY1hgq/PM1SP9EEH/EC8vHPsFUzg3jfVOQS9UY
 ZZa7cOm4F+d0UBUdnSE/0iD7j23rORaGmkrZzpvEld4lwD2oMN+8ihIpxXVNBjqwB0ls51s
 9aFJkI87hJjpA+qejnabOIwZVJaN+JN7q2/OfZ9mMpRETjKafRSYh+7vHfPknZ5LOsAwaff
 b+eScCEdgwFJJGOwyVSAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7XKEH2FvJY=:DePrBHXQ8zafj7WAME18xR
 8sHcHAwaLaaPIOky1AppLHo2ZitX2cAQSVFaftaYz+tM+NgcKJ+0iLaV/v5cD3NGeR5Un8iRH
 1r0VYghsSWsZIaTtSYf7mwWpafPLuW7Cz6UXcXv0pqPySbhuE6BrB+DjOAFogUJibcJR1jIp6
 9c71LWsw2gDOjC45xCxgqz8fTsWdBbEP8DwntZoR5kuI7DYqfZmXsrUl7ABdMRY+y1EMtKdeq
 tOJxceWZpNomYaXeweyc8RBsGQmErSFzJQziz65Embw55LyShyP+PCBGetC9PBPxcWrBfL0LY
 Lp48hni4X4hoqPiEGZTFNvwWcdNo9rRnmwo/iS/bgHMA+h3ds0bKiYTt7ihV/vnclIll6xwjW
 ekz3KyDs3V8cMqevd0urabK4s/0rYgJ+U8OT+fbrej8g9vTHL6TypIDBx039Am+Pp9BWMeBxm
 Mso4FAd3gpVupKvnnWQvYh1O5CjGDaB/DHSDlcIaJTHHoTzwglQI85BiKBLjWtg9b106sBWHs
 /yyRBkgCCibvM9eh8sCGR2YDmSw/Cdi9RiMSBWoNKJxuHv4WMXQUkM3tustuSFius8SAk885B
 juhws2nIF+122SYopS7C+9Sa3/HV+IHtGMWHzSKEV0jBQ6pArAOJZrGv+yBMn2k9W6sX8Ybhw
 /DUl1edfxM1ajTyM4sBZWdEDWjHQdvFcj0xjIMqheg/IN9rLb3aoWnkkHVMFZeEqeMVP7R07p
 b6ewOTtRBdak5FVBOWvb6lmZXy4Zwqp82BVy1Ce2JxC48ZeXxhlAgOAcoQyIIKjuNOHI9+7ib
 IvQUNTFieFwWz4WozJctK6t2Dz58pWqgt1+en3VtVBXLrGyMl0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 11:58 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Have you fixed W=1 warnings?
> > Without fixing W=1 (which makes much more sense, when used with
> > WERROR=y && COMPILE_TEST=y) this has no value.
>
> How is this connected?
> When I do `make W=2 path/to/my/code`, I want to see the actual code
> problems, not something that comes from the include files.
> When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
> actual new warnings, not something coming from the includes.
> It's much easier to overlook or miss some real warnings when the
> stderr is being flooded by the warnings from the include files.
> I'm aware there are some scripts to compare before/after, but I
> don't want to use them just because "this has to value".
> I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
> because then I'm not able to spot the actual shadow or type limit
> problems in my/new code.
> I fixed several `-Wshadow` warnings previously in the include files
> related to networking, and *nobody* said "this has no value" or
> NAKed it. And `-Wshadow` has always been in W=2.

I agree: if we decide that W=2 warnings are completely useless, we should
either remove the option to build a W=2 kernel or remove some of the warning
flags that go into it. My feeling is that both W=2 in general, and the
Wtype-limits have some value, and that reducing the number of W=2 by
30% as this patch does is a useful goal by itself.

A different question is whether this particular patch is the best
workaround for the warnings, or if a nicer alternative can be found,
such as moving -Wtype-limits to W=3, or using an open-coded variant
of __is_constexpr() that includes the comparison in a way that avoids the
warning.

       Arnd
