Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134324BC26D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbiBRWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:03:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiBRWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:03:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47253A2F3D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:03:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645221782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d70nzOgH+nbWfCS58Mq4Z9Y4ri/XR9d4Ls7M6PCrR8=;
        b=PgK/ZBP60wWkJBuX1o7VMT1N0vM/UQUthkL+vhiotfW+qAO9j6+EIz9S3rWJ6kc1TTRmbc
        Nf0HycTxM8lX914MNnY2tWpFerYw3RXYV3Aq92U167ObeGTy6/qq4T2gJYQWdENY9NbHeG
        NK1PRYzDp7SAcCnLGACX+B+sU7rOjId8vMpYufE54NifzdeXg8auuEU1nhib8e0ibf8IrV
        A+6gtPnoJhnRBIQmNVHdIVX57IDeWgrWk8Ff5plUn9mmPkpBKDRYwyrrt9XgsW59l+fiBF
        lt0Z4fxu7wH7ROTuiDSP9x5c0YMNbBeKAPn+rYOzg+HDC4F6tn8AfMHjDXdcBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645221782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d70nzOgH+nbWfCS58Mq4Z9Y4ri/XR9d4Ls7M6PCrR8=;
        b=SezbJJWx5OR7S5jcYNIbpK8ym72E/3OXF2KCg2oDBieI+th9cfVCsl2KYlAf2+rOXlKocl
        RRsQ2rrrZfOdmqCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <87o8333l97.fsf@jogness.linutronix.de>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <Yg/HWcifuqLsS6cv@alley> <87o8333l97.fsf@jogness.linutronix.de>
Date:   Fri, 18 Feb 2022 23:09:01 +0106
Message-ID: <87ley73ka2.fsf@jogness.linutronix.de>
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

On 2022-02-18, John Ogness <john.ogness@linutronix.de> wrote:
>> This is another complexity. An easier solution would be to do:
>>
>> console_trylock()
>> {
>> 	if (down_trylock(&console_sem))
>> 		return failed;
>>
>> 	for_each_console(con) {
>> 		if (mutext_trylock(&con->lock))
>> 			goto fail;
>> 	}
>>
>> 	// sucess
>>
>> fail:
>> 	for_each_console(con_fail) {
>> 		if (con_fail == con)
>> 			break;
>> 		mutex_unlock(&con->lock);
>> }
>
> No, this cannot work. Semaphores are the _only_ synchonization object in
> the kernel that is allowed to perform a trylock from any context
> (because they don't have owners).

Sorry, I need to clarify this bold statement.

Semaphores are the only synchonization object in the kernel that is
allowed to perform a trylock from any context and does not disable
preemption upon locking. (This is important because console lock holders
expect preemption to be unaffected when taking the lock.)

John
