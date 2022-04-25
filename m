Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690B50EAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiDYUyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:54:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC409344C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 600CFB81A7C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB334C385A7;
        Mon, 25 Apr 2022 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650919854;
        bh=Pg3eLCwKekjT5FX2gXoHyMivtK4TghxUHiirEWzcWtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jA0m+LEKBIGbI7aEXyYUSX7V8tXhzPXtlziXqElnOowIoUGdbPpIZ6fF8EbjgEOxC
         GhcyFU8xARrii6u121uHjzf8iU7YG1cKw3UvG/Sospsy4B1OUiB/C4siEWeMnd09hl
         CtNV3aNdjiVRlSB+JmG/LeYZ1lNCWSRn2ZMd5oy8=
Date:   Mon, 25 Apr 2022 13:50:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] ipc: Update semtimedop() to use hrtimer
Message-Id: <20220425135053.a74082b68d26f4f3f0344500@linux-foundation.org>
In-Reply-To: <8603345D-9AAD-43FF-B1DF-941BDA799DF5@oracle.com>
References: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
        <8603345D-9AAD-43FF-B1DF-941BDA799DF5@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 19:38:44 +0000 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:

> 
> 
> > On Apr 18, 2022, at 6:51 PM, Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
> > 
> > semtimedop() should be converted to use hrtimer like it has been
> > done for most of the system calls with timeouts. This system call
> > already takes a struct timespec as an argument and can therefore
> > provide finer granularity timed wait.
> > 
> > Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> 
> Can I get a review of this patch?

That would be nice.

I looked at it, seemed OK.  Perhaps the usual IPC developers (Davidlohr
and Manfred) can comment?

> Note this patch has been added to Andrew's mm tree.
> 
> 
> > ---
> > ipc/sem.c | 15 +++++++++++----
> > 1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/ipc/sem.c b/ipc/sem.c
> > index 0dbdb98..6cd1a1b8 100644
> > --- a/ipc/sem.c
> > +++ b/ipc/sem.c
> > @@ -1995,7 +1995,10 @@ long __do_semtimedop(int semid, struct sembuf *sops,
> > 	int max, locknum;
> > 	bool undos = false, alter = false, dupsop = false;
> > 	struct sem_queue queue;
> > -	unsigned long dup = 0, jiffies_left = 0;
> > +	unsigned long dup = 0;
> > +	ktime_t expires;
> > +	int timed_out = 0;
> > +	struct timespec64 end_time;
> > 
> > 	if (nsops < 1 || semid < 0)
> > 		return -EINVAL;
> > @@ -2008,7 +2011,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
> > 			error = -EINVAL;
> > 			goto out;
> > 		}
> > -		jiffies_left = timespec64_to_jiffies(timeout);
> > +		ktime_get_ts64(&end_time);
> > +		end_time = timespec64_add_safe(end_time, *timeout);
> > +		expires = timespec64_to_ktime(end_time);
> > 	}
> > 
> > 
> > @@ -2167,7 +2172,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
> > 		rcu_read_unlock();
> > 
> > 		if (timeout)
> > -			jiffies_left = schedule_timeout(jiffies_left);
> > +			timed_out = !schedule_hrtimeout_range(&expires,
> > +						current->timer_slack_ns,
> > +						HRTIMER_MODE_ABS);
> > 		else
> > 			schedule();
> > 
> > @@ -2210,7 +2217,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
> > 		/*
> > 		 * If an interrupt occurred we have to clean up the queue.
> > 		 */
> > -		if (timeout && jiffies_left == 0)
> > +		if (timeout && timed_out)
> > 			error = -EAGAIN;
> > 	} while (error == -EINTR && !signal_pending(current)); /* spurious */
> > 
> > -- 
> > 2.7.4
> > 
> 
