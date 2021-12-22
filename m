Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484047D349
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhLVOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:00:35 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhLVOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:00:34 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdtO-1mnSrv0ulK-00Nk9G for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021
 15:00:33 +0100
Received: by mail-wr1-f44.google.com with SMTP id a9so5107712wrr.8;
        Wed, 22 Dec 2021 06:00:33 -0800 (PST)
X-Gm-Message-State: AOAM533ct5/8frKsEzQQ0fnjwHTMeN/HVdkXQ6i2cHAnbiUZpm2+wQKM
        o8BmVBa8GQSZNzaXxeF2ff2/GhJcWvSuU3QGREY=
X-Google-Smtp-Source: ABdhPJzZqUV3m/4gBi9PAOChOgb2RpOg4jQAP0/DgyHh+MJob01VsDYVK0s1Stco5K8zA3yLynfQmmGKPYOk7XFmlEE=
X-Received: by 2002:adf:a352:: with SMTP id d18mr2189656wrb.317.1640181632663;
 Wed, 22 Dec 2021 06:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
 <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
 <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com> <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
In-Reply-To: <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 15:00:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
Message-ID: <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zXAV9wNIibJZsdtQWE1bzJZWJQh0A9sJNXM52Xz3A+FBSOSZ3v7
 09/k7pMWMsZHfhtitFixMKD25M6m7y7SNE67qgJ6uBLIZlcodm9GEZKkJXiPMNu9ZcIJFTo
 CWVtchej8+VdB6WcpMiKOKvJ73hpKh77HSBtFmgQT+Av7gmXX1jm0ko7poZYQuKxbyAfqji
 5dkcdsVY5guD9gXwKbBPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nmhb+HpHfkA=:eg9BSsq+ER5HRzeQX9Fp6M
 nB/RjKx3CJBDcN/oPyY1HtSp6lZNq9SbSK5C8zm/MQ8cr+pgng4s1zVpTAaqIQP99oWBmnw60
 qpyM9HLjrA7mJaumDol1+3tm3Meui7EscgiwT/xUOs65TKOyZVCpE6YOmrDUWjjlpF4nq/6Vg
 vlakFLhz5lBYGtf/ZTaSou+TpAVVyI0fQvBKfKX3XsVLvz+z4B0JYexlGEcPEvqz74SEc05fe
 7tQtvM8x+uqkY8o1Ku2V0AFKn0kHt9TUJ0URXE1VadrgkEb0GLJHRlWHvFipdXriV4ySlIFni
 JEE9a9URvVW4OrhIFlDz1YY9kkEVtcnc47Ms5gLNHUP1g3wa+3qA1yGAh1EBDBHMv6XRZpSdV
 K3gpKqZmCpeQQAIe0MR3U+VfYNZZ/sAuAP4T2dpTIPZ6Oeorg83HetmrGHHJdQrUww9d6SMZc
 4pnLWziLzhlaonnOZCRT9yCoNWQlHtHcYO5nhIv/NtrhIXY5UQSr1BEPc3ZhRdlWYG/Jh2Kvs
 6Kw0dJsG0r88KeO0c1Dt37IRnJEIF1WNMmctQBa6kgCZxaB8tzYh9QBPPQ9v9ko4GqJee8z1c
 A3Ez/UVQ2eKaEsuCenVnM6Rx5pzq3jOG+y90AL6c64DV7U4Mad05O1CnNbO/ypCKYL9HqWJWI
 pOo6uBh0jdLfnnu0b5I6vhrtGXdNDQd3YKbVcDLqyFDzwOLvXRHG+EtXZoh1G4PoqKkcAFCJk
 ilbgk7bFIsLVMZqQMp3AwOjoyv77sVxbVvclHweTVDeCAEujH89MoogTvqVD5VROs1ZWhEjhC
 qLYgamRifabmN9u1Fp1QrgsOWQWvDDDrsXgR4lEEGwub4bKRo8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Dec 22, 2021 at 1:43 PM Guo Ren <guoren@kernel.org> wrote:
>
> Right, I think the patch would be a nice cleanup, but it appears that
> riscv is among the few architectures that have defined their own
> nonstandard mmap2() syscall after all, despite using the standard
> name for the entry point. Not sure how this slipped past my original
> review, but it certainly can't be changed now.

No, I misread, the calling conventions are fine after all, it's
just written in a rather odd way.

> Maybe leave it there and change the #ifdef to build mmap2 for both
> native rv32 and compat mode.

This bit still applies though, I don't think you need to add another
helper, just use the one that is already there.

        Arnd
