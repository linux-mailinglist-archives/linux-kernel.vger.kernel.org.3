Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10D486F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbiAGBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:02:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49214 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiAGBCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:02:40 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id DC85F20B7179;
        Thu,  6 Jan 2022 17:02:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC85F20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641517360;
        bh=7MujLBKMAl1m8N9IFyAHo4bpGQmMbjwholVVMf2oSSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CizMKpRV5OZh5ReY+jZXQdsLL//O2Fa4dZMExiYNhzRVi5PDBfxEjRBJ69CoPrND/
         rMdZnJyw+xB2LOBZzaBWeyecOj0JQLiRZ5z2nkvlm1l8dyDo2qWFXKE4QprSMX0Loq
         rXC/HZRBICl/4dynEHROidcbzgIbZnlPt2Rw/2VQ=
Date:   Thu, 6 Jan 2022 17:01:55 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] user_events: Validate user payloads for size
 and null termination
Message-ID: <20220107010155.GA7306@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-12-beaub@linux.microsoft.com>
 <20211223090822.a14244522fef64b4b4398fe0@kernel.org>
 <20220103185308.GA15522@kbox>
 <20220107083252.0da5237af9c5d041a3850dc6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107083252.0da5237af9c5d041a3850dc6@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:32:52AM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Mon, 3 Jan 2022 10:53:08 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> [...]
> > > >  typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
> > > > -				   void *tpdata);
> > > > +				   void *tpdata, bool *faulted);
> > > 
> > > Why don't you just return "int" value? ;-)
> > > 
> > 
> > There can be more than one callback attached per-probe, and in all cases
> > where a return value is needed is for a faulted (or would have faulted)
> > case. This allows less branches when data is being traced/logged as the
> > return value does not need to be checked (nor should it short circuit
> > other probes that are attached).
> 
> Would you mean overwriting the 'faulted' ? If so, you can do something like
> 
> faulted = 0;
> for_each_user_event_func(user_event_func) {
> 	faulted |= user_event_func();
> }
> if (faulted)
>   ...
> 

Yeah, could OR it in, I don't see a big difference though to be honest
:)

> But I think if one user_event_func() fails to access the user data,
> other funcs also fail. In this case, it is faster to skip others than
> repeating faults.

eBPF will not fault when perf/ftrace could, at the very least we want to
ensure that callbacks get a chance to see data even if it faulted
elsewhere. This ensures that we are not blind to the fact it is happening
at least when eBPF is being used. We cannot guarantee probe/callback order.

This has been a problem in the past for us, we've seen data disappear later
to find out it was possibly due to a page fault occurring.

In later versions I would like to add internal tracepoints for these
conditions (and some others) so we can further track when they occur.

Thanks,
-Beau
