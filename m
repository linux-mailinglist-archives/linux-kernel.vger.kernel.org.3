Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3557E182
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiGVMju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:39:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7705D5B8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:39:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 98DE42045C;
        Fri, 22 Jul 2022 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658493585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DP1a2GtbATPx8o6irRIPcWaOiE49HcBZCPgR3P5JbLM=;
        b=t9D6sCzWRZ10atlezXTBIrxQP6EKm3hS3Vq46+QebNgKWXDSSPsN/gPAtqVMp6fJ/Mi7iJ
        MwL6jNFzvv2M7hFB9e5BCetZPVST20ASjHuJ4fBm9JsXgv3zcHQg4oTQqoQU+I1eUCYYlg
        xP6dP53kP7kKqULzjmuEIUCfc5AIK1w=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A79D2C15C;
        Fri, 22 Jul 2022 12:39:45 +0000 (UTC)
Date:   Fri, 22 Jul 2022 14:39:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <YtqakGJAQzw/IPul@alley>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytj3PisFjOfS9L0Y@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-07-21 08:50:38, Sebastian Andrzej Siewior wrote:
> printk might be invoked in a context with disabled interrupts and or
> preemption and additionally disables interrupts before it invokes the
> console drivers. This is behaviour is not compatible with PREEMPT_RT.

Maybe I do not understand it correctly. It sounds like we could not
disable interrupts when interrupts or preemption is already disabled.
Like nested disablement of interrupts is bad.

Is this a generic rule? Is is about the nesting?

Or is is somehow specific to the console drivers called from printk()
directly? Do you always want to disable here because it might
be an atomic context and they might take too long?

I guess that the sentence "additionally disables interrupts before
it invokes the console drivers" is not really important" and it confused me.


> Disable console printing until the return of atomic consoles and the
> printing thread. This allows to retrieve the log buffer from user space
> which is not possible by disable printk.

I guess that this is for RT tree because the kthreads and the atomic
consoles are still not in the mainline.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2843,6 +2843,16 @@ void console_unlock(void)
>  	}
>  
>  	/*
> +	 * On PREEMPT_RT it is not possible to invoke console drivers with
> +	 * disabled interrupts and or preemption. Therefore all drivers are
> +	 * skipped and the output can be retrieved from the buffer.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		__console_unlock();
> +		return;
> +	}

Do you want this even in panic() or early boot?

AFAIK, only the serial console has atomic write() callback in the RT
tree. Is this the only console used by RT kernel users in practice?


> +	/*
>  	 * Console drivers are called with interrupts disabled, so
>  	 * @console_may_schedule should be cleared before; however, we may
>  	 * end up dumping a lot of lines, for example, if called from

Best Regards,
Petr
