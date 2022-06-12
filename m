Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B5547AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiFLQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiFLQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:03:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593512AF7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:03:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655049790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih2/YNrLu+peqTES6tNKHy07xKIv3H7Sak8dQRkl3iE=;
        b=gLS6eTYM8UPoozWCdO89IjOBOvTCuOiaDmj8WraykE5Z5TJXbuTbXtxLHz2N029UFSYKW3
        s68IQfjOWvKJzRijmHpaV2SOrnQpe4QEvTPyoKZQ1joLHZdyXusMRogXW2//NOoWO1DBHs
        LSW+ex9wMxDcChSeMuOdwTsUmnmWEEIFfPN31q4zQ+NfEUlxBL8HSg4sLLXhIZbSAMqi1K
        3UzCCsY5nWHaFxtA7PO67hbsDW+XmKVbrTQfuqNt8TjsWOOvAm4WHAdrvkiz1DBgPHCbWZ
        JaplPqEfc2UArBgNIp2vnHrBbO/4lYtuDwGhgVaUtmqn23HuKdxvOLl9k8O0zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655049790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih2/YNrLu+peqTES6tNKHy07xKIv3H7Sak8dQRkl3iE=;
        b=wdUopkimK/3++thcsGB4/gTT4f7m3LAwDfr/78p6vfjyG4nJAQwschMOv8Re4doFr2sM2y
        lQ3mp2PwezxXWHBA==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org, pmladek@suse.com
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for
 per-console locking")
In-Reply-To: <20220612132302.GA873785@paulmck-ThinkPad-P17-Gen-1>
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
 <20220612132302.GA873785@paulmck-ThinkPad-P17-Gen-1>
Date:   Sun, 12 Jun 2022 18:09:10 +0206
Message-ID: <87k09llvi9.fsf@jogness.linutronix.de>
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

Hi Paul,

Thanks for looking into this! I am currently on vacation with family, so
my responses are limited. Some initial comments from me below...

On 2022-06-12, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> And the patch below takes care of things in (admittedly quite light)
> testing thus far.  What it does is add ten seconds of pure delay
> before rcutorture shuts down the system.  Presumably, this delay gives
> printk() the time that it needs to flush its buffers.  In the
> configurations that I have tested thus far, anyway.
>
> So what should I be doing instead?
>
> o	console_flush_on_panic() seems like strong medicine, but might
> 	be the right thing to do.  The bit about proceeding even though
> 	it failed to acquire the lock doesn't look good for non-panic
>       use.

For sure not this one.

> o	printk_trigger_flush() has an attractive name, but it looks
> 	like it only just starts the flush rather than waiting for it
> 	to finish.

Correct. It just triggers.

> o	pr_flush(1000, true) looks quite interesting, and also seems to
> 	work in a few quick tests, so I will continue playing with that.

This is only useful if the context is guaranteed may_sleep().

What is _supposed_ to happen is that @system_state increases above
SYSTEM_RUNNING, which then causes direct printing to be used. So the
pr_emerg("Power down\n") in kernel_power_off() would directly flush all
remaining messages.

But if the threaded printers are already in the process of printing,
they block direct printing. That may be what we are seeing here.

What I find particularly interesting is that it is not the kthread-patch
that is causing the issue.

I will have some time tonight to take a closer look.

John Ogness
