Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1E538CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiEaIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiEaIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:24:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB391572
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5398D6124A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09D4C36AE5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653985472;
        bh=Tn7z3nP0AB8VEWe8KtQeBBbkA04IzbtNqyP/X5VlNx8=;
        h=From:Date:Subject:To:Cc:From;
        b=MLuPGyKJGX4aIxw5Pg23byqZWlVu9s3tbqs/8KR+Elo8k7ZxzyXE/qCGJqJuNO+Ok
         S9TQiAbv9bspbFBNh4mmLNYftwSUnyzWiTIr9mlozqMmnoLKUq0ZSCaWceQmBCcWLY
         fC+4b6+ECSVyLTz1tylsG88V53ZjLrJHu+mdhHqmJMB+gbtKUUh67+bvZOKHzDoaV0
         fugIEkuIwywlnuo8Djy0sSKKPuV3Sv0a2CU24GomFyp9LFsfuw1jA5MCcxzajO8NaO
         IcbAgy97nfxKfW7U1riYOZ+uUg+h5EdaD+XC4C9Mhn3QDyZoKj0REYBG4RIcDZRSFL
         orLPhkU17MT2g==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3043b3f7d8fso121142297b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:24:32 -0700 (PDT)
X-Gm-Message-State: AOAM530vvwyxmwXIFYdomoM+z/AfzYIu3RxJh3yeuxUZHPgoCun2mJ8W
        51RD5/kpAB7rl4o3NjlPx3iurYi3xAm0YGut+KE=
X-Google-Smtp-Source: ABdhPJy1MqMs21iNFMm2vOhXzL0w8srBtX0g+meq/+8YXK+IdLf0E3RZiQtP9b1R+CHMTrViMePm/DPLqfWC/mU7jqk=
X-Received: by 2002:a81:28b:0:b0:30c:5e57:fac3 with SMTP id
 133-20020a81028b000000b0030c5e57fac3mr8191201ywc.249.1653985471749; Tue, 31
 May 2022 01:24:31 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 10:24:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
Message-ID: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
To:     =?UTF-8?Q?Arnaud_Pana=C3=AFotis?= <arnaud.panaiotis@gmx.fr>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        alpha@sourceware.org
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

On 17/05/2022 09:51, Arnaud Pana=C3=AFotis wrote:
> Hello,
>
> I'm working for a client to generate embedded 32-bits Linux Kernel workin=
g after y2038 issue.
>
> I generated a 5.15 Kernel thought Buildroot with Coreutils 9.0, GCC 11.2.=
0, Binutils 2.37, Glibc 2.34-9 and CFLAGS  -D_LARGEFILE_SOURCE -D_FILE_OFFS=
ET_BITS=3D64  -D_TIME_BITS=3D64.
>
> I encounter an issue while working with OpenSSH (I initially contacted th=
em before).

To clarify: did you build just openssh with  -D_TIME_BITS=3D64, or did
you build the user space
this way?

> After 2038, /usr/sbin/sshd does not create an error but it child does gen=
erate this one:
> daemon() failed: Value too large for defined data type
>
> This happend here in sshd.c:
>
> 2019         /*
> 2020          * If not in debugging mode, not started from inetd and not =
already
> 2021          * daemonized (eg re-exec via SIGHUP), disconnect from the c=
ontrolling
> 2022          * terminal, and fork.  The original process exits.
> 2023          */
> 2024         already_daemon =3D daemonized();
> 2025         if (!(debug_flag || inetd_flag || no_daemon_flag || already_=
daemon)) {
> 2026
> 2027                 if (daemon(0, 0) =3D=3D -1)
> 2028                         fatal("daemon() failed: %.200s", strerror(er=
rno));

My guess is that there are parts of glibc that are not fully
y2038-safe at the moment, but
merely provide the interfaces for time64 applications.


In the glibc code, I see

int
daemon (int nochdir, int noclose)
{
...
                if ((fd =3D __open_nocancel(_PATH_DEVNULL, O_RDWR, 0)) !=3D=
 -1
                    && (__builtin_expect (__fstat64 (fd, &st), 0)
                        =3D=3D 0)) {
...
                             } else {
                        __close_nocancel_nostatus (fd);
                        return -1;
                }
     return (0);
}

__fstatat64 (int fd, const char *file, struct stat64 *buf, int flags)
{
  struct __stat64_t64 st_t64;
  return __fstatat64_time64 (fd, file, &st_t64, flags)
         ?: __cp_stat64_t64_stat64 (&st_t64, buf);
}

If I'm reading this correctly, daemon() internally uses the time32
version of 'stat', which
fails for files with out-of-range timestamps. Are you able to rebuild
the ssh binary
(or your entire distro, if that's easier) against musl-1.2.x instead
of glibc to see if the
same thing happens there?

       Arnd

> To reproduce:
>
> # date -s "2040-05-12"
> # hwclock --systohc
> # reboot
> # /usr/sbin/sshd
>
> Note this error occurs only after the reboot, and setting a date before 2=
038 also require a reboot to remove the error.
>
> strace and gdb trace linked.
>
> Let me know if you need additional information.
