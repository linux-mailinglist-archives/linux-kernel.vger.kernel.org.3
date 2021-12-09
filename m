Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54346EB17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhLIP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:28:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37244 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbhLIP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63324CE24EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82444C004DD;
        Thu,  9 Dec 2021 15:25:16 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:25:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: potential dereference of null pointer
Message-ID: <20211209102515.3f5af7f5@gandalf.local.home>
In-Reply-To: <20211209102313.1360b39b@gandalf.local.home>
References: <20211209033127.2051504-1-jiasheng@iscas.ac.cn>
        <20211209102313.1360b39b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 10:23:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8125,6 +8125,8 @@ void __init sched_init(void)
> >  #endif
> >  	if (ptr) {
> >  		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
> > +		if (!ptr)
> > +			return;  
> 
> If this were to happen the system would crash immediately, with or without
> the return.
> 
> If you are worried about not being able to allocate ptr, then the only
> reasonable fix here is
> 
> 		BUG_ON(!ptr);
> 
> That way you would know exactly why your system crashed. Because just
> returning would crash for other reasons and make it less debuggable.

And this is not worth the churn (because if it failed to allocate, you have
bigger problems to deal with).

So NAK on this change.

-- Steve
