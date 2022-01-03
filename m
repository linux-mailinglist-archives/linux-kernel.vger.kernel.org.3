Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641B1483748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiACS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:59:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41486 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiACS7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:59:02 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 14A7120B717A;
        Mon,  3 Jan 2022 10:59:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14A7120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641236342;
        bh=Nv8ZMtiELE1gdNikp1QT/O2725C8csRs8uALLzGLIAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wzx24XTFFpmj7gM9egxp+n+s/90HwB9xiHlA7ER+QKF0/TmTMw0OdksJA8yhh80t8
         KPE8OGRH0AIU5OekFQXugVwB46XmwQtDuIg0JMFnX0JyuBtuicLfe+VzuW8vgqPrBL
         Yu2KiHn4UbnORskmh0VcOTkNvl+lNXTiqKEawaog=
Date:   Mon, 3 Jan 2022 10:58:57 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/12] user_events: Optimize writing events by only
 copying data once
Message-ID: <20220103185857.GA15573@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-9-beaub@linux.microsoft.com>
 <20211223001142.b972b667cd7d5a593999ce6c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223001142.b972b667cd7d5a593999ce6c@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:11:42AM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Dec 2021 09:35:07 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Pass iterator through to probes to allow copying data directly to the
> > probe buffers instead of taking multiple copies. Enables eBPF user and
> > raw iterator types out to programs for no-copy scenarios.
> 
> This looks good to me, except for 1 nitpick. See below.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  kernel/trace/trace_events_user.c | 113 +++++++++++++++++++++++--------
> >  1 file changed, 85 insertions(+), 28 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index cc30d1fcbb63..fa3e26281fc3 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -41,6 +41,9 @@
> >  #define MAX_FIELD_ARRAY_SIZE 1024
> >  #define MAX_FIELD_ARG_NAME 256
> >  

[..]

> > -static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
> > +static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
> >  			      void *tpdata)
> >  {
> >  	struct trace_event_file *file;
> > @@ -540,41 +556,85 @@ static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
> >  
> >  	/* Allocates and fills trace_entry, + 1 of this is data payload */
> >  	entry = trace_event_buffer_reserve(&event_buffer, file,
> > -					   sizeof(*entry) + datalen);
> > +					   sizeof(*entry) + i->count);
> >  
> >  	if (unlikely(!entry))
> >  		return;
> >  
> > -	memcpy(entry + 1, data, datalen);
> > +	if (unlikely(!copy_nofault(entry + 1, i->count, i))) {
> > +		__trace_event_discard_commit(event_buffer.buffer,
> > +					     event_buffer.event);
> > +		return;
> > +	}
> >  
> >  	trace_event_buffer_commit(&event_buffer);
> 
> Will this be 
> 
> 	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
> 		__trace_event_discard_commit(event_buffer.buffer,
> 					     event_buffer.event);
> 	else
> 		trace_event_buffer_commit(&event_buffer);
> 
> ?

Sure, why not.

Thanks,
-Beau
