Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7655663F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGEHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGEHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:20:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFEB487
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:20:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so1488992lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4mVbSKrcj1JIa6wIReN7FHnhaFXZQGaTOq3nTowIsQ=;
        b=LeZlLQ44zCsdo9tcCU9ql/QbMxiQhhyLRjM3FIs090x8oSd7Zm8KeWyBEo7aLY5eJi
         cxisyRG08Z+ZryXIbY9hplYZZGDEKdd7UHUasypPFkVcbQY86AyAOFZEROgkQmWmp++v
         TgE0qruQFTFuhV2Ka5/rIrCs1QnaZ0eWxdEgoJB0muw6nwFQYMfVlaLh49bnccUEWCaT
         nY39MadWPKzj9cry8pB13AHz9AbpGwA4Ju0aGRbVhGZ3bUbhqDnaRl8vwcYgZZ12qb3Y
         iIkzKNZ6MhhwlF7FXE6UJB+9dFOj4BmS0mbz5lHTMxCYyH+NGvJYvXmUvozSdU8Q1yYD
         Oblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4mVbSKrcj1JIa6wIReN7FHnhaFXZQGaTOq3nTowIsQ=;
        b=INYbYMGgt9Aia8fMCcpwHMuZfFIJiySwNtrAaxbYRZkFenTFfFS3NF3xShHG/mJSb6
         8cgB8QOrGb9a2dWdfwFwZAxd7kEMQ4/Oi7IHcPMBwBfw8MKxVsIyMmeUk1HswW269G+l
         y0Bs2APSLrrLvv9rNcVnDq3TJIiwB9/ovPcYVwmKPiWm3MwG6JAHF3z7VZ+3yGxWIFU/
         QvccOVtihV6R6ecVnYwxvlJw5vWmodhB1qWxuWr4dwXzP1zOT4HdNwf0+eGVvM8Ho5LU
         FR0jORwtoZeBPP5b1ol22a/fdW0aCHjQ916+/Qh4JWhH6Rr7VcscH7Pwzht5LXHkSBuX
         zvGw==
X-Gm-Message-State: AJIora+WiQ9rCGxu7TiTnlA4o16Hkd5DNXd3dzYbPqpMJ6euvjuW+JAR
        7fKQNU0zphgS28ix+mbWes06d4jiHKYyNo6APbm23hX0Q0Yrnw==
X-Google-Smtp-Source: AGRyM1uwTl27DuMBpFFrHmay/NaZ9dcNX01sliNY5dVmL9w1PSC/+XNJhSrWjHOif0lxQBrgMPqvS4r6QYv8oMoa08o=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr21240275lfg.417.1657005635698; Tue, 05
 Jul 2022 00:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <YsPOEYU7ZqmpD8dw@kroah.com> <a1fcc07e-51ef-eaad-f14b-33f1263e45ac@I-love.SAKURA.ne.jp>
In-Reply-To: <a1fcc07e-51ef-eaad-f14b-33f1263e45ac@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Jul 2022 09:20:24 +0200
Message-ID: <CACT4Y+bUw8LebceH0fDZriqAivuwNSNntTTS1647CQF-j2C4RQ@mail.gmail.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 07:54, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On Tue, Jul 05, 2022 at 02:21:17PM +0900, Tetsuo Handa wrote:
> > On 2022/07/04 23:31, Greg KH wrote:
> > > I don't understand what you are trying to "fix" here.  What is userspace
> > > doing (as a normal user) that is causing a problem, and what problem is
> > > it causing and for what device/hardware/driver is this a problem?
> >
> > Currently the root cause is unknown.
> > This might be another example of deadlock hidden by device_initialize().
> >
> > We can see from https://syzkaller.appspot.com/text?tag=CrashReport&x=11feb7e0080000 that
> > when khungtaskd reports that a process is blocked waiting for misc_mtx at misc_open(),
> > there is a process which is holding system_transition_mutex from snapshot_open().
>
> /dev/snapshot is not read/writable by anyone but root for obvious
> reasons.
>
> And perhaps it's something that syzbot shouldn't be fuzzing unless it
> wants to take the system down easily :)

We could turn CONFIG_HIBERNATION_SNAPSHOT_DEV off for syzbot, but it
will also mean this part of the kernel won't be tested at all.
I see it has 14 ioclt's (below) and not all of them look problematic
(like POWER_OFF).
Perhaps the kernel could restrict access only to reboot/restore
functionality? This way we could at least test everything related to
snapshot creation.

#define SNAPSHOT_FREEZE _IO(SNAPSHOT_IOC_MAGIC, 1)
#define SNAPSHOT_UNFREEZE _IO(SNAPSHOT_IOC_MAGIC, 2)
#define SNAPSHOT_ATOMIC_RESTORE _IO(SNAPSHOT_IOC_MAGIC, 4)
#define SNAPSHOT_FREE _IO(SNAPSHOT_IOC_MAGIC, 5)
#define SNAPSHOT_FREE_SWAP_PAGES _IO(SNAPSHOT_IOC_MAGIC, 9)
#define SNAPSHOT_S2RAM _IO(SNAPSHOT_IOC_MAGIC, 11)
#define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, struct
resume_swap_area)
#define SNAPSHOT_GET_IMAGE_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 14, __kernel_loff_t)
#define SNAPSHOT_PLATFORM_SUPPORT _IO(SNAPSHOT_IOC_MAGIC, 15)
#define SNAPSHOT_POWER_OFF _IO(SNAPSHOT_IOC_MAGIC, 16)
#define SNAPSHOT_CREATE_IMAGE _IOW(SNAPSHOT_IOC_MAGIC, 17, int)
#define SNAPSHOT_PREF_IMAGE_SIZE _IO(SNAPSHOT_IOC_MAGIC, 18)
#define SNAPSHOT_AVAIL_SWAP_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
#define SNAPSHOT_ALLOC_SWAP_PAGE _IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)
