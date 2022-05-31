Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDB538CED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbiEaIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiEaId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1636EB33
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D973B8104A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A2DC3411F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653986003;
        bh=m8CVB2IEzTm7IbE0aDktLQaZcFf8WZo00NmKcH+HpWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AV6x2upAr1IKhUAqkgQgxvvgC5gGpwQEauAwETbVfIZAOlsvwjnulXqd0MGJ4yrXl
         IEpiZC/Qw4WaAJut/wPx73rwcZ4Nukg9MrvXgmrO8+/Jtu4kjUDTjcKW7vxtcw/UH/
         OqZ6kTyeYMlodpxV57Vswe7bZCJjTIm4GrTf9jEjShR8hjUhwSP43Zo/CB572dwq4J
         9UDkN7kJoiDI3rtrP4YqPEoRbcTLdGvyquA/milLga9YVrDksrje0Ur8vck+3v1xnM
         o7SQfNT8J4ZME0BLlNZ4EX78GIIWeLnKua8sHcxaMz5km/A4Q+QdaYfiTdqyV2iZaJ
         Zc/KAHgShMfdw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-300628e76f3so131120877b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:33:23 -0700 (PDT)
X-Gm-Message-State: AOAM5339XqBlten7WGTYL5sim3hzGMrw6yq+Z7/PuetBW0aiKtHuM4ET
        KmB2cevuxhevNJQTYY4DA4wHDaJZQx0OzGICu8c=
X-Google-Smtp-Source: ABdhPJwg8kcDi1WcK3gpjtOES2s/3bBp37zt9hfKTAmsG1Ha4F56qHaitCZqHTplCheDbjoctUJducA7nLUPmgYHp3U=
X-Received: by 2002:a81:28b:0:b0:30c:5e57:fac3 with SMTP id
 133-20020a81028b000000b0030c5e57fac3mr8223535ywc.249.1653986002406; Tue, 31
 May 2022 01:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
In-Reply-To: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 10:33:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
Message-ID: <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
To:     =?UTF-8?Q?Arnaud_Pana=C3=AFotis?= <arnaud.panaiotis@gmx.fr>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc correct libc-alpha list, sorry for the typo)

On Tue, May 31, 2022 at 10:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On 17/05/2022 09:51, Arnaud Pana=C3=AFotis wrote:
> > I'm working for a client to generate embedded 32-bits Linux Kernel work=
ing after y2038 issue.
> >
> > I generated a 5.15 Kernel thought Buildroot with Coreutils 9.0, GCC 11.=
2.0, Binutils 2.37, Glibc 2.34-9 and CFLAGS  -D_LARGEFILE_SOURCE -D_FILE_OF=
FSET_BITS=3D64  -D_TIME_BITS=3D64.
> >
> > I encounter an issue while working with OpenSSH (I initially contacted =
them before).
>
> To clarify: did you build just openssh with  -D_TIME_BITS=3D64, or did
> you build the entire user space this way?
>
> > After 2038, /usr/sbin/sshd does not create an error but it child does g=
enerate this one:
> > daemon() failed: Value too large for defined data type
> >
> > This happend here in sshd.c:
> >
> > 2019         /*
> > 2020          * If not in debugging mode, not started from inetd and no=
t already
> > 2021          * daemonized (eg re-exec via SIGHUP), disconnect from the=
 controlling
> > 2022          * terminal, and fork.  The original process exits.
> > 2023          */
> > 2024         already_daemon =3D daemonized();
> > 2025         if (!(debug_flag || inetd_flag || no_daemon_flag || alread=
y_daemon)) {
> > 2026
> > 2027                 if (daemon(0, 0) =3D=3D -1)
> > 2028                         fatal("daemon() failed: %.200s", strerror(=
errno));
>
> My guess is that there are parts of glibc that are not fully
> y2038-safe at the moment, but
> merely provide the interfaces for time64 applications.
>
>
> In the glibc code, I see
>
> int
> daemon (int nochdir, int noclose)
> {
> ...
>                 if ((fd =3D __open_nocancel(_PATH_DEVNULL, O_RDWR, 0)) !=
=3D -1
>                     && (__builtin_expect (__fstat64 (fd, &st), 0)
>                         =3D=3D 0)) {
> ...
>                              } else {
>                         __close_nocancel_nostatus (fd);
>                         return -1;
>                 }
>      return (0);
> }
>
> __fstatat64 (int fd, const char *file, struct stat64 *buf, int flags)
> {
>   struct __stat64_t64 st_t64;
>   return __fstatat64_time64 (fd, file, &st_t64, flags)
>          ?: __cp_stat64_t64_stat64 (&st_t64, buf);
> }
>
> If I'm reading this correctly, daemon() internally uses the time32
> version of 'stat', which fails for files with out-of-range timestamps.
> Are you able to rebuild the ssh binary (or your entire distro, if that's
> easier) against musl-1.2.x instead of glibc to see if the same thing
> happens there?
>
>        Arnd
>
> > To reproduce:
> >
> > # date -s "2040-05-12"
> > # hwclock --systohc
> > # reboot
> > # /usr/sbin/sshd
> >
> > Note this error occurs only after the reboot, and setting a date before=
 2038 also require a reboot to remove the error.
> >
> > strace and gdb trace linked.
> >
> > Let me know if you need additional information.
