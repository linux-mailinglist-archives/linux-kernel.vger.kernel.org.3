Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4850CD62
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiDWU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDWU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:26:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3F1D83A5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:23:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j8so18343047pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1IbIo9g2avy7esoGs8UpolEry/ei+Irc3zRH03DXPA=;
        b=j/YCjwc0EXUxe8lPb6euKJQxi21je7n75sq8x/F9BEt9kOnWBI3fHFW+FOHPp5mrW4
         saYJtCKfXXIUFNhCw5SQ+tNrle8QjQC7DXOwOKt3gjqDU5DYZTb69PnImd1H1oXY8vDz
         tDicPj1UXn+dEirSKTLc0vO648sTJqta8Q90xItG/eEfADFVUeW/lPWF1klF9vp/ImKI
         dX77IpsO/FuZRRZL7hWlUbJZzUz+rRZBW8kBjw+q3i/zXWLIbOhho6K7aqrunWIkytQl
         EfaMaIdnT7/cExv5jqUAt6BEp/wcIN3flwKq7NO8fjJvLWvTgfnXjrqah9CXNl2rbFBJ
         yF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1IbIo9g2avy7esoGs8UpolEry/ei+Irc3zRH03DXPA=;
        b=7IPhTWQ1HXojMybqrlcRl8gf2XM67BCA/Sd7zRArUwJJGbNNOAqBZjDyfnYR3tYsbV
         eoNieGMFAXmdLdaIJvXtI5YL+EpXFcHogRTTHwCqCwsytbutzrNw/PZMoYC8BJRy+YDx
         INOEDnX3oHlQMterUzmTjoRZBHlVuf3q6cQrtBu76A1wu1UD2twIQQ4zUIAAM0SN2xxN
         i1sD0mXLuJO7J0sb2jOrxxdPkQoekzuOny4ECRWP6dJEtBLgvihxJdTfQGEdTs4clVIZ
         YnDmSf96u3eEZq+VyUOLwnbjkW12d/Cv5CKXHHINFxzJDjkEv3RbSG3q7XVQH1PqnqWC
         ebXA==
X-Gm-Message-State: AOAM533TRdWR28o0UU+hwHMnEe67fmegWWLcy8FkcDuim08PrGws9fFd
        2Sf4+IYF75KqxeI+09qHVqswFkexTeIBy5oKOe8=
X-Google-Smtp-Source: ABdhPJw2vPPcNTAvK1kfUBmlOcRmL4+ZFP4yJiNg2RomcAtfYQW0nI0sdlezGXRmIBoyVZs6dvz50V9oU9C/CeFtQS4=
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id
 oo6-20020a17090b1c8600b001bf2a7e5c75mr12322109pjb.145.1650745420880; Sat, 23
 Apr 2022 13:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
 <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
 <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
 <CANaxB-zDKVtGTRrqh4SpPKS96Ux6s01BL3BdAe-ZY_9HWSX9dw@mail.gmail.com> <CAHk-=wj8OCHqYkB2hVQ2FG6n5g4R0H3eetzbo9NrHooY1-4pwg@mail.gmail.com>
In-Reply-To: <CAHk-=wj8OCHqYkB2hVQ2FG6n5g4R0H3eetzbo9NrHooY1-4pwg@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sat, 23 Apr 2022 13:23:27 -0700
Message-ID: <CANaxB-whArowHWaWsFMJf6B4idPabAmJNawzk9FdokNQ-1xrSA@mail.gmail.com>
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

On Fri, Apr 22, 2022 at 10:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 10:23 PM Andrei Vagin <avagin@gmail.com> wrote:
> >
> > The big advantage of vmsplice is that it can attach real user pages into
> > a pipe and then any following changes of these pages by the process
> > don't trigger any allocations and extra copies of data. vmsplice in this
> > case is fast. After splicing pages to pipes, we resume a process and
> > splice pages from pipes to a socket or a file.  The whole process of
> > dumping process pages is zero-copy.
>
> Hmm. What happens if you just use /proc/<pid>/mem?
>
> That just takes a reference to the tsk->mm. No page copies at all.
> After that you can do anything you want to that mm.
>
> Well, anything a /proc/<pid>/mm fd allows, which is mainly read and
> write. But it stays around for as long as you keep it open, and
> fundamentally stays coherent with that mm, because it *is* that mm.
>
> And it doesn't affect anything else, because all it literally has is
> that mm_struct pointer.

I think the main reason for using vmsplice&splice was zero-copy. I wrote
a small benchmark to compare /proc/pid/mem, process_vm_readv, and
vmsplice. This benchmark emulates how criu dumps memory. It creates a
child process and dumps its memory into a file. The code is here:
https://github.com/avagin/procmem.

Here are results from my laptop:
$ ./procmem [CMD] [DUMP FILE] [BUF_SIZE] [MEM_SIZE]

$ ./procmem splice /tmp/procmem.out 1048576 2147483648
ok 4877 MB/sec
ok 4733 MB/sec
ok 4777 MB/sec
ok 4766 MB/sec
ok 4821 MB/sec
ok 4777 MB/sec
ok 4798 MB/sec
ok 4798 MB/sec
ok 4798 MB/sec
ok 4798 MB/sec

$ ./procmem mem /tmp/procmem.out 1048576 2147483648
ok 3236 MB/sec
ok 2651 MB/sec
ok 3216 MB/sec
ok 3211 MB/sec
ok 3216 MB/sec
ok 3206 MB/sec
ok 3211 MB/sec
ok 3216 MB/sec
ok 3206 MB/sec
ok 3211 MB/sec

$ ./procmem process_vm_readv /tmp/procmem.out  1048576 2147483648
ok 3833 MB/sec
ok 3075 MB/sec
ok 3792 MB/sec
ok 3792 MB/sec
ok 3819 MB/sec
ok 3813 MB/sec
ok 3819 MB/sec
ok 3806 MB/sec
ok 3799 MB/sec
ok 3813 MB/sec

vmsplice & splice  is the best. /proc/pid/mem is 30% slower.
process_vm_readv is 20% slower.

Thanks,
Andrei
