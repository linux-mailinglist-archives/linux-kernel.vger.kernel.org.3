Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB852163D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiEJNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiEJNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:05:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7F261946
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:01:47 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOz8O-1nRH0A0Mrk-00PMXu for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022
 15:01:46 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7d621d1caso178417867b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:01:45 -0700 (PDT)
X-Gm-Message-State: AOAM533/s5bUbhxByOwVMVRU9oxsNKIqVajYNG250KG11gkvcWc6nwbN
        ++d/FibFnYSYbud9jgTlS4aUyfZDnHN8y4WdpPM=
X-Google-Smtp-Source: ABdhPJy+T0eXkI/JKNqS9DdVEoRi+XhkQCs5zGGEulEfFAt349X2IljWvx8XEX4MN75HMZqLUtoIyBN++cWMnOCy59A=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr20121759ywf.347.1652187704917; Tue, 10
 May 2022 06:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220506192957.24889-1-nick.hawkins@hpe.com> <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
In-Reply-To: <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 15:01:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
Message-ID: <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dTbG73dSwWLOwXtvAE1dp5LMmobOUCwxP93UPBXVLk1MvHzcEcw
 SZx3ZA5UATuejDLVmjC8t+Lww2beqi6pOQCBDxUsl9LUoXJZfdaqGmpMP1JPc03h/7RY8TN
 vbqSUdfcK+AYkG/Nm22UM034TZvJPNXYzWAXt7Ecfk8TYo7jK9hAMvdBaBXAkWxLmk2p2Q/
 SCeaU0UEPOHvQpF9Se53g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kr9kRAQVEgI=:B0MZvF8zM1oiRUHkYw+T9f
 9hlW/E4WjXp/tS7yzRKRaauW77N81xW6PeeKZoDa9jeRRQ2vgdTZ1hntbjpoY0jOYI5nkVzcd
 N8UdRQClhxmopIcod0TsM/meM9UUtpNBSVEQLrV3+oeGaeeNOU6bV2ORHB4jU6Tl5LZHh7y7X
 AC4v7H7S64jF/x4KZ/UfIIBH9GxBOr5xjgc4m8aw1IOGKZ5cbSCt1Fn/O1fSK1b+RKE7yY+ev
 Nk+ZLIelmVPTGmR7lGhQmvKiIJo1vWgbPPniZzHR/tUlFpd1KyZHXZAj3oDfDBU7sXzV8iisu
 K/03fYdRxew8WGyqXL7z8p9yCkdMiXZ9HSzEAH3uk+LpsNwXSY0B6dtqr4eYN0ZbgcoKbrWfi
 I5WLVPcvPD0SFGKcBBCBru0XFGVlr5bx3e0NW2CFPp+D4T60mTv6cHR+ndSnszDxrfB8PN6Sv
 7KiHORfYc/5GLa6UbfIhe0U+fui8Y9e7UBSrMCldbze9tmai3HqU7Og+hyJv96blD6J9BWdHj
 fU1KqkBmDa+BIifzDBU/PIE3xT4VxtLRODdhc5+dM1FDbzCCJVuFz0BbmkjXaLNqzApe2yPNz
 VtRTDVODE1PhFrqCArJEYEwRYI86zNDF/CxnqnNMH+eB7jtbZtc32i2g6BlU0/t8vss3Z1kKz
 sacGggSJjxUYv227BX6Ml892ks5RXfmIiOuQnchjuc90oLacg4Q9wrULpo86hZ6kWlpJ2iVt1
 jl0LcOBij1Vxf9kEoJX4+cRW5uLOZN+Ya9s3w+OYxKB4vCsqGEr7WT3f4eUGjhMiqivVjueq5
 HLrqeB2kq0wjD3gN9BngaE8PVNd32Iu+U1lWbF/RKgeUrFYP1g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 1:53 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
>
> Hi Arnd,
>
> >    Hi Nick,
>
> >    This seems a bit more complex than necessary. Can't you just use a custom
> >    inline asm with an ex_table entry to catch the fault? Have a look at
> >    __get_user_asm() for an example.
> >
> >           Arnd
>
> We got inspired from debug_reg_hook within the same source file
>( ./arch/arm/kernel/hw_breakpoint.c ). We chose that path to keep coherency
> within the source code. We can implement the same fix by using an ex_table
> entry, but this will create two different ways at catching unknown instruction
> within the same source file. Will that be ok ?

I got a little lost trying to find where the breakpoint instruction comes
from that gets trapped here, but I would guess that they had to do this
using an undef_hook because the ex_table approach does not work
there for some reason.

I would still pick the ex_table method here if that works.

       Arnd
