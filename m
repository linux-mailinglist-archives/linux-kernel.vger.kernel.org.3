Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0024D6C66
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiCLD4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLD4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:56:45 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF819583BC;
        Fri, 11 Mar 2022 19:55:40 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u3so20630156ybh.5;
        Fri, 11 Mar 2022 19:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYnpJ+zUP8B5w8Rud+kPxh1fhi1W4C2mZDFdt2azrTQ=;
        b=bXyksa5Ahr290+ciDUyZ1R0dYNw5B4jaTMTCqgEG5o0fTPHc2SqfTtJJDHhFZ6jWwF
         AC7CVp1Pnu4iBEZslEt6I8lk2H/d5Z4VGlf+NhZIOfyyR4/qI+JWOmeinJ4J99bYU5Kp
         0lC21ZnoAbIQpmpXKPPaQr/VmaEdouJorgsSDbDInASrPAiJhT3VQO2WlZUAy060xfCz
         LUHghQCBFRBoHzaBJXQDEE0xthj8rduuEZCbsCxZfEV9dQOXURHU4n/f1QPIyQYG4b3d
         zCbY1spWT3hw4uaCpTBXg+aqhs59xXNg4mO8PRE8COfqtuk5BjafjY/+iEVE3r+f7T1h
         l28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYnpJ+zUP8B5w8Rud+kPxh1fhi1W4C2mZDFdt2azrTQ=;
        b=foKq3fJZ/AXMJemFhezvpoht+K2PIQAx3QicuHLQFA9/aV1SABi4tD4LAROzCkCUg1
         2KbdYmzoCdDEuKvmry3iq+CgqQ59EtfV5MacbX2xXMHjn4+BX7rzIwPu0iF58Su7Nj5U
         jz+Xm+b18WR2MBJJVf6BhrHZimPHJ2vNpJ0GMmSAvELkz/8Fr9A2vVLTHHTM0zEb/jUA
         LvWIEHiK7vdJGsMMXOw+yumT/r1JIL28cU+g82NrjPU52fWuEhK13Gqt9xnd581LNinW
         lXoNQwK90lIzrV0yJH/U/Ef8mqbm6zKd2POhD/S2JJG+FCTYeTX+CYyiGYY6hrTZh6Ls
         XbmQ==
X-Gm-Message-State: AOAM533zLsCjbECGwqocJ58+P8SQUEv3LvgPlny+Oyphw+lYxyla2mij
        kRBLEQC+sGItsIp0aCks7m4nd4fpE31+fk401VU=
X-Google-Smtp-Source: ABdhPJxNtgBT2+s/rMmUgXF8UAyf8KxRRruHTV6vUkNelZJYpKmTPmxY8/M1jgfllYTQc4ZTZ7lAVghRZc91+FldkZw=
X-Received: by 2002:a25:b2a4:0:b0:628:c38e:43cf with SMTP id
 k36-20020a25b2a4000000b00628c38e43cfmr10467424ybj.21.1647057339780; Fri, 11
 Mar 2022 19:55:39 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com> <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
