Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30104489E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiAJRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiAJRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:24:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E5EC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:24:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72496B811D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F49C36AE9;
        Mon, 10 Jan 2022 17:24:37 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:24:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220110122436.5302128f@gandalf.local.home>
In-Reply-To: <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 17:11:52 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 10 January 2022 16:56
> > 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Pingfan reported that the following causes a fault:
> > 
> >   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
> >   echo 1 > events/syscalls/sys_enter_at/enable
> > 
> > The reason is that trace event filter treats the user space pointer
> > defined by "filename" as a normal pointer to compare against the "cpu"
> > string. If the string is not loaded into memory yet, it will trigger a
> > fault in kernel space:  
> 
> If a userspace pointer can end up the kernel structure then presumably
> a 'dodgy' user program can supply an arbitrary kernel address instead?
> This may give the user the ability to read arbitrary kernel addresses
> (including ones that are mapped to PCIe IO addresses).
> Doesn't sound good at all.

Only root has access to the information read here. All tracing requires
root or those explicitly given access to the tracing data, which pretty
much allows all access to kernel internals (including all memory). So
nothing to worry about here ;-)

> 
> ...
> > +	if (likely((unsigned long)str >= TASK_SIZE)) {
> > +		/* For safety, do not trust the string pointer */
> > +		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
> > +			return NULL;
> > +	} else {
> > +		/* user space address? */
> > +		ustr = (char __user *)str;
> > +		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
> > +			return NULL;  
> 
> Is that check against TASK_SIZE even correct for all architectures?
> copy_to/from_user() uses access_ok() - which is architecture dependant.

The problem with access_ok() (which I tried first) is that it can't be used
from interrupt context, and this check can happen in interrupt context.
Either way, if we pick the wrong one for the arch, the only thing bad that
can happen is that it returns "fault" and the filter fails, just like if
the pointer was to bad memory.

> 
> I think you need to remember where the pointer came from.
> 

Why?

-- Steve
