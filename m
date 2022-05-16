Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4552935D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbiEPWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347860AbiEPWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:08:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDEB377E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:08:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mnq0K-1nWHJf1D6Q-00pL4r for <linux-kernel@vger.kernel.org>; Tue, 17 May
 2022 00:08:13 +0200
Received: by mail-yb1-f173.google.com with SMTP id a3so10388320ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:08:13 -0700 (PDT)
X-Gm-Message-State: AOAM533jRAqSdsA3yuzRcdUU5uuUKlzWHMgEnb4fdqsdmPQdSUjtA2ze
        tj6O/kLWKlUjyA+EChY9M18ubaUtBLwl0jdRORo=
X-Google-Smtp-Source: ABdhPJyg8lmZNznvDGrAjaZpF13RXTplIwcTG2eCjbp3HEt4bBEqmJcvly31PXP9RUsVH+XERPilL89kCEKaM3HPxAo=
X-Received: by 2002:a25:cfd7:0:b0:64d:9526:1ed4 with SMTP id
 f206-20020a25cfd7000000b0064d95261ed4mr8526844ybg.106.1652738892081; Mon, 16
 May 2022 15:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220515200103.1408370-1-mussitantesmortem@gmail.com>
 <20220515200103.1408370-2-mussitantesmortem@gmail.com> <20220516140620.85f84d560c85d01d48dae917@linux-foundation.org>
In-Reply-To: <20220516140620.85f84d560c85d01d48dae917@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 May 2022 23:07:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1MJf7-gyZKe8hNaZnahPcatTveBM_zKGzYx9wEh0GXOg@mail.gmail.com>
Message-ID: <CAK8P3a1MJf7-gyZKe8hNaZnahPcatTveBM_zKGzYx9wEh0GXOg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ipc, sem: fix backward compatibility with x86-32 kernels
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Maxim Zhukov <crazycdeveloper@gmail.com>, chi.minghao@zte.com.cn,
        varad.gautam@suse.com, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeelb@google.com>, vasily.averin@linux.dev,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:twQHxyQtOaLui8ngWMctNjmQHOHZxvNcDYO+FAA2OzxlWTc3f0/
 dk9tQIOwE7vr6EspgJQWp8a7bZIdS4aPUk32q7mj+tR2BXhG2tKjDW03VhWdpHpghjFA+UD
 WwqcpczjlpWA2aeXNU1zNZdojbUS9gtxxELSdtNc3x0C8/Aks1y7PNLPumLTSpUL3io0Oi4
 1VEJ4H8spfQaRq9EoItQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3eMSnQ5YbsM=:/0bVHJovIBQ9AFCTEcUBPG
 2MQyXdnuuDXLoq2tTnHVNRVBTHldvBCFIakTCjTmF/3SxOt7yCW8dW/zA4w/DNrLzw38D4UPq
 0z/9jgFzKDVUKlQNtcIMZnYEpNJ905DvP0+TDxOsVKaq3uQIpzuYMT2almFQhy6ZqbnQ7B6N3
 BAKOY3eHpn+hpxzUEzXd2CHpNHJdT7JZpvhPojQRpDWrCqMLiIdgGkOOPy0S4lIMPeU5oY6cm
 9IwF97WYA06t7lpl2JkGps1dz+KfZwywFfUctB52zEz/+F1z/bDYqqpqwPxWJoHycInjtq9kE
 hC3Uv1MVMpqcCOjqYzOQvWyJ5OrK1ysihk9xK1wue1ddIxP3ZaM6n3KATceesS14MV5SQOrUU
 rkYdqzaX1bV80O86C399vjQBuCWVQLi+2d1mxJEr2nGEbMeySNPuY1hwUC9zs7D7HzJNCgGSS
 6x3kJiTkmf/IgGnb6WAbqZGKmgZA6gHAfLybYTJfjmQbU7EPxhk8dRcJqejW7NPeSyIRAdTQM
 Sy6IA5cuYupN17Tn9oOYo2nFMOIa5G6x38lcmMS6wzJXI6xoLq5SqCzTjS/oYSSSax81HEUGm
 /XobQHEje5OXFXGly3uFNiCAZ/hOBkb8WWdBbgW4b2DIiOIa1uBfA62wd/o0E1J3kkhkcF9mJ
 1ucTM6aP7jtNyjXcpJFfkiEPnt2GXGqS8H/r6D/RxFKpq07RKvh/hA6O2tqOEk0mu1d2jg1cZ
 sYKI5uZgTZHpKrSt2IIM86q+dzY8LgIwq6Cp7wsAnxbcvOsQeY9r/qC0DfjlfCQfwF3JpS8CT
 3d39Zp7l2pMpaTgFQM6wyROuVuNT1GfJoGxIpBnnF2Mle9UFao=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:06 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 15 May 2022 23:01:03 +0300 Maxim Zhukov <crazycdeveloper@gmail.com> wrote:
>
> > Since with commit 275f22148e87 ("ipc: rename old-style shmctl/semctl/msgctl syscalls")
> > we have changed behavior:
> >
> > ksys_semctl lost parse ipc version (ipc_parse_version), because the
> > new syscall works with IPC_64 only, but the parse function has some
> > side effect - it removes IPC_64 bit from `cmd`.
> >
> > Some libc forced sends IPC_64 bit in semctl syscall[1][2][3], this leads to
> > a bug - X86-32 kernel does not have compat headers and does not
> > correctly parse received command (cmd) from semctl syscall: cmd have actual
> > command and IPC_64 bit, thus throw EINVAL error in ksys_semctl
> >
> > This commit forcibly removes IPC_64 bit from the cmd for restore
> > backward compatibility.
> >
> > [1]: https://elixir.bootlin.com/uclibc-ng/v1.0.40/source/libc/misc/sysvipc/sem.c#L58
> > [2]: https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/semctl.c#L48 -> https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/ipc.h#L22
> > [3]: https://elixir.bootlin.com/glibc/glibc-2.35/source/sysdeps/unix/sysv/linux/semctl.c#L124
> >
>
> Thanks.
>
> 275f22148e87 was three years ago.  Can you suggest why it took so long
> for this to be discovered?

I think it only shows up with a uclibc-ng built against 32-bit kernel headers
from linux-5.1 or new for m68k, mips-o32, powerpc, s390, sh, sparc, and
x86-32 (list is from my original commit 275f22148e87), not for the more
popular musl or glibc libraries.

If sysvipc is used this rarely on uclibc-ng, maybe we can fix it by making
it behave the same way as glibc instead? I agree the kernel interface is
easy to get wrong here because of the subtle difference between ipc()
and semctl(), but this was an intentional design choice at the time, and
it did not affect the behavior of the existing syscalls, only the newly
added calls.

        Arnd
