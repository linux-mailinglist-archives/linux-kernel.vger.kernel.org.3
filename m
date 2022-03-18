Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36B4DD546
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiCRHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCRHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:35:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A1E97BB4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:34:18 -0700 (PDT)
Date:   Fri, 18 Mar 2022 08:34:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647588855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/eJN5lpmCE7+cswvF10Lfr2aEkE94xTbPDQ7uj3fww=;
        b=ALK98+gdtYIFV+tZg4cQnfeum3rNW3QjnlE8zZda+QAyYbrC4epcZPQ9hZpHwA4y2VqvZK
        wZsvyWlSFcQGSq7dwRHWhr2qlAfG/eDI7MiqrlEgeA/0DWELfzu+tuqNj2tb+q4Tiq3Luv
        i7nL4dUoE3rVMLo//M/8E1K2rsSgFMBovdT+koSg9kreFfrWhR1eRw5TtJECQm6xjleomO
        v+g468RkOnF1nbBI9oEJGrCdqsNCu8e2Br3CJXhLh/E4f+14OV6n2bHAf312E9+pKYxiAe
        8dXf7SIlt1DMrZ6gTzThGD8IGl62FJxQzXNSf2aR8OzSTIDIetbHKygrgls5UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647588855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/eJN5lpmCE7+cswvF10Lfr2aEkE94xTbPDQ7uj3fww=;
        b=uhb03gCLtHv+YXIZnyFZIRxwkCRjuUMnoomprZmVKkLUTuFu0xQQEDnmMoH0l9v1x4HwKp
        eJwVrIAhPIDWJBCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] smp: Wake ksoftirqd on PREEMPT_RT instead
 do_softirq().
Message-ID: <YjQ19nUE010AOboS@linutronix.de>
References: <YgKgL6aPj8aBES6G@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgKgL6aPj8aBES6G@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-08 17:54:08 [+0100], To linux-kernel@vger.kernel.org wrote:
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -691,10 +691,25 @@ void flush_smp_call_function_from_idle(v
>  	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
>  		      smp_processor_id(), CFD_SEQ_IDLE);
>  	local_irq_save(flags);
> -	flush_smp_call_function_queue(true);
> -	if (local_softirq_pending())
> -		do_softirq();

One thing I noticed while looking for a possible PI-boost from idle/
sched_core_balance(): Interrupts are disabled by the caller right before
calling this function or that local_irq_save() here. That do_softirq()
below, may enable interrupts while invoking softirqs. Both caller don't
have a lock acquired so it should be okay.

Sebastian
