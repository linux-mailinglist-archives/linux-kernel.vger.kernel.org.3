Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE849134A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiARBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:03:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35556 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiARBCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C7CB8122A;
        Tue, 18 Jan 2022 01:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D553C36AEC;
        Tue, 18 Jan 2022 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642467767;
        bh=UjL36AtpqN/N1m6zQK0IYdRjEoTpeNF2t5q+/41fARU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z/gYtLHOmxBAddG2NFDIURm+9msmcsBXHQdC3cUmPyosgiX/f30nhpaPtryT566EL
         xR7wakG7J4aSW0+YibzShiHQO+s/nGWPrefIQeoadh8s9aP8MUxjnbXKmiBtMb/fxx
         aIAQEW+iU12VA9Pvf94xbYwBtY9hQzjmOR2fclisvAxypeFuLgyQYopnHJ+myuwxBb
         x8WyFH8bV0CrxBM0N1VB+hCT26maTkDUsArzr7u1e18PF4d/9a1MWbG5mf+5r3WbOR
         jBpIa4uUZ89lnrl80iAoFRHRDVaaBUJekbmFkAco/vTtLc6JzRQbJ2HA71cKO5QYco
         yq3rWbOxPNVog==
Date:   Tue, 18 Jan 2022 10:02:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/12] user_events: Add minimal support for
 trace_event into ftrace
Message-Id: <20220118100244.2a45702eea08c55616bb464d@kernel.org>
In-Reply-To: <20220117180914.GA1789@kbox>
References: <20220111172602.2513-1-beaub@linux.microsoft.com>
        <20220111172602.2513-2-beaub@linux.microsoft.com>
        <20220118004517.b9dda3d98d6c5d6233ac8886@kernel.org>
        <20220117180914.GA1789@kbox>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 10:09:14 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Tue, Jan 18, 2022 at 12:45:17AM +0900, Masami Hiramatsu wrote:
> > Hi Beau,
> > 
> > On Tue, 11 Jan 2022 09:25:51 -0800
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > +static int user_event_show(struct seq_file *m, struct dyn_event *ev)
> > > +{
> > > +	struct user_event *user = container_of(ev, struct user_event, devent);
> > > +	struct ftrace_event_field *field, *next;
> > > +	struct list_head *head;
> > > +	int depth = 0;
> > > +
> > > +	seq_printf(m, "%s%s", USER_EVENTS_PREFIX, EVENT_NAME(user));
> > > +
> > > +	head = trace_get_fields(&user->call);
> > > +
> > > +	list_for_each_entry_safe_reverse(field, next, head, link) {
> > > +		if (depth == 0)
> > > +			seq_puts(m, " ");
> > > +		else
> > > +			seq_puts(m, "; ");
> > > +		seq_printf(m, "%s %s", field->type, field->name);
> > > +		depth++;
> > > +	}
> > > +
> > > +	seq_puts(m, "\n");
> > > +
> > > +	return 0;
> > > +}
> > 
> > Let me confirm just one point. Your syntax supports
> > 
> > [__data_loc|__rel_loc] [unsigned] TYPE[\[LEN\]] NAME
> > 
> > or
> > 
> > struct TYPE NAME SIZE
> > 
> > for the fields, right? In that case, above seq_printf() seems not enough.
> 
> Yep, I see.
> 
> The non-struct cases work as expected from my testing:
> echo 'u:test unsigned char msg[20]' > dynamic_events
> cat dynamic_events
> u:test unsigned char msg[20]
> 
> In the struct case you are right, it's missing the size. Good catch!
> I'll fix this up!
> 
> Was there another case you had in mind that I might have missed beyond
> the struct case?

No, that's the only one which I found :)

> 
> I also would like, since I'm re-spinning, to fix a warning the intel bot
> found related to the same code pulled from single_open, etc.
> 
> See https://lore.kernel.org/llvm/YeGk0nIH9x91k01I@archlinux-ax161/

OK, I'll then wait for your next version.

Thank you!

> 
> > 
> > Thank you,
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks,
> -Beau


-- 
Masami Hiramatsu <mhiramat@kernel.org>
