Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C714DE583
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiCSDre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCSDr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F42B9631
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D56C617B7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA0C340E8;
        Sat, 19 Mar 2022 03:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647661566;
        bh=G+NuDXG6v+YZYRYM7T7C+PGBCWMAjEc/P2kRROv+lq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMpLZWX4oi1Q1NT3X640UADThSxz6H7jK+ycrRA1WPcTO+/hMpGS5yjnVzDcY93Kc
         /1wOYTJa4/UTduuHA2qiDM4NOBSYkBbVRVdfx/0EyaigMqw3IMIw49Nfq/lNbO39lt
         slcRDM/uzUknfMVDag7ugGhtl0MZqnC4x8AVXbBXibmjpcpNj1CF6kms5gzTnZZc0h
         V00Y/PLL4nP9K04vUGnmUsGDEvKVi0SkpCVmalVdDJTISv7mC/BxLbOr+itzB5h4J3
         474oG2EdNH1tCpoLGLUDcsf0nCEQBA9keHI+VG/o2UyVbVAmHatsaQgRzV2VBBHOij
         mVLBneZq4I6JQ==
Date:   Sat, 19 Mar 2022 11:45:12 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
Message-ID: <YjVRyIpIUN1jB8iK@debian>
Mail-Followup-To: Muchun Song <songmuchun@bytedance.com>,
        syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 10:19:12AM +0800, Muchun Song wrote:
> On Sat, Mar 19, 2022 at 6:33 AM syzbot
> <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > Author: Muchun Song <songmuchun@bytedance.com>
> > Date:   Thu Mar 3 01:15:36 2022 +0000
> >
> >     mm: list_lru: allocate list_lru_one only when needed
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> >
> > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
> 
> Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> should be the commit 2768c206f2c3?  What am I missing here?
> 
> [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn

I think it was an incorrect bisect so we could just ignore it.
The fix is already pending for the next merge window.

Thanks,
Gao Xiang

> 
> Thanks.
