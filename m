Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0737B4B29AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350224AbiBKQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:06:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350057AbiBKQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:06:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D6F1A8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:06:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FD35212B6;
        Fri, 11 Feb 2022 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644595562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJpoAY7nNCoSuIS1GRaZfDtEczlVm8Y36bXE6b2z9p8=;
        b=sc5m8XqyH8170FIn3vL9jgmUwa6BuBTlZ9jEuLEEmtKXAEbhmK6QCuUgiTpIMc4chSZhYd
        I7JnV0Kd9g8L70eZykHEZJt84hd9jab0hi8XDr4Es8Teyblrq9iNaDDu6ACFmOSYbis9zj
        f/TMKBDKbe7119ZyTI7XnK/9yoQsDbM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA25DA3B83;
        Fri, 11 Feb 2022 16:06:01 +0000 (UTC)
Date:   Fri, 11 Feb 2022 17:05:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YgaJZtY+EH9JIGyo@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:13, John Ogness wrote:
> The CON_ANYTIME console flag is used to label consoles that will
> work correctly before percpu resources are allocated. To check
> the condition, cpu_online(raw_smp_processor_id()) was used.
> However, this is odd because CPUs can go offline at a later point.
> Also, the function is forced to use the raw_ variant because
> migration is not disabled.
> 
> Since commit ab6f762f0f53 ("printk: queue wake_up_klogd irq_work
> only if per-CPU areas are ready") there is a variable to identify
> if percpu resources have been allocated. Use that variable instead
> of cpu_online(raw_smp_processor_id()).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I dug more into the history to be more confident about the change.
I am not sure that it is safe.

CON_ANYTIME really seems to be related to per-CPU variables and early
boot, see the commit 76a8ad293912cd2f01eca ("[PATCH] Make printk work
for really early debugging").

I am not 100% sure. I think that the support for per-CPU variables
is enabled by setup_per_cpu_areas(). It is done for_each_possible_cpu()
So that per-CPU variables should always be available after
printk_percpu_data_ready(). So far, so good.


The problem is the commit ac25575203c11145066ea ("[PATCH] CPU hotplug
printk fix"). It suggests that per-CPU data of slab are freed during
hotplug.

There are many other things that are manipulated during cpu hotplug.
And there are the two notifiers "printk:dead" and "printk:online",
see printk_late_init(). Maybe, we should use them to decide whether
the non-trivial consoles are callable during CPU hotplug.

Best Regards,
Petr
