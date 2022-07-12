Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7A570ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiGLATh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiGLATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE910551;
        Mon, 11 Jul 2022 17:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C91B615B2;
        Tue, 12 Jul 2022 00:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937E8C34115;
        Tue, 12 Jul 2022 00:18:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WjyGjZ1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657585116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVrNX/eAqVsApgBJHG8TQUp5ikaUrDBLgMgzzv+gsZE=;
        b=WjyGjZ1GO0te8xIrhejWIPcOGkDMpZsuQnL98VWJYdtnSnY+dJKhKSwyTc9+8FZie0aFyI
        6KJy06Bz9MwKZ73fIFf7LYVKprOI769ET1Div7L0xoBTd/EdRjHVQcJC/G3MfVZbxLyS/N
        +wwak93B7rMegaSX9mHRDGuhxsLvs6Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 33856e4a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 12 Jul 2022 00:18:36 +0000 (UTC)
Date:   Tue, 12 Jul 2022 02:18:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, gregerwin256@gmail.com,
        toke@redhat.com, kvalo@kernel.org, rsalvaterra@gmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5] signal: break out of wait loops on kthread_stop()
Message-ID: <Ysy92qs6Nc9zLqdp@zx2c4.com>
References: <87h73n9ufn.fsf@email.froward.int.ebiederm.org>
 <20220711232123.136330-1-Jason@zx2c4.com>
 <87sfn76vza.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sfn76vza.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Jul 11, 2022 at 07:00:25PM -0500, Eric W. Biederman wrote:
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> 
> > I was recently surprised to learn that msleep_interruptible(),
> > wait_for_completion_interruptible_timeout(), and related functions
> > simply hung when I called kthread_stop() on kthreads using them. The
> > solution to fixing the case with msleep_interruptible() was more simply
> > to move to schedule_timeout_interruptible(). Why?
> >
> > The reason is that msleep_interruptible(), and many functions just like
> > it, has a loop like this:
> >
> >         while (timeout && !signal_pending(current))
> >                 timeout = schedule_timeout_interruptible(timeout);
> >
> > The call to kthread_stop() woke up the thread, so schedule_timeout_
> > interruptible() returned early, but because signal_pending() returned
> > true, it went back into another timeout, which was never woken up.
> >
> > This wait loop pattern is common to various pieces of code, and I
> > suspect that the subtle misuse in a kthread that caused a deadlock in
> > the code I looked at last week is also found elsewhere.
> >
> > So this commit causes signal_pending() to return true when
> > kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.
> >
> > The same also probably applies to the similar kthread_park()
> > functionality, but that can be addressed later, as its semantics are
> > slightly different.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Do I need to pick this up and put it on a topic branch?
> Or does this patch have another patch to get merged?

I think it'd make sense to put this in a topic branch.

I discovered this in the process of developing [1] (which could use an
Ack for the wake_up_state EXPORT_SYMBOL, by the way). That's marked
for stable@ because the breakage there is kind of bad -- people can't put
their laptops to sleep right now. After both this patch and that one
land, I may then revisit the ath9k one and make changes for non-stable@.
That is, of course, if [1] even lands; right now I fear it might be
relegated to scheduler bikeshed purgatory and I don't have the time
right now to deal with that.

Longer term, this patch here will let me rework [1] to get rid of the
set_notify_signal() trick and use a proper condition variable wait with
`wait_for_condition_interruptible_timeout`, since this patch makes that
function work right for both contexts in which hwrng devices are called
(kthread and process). But that will mean reworking the hwrng API, which
means writing patches for every single hwrng driver, so that's work for
another time.

In the mean time, [1] is a good way forward (provided it gets acked).
And then this patch puts things in a good position to improve down the
line. I did a bunch of testing of this patch when trying out different
candidates for [1] before settling on [1] as a good-enough intermediate
solution. 

So, anyway, feel free to put this in a topic branch.

Jason

[1] https://lore.kernel.org/lkml/20220629114240.946411-1-Jason@zx2c4.com/
