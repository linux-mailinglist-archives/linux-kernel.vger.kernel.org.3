Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FB4BB516
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiBRJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:13:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBRJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:13:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70D2838EF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:12:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 89F94210EF;
        Fri, 18 Feb 2022 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645175570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20qdEe5tQLevmHlaRMVb+HYbZmpZ08+8b/EAucAyibo=;
        b=M2MT/Ud7bUN52/aUAieGuoc25sgFkvRemJqlbRNzcUWDByV77cmexZwUL5UPIy2QNGlTPx
        UVZA0UHALgKMF1Rofy66vAKp+tcQhpQW/kKkSt1VkawCZlkXQHu2QWjkc3/p7yc7Py3Wcb
        ivs5KWhtdFODt8p7iqhS/MXsEluDRpk=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F584A3B81;
        Fri, 18 Feb 2022 09:12:50 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:12:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: wake_up_all: was: Re: [PATCH printk v1 10/13] printk: add kthread
 console printers
Message-ID: <Yg9jEkBwPq7ewu6f@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:20, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irq work triggered
> by the printk caller.
> 
> Console printers synchronize against each other and against console
> lockers by taking the console lock for each message that is printed.
> ---
>  include/linux/console.h |   2 +
>  kernel/printk/printk.c  | 159 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3371,7 +3526,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  	}
>  
>  	if (pending & PRINTK_PENDING_WAKEUP)
> -		wake_up_interruptible(&log_wait);
> +		wake_up_interruptible_all(&log_wait);

Good catch. I am curious how this worked so far. It looks like only
the first waiter was waken and others had to wait for another new
message.

The typical problem with wake_up_interruptible_all() is that it wakes
many processes that needs to take the same lock and block each
other. There is even a name for this situation but I do not recall it.

My understanding is that wake_up_interruptible() requires that
the waken process wakes the next waiter when done. But I do not see
it guaranteed for @log_wait wait queue.

Best Regards,
Petr
