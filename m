Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C47483738
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiACSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:53:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiACSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:53:13 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4447520B7179;
        Mon,  3 Jan 2022 10:53:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4447520B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641235993;
        bh=A3ucKs0hga8yablksT/VshqNpBCqvri5dG/Wrf7Zs0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8AhJrt47BQlOeehUgdAviM+vbVYi8HDTBsI7fxt6eJO3fJYxaEh9q7cooETlTHMw
         9Wox48TE+DuCCFykRt6OLD22tgox/BpaS5J94qopoHFsUSYjNYhbxOxgn2jIfIXhLb
         mqOMYdygm+Amta059nbcW/hlwatdfxTjCcxR4Nes=
Date:   Mon, 3 Jan 2022 10:53:08 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] user_events: Validate user payloads for size
 and null termination
Message-ID: <20220103185308.GA15522@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-12-beaub@linux.microsoft.com>
 <20211223090822.a14244522fef64b4b4398fe0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223090822.a14244522fef64b4b4398fe0@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 09:08:22AM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Dec 2021 09:35:10 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Add validation to ensure data is at or greater than the min size for the
> > fields of the event. If a dynamic array is used and is a type of char,
> > ensure null termination of the array exists.
> 
> OK, looks good to me except a few nitpicks.
> 
> Reveiewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> I added some comments below.
> 
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  kernel/trace/trace_events_user.c | 147 +++++++++++++++++++++++++++----
> >  1 file changed, 132 insertions(+), 15 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index fa3e26281fc3..58b8c9607c80 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -64,9 +64,11 @@ struct user_event {
> >  	struct dyn_event devent;
> >  	struct hlist_node node;
> >  	struct list_head fields;
> > +	struct list_head validators;
> >  	atomic_t refcnt;
> >  	int index;
> >  	int flags;
> > +	int min_size;
> >  };
> >  
> >  /*
> > @@ -81,8 +83,17 @@ struct user_event_refs {
> >  	struct user_event *events[];
> >  };
> >  
> > +#define VALIDATOR_ENSURE_NULL (1 << 0)
> > +#define VALIDATOR_REL (1 << 1)
> > +
> > +struct user_event_validator {
> > +	struct list_head link;
> > +	int offset;
> > +	int flags;
> > +};
> > +
> >  typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
> > -				   void *tpdata);
> > +				   void *tpdata, bool *faulted);
> 
> Why don't you just return "int" value? ;-)
> 

There can be more than one callback attached per-probe, and in all cases
where a return value is needed is for a faulted (or would have faulted)
case. This allows less branches when data is being traced/logged as the
return value does not need to be checked (nor should it short circuit
other probes that are attached).

> >  
> >  static int user_event_parse(char *name, char *args, char *flags,
> >  			    struct user_event **newuser);
> > @@ -214,6 +225,17 @@ static int user_field_size(const char *type)
> >  	return -EINVAL;
> >  }
> >  

[..]

> > +static int user_event_validate(struct user_event *user, void *data, int len)
> > +{
> > +	struct list_head *head = &user->validators;
> > +	struct user_event_validator *validator;
> > +	void *pos, *end = data + len;
> > +	u32 loc, offset, size;
> > +
> > +	list_for_each_entry(validator, head, link) {
> > +		pos = data + validator->offset;
> > +
> > +		/* Already done min_size check, no bounds check here */
> > +		loc = *(u32 *)pos;
> > +		offset = loc & 0xffff;
> > +		size = loc >> 16;
> > +
> > +		if (likely(validator->flags & VALIDATOR_REL))
> > +			pos += offset + sizeof(loc);
> > +		else
> > +			pos = data + offset;
> > +
> > +		pos += size;
> > +
> > +		if (unlikely(pos > end))
> > +			return -EFAULT;
> > +
> > +		if (likely(validator->flags & VALIDATOR_ENSURE_NULL))
> > +			if (unlikely(*(char *)(pos - 1) != 0))
> 
> As we discussed in the previous version, isn't it '\0' ?
> (just a style comment)
> 

Sure, there are a few dangling around that I missed. I'll fix them.

> > +				return -EFAULT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Writes the user supplied payload out to a trace file.
> >   */
> >  static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
> > -			      void *tpdata)
> > +			      void *tpdata, bool *faulted)
> >  {
> >  	struct trace_event_file *file;
> >  	struct trace_entry *entry;
> >  	struct trace_event_buffer event_buffer;
> > +	size_t size = sizeof(*entry) + i->count;
> >  
> >  	file = (struct trace_event_file *)tpdata;
> >  
> > @@ -555,19 +648,25 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
> >  		return;
> >  
> >  	/* Allocates and fills trace_entry, + 1 of this is data payload */
> > -	entry = trace_event_buffer_reserve(&event_buffer, file,
> > -					   sizeof(*entry) + i->count);
> > +	entry = trace_event_buffer_reserve(&event_buffer, file, size);
> >  
> >  	if (unlikely(!entry))
> >  		return;
> >  
> > -	if (unlikely(!copy_nofault(entry + 1, i->count, i))) {
> > -		__trace_event_discard_commit(event_buffer.buffer,
> > -					     event_buffer.event);
> > -		return;
> > -	}
> > +	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
> > +		goto discard;
> 
> OK, this is a fault error.
> 
> > +
> > +	if (!list_empty(&user->validators) &&
> > +	    unlikely(user_event_validate(user, entry, size)))
> > +		goto discard;
> 
> But this maybe an invalid parameter error.
> 

Yes, but it has to be an invalid parameter that would have caused a
possible fault in a worse place. In my mind, I still treat it as a fault
case whether the user did it intentionally or not :)

Thanks,
-Beau
