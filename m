Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CD4B202A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiBKI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbiBKI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:27:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B9E4B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:27:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17431B82886
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8324EC340E9;
        Fri, 11 Feb 2022 08:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644568062;
        bh=uMLTx9pwl8ZLFIta4PeKt84VlBpht72HhDtAAtxCi4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClaWP5DRzWC+GppKtBPsajQCSKrdnEMO8t3K9Vlo03IlEdOClX4sr/a9n1jOO5+D5
         zCqOtVv0YU2NK2v3p12pJk3tzrPu8LeobYv4NBjZh7urvzm++JbbtNLLE61KAeWTlx
         qc4in+vb50dWGzMn0DMtbge/l4hps07X00UY0W7vgcc1jAkhM0vUPStcxlXPJnQhCK
         D8ZmPiYa2NjWl41itUtq+vAAK/sjCB19VG6xot4hqSnTq/hSMjM54F3mkM/diW9HMC
         TvE4GB9bGNlSxflshbylmPAk6Gg7T+KBuP2TT/6LFGtcGDz0nzid8pRf4XIeHb4EzK
         S+vJd5C4eZAAw==
Date:   Fri, 11 Feb 2022 09:27:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
Message-ID: <20220211082731.phyiyulx6o3tmkhh@wittgenstein>
References: <20220208163912.1084752-1-longman@redhat.com>
 <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
 <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
 <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:07:41PM +0000, Al Viro wrote:
> On Tue, Feb 08, 2022 at 01:51:35PM -0500, Waiman Long wrote:
> > On 2/8/22 13:16, Al Viro wrote:
> > > On Tue, Feb 08, 2022 at 11:39:12AM -0500, Waiman Long wrote:
> > > 
> > > > One way to solve this problem is to move the fd_install() call out of
> > > > the sighand->siglock critical section.
> > > > 
> > > > Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
> > > > on cleanups"), the pidfd installation was done without holding both
> > > > the task_list lock and the sighand->siglock. Obviously, holding these
> > > > two locks are not really needed to protect the fd_install() call.
> > > > So move the fd_install() call down to after the releases of both locks.
> > > 	Umm... That assumes we can delay it that far.  IOW, that nothing
> > > relies upon having pidfd observable in /proc/*/fd as soon as the child
> > > becomes visible there in the first place.
> > > 
> > > 	What warranties are expected from CLONE_PIDFD wrt observation of
> > > child's descriptor table?
> > > 
> > I think the fd_install() call can be moved after the release of
> > sighand->siglock but before the release the tasklist_lock. Will that be good
> > enough?
> 
> Looks like it should, but I'd rather hear from the CLONE_PIDFD authors first...
> Christian, could you comment on that?

Sorry, I'm on vacation right now until the 17th so I'm a bit mia right
now.

Short story is, I think it's fine to move the fd_install() later.

We explicitly did not give such a strong guarantee for /proc/*/fd as
we figured that's unpleasant to do cleanly and really not required, i.e.
there's no obvious use-case for that apart from really weird
corner-cases that I think we can fend off.

(For the most part we expect people that use pidfd to almost not rely on
proc. When they access proc they likely want get metadata about the
process - something which cannot yet be done using pidfds - and that's
usually only relevant later in the lifecycle of a process.)

Originally the code installed the fd before grabbing tasklist lock and
siglock but as you rightly pointed out back then this gets us into
ksys_close() territory which is yucky. So I think this was an oversight
when we fixed that.

I can pick that patch up now. Thanks for all the reviews.
