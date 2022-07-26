Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8946580E12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiGZHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGZHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:39:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFEC14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:39:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 636431FA15;
        Tue, 26 Jul 2022 07:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658821176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmbXJGe5s5+edusIb6jmJRsEkx7ZmJqyeOYvqRtA3r0=;
        b=m+mGuYfkM07cVS8L6C+K7w8NCUFdW71HAXJIFSUNLKGHuBvd01E/xQc+pjzwSCYyBa7z34
        3MVA2xjHl1tLxY/A1+rNS7lzt8cIuV8tnxnTA8VKPiqq5y78NScqsj3VlGJEisG7/pFkXZ
        yZ6kXZlt/vjYXOpwoEebsHID1F379Ao=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EFD02C16E;
        Tue, 26 Jul 2022 07:39:36 +0000 (UTC)
Date:   Tue, 26 Jul 2022 09:39:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt+aNCBNk046viFq@alley>
References: <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
 <Yt6gxxRxDZ/wFHrA@linutronix.de>
 <Yt6nlaSrfZ+fn80x@alley>
 <Yt6zwP9xSdUhsoQ9@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt6zwP9xSdUhsoQ9@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-25 17:16:16, Sebastian Andrzej Siewior wrote:
> printk might be invoked in a context with disabled interrupts and or
> preemption and additionally disables interrupts before it invokes the
> console drivers. This behaviour is not desired on PREEMPT_RT:
> - The console driver are using spinlock_t based locking which become sleeping
>   locks on PREEMPT_RT and must not be acquired with disabled interrupts (or
>   preemption).
> 
> - The locks within the console drivers must remain sleeping locks and they must
>   not disable interrupts. Printing (and polling for its completion) at 115200
>   baud on an UART takes too long for PREEMPT_RT in general and so raises the
>   latency of the IRQ-off time of the system beyond acceptable levels.
> 
> Skip printing to the console as temporary workaround until the printing threads
> and atomic consoles have been introduced or another solution which is
> compatible with the PREEMPT_RT approach.
> With this change, the user will not see any kernel message printed to the
> console but can retrieve the printk buffer from userland (via the dmesg
> command). This allows enable PREEMPT_RT as a whole without disabling printk and
> loosing all kernel output.
> 
> Disable console printing on PREEMPT_RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks a lot for updating the commit message. It looks good to me now.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: John, if you ack it then I'll queue it for 5.20.
