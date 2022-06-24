Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE2559D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiFXPLa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFXPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:11:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588E4CD7F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:11:25 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1Oft-1ngfqK3s4p-012niI for <linux-kernel@vger.kernel.org>; Fri, 24 Jun
 2022 17:11:24 +0200
Received: by mail-yb1-f176.google.com with SMTP id d5so5000799yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:11:23 -0700 (PDT)
X-Gm-Message-State: AJIora+xZouIQgJlXCJt6C8QmN9QLyfmR9yGjUtFRkA+2fUgxzAseTnO
        EPHTHWo4D6DyYeYJEDUqmrYDHxcDPdidWfD/Ghk=
X-Google-Smtp-Source: AGRyM1vJJnhlcyd7ZSZrixr3FMT9677Grp/rNK0TzdIxtZ3Z0+OUPG5WXg1A6g8fJkwRsaVEZy+JKkarEpgkYASSVk4=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr15555982ybq.472.1656083482781; Fri, 24
 Jun 2022 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220605075841.19929-1-linmq006@gmail.com> <m3wnd76ako.fsf@t19.piap.pl>
In-Reply-To: <m3wnd76ako.fsf@t19.piap.pl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jun 2022 17:11:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dDJrPPM6gRc+s7OQStphWdvWRdcELtNBXSzvd+gxoLw@mail.gmail.com>
Message-ID: <CAK8P3a3dDJrPPM6gRc+s7OQStphWdvWRdcELtNBXSzvd+gxoLw@mail.gmail.com>
Subject: Re: [PATCH] ARM: cns3xxx: Fix refcount leak in cns3xxx_init
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:n5MdKEkkXMtSOTgpnCbms+npJ8lvJY407XvU7TA1qF8g1iVn6N8
 L4R5ILDoOjNhCC818KJPhZlk3uSJWi0NyBHWsOd+ORkLliTib7hInjrqTAlxe4weXMsySB0
 GpdD/vmUD3jotPL16aTRlTKB20QhBAYjgklq//L6qg+C3vKrFllgd3nf831kUfEJs8kPr3X
 xI4uUbcIxZi6RKB3iPUBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DaDFQRbkddw=:iRyVpdIvaPcMifQWf/V16x
 tNXUWZFwK9HB6guS2imJ+ZzASCa8AlLsg6ct5wPIwte6LGTYaBM/5HhzueBgUEApWwpQRF1wN
 h0uL1B+puZVsJjDyqfL5uGzxFdUr4RudSZfZUyxuanD4BBdKTPWsnieyuB0gLbepaFKewMxnQ
 R2lQzKmfs14OAN1703EUiGuj50PD3xir7F/q/s/mN3ROeyVQolTSc1iKnDqpuo8xXbY+3UGQ4
 FCAj7fL2AB9NF9eUMerCui2HhUBmuL+n+ydUu0JGUBoDDT1N8Pm4s7hGya1ertS5qMCVn02ju
 rhpNfbK2iw1v5p0I27UUj5N5YjmKDr+MxIVteEfifR3soAd0mqoLch5az4ERhuWrIAnMQENAv
 6aVQqR8OraT8wG84h8eNv8wRHMG9GzOaXNrpGw1hVIR0LFyWfQmAPaZ0sfpTHdlEuV5gvYBUO
 KR1vJ/4aFzfMR08Oxk/7n+jQvfr57/RVfQ/+A0Mrc+8L/TBgJ1tbR+ukDq6EP4nCeJ23ZfeoB
 Er79jVhYwZ5rwJBdZ5dH4H5qfp5JuJfRmbQspDDII8kVtyOovGH4biOkcAXt5vLKcv7zx4XGK
 909ovtfbbewNllEqyw7RvbZAKG/tZPIVbVMrnS09D+NhpdeafI4KiPQKaMwBs8CC3SrPVh9TM
 I1VadikK8/zcLS5kfcpgUwwHB8mO9O+rbp3DUpE2kMHA7QA0vXv2dZm8icmVIupiu47yx8gDT
 yExTsjNNwlGPbb9THIUk5xjj+aHcYrqVv7yHQA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:36 AM Krzysztof Hałasa <khalasa@piap.pl> wrote:
>
> Miaoqian Lin <linmq006@gmail.com> writes:
>
> > of_find_compatible_node() returns a node pointer with refcount
> > incremented, we should use of_node_put() on it when done.
> > Add missing of_node_put() to avoid refcount leak.
> >
> > Fixes: 415f59142d9d ("ARM: cns3xxx: initial DT support")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
>
> Arnd, I guess you are in the best position to pick this patch up?
> Thanks to both of you.

Done now, thanks!

        Arnd
