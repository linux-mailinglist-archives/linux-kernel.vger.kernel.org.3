Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3DA56A30D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiGGM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiGGM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:58:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF469631A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:58:40 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0qmr-1nLzpL2Vcr-00wlg4 for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022
 14:58:38 +0200
Received: by mail-yb1-f175.google.com with SMTP id 64so23082853ybt.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:58:38 -0700 (PDT)
X-Gm-Message-State: AJIora/Jh4bFRBOY75/n0BhavboDhPra6WEeuoDgeGpLtXc5oA+fNtzU
        wL5IJ2mUdf9Hv0I4dFxRIleYbVj5tRd4aWJMUdo=
X-Google-Smtp-Source: AGRyM1uX1VubXKRKAhrgEy4zsIF4xDfIjrS0y1PZaFYEmVVlCmS2hLH5NANA7MGYxLWc2r2GdTcZjF+dyth/NlYbv8w=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr50808203ybu.134.1657198717455; Thu, 07
 Jul 2022 05:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com> <20220707110511.52129-2-zhengqi.arch@bytedance.com>
In-Reply-To: <20220707110511.52129-2-zhengqi.arch@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 14:58:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0h1rFot013raf+O49pvV0JtyBX4Hwp3dt_85jzsJv3ww@mail.gmail.com>
Message-ID: <CAK8P3a0h1rFot013raf+O49pvV0JtyBX4Hwp3dt_85jzsJv3ww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: run softirqs on the per-CPU IRQ stack
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Fbdeyp6aStkOat7X8aZFib1kvwr8Isk9MFjCz1eXuG/SgWwXr/U
 BUcJh3NX8kyDmBp3379Xups9tIZwPHGqUaFDF5Nv7/opVqRJaRXN4mA5z6JCGoJwpDIThPX
 lHEO0PnKqm1WUQQ0ve0cOs61wQhQuZaQa1zSJtZHe8eighgifnGgZusqtHJtX/ujHW2Ejda
 Lt4H873QtslRqX4oivACw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Asw8vCdvcxc=:Dc+rVX/pwIMghXDnEzcqOT
 8hH4+83KwV/2qLcWPHAg7pPvJtikGRUlF2W3iEyo2ylpPw03WTKa+dw/MZJRajtRHpXaE4V4F
 da6Z9olr2BeUKOYWEVwoC+ha9tlJT9VSY39Ws2nk2XYw4a7JlYWafmtUcB2x+P693Q2wsPZyT
 uYi3OLtOC78r0M4QzA16f0FTb5GfrzrQVwJjcovOXiSjuhS5nXm7E0ckc+kXEc47Ld6ZNVxP0
 NkwfoIqO0zeCT4PnyiFEy3YAJPGKDbjprSiQdqlY89IDsL79zzL8/mIxlPAPU5NVBPeIUvBQc
 FE8zCDzlMWTZYTyfdD8dW0dV+F7dpI++RuMBLEMAnswNOO/u7C1Tco+iuP+IR4Utu5r8sOebw
 2XdQ9ef5+HTW1TMyFiLPYfj83R+qi1imA/r9CLUncTH4fcJ+pTv82SF93qBAjzspGiUWYb0bw
 UJ3rluGbhYB3wvvKmlAmmCEVU8JJi+AhwO5MbX9rsoZZE8/GqGPCF49CD40iiC34blMh0C+Fw
 oXl2Y+LIZ/OfOUCIGT+PB0229dJjy7e1cIHrHBg+UgeIp5yn4MoXBU7F254kguyysMPl0txZ2
 0XidCgK7h1fyd09SOOjL1HmXQpE25HfjZ2gX1JVE3ZeU3MYcVN111xJyWTII2wKd8R9DWTYeW
 ih59/yabSqGhJxgEhHC6Shok5ryqouwyQSpNrp9fvmOKN4kMHikXMyRaAkgNpJGQ+QpaUkpgk
 y575zpB/vrbQEQeEXVoBOZbmE5mahxBqBJIivBedMPtglLjd8i2E0+ILrvjKzuOhwaNteeAW0
 xHlH70O9nz8YyMOcKcyC3GFkUSMzuSKut2lSs7qyhus72oXedSQpECylzK01ZuNdtr832HCB5
 5ANW3TrZvXaogcQtOWxw6Goa+ITkMEJfqmFUIuTdM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
>
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I think this is the correct approach, but your patch conflicts with another
patch I have queued up in the asm-generic tree, see
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?h=asm-generic&id=f2c5092190f21

Please adapt accordingly.

Are there any architectures left that use IRQ stacks but don't
set HAVE_SOFTIRQ_ON_OWN_STACK? If not, we could
also consider removing the Kconfig symbol and just requiring
it to be done this way (for non-PREEMPT_RT).

        Arnd
