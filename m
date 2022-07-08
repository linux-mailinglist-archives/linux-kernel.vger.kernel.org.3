Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFD56B282
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiGHGGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiGHGGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:06:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB624F17
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:06:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t19so34033319lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDcFqeczHGyZYd7T238OgZvCCK1eXFIoTBdYc3SeZos=;
        b=DittmnZPcRT+xjFr0ed9UvAlzAFmVKUPNDmbhL2Xp88Abar5gi3sxJN4MHIPC8oBri
         +kAmgOZX95RtjJD6AcqYQIdiw1XHTh3e5knHYqmil56Av1TN6O4cOoQHvI26Iyc73Y90
         VJBKK8nB8ovQ5ZPoeO8+A2MTtM0qgCutPIz/D/nBnhMmFMfLU3Aw4DMieUBq6JwHLUOy
         g6M/acHahuel+dFTIQAKAhLLEpbugR5KCP5VNdLxC5iWqB8rrqL6iUPylXYrxlv2YBvT
         x5CYJWIQvNFNAzsixoH8VJDl+lngq0VfCvAM5PPFxoJaqEVzI3CkI6fd049rvjlAjxDL
         Iapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDcFqeczHGyZYd7T238OgZvCCK1eXFIoTBdYc3SeZos=;
        b=YXL5KzNrEqMVZEoCut6ll3mE9yUUrwgAi7K97eozntGTYR1QtVuRqKurcXDGAsknJY
         ryFdG3Oe7jg+NnoEMsRIEttggENyA6+3HOq8d49HOLnHiFwGwgErAc5lAlmPqmYUIl4X
         yyMZ4XsS8xzuYYGx9vfOVwFAkSKBBPaM+PhhPFfwc0kqXfEFN9QwR1pDGgrWWL7kKahL
         aglV9QTXp0kb4y/YPDRMsWdScf922WVhQgJ5Mlz35v7CSBVBm2J3DRHVBODiIg/hvsQB
         klj0et4VdPgYdwa6dxjMkJ5dxGT2SgeaGuPrnaxV/e5pi6yDQsUqMGckkNGwNxmqRQty
         fD0g==
X-Gm-Message-State: AJIora8Cv62h7iuDZ6jVUxMa8+9RYHqT54i3ckoMPnnqiXy51kGOdvnG
        2fAV7etccRxwXFKwy9z9IGK1hKnGN68usrshS4ZzNA==
X-Google-Smtp-Source: AGRyM1sTtjfrNu/fSE3mT7VoMqjGcZ4ClYdoRho9XcGSkjNBrML2LhgLhFEP2pyAGlMoHwoO0ig22H81jkQ3gZammY0=
X-Received: by 2002:a05:6512:114b:b0:482:c057:60b3 with SMTP id
 m11-20020a056512114b00b00482c05760b3mr1284786lfg.206.1657260402433; Thu, 07
 Jul 2022 23:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <YsPOEYU7ZqmpD8dw@kroah.com> <a1fcc07e-51ef-eaad-f14b-33f1263e45ac@I-love.SAKURA.ne.jp>
 <CACT4Y+bUw8LebceH0fDZriqAivuwNSNntTTS1647CQF-j2C4RQ@mail.gmail.com> <YsQOG3+ItWmrpaFt@kroah.com>
In-Reply-To: <YsQOG3+ItWmrpaFt@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 Jul 2022 08:06:30 +0200
Message-ID: <CACT4Y+asMhzEh+6WvHTX6-DNCf3A+oqwZJ27oedPCaP8kv7TVg@mail.gmail.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 12:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 09:20:24AM +0200, Dmitry Vyukov wrote:
> > On Tue, 5 Jul 2022 at 07:54, Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > On Tue, Jul 05, 2022 at 02:21:17PM +0900, Tetsuo Handa wrote:
> > > > On 2022/07/04 23:31, Greg KH wrote:
> > > > > I don't understand what you are trying to "fix" here.  What is userspace
> > > > > doing (as a normal user) that is causing a problem, and what problem is
> > > > > it causing and for what device/hardware/driver is this a problem?
> > > >
> > > > Currently the root cause is unknown.
> > > > This might be another example of deadlock hidden by device_initialize().
> > > >
> > > > We can see from https://syzkaller.appspot.com/text?tag=CrashReport&x=11feb7e0080000 that
> > > > when khungtaskd reports that a process is blocked waiting for misc_mtx at misc_open(),
> > > > there is a process which is holding system_transition_mutex from snapshot_open().
> > >
> > > /dev/snapshot is not read/writable by anyone but root for obvious
> > > reasons.
> > >
> > > And perhaps it's something that syzbot shouldn't be fuzzing unless it
> > > wants to take the system down easily :)
> >
> > We could turn CONFIG_HIBERNATION_SNAPSHOT_DEV off for syzbot, but it
> > will also mean this part of the kernel won't be tested at all.
> > I see it has 14 ioclt's (below) and not all of them look problematic
> > (like POWER_OFF).
> > Perhaps the kernel could restrict access only to reboot/restore
> > functionality? This way we could at least test everything related to
> > snapshot creation.
>
> This is already restricted to root, why would you want to restrict it
> anymore?

Root like the wrong criteria here. Root protection is for global
machine state and in some cases closing unreliable code. It's not
about if this code should be randomly tested or not. In fact,
unreliable code (bpf, filesystems) is exactly the code that needs to
be tested as much as possible. But it is restricted with root as well.

Though, I noticed syzkaller already avoids SNAPSHOT_FREEZE and
SNAPSHOT_POWER_OFF:
https://github.com/google/syzkaller/blob/bff65f44b47bd73f56c3d6a5c3899de5f5775136/sys/linux/init.go#L310-L315
This should work fine (unless the IOCTL const values don't collide
with any other IOCTL const values, otherwise these duplicate values
won't be tested as well).



> > #define SNAPSHOT_FREEZE _IO(SNAPSHOT_IOC_MAGIC, 1)
> > #define SNAPSHOT_UNFREEZE _IO(SNAPSHOT_IOC_MAGIC, 2)
> > #define SNAPSHOT_ATOMIC_RESTORE _IO(SNAPSHOT_IOC_MAGIC, 4)
> > #define SNAPSHOT_FREE _IO(SNAPSHOT_IOC_MAGIC, 5)
> > #define SNAPSHOT_FREE_SWAP_PAGES _IO(SNAPSHOT_IOC_MAGIC, 9)
> > #define SNAPSHOT_S2RAM _IO(SNAPSHOT_IOC_MAGIC, 11)
> > #define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, struct
> > resume_swap_area)
> > #define SNAPSHOT_GET_IMAGE_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 14, __kernel_loff_t)
> > #define SNAPSHOT_PLATFORM_SUPPORT _IO(SNAPSHOT_IOC_MAGIC, 15)
> > #define SNAPSHOT_POWER_OFF _IO(SNAPSHOT_IOC_MAGIC, 16)
> > #define SNAPSHOT_CREATE_IMAGE _IOW(SNAPSHOT_IOC_MAGIC, 17, int)
> > #define SNAPSHOT_PREF_IMAGE_SIZE _IO(SNAPSHOT_IOC_MAGIC, 18)
> > #define SNAPSHOT_AVAIL_SWAP_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
> > #define SNAPSHOT_ALLOC_SWAP_PAGE _IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)
>
> Fuzzing this is always nice, but be very aware of the system state
> changes that you are creating.  Also know when you make these state
> changes, the rest of the system's functionality also changes.
>
> thanks,
>
> greg k-h
