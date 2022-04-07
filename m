Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3734F8557
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbiDGQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiDGQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:58:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D793EBB85
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:56:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 584B5212C6;
        Thu,  7 Apr 2022 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649350590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mP2odnJSeoF/yydms9dwiGv1fjKNLID7+GKiqaXkf4k=;
        b=WEdjn74L9Q1U7fXXAMo3TCJGmHDaf+8dEG4UiISQFVx3N+HRG65f5XFvlosBBntOkpHTe8
        0c0HlCNYPUW9og1sQgm6hrRt0XN2nJOmC1HosluMESNEA3pMcZtirm3uiE3XKgu7K6qGVJ
        DLoiua8SVoZg/CloR5F2dg90w/8eHAU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3971DA3B82;
        Thu,  7 Apr 2022 16:56:30 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:56:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: console_flush_all(): was: : was Re: [PATCH printk v2 10/12] printk:
 add kthread console printers
Message-ID: <Yk8XvLJgyIGBuV9w@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:33, John Ogness wrote:
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
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h |   2 +
>  kernel/printk/printk.c  | 262 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 252 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8c1686e2c233..9a251e70c090 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -2773,6 +2809,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  	*handover = false;
>  
>  	do {
> +		/* Let the kthread printers do the work if they can. */
> +		if (!allow_direct_printing())
> +			break;

We should return either "true" or "false" here to have predictable
result.

I suggest to return "false". I would mean that the function did not
finish the job as I suggested for the 6th patch.

> +
>  		any_progress = false;
>  
>  		for_each_console(con) {

Best Regards,
Petr
