Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD314CAA17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiCBQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiCBQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:26:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413B76E33
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:26:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646238359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7NOla583Dkc2hPJm4Geje9sBORuvB2xZD1bf3QcRf0=;
        b=Qy+3zIMLj+7Rr1DQ41rQCdAwVFuQGyDYXVmWIRf0EIDo24k2KHuegBQEmHY2ThGiOo4vu1
        e3rpbuhWvBbdDs0yxbaH+AsfAPXlSyeBNI3vXBNsVLeHYiPygQTRblS1kfadDSayLZ8i1P
        u5HXrFIy1r81I3DR+0OnBRpqb193e3JVoWUEGiYa9xKzI7UtyFvH5HDYdV2kNaDYbFRTkl
        +y9Roxk/TB1cT56WkNYGkhKlOvp4Vtez0c/EyUSSdZobpnA0rv5ed+rTNb/GP9e2mk4aeq
        DflBSwptsNJfrgfENNEo1YUin+gsrsPh9V+RdJaN31E/37y5fRucynfba7iccw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646238359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7NOla583Dkc2hPJm4Geje9sBORuvB2xZD1bf3QcRf0=;
        b=Du14RPYMtbTfQ/71wH5f9Vcj+4qABQOtVVN3bp1MLQnAY4J+MVhvu0+jU7nITIiFh5tGx+
        LCxAyEp1paHscgBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 07/13] printk: move buffer definitions into
 console_emit_next_record() caller
In-Reply-To: <Yg0iA/McHYWK6d4D@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-8-john.ogness@linutronix.de>
 <Yg0iA/McHYWK6d4D@alley>
Date:   Wed, 02 Mar 2022 17:31:58 +0106
Message-ID: <87pmn4gw2x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 822b7b6ad6d1..02bde45c1149 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2597,13 +2611,13 @@ static bool console_emit_next_record(struct console *con, bool *handover)
>>  		goto skip;
>>  	}
>>  
>> -	if (con->flags & CON_EXTENDED) {
>> -		write_text = &ext_text[0];
>> -		len = info_print_ext_header(ext_text, sizeof(ext_text), r.info);
>> -		len += msg_print_ext_body(ext_text + len, sizeof(ext_text) - len,
>> +	if (ext_text) {
>> +		write_text = ext_text;
>> +		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
>> +		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
>>  					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
>>  	} else {
>> -		write_text = &text[0];
>> +		write_text = text;
>>  		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>
> @text and @ext_text buffers are never used at the same time. It might
> be enough to use a single text[CONSOLE_EXT_LOG_MAX] buffer. It would
> even slightly simplify the code.

No, they _are_ used at the same time.

r.text_buf is @text. msg_print_ext_body() takes @ext_text and
&r.text_buf[0]. Unfortunately msg_print_ext_body() does not work "in
place" like record_print_text() does.

>> @@ -2650,6 +2664,9 @@ static bool console_emit_next_record(struct console *con, bool *handover)
>>   */
>>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>>  {
>> +	static char dropped_text[DROPPED_TEXT_MAX];
>> +	static char ext_text[CONSOLE_EXT_LOG_MAX];
>> +	static char text[CONSOLE_LOG_MAX];
>
> These buffers are for printing from console_unlock(). The same buffers
> will need to be allocated for each console in the kthreads.
>
> It might make sense to allocate these buffers in register_console()
> and store the pointers in struct console.
>
> Well, we might need extra buffers for atomic console drivers and
> diffent contexts that would be used during panic. But maybe
> they can be allocated in register_console() as well.

register_console() happens quite early. But my plan for v2 is to make
them global static variables and allocate them on the first
register_console().

>>  	bool any_usable = false;
>>  	struct console *con;
>>  	bool any_progress;
>> @@ -2667,7 +2684,16 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>>  				continue;
>>  			any_usable = true;
>>  
>> -			progress = console_emit_next_record(con, handover);
>> +			if (con->flags & CON_EXTENDED) {
>> +				/* Extended consoles do not print "dropped messages". */
>> +				progress = console_emit_next_record(con, &text[0],
>
> IMHO, &text[0] buffer is not used for extended consoles.

Yes. msg_print_ext_body() needs it.

>> +								    &ext_text[0], NULL,
>> +								    handover);
>> +			} else {
>> +				progress = console_emit_next_record(con, &text[0],
>> +								    NULL, &dropped_text[0],
>> +								    handover);
>> +			}
>>  			if (*handover)
>>  				return true;
>
> I do not resist on allocating the buffers in register_console(). I am
> not sure if it would really makes things easier.

I'll give it a try for v2.

John
