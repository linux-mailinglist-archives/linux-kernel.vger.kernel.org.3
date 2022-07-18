Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F068578AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiGRT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiGRT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:28:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7022F67D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:28:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bp15so23172713ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=glVmtsuU15Iaox1iZcFTntcIxvzzo12UNdGz2h5AEHU=;
        b=aSZgaWhEpqugDki03ICBGmsvTrcI45a/Gg144M0CC2+3qihdGYp0Dzmpkilf8GwM2T
         FP0uyixIPyan05aTJxgyStEzgKas9WUBCMWpIxManFkBhcYzUBWPTLcdouv6+lJwkNDX
         GI2kI5TVbCS0YI/Y8Zk65yubZwt2bd3k9YffY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=glVmtsuU15Iaox1iZcFTntcIxvzzo12UNdGz2h5AEHU=;
        b=r6qYMru+kpjyzqO3KZkJ8eiiPnDN6rDqAbvaMJaWrDGpCuOADzOq6UskxBsEVADklm
         9PID1Vkflmu88EQnW8CrGhAYX+BLUv/UII0M4CZOGbAEkKLQX6ptyPYhB16bJmLT1Q2h
         UxqsQn+K51F8xI8IBGwZFQ92eJR8nykl4WxGTyOfM8K0TNDGckNZU4WfUSc+bXRmohbg
         lWPj7f9f0qpz3Qm6yDkFJ4xCfHGkPIjihDN9P18RD8REs5R5kbawZMmCphbPt5/XBlAv
         9BK4fi6NnjGy7aqXui1yA5gNeDwb/7n6m7JzmY35SFsjn4S9Rs4tsH4NzV/lLXUBrF39
         INCA==
X-Gm-Message-State: AJIora93LsEbRa93G4q1hEvp4kaEbtqVlRAEhvdLuuW1/CTU1lYMmtdE
        fgkoZcgOpbCJEKakmtvnqHfllc2pQsq1ynKn0+PM0fcyN7qSIQ==
X-Google-Smtp-Source: AGRyM1sq1MSfMyVlmKSD9wRyBuQtE1YpswvG3rNfRWhbtbaq6G1mrK8LwieWjUvcdfC4v9u29djHnNWzwEaacmnUaG8=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr25166610ejc.523.1658172486510; Mon, 18
 Jul 2022 12:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
In-Reply-To: <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 21:27:55 +0200
Message-ID: <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 at 21:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 18, 2022 at 12:04 PM Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
> >
> > The regression in question caused overlayfs to erroneously return ENOSY=
S when one lower filesystem (e.g., davfs2) returned this upon checking exte=
nded attributes (there were two relevant submissions triggering this somewh=
ere around 5.15, 5.16)
>
> Well, if that's the case, isn't the proper fix to just fix davfs2?
>
> If ENOSYS isn't a valid error, and has broken apps that want to just
> ignore "no fattr support", then it's a davfs2 bug, and fixing it there
> will presumably magically just fix the ovl case too?

Libfuse returns ENOSYS for requests which the filesystem doesn't
support.  Hence this is not a davfs bug, davfs knows nothing about
itoctls, the userspace filesystem is just returning the error value
that is used to mean "no support for this type of request".

So this is a bug in the kernel part of fuse, that doesn't catch and
convert ENOSYS in case of the ioctl request.

Fixing it in fuse should fix it in overlayfs as well, as you say.

Thanks,
Miklos
