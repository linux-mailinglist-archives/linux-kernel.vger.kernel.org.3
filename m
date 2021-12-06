Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75446A11D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387415AbhLFQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:22:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382461AbhLFQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DE4B9212BF;
        Mon,  6 Dec 2021 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638807551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOhQ/Z0ukUVoORMcE0ydXV59a6vhiU4ipuXPoXLnBzA=;
        b=jFh6gx5JudPDZoQBKOeN3oh02p9fazyH+x4QUy2z03ImTxdG3DPxsdOO9fYiUj4AEY3wdW
        Vs4LXlWZNaHPUOf00FBEmcQhrj12gOgXxl+p2gn6S4WWmOX0m37JhLhfwuFN3EqR8WPFgK
        CIc/j2S/glq6+LtGJwiPbO0+wTccXYs=
Received: from suse.cz (unknown [10.163.24.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94CC1A3B84;
        Mon,  6 Dec 2021 16:19:11 +0000 (UTC)
Date:   Mon, 6 Dec 2021 17:19:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] printk: More consistent loglevel for continuous lines
Message-ID: <Ya43/0m5/h7V2bNL@alley>
References: <20211124154838.5415-1-pmladek@suse.com>
 <YZ7enboRQprct49o@google.com>
 <3530db0aa97eed41553ae94da6c99c8979c41cad.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3530db0aa97eed41553ae94da6c99c8979c41cad.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-11-24 17:45:57, Joe Perches wrote:
> On Thu, 2021-11-25 at 09:53 +0900, Sergey Senozhatsky wrote:
> > On (21/11/24 16:48), Petr Mladek wrote:
> > > 
> > > Anyway, it looks a bit non-practical to update all existing pr_cont()
> > > callers:
> > > 
> > > 	$> git grep "pr_cont" | wc -l
> > > 	2054
> > 
> > Another question is how many pr_cont()-s are getting compiled with
> > the "average" production kernel config. A number of pr_cont() is in
> > debugging code - lockdep, kasan, etc. - which is not compiled for prod.
> 
> This was Linus' attempt to make KERN_CONT meaningful again when it
> was IMO a slightly different issue to fix bare printks.

Yes, the primary motivation for Linus' commit 4bcc595ccd80decb424
("printk: reinstate KERN_CONT for printing continuation lines) was
different. It solved the problem when two unrelated lines were
connected because of a missing newline.

The support for KERN_CONT together with real log level was just
a side effect because some code used it in the meantime.


> Linus changed the few bare printks that mattered to him at the time.

IMHO, Linus was more interested into the missing newlines. He did the
change in v4.9-rc1 and I see a lot of newlines fixes around.

Anyway, I checked v4.9 final sources and found only one location
that combined KERN_CONT with another real log level. It was

     pr_warn(KERN_CONT " trap #%lu: %s%c", code,

in arch/parisc/mm/fault.c. And it was later removed by the commit
commit 8351badf349b22b47c969 ("parisc: fix a printk").

I really can't find any occurrence of KERN_CONT together with
a real log level in the current sources.


We could make it required for new code by checkpatch.pl. But it would
still leave several hunderds/thousands of existing callers to be
fixed. And it seems that people do not care much about it.


Best Regards,
Petr
