Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5650B200
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445037AbiDVHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445030AbiDVHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:51:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A0517F9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:48:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D49351F37B;
        Fri, 22 Apr 2022 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650613732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44qdVfz1XuJJXWcJTl5T+pYqKOMV/Q7Z8ES+RLPB7/s=;
        b=r2bMrNyYh12L570kwekUnSK78tMfvhNgrTvnVpUHskeMn8KhxTCH93ghpklfQQ4eLXx548
        ug4PJwEzdrqNthI1xx6hepigeD1AHktZ5+JvG8i1tI+hTBTYMJsPki+WLXuzTpLsjZpLOq
        2PzZ65J3w33jWjDTDLs+PYdJdrVCOnc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B1212C145;
        Fri, 22 Apr 2022 07:48:52 +0000 (UTC)
Date:   Fri, 22 Apr 2022 09:48:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 13/15] printk: add kthread console printers
Message-ID: <YmJd43IwQ4fR1En1@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421212250.565456-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-21 23:28:48, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irqwork triggered
> by the printk caller, referred to as direct printing.
> 
> Since threaded console printers are responsible for all printing
> during normal operation, this also includes messages generated via
> deferred printk calls. If direct printing is in effect during a
> deferred printk call, the queued irqwork will perform the direct
> printing. To make it clear that this is the only time that the
> irqwork will perform direct printing, rename the flag
> PRINTK_PENDING_OUTPUT to PRINTK_PENDING_DIRECT_OUTPUT.
> 
> Threaded console printers synchronize against each other and against
> console lockers by taking the console lock for each message that is
> printed.
> 
> Note that the kthread printers do not care about direct printing.
> They will always try to print if new records are available. They can
> be blocked by direct printing, but will be woken again once direct
> printing is finished.
> 
> Console unregistration is a bit tricky because the associated
> kthread printer cannot be stopped while the console lock is held.
> A policy is implemented that states: whichever task clears
> con->thread (under the console lock) is responsible for stopping
> the kthread. unregister_console() will clear con->thread while
> the console lock is held and then stop the kthread after releasing
> the console lock.
> 
> For consoles that have implemented the exit() callback, the kthread
> is stopped before exit() is called.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
