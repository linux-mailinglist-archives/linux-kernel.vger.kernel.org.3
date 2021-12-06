Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A664B46A310
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhLFRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:37:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbhLFRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:37:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E937C21B45;
        Mon,  6 Dec 2021 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638812054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/+W3ZUWSpO4LL+dq/AMKpuu0pHjQCviNvp3TIy81KM=;
        b=VKdlQQ9G3ehllzT8jBDlnk4Ou6VKu4Chnk541RuFZHDwYEmaaH8GiXM9KGBsBKeCLWXN3o
        9VsSpGpox9tlKWOI3uWaqveGY3rSvgp12NzViaTdXh460yjCyVAjB0SlvWVw89YyzGQgme
        uGH+rOHTyRRKEOIoyAG7mJH2uMFRTPA=
Received: from suse.cz (unknown [10.163.24.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7005BA3B8C;
        Mon,  6 Dec 2021 17:34:14 +0000 (UTC)
Date:   Mon, 6 Dec 2021 18:34:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] printk: More consistent loglevel for continuous lines
Message-ID: <Ya5JlkdRDFjPj/1X@alley>
References: <20211124154838.5415-1-pmladek@suse.com>
 <YZ7enboRQprct49o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ7enboRQprct49o@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-11-25 09:53:49, Sergey Senozhatsky wrote:
> On (21/11/24 16:48), Petr Mladek wrote:
> > 
> > Anyway, it looks a bit non-practical to update all existing pr_cont()
> > callers:
> > 
> > 	$> git grep "pr_cont" | wc -l
> > 	2054
> 
> Another question is how many pr_cont()-s are getting compiled with
> the "average" production kernel config. A number of pr_cont() is in
> debugging code - lockdep, kasan, etc. - which is not compiled for prod.

It is still >500 for x86_64 default configuration as mentioned in
the reply by Joe.


> Let's assume something like this
> 
> 	foo()
> 	{
> 		char *s;
> 
> 		pr_cont("Blah ");
> 		s = arch_foo();
> 		pr_cont("%s \n", s);
> 	}
> 
> Suppose that arch_foo() errs and pr_warn()-s. Are we going to use WARN
> level for trailing pr_cont()?
> 
> 	pr_cont("Blah ") -> printk_write_loglevel_ctx(default)
> 	pr_warn() -> printk_write_loglevel_ctx(warn)
> 	pr_cont("%s \n"") <- printk_read_loglevel_ctx(warn)


Yes, the proposed solution will not work when there is a nested
message in the same context. It was even mentioned in the commit
message.

But nested messages break the continuous lines completely. They
primary break the text.

pr_cont()/KERN_CONT approach could work reasonably only for
self-contained code. Though even these lines might still get
interleaved by messages from another context/CPU. But it has
a solution. caller_id allows to connect the right pieces.
The proposed patch allows to preserve the loglevel and
actually see all the pieces.

pr_cont()/KERN_CONT is bad API for situations where the pieces
are printed by complicated and/or external code. Such code
should use its own buffer or avoid continuous lines at all.


By other words. The patch solves one fundamental problem when
pr_cont() is used reasonably. It does not help in situations
where pr_cont() should not be used at all.

Best Regards,
Petr
