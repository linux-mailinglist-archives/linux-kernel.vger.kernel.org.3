Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D35245E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbiELGgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbiELGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:35:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385D6309
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:35:53 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFbiK-1nZ48X0gu6-00H99O for <linux-kernel@vger.kernel.org>; Thu, 12 May
 2022 08:35:51 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ef5380669cso44944117b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:35:50 -0700 (PDT)
X-Gm-Message-State: AOAM531f72JkEbwNqizxr/Kb+/E+oBOhUp79LZN/y+WcgQd4OARToPOB
        DdJNYVJDCVIoTwyVMu8k46PhIsL8eM8k9h119So=
X-Google-Smtp-Source: ABdhPJzOwHW/6VWBQNzyMA36HesEBiujehWGsTu60Ya9Lkk1dZKXf0qHoUwRQoB1NauboCfk31SvIcmCe14DUvTb1JQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr29952928ywk.209.1652337350022; Wed, 11
 May 2022 23:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220512020641.45156-1-linmq006@gmail.com>
In-Reply-To: <20220512020641.45156-1-linmq006@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 May 2022 08:35:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0G51Ky6aHq=YS8T-TafcxfW0+E7=A0LX4zT-Yxo-JB2g@mail.gmail.com>
Message-ID: <CAK8P3a0G51Ky6aHq=YS8T-TafcxfW0+E7=A0LX4zT-Yxo-JB2g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Fix refcount leak in axxia_boot_secondary
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Anders Berg <anders.berg@lsi.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uy2ttkUPBz4Juu1hc7+CStJRE4wXN7BkPZZcJE1uRChio0Sy5im
 d9lwG+YOetsbTFpAU1OU0LAaB1apzWci7BsPcU/cDp0s1wNlVL5EzeoQbdVJubEM7VxnbuT
 xlx224nBn9if8rQJor8RjsAWGErwxKXVsUJH1F/Y8ANKxzUnenjpmLyBnwJvzKMnQrs3++t
 CbORkNPecSrO0WANcIkyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjmWOvgfpv8=:eOPWtweAhxiJgy6s/XAUk/
 6EjZAZsLIL12O5epTnaaaKkesrb8GhOizNhthw7Tr2eTztc30hyqB1tVq/40tovJ+rYiecJ9S
 cSffG7mKGkEOQhrwVx6y5/rHOu/DT6gbbiNfskGVmXS7VUOQFVUzAAF9/wMszQz2dvDv7Hw7z
 65LvP3hIOAD/7suArePwgYynAe5kgOkyQyHCIebcmNHCHiPuH2ljuN96TBh8pPw75nBSWrWSM
 5GfaWwZxYuheuTjK/lzVgJAJmlnXQd3GlcbXPIv/FuIswA2l1lMgLGRmK0xhNOiyv6qiMPfX3
 Hrh+7puPD/h0bbR8qQApqOy5/YUYtYI5Me0/wdy1l75jQxVwqXyot3VG/bkWj8GRxIjM6+xCn
 Olf0CXPNX6Ed35CeBShExEPkeq6tgsQvm8M/xTopMq/ppJd/w6dg3d5n6K3ATdZ3H+ZahT5vZ
 FWOvoCo3VA9yFxPlITd/oVPktTQdAspfDvBJHFuHuQa1q4rSDx6FXl2l8DDayXw4IPdFWXNie
 6Xf5O+C0dPgjaIv6/ZGq/mQPAH4mVh5tLNtChWHYmG4zsFzW6Zd0TIb5LOzEHxe3NUrIVKGfO
 Yn9tPovlxSIKPMta3rHHfdD1Dr3PcNLqC++ehDMOnbK6MZuO+0VbYxBfytzt6l03m86nHQbvP
 DEwzfmLbslQ7ATBoAmxKHzHFsApJS3I4y/MKw7US7q0XTay9AfOSpQgsQDmRqNOXdOuOV/kfn
 Kdcv0RWv7pDD5R19MUdVd0QLPDgOy6suJOytYsShqSw16Je+JtQDE7MoAOPIlYFViGYHPeNmR
 0y3LM82dvoCyLenipnTbPC2QlamnEkLksGKnYgJuBAnMWjmFlZHX7hkUcjgxngabymBAN+NI3
 5K2OxJ7ryuZFu+jOlVew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 4:06 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 1d22924e1c4e ("ARM: Add platform support for LSI AXM55xx SoC")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

This looks good to me, thanks a lot for the fixes. The arch/arm/mach-*/
patches usually get picked  up by platform maintainers, but not all of
them are very active.

I would suggest you wait a few more days for individual  maintainers to either
pick up, ack or nack the patches. For those that you get either an Ack or
no reply, please resend them to soc@kernel.org, and I'll apply them to
the soc tree directly.

       Arnd
