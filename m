Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673657BD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiGTRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiGTRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:50:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C201E52DF8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:50:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658339402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VUm5aTaIdNRBFOr1j7UUNjxF47G/uhDPjNYTrsInFNw=;
        b=nQ17EscHCyVIWoLBhCVLmzNsEzx0F9kZrsxMtUKmiG+iPfy+zfdsj57v+9s1iMs0fDlQUv
        PrsS8Kx/Opg5TS56YM+7MsZf+H6aVt2kIn/AnDUpVTaWjUgbfiC98T2KdOJy9Oz6saPuqD
        Oj0hCwKpL3vMpxUp/qns3T+l34jFVOpHq7PWdRptk0Tci5iG6dxOe9p9kfYY86vM1rW50/
        CZBvPxa6sPl0BDO2QRsSo76QxSak4JU8iEvjyX0IKS1yalPBMtdmSnTmEbtb+4RXH8kwrM
        SGlLVoqkQFhkZ+drBafU/ocz2qVmR0j0sfEgHf7t5eyTa8bhZNgg5MYVjrhueA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658339402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VUm5aTaIdNRBFOr1j7UUNjxF47G/uhDPjNYTrsInFNw=;
        b=sAUa8E5PDV1adgTLlIG83vSbdrGTNzf+WZlhXM6jrP8Ls+Q04JRXAkJ9WVn4Our+XNnygA
        2O+7a2hpuvbOuUBg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] printk: Skip console drivers on PREEMPT_RT.
In-Reply-To: <Ytgu17hATM8iqdGC@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de> <Ytgu17hATM8iqdGC@linutronix.de>
Date:   Wed, 20 Jul 2022 19:56:01 +0206
Message-ID: <87ilnrn06u.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -2843,6 +2843,16 @@ void console_unlock(void)
>> >  	}
>> >  
>> >  	/*
>> > +	 * On PREEMPT_RT it is not possible to invoke console drivers with
>> > +	 * disabled interrupts and or preemption. Therefore all drivers are
>> > +	 * skipped and the output can be retrieved from the buffer.
>> > +	 */
>> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> > +		up_console_sem();
>> 
>> This should be:
>> 
>>                 __console_unlock();
>
> Why?

Because that is the official function that performs the console
unlocking. With upcoming patches, that function does more. But even
without those patches, by directly calling up_console_sem() you are
leaving @console_locked set. The @console_locked variable is used by the
vt code to validate correct console locking.

I realize you are just copy/pasting from the condition above (checking
@console_suspended), but that condition is special. When consoles are
suspended, we still allow @console_sem to be locked/unlocked, but
without changing the locked status of the console. See suspend_console()
and resume_console() if you really want to see the gory details.

John
