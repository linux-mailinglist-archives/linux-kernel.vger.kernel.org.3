Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766C4A7911
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiBBT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBBT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:57:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11717C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:57:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q22so665068ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3CIuft7MFInnh1xqsvdSm7aJQ1m6iJ5S3C53p3CCUHc=;
        b=T+H7wnmd7kfHJC8X6vmZGalF+103bfBAMVkRiADef73+EKFKl9I+0ZlOTqDGdHCbH8
         Q1oEbfCllEYRsp1prWpBrTlb+wDNxqeKUCEiyHGRfzjNO5kIqgYkyrw4wwd8RflWRmTf
         Dkk3ZXyyLRzNW7qPpijDbsy8MZ3iQPAwtclg2Ct3ARAa0hPaa+nPn4DYtTVDW5uKy4P9
         UJ0Px0+NhrQOFwDsqscBS8Tx2i0jbB/YL7rF42aizdgvyxaUYlDt/jxwHDk7l3Sl+pwb
         zUwh9fKqC3w8wLR2xhFRNELmJ5MgyIReJLSwXta04u6CnM18+RljvoLA+vzD1Bn4h5AJ
         dN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3CIuft7MFInnh1xqsvdSm7aJQ1m6iJ5S3C53p3CCUHc=;
        b=tA1L8IoA1gEJffyiN+0uAQMwppUmwyRuIJRWzE8Fa26RJq7wrB5TNDOP9wfNhdxmAS
         6CoqqZu6mqqSYAamANU+1e4vuy5iRBW2LeH/x0Cek0D7MXjmm3f8ExaOxHaCg641TBAA
         ErBDlVblkPw070Rld/XhzBU0rnbZNySQLhAjOgVGoTq5tOFJJDjMH1W9NpnHaIivkq6R
         nhpdrpQzssMamC81iiL/jOVLGJFU4t0VX1ERyPCw8hueJgy3x3HN77wUklVLc94Om/4x
         1YHbDZRbLqbEoOrIq1U4L+IRcnnZP9rDWb0+LjyxbHrJ6Zqy+LDz4sUPyahMbyzraRTk
         EpaA==
X-Gm-Message-State: AOAM531JldYLnWvQiX/GQ1uWXHhwNWhxj2SDdeohdSFjA0Z/y2j8iaGJ
        2jkqc3SSY+1F9XdHCAHD3Ch0lP4C/WI=
X-Google-Smtp-Source: ABdhPJy6YqLj2e3pYrZsKt8LhaB5KzLWfvsSR0JWSNWS0CYNQ1l6b/Lka0LlJ0u8hGKE8GE3PaWlDw==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr20067068ljj.316.1643831847205;
        Wed, 02 Feb 2022 11:57:27 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id a2sm3967086lfl.246.2022.02.02.11.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:57:26 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 567C95A0020; Wed,  2 Feb 2022 22:57:25 +0300 (MSK)
Date:   Wed, 2 Feb 2022 22:57:25 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kcmp: Comment get_file_raw_ptr() RCU usage
Message-ID: <YfriJS+kgoGbaMmz@grain>
References: <20220202151734.10418-1-jandryuk@gmail.com>
 <YfrC/fQvQ1nkIJNJ@grain>
 <CAKf6xpsfDpEpjSjYbGU5fQOxqjccbu3CAXTxpcKggKYu6qEfNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xpsfDpEpjSjYbGU5fQOxqjccbu3CAXTxpcKggKYu6qEfNA@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:48:48PM -0500, Jason Andryuk wrote:
> On Wed, Feb 2, 2022 at 12:44 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> >
> > On Wed, Feb 02, 2022 at 10:17:34AM -0500, Jason Andryuk wrote:
> > > This usage of RCU appears wrong since the pointer is passed outside the
> > > RCU region.  However, it is not dereferenced, so it is "okay".  Leave a
> > > comment for the next reader.
> > >
> > > Without a reference, these comparisons are racy, but even with their use
> > > inside an RCU region, the result could go stale.
> > >
> > > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > > ---
> > > I was looking for examples of task_lookup_fd_rcu()/files_lookup_fd_rcu()
> > > and found this.  It differed from the example given in
> > > Documentation/filesystems/files.rst, so I was initially confused.  A
> > > comment seemed appropriate to avoid confusion.
> > >
> > >  kernel/kcmp.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/kernel/kcmp.c b/kernel/kcmp.c
> > > index 5353edfad8e1..4fb23f242e0f 100644
> > > --- a/kernel/kcmp.c
> > > +++ b/kernel/kcmp.c
> > > @@ -63,6 +63,9 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
> > >  {
> > >       struct file *file;
> > >
> > > +     /* This RCU locking is only present to silence warnings.  The pointer
> > > +      * value is only used for comparison and not dereferenced, so it is
> > > +      * acceptable. */
> > >       rcu_read_lock();
> > >       file = task_lookup_fd_rcu(task, idx);
> > >       rcu_read_unlock();
> >
> > They are not wrong, this is just such a bit weird semantics where
> > we fetch the pointers and strictly speaking map them into numbers
> > set to compare. But I agree that such tricks might confuse. How about
> >
> >         /*
> >          * Fetching file pointers inside RCU read-lock section
> >          * and reuse them as plain numbers is done in a sake
> >          * of speed. But make sure never dereference them after.
> >          */
> 
> I would tweak it a little to "Fetch file pointers inside RCU read-lock
> section, but skip additional locking for speed.  The pointer values
> will be used as integers, and must not be dereferenced."

Up to you. Initially I use _raw_ptr suffix in function name trying to
point out that the pointer obtained should not be considered in any
way except a natural number. So I'm fine with any comment which helps
readability.

> 
> One other idea I had was to switch the return value to "void *".  That
> way it isn't a struct file, and it isn't readily dereference-able.
> But I wasn't sure if that would be overkill.  What do you think?

Lets better stick with a comment I think. Thanks!
