Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A84CA7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiCBOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiCBOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:22:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BE49931
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:21:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646230911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5SU9+qdhXqvLsEbDMcfOtF5xKExfG0kzV2SVN80vBg=;
        b=wblLdsxCCmhA8EPlNPOgM5kuwmiptnCM3wfjBj8yxggS1vFAeNL9wfYbrN5R+tzwFhQIez
        k/ZgP33EWDMyG3ZcaLboAl0JH5bIrIuP28vf2pg+aphqr60bqwiG91Dd/UroZApvk2NjT2
        6geJI8VKKASt3yMyMD5mhPNvzIqIdhA5a+9XHqJutQjOp2NwP82dk2KCMCWQUVildP6qsi
        mY/CjPhQ5z+k745zPJjHJXY35Swl7VBTG5fShkNLQbLTYfTp3GWgMXRHlkxH1qvpNsvrV5
        S1edtoSzfizNKpKvFUn3svPzFJZSj3uKQev2UmCt7SRB5tv/QsFAnK0Xhyi1pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646230911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5SU9+qdhXqvLsEbDMcfOtF5xKExfG0kzV2SVN80vBg=;
        b=hFcJ4MXzHa/YrJ+nHCLxP6+aXlTex9MzjfGSSpZqpIiJPCEHJyfMPSvVgZ8Qg3shnHRfCW
        roNAkspoBNG3DcBQ==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
In-Reply-To: <YguCuFYeZ52mkr4r@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley> <YgoGNmYER8xni34K@google.com>
 <YguCuFYeZ52mkr4r@alley>
Date:   Wed, 02 Mar 2022 15:27:50 +0106
Message-ID: <87zgm8h1tt.fsf@jogness.linutronix.de>
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

I have taken some time to investigate the percpu implementation so that
I could provide clear answers here.

On 2022-02-15, Petr Mladek <pmladek@suse.com> wrote:
> I am not 100% sure. But it seems that static per-CPU variables might
> actually be used since the boot.

You are correct, but until per-cpu areas are setup, they all point to
CPU0. Normally that is not a problem since usually code is using
this_cpu_ptr() (which will always be the CPU0 in early boot), rather
than specifying foreign CPUs with per_cpu_ptr().

> Most likely, only dynamically allocated per-cpu variables have to wait
> until the per-cpu areas are initialized.

It is also important to wait if data will be stored that is no longer
valid after per-cpu areas are setup. setup_per_cpu_areas() copies the
static CPU0 per-cpu value to all the newly setup per-cpu areas.

This is actually the cause for the mystery [0] of failing irq_work when
printk_deferred was added with commit
15341b1dd409749fa5625e4b632013b6ba81609b ("char/random: silence a
lockdep splat with printk()". The problem was that the irq work was
being queued and _claimed_ before per-cpu areas were setup. But the
actual work functions are not called there. So when the irq_work was
copied to all the new per-cpu areas and the actual work was carried out,
the work item that was cleared was the old static variable and not the
new per-cpu area variable. This means all the irq_work flags were left
in the claimed state (PENDING|BUSY) and could no longer be claimed.

By avoiding queueing irq_work before setup_per_cpu_areas(), we correctly
avoided this problem. (I considered sending a patch so that
irq_work_claim() will fail if a global @percpu_complete is not yet
set. But for now, our set_percpu_data_ready() solution is at least good
enough for the printk subsystem.)

> We should probably revisit the code and remove the fallback to
> normal static variables.

Definitely. Now it is clear that @printk_count and @printk_count_nmi do
not need early variants.

John

[0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/
