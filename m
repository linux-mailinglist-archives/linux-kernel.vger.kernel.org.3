Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97C549E561
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbiA0PDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:03:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiA0PDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:03:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91DB11F385;
        Thu, 27 Jan 2022 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643295828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmFKl1JRf6VnoVBKpirJQ1wmAaQ33BFHMRqpetuEs2s=;
        b=sJzhUBm3gnTABewOh8sswATXRhOr9WRO5dzBp3lvDZENzYItUOjodoTBkQXf/3BJmUfXo8
        OvrqZ0j1Mi2rxRqcO/SEKIAs70a6RpOKhGDKVEOorp4A2S+5tLJ8bdmePa43FmReTwoeV3
        hhtXqg+YDVXurCLYZFPsoFr7FONxeNI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 338BBA3B83;
        Thu, 27 Jan 2022 15:03:48 +0000 (UTC)
Date:   Thu, 27 Jan 2022 16:03:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] printk: Drop console_sem during panic
Message-ID: <YfK0Ugt/i8nMVOmY@alley>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-5-stephen.s.brennan@oracle.com>
 <87fsp9pm6q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsp9pm6q.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 10:28:53, John Ogness wrote:
> On 2022-01-26, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2759,7 +2782,7 @@ void console_unlock(void)
> >  	 * flush, no worries.
> >  	 */
> >  	retry = prb_read_valid(prb, next_seq, NULL);
> > -	if (retry && console_trylock())
> > +	if (retry && !abandon_console_lock_in_panic() && console_trylock())
> 
> As Sergey suggested [0], I would like to see the call to
> abandon_console_lock_in_panic() move inside console_trylock(). This will
> help to avoid the race between NMI CPU halt and the internal sema.lock
> spinlock.

I would prefer if it is done as a followup patch. The code in this
patch is still needed. It helps when the non-panic CPU is busy
with pushing many pending messages. Also it is a more conservative
approach.

Always failing console_trylock() on non-panic CPU makes sense as well.
But it affects many more users. It is likely safe because it is
trylock. But the entire effect is not fully clear to me. So, I suggest
to do it in a separate patch. It might help with bisection.

Best Regards,
Petr
