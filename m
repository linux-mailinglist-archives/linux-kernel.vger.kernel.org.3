Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABA34D4A01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiCJOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbiCJObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3FAC6261
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:27:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B305468B05; Thu, 10 Mar 2022 15:27:36 +0100 (CET)
Date:   Thu, 10 Mar 2022 15:27:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_work: simplify the task_work_add() interface
Message-ID: <20220310142736.GA1103@lst.de>
References: <20220223072754.616027-1-hch@lst.de> <58c5f828-df7d-6698-e2d6-2a869e134dd4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c5f828-df7d-6698-e2d6-2a869e134dd4@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:43:25AM -0700, Jens Axboe wrote:
> On 2/23/22 12:27 AM, Christoph Hellwig wrote:
> > Provide a low-level task_work_add_nonotify interface that just adds
> > the work to the list and open code the TWA_SIGNAL and TWA_NONE callers
> > using it.  task_work_add() itself now only handles the common TWA_RESUME
> > case and can drop the notify argument.
> 
> Not sure this is much of a cleanup, and a potential fast case of
> TWA_NONE will now still still set TIF_NOTIFY_RESUME. Also:

No, the old TWA_NONE case is switched to task_work_add_nonotify and
does not set TIF_NOTIFY_RESUME.

> 
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index 77b9c7e4793bf..94116a102dc61 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -9606,7 +9606,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
> >  					ctx_node);
> >  		/* don't spin on a single task if cancellation failed */
> >  		list_rotate_left(&ctx->tctx_list);
> > -		ret = task_work_add(node->task, &exit.task_work, TWA_SIGNAL);
> > +		ret = task_work_add_nonotify(node->task, &exit.task_work);
> >  		if (WARN_ON_ONCE(ret))
> >  			continue;
> 
> This one is now no longer setting TIF_NOTIFY_SIGNAL.

Yes, this was a rebase bug.

> If you want to get rid of the argument, why not just have separate
> helpers? task_work_add_signal(), task_work_add_resume(),
> task_work_add(). Setting TWA_RESUME unconditionally because it's the
> common use case doesn't seem ideal.

In this series, task_work_add_nonotify is what you seems to call
task_work_add, task_work_add is this series is what you call
task_work_add_resume and task_work_add_signal is open coded because
there aren't a whole lot of users.  But if you want I can add
task_work_add_signal and rename task_work_add to task_work_add_resume,
but I think keeping the task_work_add_nonotify name for the low-level
helper is a lot more descriptive.
