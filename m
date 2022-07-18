Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AC57835B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiGRNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiGRNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:13:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45200275D0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:13:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m8so1765791edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DemOKMHhZF3bL68gab3/ZnvjvNZQC14ke44+CAjVeE0=;
        b=qkj5sL9AXqE4MMHohODclRGaHobppjOPaPwZrckNV7rVX+5xk6Y5kZLptuYAsgmuLV
         W/E5E3Liof8DSJgkDsZ5FH1U4RmtxhbDLpIj98x5vOqrNmnAfVtrMyuMSsa1VN38M5Co
         zzfBesdWFUs7dEGqENIHgu5wIsZ6f1Fhme6wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DemOKMHhZF3bL68gab3/ZnvjvNZQC14ke44+CAjVeE0=;
        b=NcJyqq8q7B0zxP/lIlMHbiG8LWpb996SltPpCD5M7xzeet8YfuCDWoEj0rsI2+lTYe
         wxIEcQteprt0KhCJTqPTJfs+EMs8XD+fm755+Z7pk8VfK4RKV6nm1Llpm8y7mc41eYSO
         SWer8bAWDZe+G8tj/mtgxJ1u5qimdoTA+50gR81UAX4kNjAzt8WtB0rSH7B8bhBz5OQf
         K0yeRSr9hvtbatRaONote3tfpB54ptBmyFEmDARs6lFFk2XRNkNGtDquBKur3eKaI/R6
         mVwILrcFP35eopZJETSwxyNcqAqOYatmEFgDweWWW7cYsrf7aecLqDogFe1t9s73hsep
         +iWg==
X-Gm-Message-State: AJIora8n5FcNcPnxQq3P2pwQjSERgR1orvimlNJzBmLdoTHF2MBRVeCB
        EHfspqYVmRePSqmsU7heBNrkFco82yuhGtGpgXJTBA==
X-Google-Smtp-Source: AGRyM1s62j3MUSXuzz3DC8rfU5UvJmiYwnYQo2iuFRpY/jqWv1YRWKc3lzzXZMGJlstM+esSCZOyhW7Z67XsTzxSgfg=
X-Received: by 2002:a05:6402:4245:b0:43a:961a:583f with SMTP id
 g5-20020a056402424500b0043a961a583fmr37178878edb.374.1658150019848; Mon, 18
 Jul 2022 06:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com>
In-Reply-To: <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 15:13:28 +0200
Message-ID: <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
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

On Mon, 18 Jul 2022 at 15:03, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> Am 18.07.2022 um 14:21 schrieb Miklos Szeredi <miklos@szeredi.hu>:
> >
> > On Mon, 18 Jul 2022 at 12:56, Christian Kohlsch=C3=BCtter
> > <christian@kohlschutter.com> wrote:
> >
> >> However, users of fuse that have no business with overlayfs suddenly s=
ee their ioctl return ENOTTY instead of ENOSYS.
> >
> > And returning ENOTTY is the correct behavior.  See this comment in
> > <asm-generic/errrno.h>:
> >
> > /*
> > * This error code is special: arch syscall entry code will return
> > * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
> > * failures of syscalls that really do exist distinguishable from
> > * failures due to attempts to use a nonexistent syscall, syscall
> > * implementations should refrain from returning -ENOSYS.
> > */
> > #define ENOSYS 38 /* Invalid system call number */
> >
> > Thanks,
> > Miklos
>
> That ship is sailed since ENOSYS was returned to user-space for the first=
 time.
>
> It reminds me a bit of Linus' "we do not break userspace" email from 2012=
 [1, 2], where Linus wrote:
> > Applications *do* care about error return values. There's no way in
> > hell you can willy-nilly just change them. And if you do change them,
> > and applications break, there is no way in hell you can then blame the
> > application.

Correct.  The question is whether any application would break in this
case.  I think not, but you are free to prove otherwise.

Thanks,
Miklos
