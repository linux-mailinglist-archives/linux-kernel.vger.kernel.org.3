Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B300B509FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383076AbiDUMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbiDUMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:48:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B731DF8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:46:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BD25A1F388;
        Thu, 21 Apr 2022 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650545164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZLCNDIFv3IuT3iedPC749bBoTwnlNLfmhhzvPa3R1hU=;
        b=se5eF9C/IyDQF955Y/avSJzAXntnx0USJ8uxqitski2sptvTHu+5lWa2fhRWtsYiC7AlNE
        tFf8UobG6eopLxNK8BNXnU3yFWdRykg2kfi5XUiq82bLtp7+276D3VX/+QBf2EpfzCfxC2
        0UeuMGLyk/jp5AtSyBRq04OVK+ies6o=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A447F2C149;
        Thu, 21 Apr 2022 12:46:04 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:46:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 15/15] printk: remove @console_locked
Message-ID: <20220421124604.GC11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-16-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-16-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:37, John Ogness wrote:
> The static global variable @console_locked is used to help debug
> VT code to make sure that certain code paths are running with
> the console_lock held. However, this information is also available
> with the static global variable @console_kthreads_blocked (for
> locking via console_lock()), and the static global variable
> @console_kthreads_active (for locking via console_trylock()).
> 
> Remove @console_locked and update is_console_locked() to use the
> alternative variables.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2705,13 +2696,11 @@ void console_lock_single_hold(struct console *con)
>  	might_sleep();
>  	down_console_sem();
>  	mutex_lock(&con->lock);
> -	console_locked = 1;

is_console_locked() is not able to detect that a given console
is locked by console_lock_single_hold().

>  	console_may_schedule = 1;
>  }
>  

Best Regards,
Petr
