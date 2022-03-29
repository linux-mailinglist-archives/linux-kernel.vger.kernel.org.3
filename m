Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260884EAFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiC2PBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiC2PBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:01:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D48172893
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:00:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so35731553ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jr+YHDK3n2vTpZOmH5dp3WwG8cBZ0d9eo62u5A14CnQ=;
        b=dU8g3eM9IZW/mOtxib5HnHyHG+Dk1mLogrsoXXlUXu26Wv7GPll9bgcPa1LzwUKRlr
         RSmRLBi1J88rzF5GCcJ1JBaPn28tmD3H6pnDOM+O1EYW13A4pmxVbhF/VEk0U1bFc7Kb
         Ci0XcJeRSmQjgHjH1APsCIMiF2pz1rr2xeZg3L7gIlPLazn12jUQYBXHAUwFgpfVyYoW
         sRVRL3VvfBAsdIiLumBkBXHzXLWeVXmQDpwdsCuV+7PjoTQgW6xBdlJ2mXoZTW3PUx63
         2w/K4bOb8/jkGFuBMJti9ch8jrSy0IBx93jzFIztJRr1UcjUVWXC3Z6EkRPCJBlQi26/
         2dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jr+YHDK3n2vTpZOmH5dp3WwG8cBZ0d9eo62u5A14CnQ=;
        b=Tc6ZU9XSZi0VHBg9Upv82b6/Qwt8iJlSLr+LAA70aA9xnzEiFWxSMMDHUle1PyRZIl
         62Jy8zS4Mkr2qV/Y4KcOKxs8h840GIHzslsE/2yls10/qZvusEAQdmd4w+XKDDn5c0zW
         8j8dA67s4y5rw+4ENYkmKZLJCnbGBtspjKJ2AMwYP4wybSZBqO61MmBDjcryggP0dtjN
         t6zDGsMdzn1eU1XaEqDx34JYkWlVjl9EDEFJfmqinsd4J70pyjTxeID2hZ+Zcc06f68Y
         BMqoF8UYJtOnp7KspTrnUChRdyZ92YwMDX3lehGITvyA0lmWY1uJoJzWDtv3HwHre+Nr
         c/Kg==
X-Gm-Message-State: AOAM5320dMOGbTMQj9BiB3hArjHVUiAO6r0f4BzBa66XqliDJMuX0XbF
        mUfOYSfEgQWvCi2LDHwIsW2X2efbLg9XH2eswrsA2tWI+tc=
X-Google-Smtp-Source: ABdhPJwBVxxhotY4Guhj8daqDOOTdY8D+IGs0CqmabWY98csspgg4M7bOY0gNJWTIkdyaUmrgOMajY9I72kDGrOueVM=
X-Received: by 2002:a17:906:3cf1:b0:6cf:86c6:8a12 with SMTP id
 d17-20020a1709063cf100b006cf86c68a12mr34416789ejh.202.1648565999599; Tue, 29
 Mar 2022 07:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220324181224.21542-1-manivannan.sadhasivam@linaro.org>
 <20220328155123.GA3722211@p14s> <20220329143146.GA2137@thinkpad>
In-Reply-To: <20220329143146.GA2137@thinkpad>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 29 Mar 2022 08:59:48 -0600
Message-ID: <CANLsYkwZY=JwUyfTRkUS2Kq8VEjjgETRW9E3ryrznEvcWntfpA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Don't bother checking the return value of debugfs_create*
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 at 08:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi Mathieu,
>
> On Mon, Mar 28, 2022 at 09:51:23AM -0600, Mathieu Poirier wrote:
> > Hi Mani,
> >
> > On Thu, Mar 24, 2022 at 11:42:24PM +0530, Manivannan Sadhasivam wrote:
> > > DebugFS APIs are designed to return only the error pointers and not NULL
> > > in the case of failure. So these return pointers are safe to be passed on
> > > to the successive debugfs_create* APIs.
> > >
> > > Therefore, let's just get rid of the checks.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/remoteproc/remoteproc_debugfs.c | 17 ++---------------
> > >  1 file changed, 2 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > > index b5a1e3b697d9..2e2c4a31c154 100644
> > > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > > @@ -386,16 +386,8 @@ void rproc_remove_trace_file(struct dentry *tfile)
> > >  struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> > >                                    struct rproc_debug_trace *trace)
> > >  {
> > > -   struct dentry *tfile;
> > > -
> > > -   tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > > +   return debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > >                                 &trace_rproc_ops);
> > > -   if (!tfile) {
> > > -           dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> > > -           return NULL;
> > > -   }
> > > -
> > > -   return tfile;
> >
> > Please see this thread [1] for an earlier conversation on this topic.
> >
> > [1]. https://lore.kernel.org/lkml/20220105131022.25247-1-linmq006@gmail.com/T/
> >
>
> Thanks for the pointer! I believe the conclusion was to return 0 here
> and ignore the return from debugfs_create_file(). If that's the case, it looks
> fine to me and I'll send a follow-up patch.

Correct.

>
> > >  }
> > >
> > >  void rproc_delete_debug_dir(struct rproc *rproc)
> > > @@ -411,8 +403,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
> > >             return;
> > >
> > >     rproc->dbg_dir = debugfs_create_dir(dev_name(dev), rproc_dbg);
> > > -   if (!rproc->dbg_dir)
> > > -           return;
> > >
> > >     debugfs_create_file("name", 0400, rproc->dbg_dir,
> > >                         rproc, &rproc_name_ops);
> > > @@ -430,11 +420,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
> > >
> > >  void __init rproc_init_debugfs(void)
> > >  {
> > > -   if (debugfs_initialized()) {
> > > +   if (debugfs_initialized())
> > >             rproc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> > > -           if (!rproc_dbg)
> > > -                   pr_err("can't create debugfs dir\n");
> > > -   }
> >
> > The above two are fine since debugfs_create_file() and debugfs_create_dir() can
> > deal with @parent being an error code.
> >
>
> debugfs_create_* APIs would never return NULL, so these checks are wrong.
> Moreover, Greg recommends not to check the return value for any of these
> functions.
>

When writing "the above two are fine", I meant that I am in agreement
with your changes.  Reading my comment again I can see how it could be
interpreted as "I don't think your changes are necessary", which isn't
the case.

> I've found the mail thread where Greg explained the reasoning behind it:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1907800.html
>

I'll bookmark this one as it is bound to come back again.

> Thanks,
> Mani
>
> > Thanks,
> > Mathieu
> >
> > >  }
> > >
> > >  void __exit rproc_exit_debugfs(void)
> > > --
> > > 2.25.1
> > >
