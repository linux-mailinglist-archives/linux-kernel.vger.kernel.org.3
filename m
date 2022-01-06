Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96919486DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiAFXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:33:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57442 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbiAFXc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:32:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58B361E85;
        Thu,  6 Jan 2022 23:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB8C36AE0;
        Thu,  6 Jan 2022 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641511976;
        bh=rL3mJhFcwsAPvSpaRtRP4ONHUtXAnLRH1GqGfnhGt3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UZnsn9jgrTafa4VvQpKHdcRBJqDAJTC2BUIlscUTBL+tdGGQy3YEkzPDmxZhvPbrP
         muwEMoxmqFxYBfI4GzZb4aGIPMVmVZ64GqU9McThr4INONhGp6HvEC0aJZ44LvCcYL
         9GkeWX7TqGbRVTuwfKlZkq9mQGp81XwpnONGeINjqY4tcgPAAKID+RIAhKpUcdpqD3
         IOuBtogkWtXbitIkvGQmOYo1U19BRPyhp7xuamrYKir5K/JdBkx3JaAHuEZJkxESuQ
         6ePZ0pkaSnJEcqCWVGrm34vbDDX/5+fj8cFJbtPUu4x5lxzt2ZPH0MloIBiIP4dTUW
         XJTFoJAyOx2Sw==
Date:   Fri, 7 Jan 2022 08:32:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] user_events: Validate user payloads for size
 and null termination
Message-Id: <20220107083252.0da5237af9c5d041a3850dc6@kernel.org>
In-Reply-To: <20220103185308.GA15522@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-12-beaub@linux.microsoft.com>
        <20211223090822.a14244522fef64b4b4398fe0@kernel.org>
        <20220103185308.GA15522@kbox>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Mon, 3 Jan 2022 10:53:08 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

[...]
> > >  typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
> > > -				   void *tpdata);
> > > +				   void *tpdata, bool *faulted);
> > 
> > Why don't you just return "int" value? ;-)
> > 
> 
> There can be more than one callback attached per-probe, and in all cases
> where a return value is needed is for a faulted (or would have faulted)
> case. This allows less branches when data is being traced/logged as the
> return value does not need to be checked (nor should it short circuit
> other probes that are attached).

Would you mean overwriting the 'faulted' ? If so, you can do something like

faulted = 0;
for_each_user_event_func(user_event_func) {
	faulted |= user_event_func();
}
if (faulted)
  ...

But I think if one user_event_func() fails to access the user data,
other funcs also fail. In this case, it is faster to skip others than
repeating faults.

[...]
> > > @@ -555,19 +648,25 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
> > >  		return;
> > >  
> > >  	/* Allocates and fills trace_entry, + 1 of this is data payload */
> > > -	entry = trace_event_buffer_reserve(&event_buffer, file,
> > > -					   sizeof(*entry) + i->count);
> > > +	entry = trace_event_buffer_reserve(&event_buffer, file, size);
> > >  
> > >  	if (unlikely(!entry))
> > >  		return;
> > >  
> > > -	if (unlikely(!copy_nofault(entry + 1, i->count, i))) {
> > > -		__trace_event_discard_commit(event_buffer.buffer,
> > > -					     event_buffer.event);
> > > -		return;
> > > -	}
> > > +	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
> > > +		goto discard;
> > 
> > OK, this is a fault error.
> > 
> > > +
> > > +	if (!list_empty(&user->validators) &&
> > > +	    unlikely(user_event_validate(user, entry, size)))
> > > +		goto discard;
> > 
> > But this maybe an invalid parameter error.
> > 
> 
> Yes, but it has to be an invalid parameter that would have caused a
> possible fault in a worse place. In my mind, I still treat it as a fault
> case whether the user did it intentionally or not :)

OK, I got it.

Thank you,

> 
> Thanks,
> -Beau


-- 
Masami Hiramatsu <mhiramat@kernel.org>
