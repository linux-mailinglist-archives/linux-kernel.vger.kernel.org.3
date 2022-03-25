Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D74E7B64
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiCYTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiCYTsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:48:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB09220FD8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:32:07 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so7028039qvx.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDLVL2CBtTtmZ03hvae7Gda3UiodG88S9fzgPpRXpvw=;
        b=OiWmJSqsd56fJnsMw7vy14nT7y4RqvdUDtzT0hRVl8eJM8j+kwYhzyKSXtH1X0btj+
         gF6iVne9zsezOcHNXAWwuNmE+7+4oXfeQ3zzCnBO1EMiKA0V4JaqdB1fUHTpBZyfP16f
         mv5riwoU/Uzt2nQrsxTceBnO5Q8peVyJiIhNvjpN/r8ZKS/IRxBoZAY4eQgLXM1yU1wf
         RuyTp3+5TNjAhKRzpedRkXInlLXr+vIIQN8Ju/9g6WcTI/Q1Gx2gMlDHTgUo7q67SlIA
         XglOP+lMKdSyY9n3ZWaZDOe94rZRoU4QCqE3q5wD7lW1aIZ4E8iuhVq7n2Jf9qIqBUb6
         mz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDLVL2CBtTtmZ03hvae7Gda3UiodG88S9fzgPpRXpvw=;
        b=J8Rr9zzmkHRN91ThANvJspQ+SgKlE7yXNqyrJ8tzTY0do4D+d3x+5j8kCC/yWgyqeu
         KGnA70iXsjWb9hTMU/9N/Sc/Ygm64r+9GGHnoDFb4nB20bmpUoBu7ey+KnGJgSIhQeUj
         4P+YuM0z+nD9/ulZJD84ChrbEWgotBLcgSI8HmL89leQtf6WHuMGLdc6R0bZzTthkouz
         Ekue1b23WI5FlyMVlas62lLIXnmz3wCZj1sMOtTK+uMY/lCLqCaXWEFlCYYwEGE2367p
         PGowOHj1RYX18EvAT20lbNASKekSu6gYTJhOf5bnnTHlp7rBf0cGWKTv7HyZi/YHqe60
         wlOg==
X-Gm-Message-State: AOAM533/wScyHy/XAM3B+AzUldDDaJfN8XjG7WIG5Rweg77NOIquCESe
        mCjVNmwy58HD6MlO9LXxHWNblkpwoPRQ8g==
X-Google-Smtp-Source: ABdhPJx4UuZpPPNTjdIKS58siaD7XKd04M0BmM0IvWb3s03mLNTfP7MWSWNilRuPWBWICiRC4ete5Q==
X-Received: by 2002:a05:6a00:98e:b0:4fb:1162:b2a5 with SMTP id u14-20020a056a00098e00b004fb1162b2a5mr4155395pfg.12.1648228956842;
        Fri, 25 Mar 2022 10:22:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a005000b001c7511dc31esm6674946pjb.41.2022.03.25.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:22:35 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:22:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "S.J. Wang" <shengjiu.wang@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove state checking before changing
 state
