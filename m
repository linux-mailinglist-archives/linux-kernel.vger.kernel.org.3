Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDF4E4AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiCWB45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiCWB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540835621F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E0D61465
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89537C340EC;
        Wed, 23 Mar 2022 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648000524;
        bh=kSCpaZcs6hkCplY9uGNsf2FJl2K9ZAY3Artf7nx/gh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDkkIC8qCfqNXvOhBliX16ZFmvwqMnHs7g//69mXSFegupyNnnUm7oZEWXPQVom0d
         NUN/kGRbOMAx8Q5h25oh0rhmk2ybJ+VhqIoHiP3Pg6eEhIjoREiGcpbcf5bxsX6UWb
         VgqqWSB1b2y5GKRaLzoSfNVFhX9DH5nye3HogFr+vAaQ84OFMSOrEqjxyowMUTSVpv
         SFL90xpWi0hjORb+xyhfmMVSpVLXGvvVjU7hNmT7OeIuIEGTWrjLU1Pdj7iIDpS+S2
         3nnKwZruLijlRN7Vp+CjxIrVLV9MR0YJsZ5UzpQ6R9ln36C2+bG73dDx35ctjTRFJB
         GVEY4g2Pw/0yQ==
Date:   Wed, 23 Mar 2022 09:54:58 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
Message-ID: <Yjp98n5sxzfu2q36@debian>
Mail-Followup-To: Dmitry Vyukov <dvyukov@google.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
 <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
 <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:55:29AM +0100, Dmitry Vyukov wrote:
> On Sun, 20 Mar 2022 at 05:19, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 6:33 AM syzbot
> > > <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has bisected this issue to:
> > > >
> > > > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > > > Author: Muchun Song <songmuchun@bytedance.com>
> > > > Date:   Thu Mar 3 01:15:36 2022 +0000
> > > >
> > > >     mm: list_lru: allocate list_lru_one only when needed
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > > > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > > > git tree:       linux-next
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> > > >
> > > > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > > > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
> > >
> > > Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> > > should be the commit 2768c206f2c3?  What am I missing here?
> >
> > Sometimes syzkaller bisection may make mistakes. Please ignore it.
> >
> > >
> > > [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
> >
> 
> Let's tell syzbot so that it reports new bugs in future:
> 
> #syz fix: fs: erofs: add sanity check for kobject in erofs_unregister_sysfs

Thanks! The fix has been landed upstream now.

Thanks,
Gao Xiang
