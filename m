Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E03529349
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiEPWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiEPWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:01:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296C21BB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:00:58 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQ5jC-1oCfV22p6W-00M61c for <linux-kernel@vger.kernel.org>; Tue, 17 May
 2022 00:00:56 +0200
Received: by mail-yb1-f175.google.com with SMTP id e78so8336383ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:00:56 -0700 (PDT)
X-Gm-Message-State: AOAM530J9PsopS7SF7E/HNv//eNI919Crh28OL6j7BsgFL7KHhvAE0Gl
        fY3YJbaUzNccZtSe67uihbfYpHl/lNlNcfZ83o4=
X-Google-Smtp-Source: ABdhPJzOvJ1Nur3G1JX+IlZOcGaB7Oj05AJI5+nXjMqV097nGVWvQsIJehlQhKoegNzSX0crzcxnj6HgxTm7u9AM0ho=
X-Received: by 2002:a25:cfd7:0:b0:64d:9526:1ed4 with SMTP id
 f206-20020a25cfd7000000b0064d95261ed4mr8500297ybg.106.1652738455478; Mon, 16
 May 2022 15:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220515200103.1408370-1-mussitantesmortem@gmail.com> <20220515200103.1408370-2-mussitantesmortem@gmail.com>
In-Reply-To: <20220515200103.1408370-2-mussitantesmortem@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 May 2022 23:00:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3UFFt8uf_64J-aRbmB-zdH8TpEaRHSdf9JzPk9SYzYgA@mail.gmail.com>
Message-ID: <CAK8P3a3UFFt8uf_64J-aRbmB-zdH8TpEaRHSdf9JzPk9SYzYgA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ipc, sem: fix backward compatibility with x86-32 kernels
To:     Maxim Zhukov <crazycdeveloper@gmail.com>
Cc:     chi.minghao@zte.com.cn, varad.gautam@suse.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, vasily.averin@linux.dev,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rpCXLAVmjklRkaamrBhhpN0BOk3gH1ffpix3l27wZHSmXY10VsF
 PM4ZROuAxSSbGtULS1/Ob3vUxlt+RfXfGBlqHeYHRlXFozobNL+sUJwi2ZXjFZSy1Eox97B
 YXxE5uDlHWE0J1FI69qQbC85gX2Yw66Yhj8idzu+AXmkyEoK4QT0HpXKQHFY1ClD2uWyHv+
 rC4l53Vq2+gZz4T8HgLsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8HD+dKUJ+I=:YBtEjj5X+9O5eE9i7XOLS4
 rS+oFBZCsze4cwT8hPEOPEts3MN/0uU802/bPnX7T14RUtzg4IgfkHqGY7jVhSWn1T2esdQLL
 X/TtzGjZ3+P+ORQ9hbFYiXGTd3W+qq5nVLX3ORmrqZGv/1JuK+3UtCSl1l1QD8RQPJdXvrU2S
 97aokfIHjB596913PUH7uNHydutuMQssaUj2aMz6dVA+f//5uaZ/GyrM24mN9xj6NnwKJByUC
 7+QniBO/bMNWtO+psiz/UfDokyNxrsmuw4nup4izQgDvqsvbc3qLIrYPyHPbGCOTrdcEZv1zd
 7DzI8O1U97fWVLH+MPxYxH01CBgDKSexZ1yrZlXlLqzTXfnrSyMBZPbcLQK4RxazcpmyhsrLa
 m7ilYQPsiSr6lveqRobOu2RYd2ewrWzQLH58Uf13/CJ0SfokTI4i3Pgn7PSOUIWmV41sedl3s
 KVfvejGXt4BOCQVbXaP2QdOGCdHNOuzAd8NtZqfTOn0rofbwPAPmImwRt5trNpk0BtKUsrrCF
 nWTEgglDlzq00vS6K2DAk95J0Cxyj99aq3fOvDpB/XczSgeMTesqkdSnO7vGq/hDNWk9onrgR
 KodcHTUOJGXVNKfVSdN03/ArBrqG4sOJJ7RcrJEavYgXDzAi6ZK1FMfZAHneierDRRSaJyNBu
 hN0zxu1d14E6bamWtnYarUwWH2Mb/7EaW3xPBnfV7AG/sufpPjbsyBJBFiboWybmtl9iNcOQm
 eDlFoKtqpIAO7+TpO1jFU1GEI3wsE6qtmEMrcoGUonb+rox9ejP+UKUxGZ45o3HzCLnehsZgB
 GNyJQciMGlFHbaSDSt/vMVLYxQCaCbE8Pi4GrvrhzkBE6iQUiI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 9:01 PM Maxim Zhukov <crazycdeveloper@gmail.com> wrote:
>
> Since with commit 275f22148e87 ("ipc: rename old-style shmctl/semctl/msgctl syscalls")
> we have changed behavior:
>
> ksys_semctl lost parse ipc version (ipc_parse_version), because the
> new syscall works with IPC_64 only, but the parse function has some
> side effect - it removes IPC_64 bit from `cmd`.
>
> Some libc forced sends IPC_64 bit in semctl syscall[1][2][3], this leads to
> a bug - X86-32 kernel does not have compat headers and does not
> correctly parse received command (cmd) from semctl syscall: cmd have actual
> command and IPC_64 bit, thus throw EINVAL error in ksys_semctl

That is unfortunate, and clearly against the intention of my commit
from back then:
the idea was that any libc that moves from the old to the new syscalls would
drop support for the ancient IPC version and no longer have to pass the IPC_64
flag.

Given how long it took to run into this bug, let's try to figure out
exactly what
options we have to address this before applying any patch.

> This commit forcibly removes IPC_64 bit from the cmd for restore
> backward compatibility.
>
> [1]: https://elixir.bootlin.com/uclibc-ng/v1.0.40/source/libc/misc/sysvipc/sem.c#L58
> [2]: https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/semctl.c#L48 -> https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/ipc.h#L22
> [3]: https://elixir.bootlin.com/glibc/glibc-2.35/source/sysdeps/unix/sysv/linux/semctl.c#L124

I think musl handles it correctly here: it always calls the old-style
ipc() syscall if that is
available.

For glibc, I'm not completely sure but I think that also does it
correctly, defining
IPC_64 to 0 for the configuration in which it calls sys_semctl().

The uclibc-ng implementation is clearly wrong here, I assume that's what you
tested with? While your patch would make uclibc-ng work on the affected
architectures and not break the other libc implementations, it is still an
ABI change to allow the 0x100 bit to be set in the "cmd" value. This is
different from both the traditional behavior on the ipc() syscall, and from
the traditional behavior on architectures that had semctl() without IPC_64.

> Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
> ---
>  ipc/sem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98fdf2d..824244170000 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1706,7 +1706,7 @@ static long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg, int v
>
>  SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
>  {
> -       return ksys_semctl(semid, semnum, cmd, arg, IPC_64);
> +       return ksys_semctl(semid, semnum, cmd & (~IPC_64), arg, IPC_64);
>  }

I don't think it makes sense to do this for semctl but not also for
shmctl and msqctl --
whatever we end up doing should be the same across all three.

       Arnd
