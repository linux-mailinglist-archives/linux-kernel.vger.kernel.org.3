Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70057FF03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiGYMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiGYMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:30:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37CFE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:30:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 07C7620124;
        Mon, 25 Jul 2022 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658752208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Djhp/kj6T5Dlta/dAFi83yMTsDZOdx2mCFb0oJGeuo=;
        b=smASnO5nClMmRn44SKR3UHMcTznlkTTqxrwiYBmd8y6eN8EvZ90gaONNA1SigZ3AZToDVj
        jBDFQFGrZLE9uXYSlDZx1XnZRhmApdiq/dzdv3aD4m3L2il/HY7IOsAXRmE8zdCm85D1ku
        eMTvbzhjlrDsLA7UZvK4O4eWZbG1rY8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE54C2C152;
        Mon, 25 Jul 2022 12:30:07 +0000 (UTC)
Date:   Mon, 25 Jul 2022 14:30:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt6MzEEFfpyTBIIj@alley>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtrYdXWGb0NQLKNA@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-22 19:03:49, Sebastian Andrzej Siewior wrote:
> On 2022-07-22 14:39:44 [+0200], Petr Mladek wrote:
> > On Thu 2022-07-21 08:50:38, Sebastian Andrzej Siewior wrote:
> > > printk might be invoked in a context with disabled interrupts and or
> > > preemption and additionally disables interrupts before it invokes the
> > > console drivers. This is behaviour is not compatible with PREEMPT_RT.
> > 
> > Maybe I do not understand it correctly.
> 
> > Or is is somehow specific to the console drivers called from printk()
> > directly?
> 
> You can't acquire a sleeping lock with disabled interrupts and or

This is what I have missed. It might be obvious for people living by RT
kernel. But spinlocks do not sleep in normal kernel. So I did not get
that the spinlocks are the culprit. Please, make it more obvious
in the commit message, for example:

--- cut ---
Console drivers use spinlocks that might sleep in PREEMPT_RT. As a
result they must not be called with interrupts enabled...
--- cut ---

> > > Disable console printing until the return of atomic consoles and the
> > > printing thread. This allows to retrieve the log buffer from user space
> > > which is not possible by disable printk.
> > 
> > I guess that this is for RT tree because the kthreads and the atomic
> > consoles are still not in the mainline.
> 
> I would like to have this applied to the v5.20 upstream tree and then
> revoked once the missing bits have been  merged. Based on what I see,
> there shouldn't be any road blocks.

Huh, I do not think that it is a good idea. There are neither atomic
consoles nor printk kthreads in upstream. The patch effectively
completely disables the consoles in PREEMPT_RT. All consoles
will be _empty all the time_.

Also the consoles were never tested with interrupts enabled. I am
pretty sure that interrupts has to be disabled in some locations,
for example, when sending some data sequences on the ports. Are we
sure that they are always explicitly disabled inside the drivers?
This is one reason why we reverted the console kthreads in 5.19-rc4.
AFAIK, John is doing some inspection of all drivers.

That said, I am going to leave the decision on John. I am not sure
what are the expectations of RT users in mainline.

From my point, this patch does not make much sense. IMHO, it will
not make mainline usable with PREEMPT_RT. Any serious RT user will
need to revert it and apply a better printk solution from
the out-of-tree RT patchset.

Best Regards,
Petr
