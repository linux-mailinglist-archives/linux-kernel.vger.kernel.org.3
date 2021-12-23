Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0E47DE17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbhLWDdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbhLWDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:33:04 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D78C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:33:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g26so9460155lfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX2Kl8gX8k0KfOlSMTUJ+96I9WihRqVBiBHr2BpI2AU=;
        b=q1ZGJQm352acTdJlVioJ745aU5C2emD6YmiJ8jyG2AUiQNmUQZj4+0+iIopCLcH0AR
         y1qSdZgS06lUFAlUheRK4b/MTDPUwSNyUeCfcsr7l9QW3ITBkOKD/UXQ4SA0STKfDpvV
         M1j2uM8zrzLslu6Quni+zt9t2S07CK0kGy/VXptObA5E9binLDR9Tnt1VrFTcBklvW2u
         LH9nX4TKIzL2sBHVkW9ntcOJk0tr5NoL1teKBRlVP2WHsEU9ilcDfsHeXv7qNlUZnQl+
         8N1phLOYtU7DJBqXvanlHFttOxThI4+yw40jbofBJq30LMQVsZ9P918OyVoTj2Z0ShsS
         orBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX2Kl8gX8k0KfOlSMTUJ+96I9WihRqVBiBHr2BpI2AU=;
        b=izxa8s4C1mOJDa19WIMj1k5nNxufEtjfHPYzeb6x/B3TTOFacTDDelnjp0dyLlfdLT
         QADKOWh5lirICRtSY/cpH7hq30Eacylb/33LJyo6oi5u/a4r2pcXhFJBuwo8Ez4sMB2r
         8FnmmfVvtyF1VOVOR95dffTIdUNF0L8g9vhdmiZFCp1f+lgsorBP6H+LogZWj1B1ILBs
         biEUQLh8b45yFutDPSNqAxRp2wH3TOsO4Njd9tVwAF3fZ/SMPjGirIDRaoxJ6djHsEXL
         8rOO3Wxaukl4ZeE8LTnzG7gEWZZIdHlVsYbaZhgx/Es1F8tjFBWsl3dMKsV+t3iyrZi0
         KREw==
X-Gm-Message-State: AOAM531I/HwCUWdZTIK4xhFVIuWo8fz6tmLobklf98sGEh3OMCTRetH3
        V7TyTe7iTtigYPGlKyzzhFZ+I6siURqjWCbot9P9d9yUOVV1qQ==
X-Google-Smtp-Source: ABdhPJw50J2CrfZrnaDw/giHJvA7J4IAiiK8Redb8hH8NZ48XlhWynPVxeAiXjLS29fkWSmXQGP0MkVrQ4BsPDMWreE=
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr501609lfu.13.1640230379978;
 Wed, 22 Dec 2021 19:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20211216080303.388139-1-yinxin.x@bytedance.com>
 <CAD+ocbzWryj6FnHR4naiBvNHN4WqyuGo_n-52J_42jpLVLeAew@mail.gmail.com> <CAD+ocbx=e14c1wwv7zpp2N7v=kSHPD=muBC37PcRrdUDqtDKCA@mail.gmail.com>
In-Reply-To: <CAD+ocbx=e14c1wwv7zpp2N7v=kSHPD=muBC37PcRrdUDqtDKCA@mail.gmail.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Thu, 23 Dec 2021 11:32:49 +0800
Message-ID: <CAK896s4L00RU6jxJheimfGOZ382bGP_Dv=j5xwyhEmup0XY5WQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ext4: call fallocate may cause process to
 hang when using fast commit
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying Harshad's patch series "ext4 fast commit API cleanup" ,
this issue has been fixed.
So , please ignore this patch.

Thank,
Xin Yin

>On Thu, Dec 23, 2021 at 10:44 AM harshad shirwadkar <harshadshirwadkar@gmail.com> wrote:
>
> Once the patch series "ext4 fast commit API cleanup" gets merged in
> (https://patchwork.ozlabs.org/project/linux-ext4/list/?series=277672),
> this patch won't be required anymore. So, I'll undo my review in favor
> of merging the API cleanup patch series first.
>
> - Harshad
>
> On Fri, Dec 17, 2021 at 12:17 PM harshad shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > Thanks for the patch Xin, it looks good to me. I think there are a few
> > other places where we are not stopping the transaction before calling
> > commit. I'm trying to find them out.
> >
> > Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > On Thu, Dec 16, 2021 at 12:04 AM Xin Yin <yinxin.x@bytedance.com> wrote:
> > >
> > > If open a file with O_SYNC, and call fallocate with mode=0.when using
> > > fast commit, will cause the process to hang.
> > >
> > > During the fast_commit procedure, it will wait for inode update done.
> > > call ext4_fc_stop_update() before ext4_fc_commit() to mark inode
> > > complete update.
> > >
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > > ---
> > >  fs/ext4/extents.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 4108896d471b..92db33887b6c 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -4707,8 +4707,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> > >                 goto out;
> > >
> > >         if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> > > +               ext4_fc_stop_update(inode);
> > >                 ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> > >                                         EXT4_I(inode)->i_sync_tid);
> > > +               inode_unlock(inode);
> > > +               trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> > > +               return ret;
> > >         }
> > >  out:
> > >         inode_unlock(inode);
> > > --
> > > 2.20.1
> > >
