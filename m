Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29EC49100E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiAQSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:09:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiAQSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:09:19 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 56F4E20B9137;
        Mon, 17 Jan 2022 10:09:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56F4E20B9137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642442959;
        bh=B2GA201M0cTSfGmIbIiF4zl6ZppQgnfBiD+YcFkewWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpkxX8QqPHnDxN5lEuXzKNbq5NCY+Gp4dzBoc5PI/W4W9+7dm+SLhlfOKXeFLXQW2
         G85KbAm3R6wqtxD6jprj2sr1g3xkaCmVwx+4SK8o8rWsrGMoEXyQwWeTmIEegoE8TK
         s1M8sc7qGL7ffi2TVhTYo8gBN7DOHSYg7gGb2GfM=
Date:   Mon, 17 Jan 2022 10:09:14 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/12] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20220117180914.GA1789@kbox>
References: <20220111172602.2513-1-beaub@linux.microsoft.com>
 <20220111172602.2513-2-beaub@linux.microsoft.com>
 <20220118004517.b9dda3d98d6c5d6233ac8886@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118004517.b9dda3d98d6c5d6233ac8886@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 12:45:17AM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Tue, 11 Jan 2022 09:25:51 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > +static int user_event_show(struct seq_file *m, struct dyn_event *ev)
> > +{
> > +	struct user_event *user = container_of(ev, struct user_event, devent);
> > +	struct ftrace_event_field *field, *next;
> > +	struct list_head *head;
> > +	int depth = 0;
> > +
> > +	seq_printf(m, "%s%s", USER_EVENTS_PREFIX, EVENT_NAME(user));
> > +
> > +	head = trace_get_fields(&user->call);
> > +
> > +	list_for_each_entry_safe_reverse(field, next, head, link) {
> > +		if (depth == 0)
> > +			seq_puts(m, " ");
> > +		else
> > +			seq_puts(m, "; ");
> > +		seq_printf(m, "%s %s", field->type, field->name);
> > +		depth++;
> > +	}
> > +
> > +	seq_puts(m, "\n");
> > +
> > +	return 0;
> > +}
> 
> Let me confirm just one point. Your syntax supports
> 
> [__data_loc|__rel_loc] [unsigned] TYPE[\[LEN\]] NAME
> 
> or
> 
> struct TYPE NAME SIZE
> 
> for the fields, right? In that case, above seq_printf() seems not enough.

Yep, I see.

The non-struct cases work as expected from my testing:
echo 'u:test unsigned char msg[20]' > dynamic_events
cat dynamic_events
u:test unsigned char msg[20]

In the struct case you are right, it's missing the size. Good catch!
I'll fix this up!

Was there another case you had in mind that I might have missed beyond
the struct case?

I also would like, since I'm re-spinning, to fix a warning the intel bot
found related to the same code pulled from single_open, etc.

See https://lore.kernel.org/llvm/YeGk0nIH9x91k01I@archlinux-ax161/

> 
> Thank you,
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
-Beau
