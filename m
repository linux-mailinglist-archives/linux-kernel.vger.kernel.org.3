Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833CC5483D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiFMKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiFMKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:14:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C2F72
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:14:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B481B21D51;
        Mon, 13 Jun 2022 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655115254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8A1SBt7Y4ENgqL4eImjxK6vltqR5eYeh6JFaCiLr7vA=;
        b=XEIaa7toxjzMzmVz63x8m/Bpz29asC1XFMDzDOXMWlSSE/4ReiaKbx5luU5EL1s71vEGjb
        MV3HE9NpUiJSOf2bpEKQjUPEkTT8jliDvnD0E1jO++E86f768apChswS7pPvdQGUEFrQGC
        G6pZM5KHDslkiRb0FnVSVU1b3+9IJ/Y=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82DAF2C142;
        Mon, 13 Jun 2022 10:14:14 +0000 (UTC)
Date:   Mon, 13 Jun 2022 12:14:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
Message-ID: <YqcN9mH/aVwBoIMQ@alley>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de>
 <Yqazr060OLp2Rpbk@google.com>
 <87wndlge43.fsf@jogness.linutronix.de>
 <Yqb9xOBiY/262lhk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqb9xOBiY/262lhk@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-13 18:05:08, Sergey Senozhatsky wrote:
> On (22/06/13 10:36), John Ogness wrote:
> > >> IMHO, no. Especially in that situation, we do not want printk causing
> > >> that atomic section to become even longer. If the machine has entered
> > >> normal operation, we want printk out of the way.
> > >
> > > At the same time printk throttles itself in such cases: new messages are
> > > not added at much higher pace that they are printed at. So we lower the
> > > chances of missing messages.
> > 
> > That is true if there is only 1 printk caller.
> 
> Well, which is the case when num_online_cpus() == 1?

Good question.

Well, it would be nice to have the same behavior on single CPU
and SMP systems. Blocking atomic context with slow console is
bad even on single processor system. If there are problems with
lost messages then we will need a solution for SMP anyway.

> > For SMP systems with printing handovers, it might not help at all.
> > I firmly believe that sprinkling randomness into printk (i.e. system)
> > latencies is not the answer. We need to keep printk lockless and out
> > of the system's way unless there is a real emergency happening.
> 
> Yeah sure.
>
> > This particular thread is not about missed messages due to printk not
> > "throttling the system", but rather the kernel buffers not getting
> > flushed in an emergency. This, of course, needs to be properly handled.
> 
> True, but Peter mentioned
> 
>   "I noticed with threading enabled during large bursts the console
>    drops an excessive amount of messages. It's especially apparent
>    during the handover from earlycon to the normal console."

But this is also the situation when softlockups happen. It should
ideally be solved with a big enough buffer.

Another interesting alternative is the Peter Zijlstra's mode
where all messages are printed to the console "immediately".
They are serialized only by the CPU-reentrant lock.

This mode is not good for production system. But it might
be good for debugging. The good thing is that the behavior
is well defined.

I hope that we will get this mode with the atomic consoles.

Best Regards,
Petr
