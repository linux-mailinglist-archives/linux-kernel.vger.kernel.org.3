Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FE487443
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbiAGItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346181AbiAGItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:49:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02396C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:49:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g11so13155048lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFIR/uG+ezKrSRft5Fjc/6qgQZpqXtpbYwZlKrolyBI=;
        b=EPjRpFxeAOL5ruGpOFP9TB1lKbJCbfoKYbxjlUtpeTvc+gd53NIICxNWvl3R1Y9601
         9bwUwDFv+PCYE1hSyjaATzGGtQ0GebLMpf1FWs3khCbXQ0I7DxRmjW5BLkJMRxtkJMIv
         Lt0Xzt56zUCwRWeUCy0cLvrkQCVtb7epfWkemPi9spuNw8b9/D9rXZUrUT5cmZASuspk
         pvgYGvtM/4+ZCzLfaa8ZW+36xDieteTr98WJoJWOE6VcqGDj2L6iAMxs4MzM80UyJ27/
         M+Qp+7DMRzoG5LmyXx+lUqnWcj+kUQsnjxwI6yb3vaiqHWn96NIgZAZp23k69YUi3I+7
         7NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFIR/uG+ezKrSRft5Fjc/6qgQZpqXtpbYwZlKrolyBI=;
        b=ztv2Yx1Po/Y4vMnBpLy3N/lYt9ORXiQH4v+PJZm5+jjAglsuNnxoEaoGsUBH/B7dnb
         lXJsMztPzWZ8jMqdG/VxLC15nV9xT1vUfcw+nETolX0L3js/ou2oZej5ZCk48Trnw1/r
         JQJvtF0Co9QRsdvPMKIhDPZ4OrnmjIO9gx4Ctg8SEsZOVGOLRroLv86MVA4qx9yoxMpf
         UyEimsEHFbbHBJodalRrY18BmkPcQjVD1ytVrc+UcgSSOx70sny2HAjXOLPDFQZal+SQ
         vUMtY4gXegql8pnXAV26t6w0cbEP2BmeXmWS532M2gxfq/ZvhsU3FFNLRdTFvGW/pQUv
         d2DQ==
X-Gm-Message-State: AOAM530sueNCdQJaV1CjlRQ1exBL3oXmMZEMeZcZmRR26zHF8BuaDqyQ
        cumUT/g+b5uVKZRzXdlXkGaCsLBKSFbHD/fk5SLrJEGy9+C9rw==
X-Google-Smtp-Source: ABdhPJzAv2NLTpJ1v0haPGOEU+pdJb4gIC5IXAchiRWpKGjAMTLWgrBbxhgux6AyqMYBZ5E/WzWCGOor5Zjj7bUhh1w=
X-Received: by 2002:ac2:4895:: with SMTP id x21mr56297330lfc.336.1641545351905;
 Fri, 07 Jan 2022 00:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20211224065728.5820-1-yinxin.x@bytedance.com> <YdZgYvC4K87PiMfO@mit.edu>
In-Reply-To: <YdZgYvC4K87PiMfO@mit.edu>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Fri, 7 Jan 2022 16:49:01 +0800
Message-ID: <CAK896s7kJ47Q857u-+vBsera95tSJkxMy2Qhqk-91YjbR3QSdA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RESEND] ext4:fix different behavior of
 fsync when use fast commit
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation and direction , I will do another fix for this issue.



Best Regards,
Xin Yin


On Thu, Jan 6, 2022 at 11:22 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Dec 24, 2021 at 02:57:28PM +0800, Xin Yin wrote:
> > For the follow test example:
> > -mkdir test/
> > -create&write test/a.txt
> > -fsync test/a.txt
> > -crash (before a full commit)
> >
> > If fast commit is used then "a.txt" will lost, while the normal
> > journaling can recover it.
>
> The problem is that your proposed fix:
>
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 3deb97b22ca4..4b843648ffe5 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -423,7 +423,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
> >       args.op = EXT4_FC_TAG_CREAT;
> >
> >       ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
> > -                                     (void *)&args, 0);
> > +                                     (void *)&args, 1);
> >       trace_ext4_fc_track_create(inode, dentry, ret);
> >  }
>
> affects both file creations as well as directory creations (mkdir).
> Putting the inode on the fast commit list is something that is meant
> for files, and means that on a fast commit we need to force the data
> blocks out.  So it seems that isn't the right fix for the problem.
>
> Why do something really simple?  Look at the parent directory's inode,
> and check its i_sync_tid.  If it's not equal to
> handle->h_transaction->t_tid, then it's safe to do the fast commit.
> If it's equal to the current transaction, we can either force a full
> commit.
>
> Optionally, in the case where i_sync_tid == current tid, since there's
> a chance that the parent directory's inode could have been freshly
> fetched from disk (see __ext4_iget() in fs/ext4/inode.c), we could
> compare its i_crtime against ktime_get_real_seconds(), and if the
> inode was created in the last 2*journal->j_commit_interval/HZ seconds,
> it's safe to do a fast commit; otherwise do a full commit.
>
> Cheers,
>
>                                         - Ted
