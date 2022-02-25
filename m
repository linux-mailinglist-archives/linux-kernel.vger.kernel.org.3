Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C74C446D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiBYMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBYMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:17:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706B66235
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:16:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C04D71F38B;
        Fri, 25 Feb 2022 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645791411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXU2yW7ixjixRRw0Q57kpRI6j5RLnVvGyCqUJObmb2U=;
        b=FYigLd+kGzJ5abnC6rvr5OqYhET1oF4hX+i+caMR4Tfjrid94QzuOJ74k+9pSPRaIVz2Mf
        tFOR8O1Kq4UXT6qJryZYBaaYk96nL4TGrI0V9di2xSbkFpsrtuHQhAS29fkYo44FhlPUq3
        sVdliJOyE+FQHUt56NWGadBPA1HflO4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44EF8A3B81;
        Fri, 25 Feb 2022 12:16:51 +0000 (UTC)
Date:   Fri, 25 Feb 2022 13:16:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhjIsPpA0kN1yeOM@alley>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhhmnmgAlVCcVqSV@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-25 14:18:22, Sergey Senozhatsky wrote:
> IOW move console_flush_on_panic() handling out of panic_print_sys_info().
> console_flush_on_panic() isn't really related to "print sys info" stuff
> that panic_print_sys_info() does.
> 
> Something like this may be:
> 
>  static void panic_print_sys_info(void)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> -
>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
>  
> @@ -196,6 +193,23 @@ static void panic_print_sys_info(void)
>  		ftrace_dump(DUMP_ALL);
>  }
>  
> +static void panic_console_flush(void)
> +{
> +	/*
> +	 * We may have ended up stopping the CPU holding the lock (in
> +	 * smp_send_stop()) while still having some valuable data in the console
> +	 * buffer.  Try to acquire the lock then release it regardless of the
> +	 * result.  The release will also print the buffers out.  Locks debug
> +	 * should be disabled to avoid reporting bad unlock balance when
> +	 * panic() is not being callled from OOPS.
> +	 */
> +	debug_locks_off();
> +	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	else
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> +}
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
> @@ -329,17 +343,7 @@ void panic(const char *fmt, ...)
>  #endif
>  	console_unblank();
>  
> -	/*
> -	 * We may have ended up stopping the CPU holding the lock (in
> -	 * smp_send_stop()) while still having some valuable data in the console
> -	 * buffer.  Try to acquire the lock then release it regardless of the
> -	 * result.  The release will also print the buffers out.  Locks debug
> -	 * should be disabled to avoid reporting bad unlock balance when
> -	 * panic() is not being callled from OOPS.
> -	 */
> -	debug_locks_off();
> -	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> -
> +	panic_console_flush();
>  	panic_print_sys_info();
>  
>  	if (!panic_blink)

The result looks good to me. We could do it as a followup patch.

Best Regards,
Petr
