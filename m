Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379FB492506
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiARLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiARLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:37:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A043C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFupe0HjDg4gAYbDYTVI7SZo7gXFGL/sn/FwIGWhkV4=; b=H8W7kaD2lcPv7gSnx7F8WSHtkS
        7fCDfagygRhZiSpAZ4PMwjRD8V2WtRbU9XguiR0JEI+VzuqJEuWNJh5pU/jjJ8aTq/pZwl6XbcMpi
        A64+1wrITn+MKG5hB8c0rSTg79Da8cwC2dx4Esmn1aE2SWvkxHs5yyjsOdmJ+tbrIlZMkuG5hHC8g
        HdIEhwFu3TiAAJeEvUbtCeqqVY8FFZ524zmSzO0TZ7ltuJO8mwD3fUWZxfUnt70CoTWgF+1uQrEBo
        i3SaDRuqncsaUAQCJCMufVGYoAiXrvlOvdbi66M6e3QhD7BICd6kGnKHfegmUl5rHMLq1hwYyHkmk
        cdbDmIfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9mnR-009AmH-9H; Tue, 18 Jan 2022 11:37:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3415300252;
        Tue, 18 Jan 2022 12:37:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E20A203BFC67; Tue, 18 Jan 2022 12:37:03 +0100 (CET)
Date:   Tue, 18 Jan 2022 12:37:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Walt Drummond <walt@drummond.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ar@cs.msu.ru,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        mm <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] status: Display an informational message when the
 VSTATUS character is pressed or TIOCSTAT ioctl is called.
Message-ID: <YeamX3ELWyc/BtGp@hirez.programming.kicks-ass.net>
References: <20220118044323.765038-1-walt@drummond.us>
 <20220118044323.765038-3-walt@drummond.us>
 <72a719a0-cd7c-9516-93c2-bd258930b71e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a719a0-cd7c-9516-93c2-bd258930b71e@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:29:54AM +0100, Jiri Slaby wrote:

> > +static const char * const task_state_array[] = {
> > +	"running",
> > +	"sleeping",
> > +	"disk sleep",
> > +	"stopped",
> > +	"tracing stop",
> > +	"dead",
> > +	"zombie",
> > +	"parked",
> > +	"idle",
> > +};

Please no; don't add yet another one of these things. Can't you use the
one in fs/proc/array.c ?


> > +static inline struct task_struct *compare(struct task_struct *new,
> > +					  struct task_struct *old)
> > +{
> > +	unsigned int ostate, nstate;
> > +
> > +	if (old == NULL)
> > +		return new;
> > +
> > +	ostate = task_state_index(old);
> > +	nstate = task_state_index(new);
> > +
> > +	if (ostate == nstate) {

That's not an ordered set, please don't do that.

> > +		if (old->start_time > new->start_time)
> > +			return old;
> > +		return new;
> > +	}
> > +
> > +	if (ostate < nstate)
> > +		return old;
> > +
> > +	return new;
> > +}

> > +static inline const char *get_task_state_name(struct task_struct *tsk)
> 
> This definitely doesn't belong here. How do you ensure it matches the
> returned index also in the future. Put it along with task_index_to_char()?
> Or simply use task_state_to_char()?
> 
> > +{
> > +
> > +	int index;
> > +
> > +	index = task_state_index(tsk);
> > +	if (index > ARRAY_SIZE(task_state_array))
> 
> Should be >=, or?
> 
> > +		return task_state_unknown;
> > +	return task_state_array[index];
> > +}

*groan*.. that's very bad copy paste from fs/proc/array.c. There at east
there's a BUILD_BUG_ON() to make sure things are good.

> > +
> > +int n_tty_get_status(struct tty_struct *tty, char *msg, size_t *msglen)
> > +{
> > +	unsigned long loadavg[3];
> > +	uint64_t pcpu, cputime, wallclock;
> > +	struct task_struct *p;
> > +	struct rusage rusage;
> > +	struct timespec64 utime, stime, rtime;
> > +	char tname[TASK_COMM_LEN];
> 
> How much stack did you consume in sum with its caller n_tty_status()?
> 
> > +	size_t len;
> > +
> > +	if (tty == NULL)
> > +		return -ENOTTY;
> 
> How can this happen?
> 
> > +	get_avenrun(loadavg, FIXED_1/200, 0);
> > +	len = scnprintf(msg + len, *msglen - len, "load: %lu.%02lu  ",
> > +			LOAD_INT(loadavg[0]), LOAD_FRAC(loadavg[0]));
> > +
> > +	if (tty->ctrl.session == NULL) {
> > +		len += scnprintf(msg + len, *msglen - len,
> > +				 "not a controlling terminal\n");
> > +		goto out;
> > +	}
> > +
> > +	if (tty->ctrl.pgrp == NULL) {
> > +		len += scnprintf(msg + len, *msglen - len,
> > +				 "no foreground process group\n");
> > +		goto out;
> > +	}
> > +
> > +	p = pick_process(tty->ctrl.pgrp);
> 
> Why is no lock needed?
> 
> > +	if (p == NULL) {
> > +		len += scnprintf(msg + len, *msglen - len,
> > +				 "empty foreground process group\n");
> > +		goto out;
> > +	}
> > +
> > +	get_task_comm(tname, p);
> > +	getrusage(p, RUSAGE_BOTH, &rusage);
> > +	wallclock = ktime_get_ns() - p->start_time;
> > +
> > +	utime.tv_sec = rusage.ru_utime.tv_sec;
> > +	utime.tv_nsec = rusage.ru_utime.tv_usec * NSEC_PER_USEC;
> > +	stime.tv_sec = rusage.ru_stime.tv_sec;
> > +	stime.tv_nsec = rusage.ru_stime.tv_usec * NSEC_PER_USEC;
> > +	rtime = ns_to_timespec64(wallclock);
> > +
> > +	cputime = timespec64_to_ns(&utime) + timespec64_to_ns(&stime);
> > +	pcpu = div64_u64(cputime * 100, wallclock);

How is this number useful?

> > +
> > +	len += scnprintf(msg + len, *msglen - len,
> > +			 /* task, PID, task state */
> > +			 "cmd: %s %d [%s] "
> > +			 /* rtime,    utime,      stime,      %cpu,  rss */
> > +			 "%llu.%02lur %llu.%02luu %llu.%02lus %llu%% %luk\n",
> > +			 tname,	__get_pid(p, tty),
> > +			 (char *)get_task_state_name(p),
> > +			 rtime.tv_sec, frac_sec(rtime.tv_nsec),
> > +			 utime.tv_sec, frac_sec(utime.tv_nsec),
> > +			 stime.tv_sec, frac_sec(stime.tv_nsec),
> > +			 pcpu, getRSSk(p->mm));
> 
> Why do you think p->mm is still alive (even after the getRSSk()'s check)? So
> no get_task_mm() needed?
> 
> > +out:
> > +	*msglen = len;
> > +	return 0;
> > +}

Re lack of refcounting and locking, perhaps he's attemting a root hole?

