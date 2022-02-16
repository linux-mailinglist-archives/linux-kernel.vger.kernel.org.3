Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4E4B8D77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiBPQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiBPQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:10:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB62AD677
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:10:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 54DFA2177B;
        Wed, 16 Feb 2022 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645027844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bDvymKzSLLrtbDA6EXSQG+NWXMWEYN2CVr6HzbEY3I=;
        b=kesOboPnTpeky5AGrib1knxPwu5U1RqU3zXLunk0Ju9NTWD1zUaDIJ+uQcDclz32jZImLa
        N1rN1tfoIzqRs+KUe1ejs3sy+mCkpmh3KYpO87iR9t1mokj01iXwbPokm4FrQS0I0DxZu1
        PxnaohjTPXFcFpthOeLzwFMptNlHxfk=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 138FAA3B84;
        Wed, 16 Feb 2022 16:10:43 +0000 (UTC)
Date:   Wed, 16 Feb 2022 17:10:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 07/13] printk: move buffer definitions into
 console_emit_next_record() caller
Message-ID: <Yg0iA/McHYWK6d4D@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:17, John Ogness wrote:
> Extended consoles print extended messages and do not print messages about
> dropped records.
> 
> Non-extended consoles print "normal" messages as well as extra messages
> about dropped records.
> 
> Currently the buffers for these various message types are defined within
> the functions that might use them and their usage is based upon the
> CON_EXTENDED flag. This will be a problem when moving to kthread printers
> because each printer must be able to provide its own buffers.
> 
> Move all the message buffer definitions outside of
> console_emit_next_record(). The caller knows if extended or dropped
> messages should be printed and can specify the appropriate buffers to
> use. The console_emit_next_record() and call_console_driver() functions
> can know what to print based on whether specified buffers are non-NULL.
> 
> With this change, buffer definition/allocation/specification is separated
> from the code that does the various types of string printing.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 822b7b6ad6d1..02bde45c1149 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2597,13 +2611,13 @@ static bool console_emit_next_record(struct console *con, bool *handover)
>  		goto skip;
>  	}
>  
> -	if (con->flags & CON_EXTENDED) {
> -		write_text = &ext_text[0];
> -		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
> -		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
> +	if (ext_text) {
> +		write_text = ext_text;
> +		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
> +		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
>  					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
>  	} else {
> -		write_text = &text[0];
> +		write_text = text;
>  		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);

@text and @ext_text buffers are never used at the same time. It might
be enough to use a single text[CONSOLE_EXT_LOG_MAX] buffer. It would
even slightly simplify the code.

>  	}
>  
> @@ -2621,7 +2635,7 @@ static bool console_emit_next_record(struct console *con, bool *handover)
>  	console_lock_spinning_enable();
>  
>  	stop_critical_timings();	/* don't trace print latency */
> -	call_console_driver(con, write_text, len);
> +	call_console_driver(con, write_text, len, dropped_text);
>  	start_critical_timings();
>  
>  	con->seq++;
> @@ -2650,6 +2664,9 @@ static bool console_emit_next_record(struct console *con, bool *handover)
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> +	static char dropped_text[DROPPED_TEXT_MAX];
> +	static char ext_text[CONSOLE_EXT_LOG_MAX];
> +	static char text[CONSOLE_LOG_MAX];

These buffers are for printing from console_unlock(). The same buffers
will need to be allocated for each console in the kthreads.

It might make sense to allocate these buffers in register_console()
and store the pointers in struct console.

Well, we might need extra buffers for atomic console drivers and
diffent contexts that would be used during panic. But maybe
they can be allocated in register_console() as well.



>  	bool any_usable = false;
>  	struct console *con;
>  	bool any_progress;
> @@ -2667,7 +2684,16 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  				continue;
>  			any_usable = true;
>  
> -			progress = console_emit_next_record(con, handover);
> +			if (con->flags & CON_EXTENDED) {
> +				/* Extended consoles do not print "dropped messages". */
> +				progress = console_emit_next_record(con, &text[0],

IMHO, &text[0] buffer is not used for extended consoles.

> +								    &ext_text[0], NULL,
> +								    handover);
> +			} else {
> +				progress = console_emit_next_record(con, &text[0],
> +								    NULL, &dropped_text[0],
> +								    handover);
> +			}
>  			if (*handover)
>  				return true;

I do not resist on allocating the buffers in register_console(). I am
not sure if it would really makes things easier.

But I would really like to use the same buffer for normal and extended
consoles if possible.

Best Regards,
Petr
