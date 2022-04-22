Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FD50AFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiDVFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiDVF0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:26:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E194F442
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:23:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x191so6490910pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs8TzJaMMRdlcgPCr158FHr4muxROdIwIKSMdWLHkHo=;
        b=G/BsrDbXacV0SZ9Ne77oXKsQiEopiKSGAiAaqGYk4H47zX958UCh8d3h3fFf0mau//
         MbXqvOB66RzNwCOaZyNP4nEsHtnwdkNJyeQgbU5sculwgSThov+D1pKikSKCetXMO262
         ly67chsgg+6zDuX8kxXbJXJsM8vcXDnYmnl9QxhveSX5SgDKMtjFnsuQn0iuvI5xsc9j
         yZHAOh1JlYWxiC8XEu5CIy1vrTrauwUA/V/xI8L4EFalIBpwfuRCuMVn6XSLY6sPj80a
         iRHpIbGzVp89absSi+vJ3vna/H+s3JJdcIcKsKzqb+1fbLbZD42wIsiHagNaDg9+Jm37
         KPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs8TzJaMMRdlcgPCr158FHr4muxROdIwIKSMdWLHkHo=;
        b=aFYeUxAONmAvCSueRIwkt5EXhdzzZbcII1LQ3O93naU9T/MDoWJ4EXxL/nf30ODduk
         oLc8i20Kjnh1iFH9zGlTAbWcjhmqZYm2ZpeXrX+ZmFiY+5bECyHg0cJMiXAXmDtgnV5G
         NUSF2c1uwqnMnBjFzOX24bogtUhuO78vNEfcDiAdDZZRRCD91BXoFylWREBijUPh0g/J
         uXAB57iMOOx7H4FdGsh5cgTzu7slJajH8rBV85ifaVPj25Vf4emXokr0Gmqd6GYvjB3G
         arRZK2kBG8t5D9lBDVC3xZvvfCaWRbWDafyKH+6iyFpBvTrFkcjnLt6sShAUuDxFJNRV
         5gig==
X-Gm-Message-State: AOAM5335MGVTuNucmEA9pVTwkJD4aavCRfgHUvmPON7eqs274Zn3yYYy
        dWRBhcHsYLdtRpxc0wNdNjgB4+k+QgrWWSxASpc=
X-Google-Smtp-Source: ABdhPJxGskIJDKnYp4O7Zl7AraYPDKiRG6aG0jNJsiX2fxEPmngjRzXg5dlvN+nBrUVDoTsMOaf4Dqsi7enIghU44k4=
X-Received: by 2002:a65:5b4b:0:b0:3a3:d8fb:6926 with SMTP id
 y11-20020a655b4b000000b003a3d8fb6926mr2507143pgr.76.1650604994231; Thu, 21
 Apr 2022 22:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
 <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com> <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
In-Reply-To: <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 21 Apr 2022 22:23:02 -0700
Message-ID: <CANaxB-zDKVtGTRrqh4SpPKS96Ux6s01BL3BdAe-ZY_9HWSX9dw@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 9:30 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The pipe part sounds like a horrible hacky thing.
> >
> > I also assume you already tried that, and hit some performance issues.
> > But it does sound like the better interface, more directly what you
> > want.
> >
> > So what are the problems with using process_vm_readv?

The big advantage of vmsplice is that it can attach real user pages into
a pipe and then any following changes of these pages by the process
don't trigger any allocations and extra copies of data. vmsplice in this
case is fast. After splicing pages to pipes, we resume a process and
splice pages from pipes to a socket or a file.  The whole process of
dumping process pages is zero-copy.

>
> Actually, I take that back.
>
> Don't use pipes.
>
> Don't use process_vm_readv().
>
> Use the system call we already have for "snapshot the current VM".
>
> It's called "fork()". It's cheap, it's efficient, and it snapshots the
> whole VM in one go. No stupid extra buffers in pipes, no crazy things
> like that.
>
> So just make your pre-dump code do a simple fork(), let the parent
> continue, and then do the dumping in the child at whatever pace you
> want.
>
> In fact, you might just leave the child process alone, and let it _be_
> that pre-dump.
>
> You can create a new snapshot every once in a while, and kill the
> previous snapshot, if you want to keep the snapshot close to the
> target, and then use the memory tracking to track what has changed
> since.
>
> And you might not want to use plain "fork()", but instead some kind of
> "clone()" variant. You might want to use CLONE_PARENT and some
> non-SIGCHLD exit signal to basically hide the snapshot image from the
> thing you are snapshotting.
>
> Anyway, the "use vmsplice to a pipe to create a snapshot" sounds just
> insane when you have a very traditional system call that is all about
> snapshotting the process.
>
> Maybe a new CLONE_xyz flag could be added to make that memory tracking
> integrate better or whatever.
>
> Any showstoppers?

We considered this approach. CRIU dumps a tree of processes. In many
cases, it's a container with its pid namespace. In such cases, it isn't
possible to fork helper processes without affecting the behavior of
dumped processes. First, helper processes will be visible for dumped
processes. Second, waitid with __WALL will wait for our helpers and a
dumped process can be very surprised to find a child that it hasn't
created. For the pre-dump, we don't need a true memory snapshot, we
don't care about changed pages. But if we fork a process in the wrong
moment, we can double its memory consumption and as this is happening in
a dumped process context, we can hit its resource limits or trigger OOM
in a dumped container.
Forking a helper itself can hit resource limits such as rlimits or
cgroup limits.

Thanks,
Andrei