Message-ID: <20220325172233.GB3576184@p14s>
References: <PAXPR04MB9089EC1B959187335D00953BE31A9@PAXPR04MB9089.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9089EC1B959187335D00953BE31A9@PAXPR04MB9089.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 03:44:20AM +0000, S.J. Wang wrote:
> Hi
> 
> > >
> > > There is no mutex protecting of these state checking, which can't
> > > garantee there is no another instance is trying to do same operation.
> > >
> > > The reference counter rproc->power is used to manage state changing
> > > and there is mutex protection in each operation function for multi
> > > instance case.
> > >
> > > So remove this state checking in rproc_cdev_write() and state_store(),
> > > just let reference counter rproc->power to manage the behaviors.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_cdev.c  | 11 -----------
> > > drivers/remoteproc/remoteproc_sysfs.c | 11 -----------
> > >  2 files changed, 22 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_cdev.c
> > > b/drivers/remoteproc/remoteproc_cdev.c
> > > index 906ff3c4dfdd..687f205fd70a 100644
> > > --- a/drivers/remoteproc/remoteproc_cdev.c
> > > +++ b/drivers/remoteproc/remoteproc_cdev.c
> > > @@ -32,21 +32,10 @@ static ssize_t rproc_cdev_write(struct file *filp,
> > const char __user *buf, size_
> > >                 return -EFAULT;
> > >
> > >         if (!strncmp(cmd, "start", len)) {
> > > -               if (rproc->state == RPROC_RUNNING ||
> > > -                   rproc->state == RPROC_ATTACHED)
> > > -                       return -EBUSY;
> > > -
> > >                 ret = rproc_boot(rproc);
> > >         } else if (!strncmp(cmd, "stop", len)) {
> > > -               if (rproc->state != RPROC_RUNNING &&
> > > -                   rproc->state != RPROC_ATTACHED)
> > > -                       return -EINVAL;
> > > -
> > >                 ret = rproc_shutdown(rproc);
> > >         } else if (!strncmp(cmd, "detach", len)) {
> > > -               if (rproc->state != RPROC_ATTACHED)
> > > -                       return -EINVAL;
> > > -
> > >                 ret = rproc_detach(rproc);
> > >         } else {
> > >                 dev_err(&rproc->dev, "Unrecognized option\n"); diff
> > > --git a/drivers/remoteproc/remoteproc_sysfs.c
> > > b/drivers/remoteproc/remoteproc_sysfs.c
> > > index 51a04bc6ba7a..8c7ea8922638 100644
> > > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > > @@ -194,23 +194,12 @@ static ssize_t state_store(struct device *dev,
> > >         int ret = 0;
> > >
> > >         if (sysfs_streq(buf, "start")) {
> > > -               if (rproc->state == RPROC_RUNNING ||
> > > -                   rproc->state == RPROC_ATTACHED)
> > > -                       return -EBUSY;
> > > -
> > 
> > As per my previous comment the above conditions need to be moved into
> > rproc_boot().
> > 
> > >                 ret = rproc_boot(rproc);
> > >                 if (ret)
> > >                         dev_err(&rproc->dev, "Boot failed: %d\n", ret);
> > >         } else if (sysfs_streq(buf, "stop")) {
> > > -               if (rproc->state != RPROC_RUNNING &&
> > > -                   rproc->state != RPROC_ATTACHED)
> > > -                       return -EINVAL;
> > > -
> > >                 ret = rproc_shutdown(rproc);
> > >         } else if (sysfs_streq(buf, "detach")) {
> > > -               if (rproc->state != RPROC_ATTACHED)
> > > -                       return -EINVAL;
> > > -
> > 
> > This patch should have been part of a patch series with your other work sent
> > on March 18th[1].
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. [PATCH] remoteproc: core: check rproc->power value before decreasing
> > it
> > 
> 
> Thanks for the comments.
> I still have one question, if there are two instances independently to 'start'
> 'stop' remoteproc, for example:
> 
> Instance1: echo start > /sys/class/remoteproc/remoteproc0/state
> Instance2: echo start > /sys/class/remoteproc/remoteproc0/state
> 
> ...
> 
> Instance2: echo stop > /sys/class/remoteproc/remoteproc0/state
> ...
> Instance1: echo stop > /sys/class/remoteproc/remoteproc0/state
> 
> When instance2 'stop' the remoteproc, then instance1 will be impacted for
> It still needs the service from remoteproc.
> 
> That's why I just removed of the checking state, didn't move them to
> rproc_boot()/rproc_shutdown()/rproc_detach(). And in order to utilize
> the reference counter (rproc->power) to handle the multi-instance case.

Thanks for the exta information, now I understand the problem.  The above should
be part of the changelog.

There are two problems here:

1) Dealing with race conditions when checking the state of a remote processor.
2) Properly dealing with the remote processor's reference count.

For the first one, state checks control the remote processor state machine and
can't simply be removed.  They have to be brought inside the mutex lock in order
to avoid race conditions when multiple users interact with the remote processor.

For the second one, moving the rproc->state checks inside the mutex lock in
rproc_shutdown() and rproc_detach() will work with the rproc->power check.

The problem is with rproc_boot().  For (at least) two years now we have lost
the capability to increase the rproc->power reference count from sysfs and the
cdev interface due to the rproc-state checks in state_store() and
rproc_cdev_write().  I think that should be corrected but it will introduce a
user space visible change, which needs to be treated carefully.

With the above in mind, please send a patchset that includes one patch that
removes the rproc->state checks from the "start" command in state_store() and
rproc_cdev_write().  The other patch should move the rproc->state checks for the
"stop" and "detach" command inside rproc_shutdown() and rproc_detach().

With that we can start a discussion on the best way to proceed.

Thanks,
Mathieu

> 
> 
> Best regards
> Wang Shengjiu
