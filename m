Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53B488788
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 04:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiAIDHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 22:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiAIDG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 22:06:59 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5676C061401
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 19:06:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x6so31249612lfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFCwYYaJtD+h2CoX9K4/NZ5SGhf2H1bVCDfwVf5ZnaA=;
        b=x+hO075Zb+7GRSUV9aG8zqpNACbm6t+feW3NUoUSwEIbXVBxTRO8yVlccyN4VlSrdE
         L9FR7IP1T9evnFvXoaGfuENot73h3pmsPMDYFhLkwEhKJnuXO3nM/zMHHWMB9tsW/vra
         eIOvLPUUkDWLYU39/Do15z0089WpoOlr6y8afMJOVa+Gb2rzvr6hBtmpuN6Xtwt1VQcz
         3SwuatDMtH1xU6AFiLqSTNgdw7RQ7cV++pe7+EsBNbm1OyQMQylFqgsyjWVhJGx6U7zR
         AkhgJQ0IS3GRU9KioQKZuIjMLM2N1DauqdB4WNoX5JxISYotrK+Pc7L2g6c8d41tc08a
         va/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFCwYYaJtD+h2CoX9K4/NZ5SGhf2H1bVCDfwVf5ZnaA=;
        b=L4AYQfVr/bLZ2GyhTQkUmnqMU6ULzf13taKO8//jzpOeeg5P6LiKuNnxzrl8MiGjl1
         94Z6aEy1UTZL32yT0SCBN7ICar/ryZegB89J8rIjgzKg64hz9Ji2AyVgvY0yAa6CT0aF
         Pzex8YPlNO/KAbDVPl5833rhQfJJRswVEs2t15q2UOG98JTcnRqAdQe9NANx4ymaf+Dt
         Z4YJJK46uLYFF2dbj+Y5BpGlUjVtdXoqF2wQ1YVmhkC6mXp1JgC0qGOEexbpUOlQQXRJ
         ojVOVh85eBxARP/JNw9hqC0cAwY3WpGxD5GLcGylPLGrdHOqcd+29F8lFWLrxVzQJ4fb
         MUQg==
X-Gm-Message-State: AOAM532PqU50kHcYIPh3jyczIaHD3C67xycBft0gr9foU26IhI6Q31v0
        yGwSVgNLkRAVd4a7Sgzn1me6o5rFmxQRSXTq0ahp7KXsm01TVg==
X-Google-Smtp-Source: ABdhPJxvausqaOYs2BnXRzqzBzqDLZZUmhpxFhxAuHSvo7IoIago7aHJnckO+yIQhj29ZGiwNI0V0vPF+NciFtsbKIQ=
X-Received: by 2002:a19:4957:: with SMTP id l23mr762202lfj.298.1641697616943;
 Sat, 08 Jan 2022 19:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20220107121215.1912-1-yinxin.x@bytedance.com> <20220107121215.1912-3-yinxin.x@bytedance.com>
 <CAD+ocbxUaQMjhOof-zphqYs2MvtqtM5dLxmfxmRGrj2sORZ+sQ@mail.gmail.com>
In-Reply-To: <CAD+ocbxUaQMjhOof-zphqYs2MvtqtM5dLxmfxmRGrj2sORZ+sQ@mail.gmail.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Sun, 9 Jan 2022 11:06:46 +0800
Message-ID: <CAK896s5EV9AOenyPrHJFk7=R--RGhH0eWeVU55vnScSJmM6qwA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] ext4: fast commit may miss file actions
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, you are right , the EXT4_MF_FC_COMMITTING is not needed after
this change , I will do the cleanup for it , and send a v2 patches
set.

Thanks,
Xin Yin

On Sat, Jan 8, 2022 at 4:14 AM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Makes sense. With this change, we don't really need
> EXT4_MF_FC_COMMITTING flag anymore. So, we can drop it. But other than
> that, this patch looks good.
>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> On Fri, Jan 7, 2022 at 4:13 AM Xin Yin <yinxin.x@bytedance.com> wrote:
> >
> > in the follow scenario:
> > 1. jbd start transaction n
> > 2. task A get new handle for transaction n+1
> > 3. task A do some actions and add inode to FC_Q_MAIN fc_q
> > 4. jbd complete transaction n and clear FC_Q_MAIN fc_q
> > 5. task A call fsync
> >
> > fast commit will lost the file actions during a full commit.
> >
> > we should also add updates to staging queue during a full commit.
> > and in ext4_fc_cleanup(), when reset a inode's fc track range, check
> > it's i_sync_tid, if it bigger than current transaction tid, do not
> > rest it, or we will lost the track range.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/ext4/fast_commit.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 3673d4798af3..4cea92aec7c4 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -365,7 +365,8 @@ static int ext4_fc_track_template(
> >         spin_lock(&sbi->s_fc_lock);
> >         if (list_empty(&EXT4_I(inode)->i_fc_list))
> >                 list_add_tail(&EXT4_I(inode)->i_fc_list,
> > -                               (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
> > +                               (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> > +                                sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
> >                                 &sbi->s_fc_q[FC_Q_STAGING] :
> >                                 &sbi->s_fc_q[FC_Q_MAIN]);
> >         spin_unlock(&sbi->s_fc_lock);
> > @@ -418,7 +419,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> >         node->fcd_name.len = dentry->d_name.len;
> >
> >         spin_lock(&sbi->s_fc_lock);
> > -       if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
> > +       if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> > +               sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
> >                 list_add_tail(&node->fcd_list,
> >                                 &sbi->s_fc_dentry_q[FC_Q_STAGING]);
> >         else
> > @@ -1202,7 +1204,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> >                 list_del_init(&iter->i_fc_list);
> >                 ext4_clear_inode_state(&iter->vfs_inode,
> >                                        EXT4_STATE_FC_COMMITTING);
> > -               ext4_fc_reset_inode(&iter->vfs_inode);
> > +               if (iter->i_sync_tid <= tid)
> > +                       ext4_fc_reset_inode(&iter->vfs_inode);
> >                 /* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
> >                 smp_mb();
> >  #if (BITS_PER_LONG < 64)
> > --
> > 2.20.1
> >
