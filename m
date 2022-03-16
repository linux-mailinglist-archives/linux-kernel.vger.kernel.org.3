Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3924DB6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbiCPRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbiCPRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:07:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225946B2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:05:55 -0700 (PDT)
Date:   Wed, 16 Mar 2022 18:05:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647450354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4mgZ1/pDWQ3nScxh+XnF6i72BqJEn7PNWTgnZdOXFI=;
        b=S99Yk6tEYxSJ207mxDQGhlcrR3wYLa+q3V7akvdsQ7AxrUyxXjQ9aaxLdfNX8fjI2K+Tjw
        T3zQDHsN2p1IYaIa2vK1OBxnc4/M3Kl5y0eLyR2ytVMaebnPvZFo9i2y+u+zkv8E9tceZD
        59EURG5Hxjgdw6lS13DK+Pv4KadgwVpLO+ZRYlc3OJsfo5JbGeYImKPTinm2KHZv95ZVlu
        HVW7env1R3LS3jGBaYC/1/oNeNr1A0y6shKcT92ZLqaeQhF/EO2J67zdyxkJId/b6OH21t
        3ckiBpVm8wYe/1u8XYny6azDugFIB/WxUzjUOXfqoKZLekiaIBooWq4Fr5+F7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647450354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4mgZ1/pDWQ3nScxh+XnF6i72BqJEn7PNWTgnZdOXFI=;
        b=8GbkF1fFvHY1ZuXbjdnWK7Uk3yBUPOM7fRvk4HvJUYlXKlrWe/sDpS7aUDnXnNKnCQEAtJ
        HEpzNCv8FibxEnAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <YjIY8Ciw7IvKKQCZ@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <YjIKQBIbJR/kRR+N@linutronix.de>
 <YjIN4C8EFIOOR+o4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjIN4C8EFIOOR+o4@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 17:18:41 [+0100], To Steven Rostedt wrote:
> on top my problems are gone. Let me do some testing and then I would
> patch unless PeterZ does the yelling :)

so the long irq-off section is latency wise less than optimal. A
testcase went from ~40 to 140us. And then there is this:
| NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
| NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #10!!!

which might be RT-only.
I *think* we want first the buggy part gone and then the latency fixed.

> > > Thanks,
> > > 
> > > -- Steve

Sebastian
