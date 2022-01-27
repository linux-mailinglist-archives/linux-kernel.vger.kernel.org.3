Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60AB49E586
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiA0PNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:13:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiA0PNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:13:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE54F1F3A9;
        Thu, 27 Jan 2022 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643296380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvL1YYl5W4GI9g+co4qNQ7x00M2JFYmNkhWDE8SBozw=;
        b=L6R7ceTqkPzvfThlwNqs7lUAIM26anfYGwC7FhNrYrpZt19OoJM+c02/JR8H/M1DZz38KC
        0cIKui/Pf4wfAFS/slczwWQwG5xd3yTdDf22fsL7tu3djXIQq5BTX+EacR7zFS1cOuMNBk
        j6ydMtzKxAcrgm1SpWKBztV8JVhDdiE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F474A3B81;
        Thu, 27 Jan 2022 15:13:00 +0000 (UTC)
Date:   Thu, 27 Jan 2022 16:12:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] printk: Drop console_sem during panic
Message-ID: <YfK2ekZdiM/lJOEW@alley>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-5-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126230236.750229-5-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-26 15:02:36, Stephen Brennan wrote:
> If another CPU is in panic, we are about to be halted. Try to gracefully
> abandon the console_sem, leaving it free for the panic CPU to grab.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 18107db118d4..572363ff716f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2742,6 +2761,10 @@ void console_unlock(void)
>  		if (handover)
>  			return;
>  
> +		/* Allow panic_cpu to take over the consoles safely */
> +		if (abandon_console_lock_in_panic())
> +			break;

Hmm, it makes some sense to have it before cond_resched(). But I would
like to have it at the beginning of the cycle so that console_unlock()
might leave quickly without processing any single message.

We could have it in both (three) locations. But it might be over
cautious.

Anyway, the beginning is more important. Sleeping with console_sem is
less risky from the panic and races point of view.

Best Regards,
Petr