In-Reply-To: <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 12 Mar 2022 12:55:27 +0900
Message-ID: <CAKFNMoky+O2BBfrcm_m3TV+t1orRByrER=2CQ=ApevgWqSnAGA@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On Wed, Mar 9, 2022 at 5:30 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Tue, Mar 8, 2022 at 4:42 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Tue, Mar 8, 2022 at 4:31 PM Ryusuke Konishi
> > <konishi.ryusuke@gmail.com> wrote:
> > >
> > > Hi Dongliang,
> > >
> > > On Tue, Mar 8, 2022 at 11:22 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > > >
> > > > On Sat, Jan 22, 2022 at 12:22 PM Ryusuke Konishi
> > > > <konishi.ryusuke@gmail.com> wrote:
> > > > >
> > > > > Hi Dongliang,
> > > > >
> > > > > On Sat, Jan 22, 2022 at 9:31 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > > > > > > (added Nanyong Sun to CC)
> > > > > > > Hi Dongliang,
> > > > > > >
> > > > > > > On Thu, Jan 20, 2022 at 11:07 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Hi Dongliang,
> > > > > > >
> > > > > > > On 1/20/22 16:44, Dongliang Mu wrote:
> > > > > > >
> > > > > > > The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> > > > > > > nilfs_sysfs_delete_device_group") only handles the memory leak in the
> > > > > > > nilfs_sysfs_delete_device_group. However, the similar memory leak still
> > > > > > > occurs in the nilfs_sysfs_create_device_group.
> > > > > > >
> > > > > > > Fix it by adding kobject_del when
> > > > > > > kobject_init_and_add succeeds, but one of the following calls fails.
> > > > > > >
> > > > > > > Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")
> > > > > > >
> > > > > > >
> > > > > > > Why Fixes tag points to my commit? This issue was introduced before my patch
> > > > > > >
> > > > > > >
> > > > > > > As Pavel pointed out, this patch is independent of his patch.
> > > > > > > The following one ?
> > > > > >
> > > > > > Hi Pavel,
> > > > > >
> > > > > > This is an incorrect fixes tag. I need to dig more about `git log -p
> > > > > > fs/nilfs2/sysfs.c`.
> > > > > >
> > > > > > I wonder if there are any automatic or semi-automatic ways to capture
> > > > > > this fixes tag. Or how do you guys identify the fixes tag?
> > > > >
> > > > > I guess `git blame fs/nilfs2/sysfs.c` may help you to confirm where the change
> > > > > came from.   It shows information of commits for every line of the input file.
> > > > > If you are using github, 'blame button' is available.
> > > > >
> > > > > If an issue is reproducible, we use `git bisect` to identify the patch
> > > > > that caused the
> > > > > issue, however, even then, try to understand why and how it affected
> > > > > by looking at
> > > > > source code and the commit.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > 5f5dec07aca7 ("nilfs2: fix memory leak in nilfs_sysfs_create_device_group")
> > > > > > >
> > > > > > > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > > > > > ---
> > > > > > > fs/nilfs2/sysfs.c | 5 ++++-
> > > > > > > 1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > >
> > > > > > > Can you describe what memory leak issue does this patch actually fix ?
> > > > > > >
> > > > > > > It looks like kobject_put() can call __kobject_del() unless circular
> > > > > > > references exist.
> > > > > > >
> > > > > > > kobject_put() -> kref_put() -> kobject_release() ->
> > > > > > > kobject_cleanup() -> __kobject_del()
> > > > > > >
> > > > > > > As explained in Documentation/core-api/kobject.rst,
> > > > > > >
> > > > > > > kobject_del() can be used to drop the reference to the parent object, if
> > > > > > > circular references are constructed.
> > > > > > >
> > > > > > > But, at least, the parent object is NULL in this case.
> > > > > > > I really want to understand what the real problem is.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Ryusuke Konishi
> > > > > >
> > > > > > I know where my problem is. From the disconnect function, I think the
> > > > > > kobject_del and kobject_put are both necessary without checking the
> > > > > > documentation of kobjects.
> > > > > >
> > > > > > Then I think the current error handling may miss kobject_del, and this
> > > > > > patch is generated.
> > > > > >
> > > > > > As a result, I think we can ignore this patch. Sorry for my false alarm.
> > > > >
> > > > > Okay, thank you for your reply.
> > > > > If you notice anything we missed on this difference, please let us know.
> > > >
> > > > Hi Ryusuke,
> > > >
> > > > My local syzkaller instance always complains about the following crash
> > > > report no matter how many times I clean up the generated crash
> > > > reports.
> > > >
> > > > BUG: memory leak
> > > > unreferenced object 0xffff88812e902be0 (size 32):
> > > >   comm "syz-executor.2", pid 25972, jiffies 4295025942 (age 12.490s)
> > > >   hex dump (first 32 bytes):
> > > >     6c 6f 6f 70 32 00 00 00 00 00 00 00 00 00 00 00  loop2...........
> > > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > > >   backtrace:
> > > >     [<ffffffff8148a466>] kstrdup+0x36/0x70 mm/util.c:60
> > > >     [<ffffffff8148a4f3>] kstrdup_const+0x53/0x80 mm/util.c:83
> > > >     [<ffffffff8228dcd2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
> > > >     [<ffffffff8238ca5b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
> > > >     [<ffffffff8238d3bd>] kobject_add_varg lib/kobject.c:384 [inline]
> > > >     [<ffffffff8238d3bd>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
> > > >     [<ffffffff81d39d3a>] nilfs_sysfs_create_device_group+0x9a/0x3d0
> > > > fs/nilfs2/sysfs.c:991
> > > >     [<ffffffff81d22ee0>] init_nilfs+0x420/0x580 fs/nilfs2/the_nilfs.c:637
> > > >     [<ffffffff81d108e2>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
> > > >     [<ffffffff81d108e2>] nilfs_mount+0x532/0x8c0 fs/nilfs2/super.c:1316
> > > >     [<ffffffff815de0db>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
> > > >     [<ffffffff81579ba8>] vfs_get_tree+0x28/0x100 fs/super.c:1497
> > > >     [<ffffffff815bb582>] do_new_mount fs/namespace.c:3024 [inline]
> > > >     [<ffffffff815bb582>] path_mount+0xb92/0xfe0 fs/namespace.c:3354
> > > >     [<ffffffff815bba71>] do_mount+0xa1/0xc0 fs/namespace.c:3367
> > > >     [<ffffffff815bc084>] __do_sys_mount fs/namespace.c:3575 [inline]
> > > >     [<ffffffff815bc084>] __se_sys_mount fs/namespace.c:3552 [inline]
> > > >     [<ffffffff815bc084>] __x64_sys_mount+0xf4/0x160 fs/namespace.c:3552
> > > >     [<ffffffff843dd8e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >     [<ffffffff843dd8e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >     [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >
> > > > Unfortunately, there is no reproducer attached to the crash report.
> > > > But I still think there should be another issue in the code.
> > >
> > > The bug is happening in the call to kobject_init_and_add() in
> > > nilfs_sysfs_create_device_group().
> > > So, it looks like a separate issue from your original patch.  Is this right ?
> >
> > Yes, it may not be related to my patch. But it makes me confusing about the bug.
> >
> > >
> > > Which version of kernel does this bug occur on ?
> > > (Are you testing against the latest mainline kernel or some stable version?)
> >
> > I always test against the latest mainline kernel.
> >
> > Now I am checking the log and trying to find error injection in the
> > log file, as said by Pavel.
>
> Attached is the report and log file.
>
> @Pavel Skripkin I don't find any useful error injection in the log file.
>
> In case I made some mistakes, I will clean up my local crash reports,
> update to the latest upstream kernel and restart the syzkaller. Let's
> see if the crash still occurs.

Could you confirm whether your original patch suppresses this error or not ?
If it does, please repost the patch with a commit message that explains
the patch fixes the above issue (oops).

The log shows that a copy of device name (sb->s_id) leaked in your test.
In nilfs, "as-is copy" of "sb->s_id" is only performed in this
kobject_init_and_add() call at nilfs_sysfs_create_device_group().
So, I now suspect that the missing kobject_del() at the error path of
nilfs_sysfs_create_device_group() causes the memory leak.

Regards,
Ryusuke Konishi
