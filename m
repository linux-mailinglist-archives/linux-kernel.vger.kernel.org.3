Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EC4F0FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377578AbiDDHEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDDHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:04:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21624326D4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4DehWVmqtNmqk3InZz8gMRe+DXyKq9QiQKFXiTH2z0A=;
        t=1649055735; x=1650265335; b=hy/mc69DKyHGeRNJv1pil+cT7UtB3CodN/ycw7gdhb86Fwq
        /x84kxAq25NPHvlR0XoUoaho4+XVEOlhkQQJN9EVW9I6BwWEtE+pqgQ9/rUq5XeaBaP5glEIV++W9
        LtpNaxNEJCDrMzKnXZAU99b0bdkkofj1d+cS3f111mT9ZI16JPAlEz+9EjLrsAtX92PVmVnd+LwcL
        6cE8EWLyzxDPBl9omFjeS9ulwc8pPb89fHJ1TizOgLQ6dyHuREWqkelISU8FuEIZMsNLWitNcgtL4
        NaliMR4dd18UUt+nS8QJLS39wLfEyvHOyP3SSZDJalQlc7j+pgT1FcIqq6k8Yc7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbGj4-004h3H-IN;
        Mon, 04 Apr 2022 09:02:10 +0200
Message-ID: <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Mon, 04 Apr 2022 09:02:09 +0200
In-Reply-To: <87pmlykksj.ffs@tglx>
References: <20220330110156.GA9250@axis.com>
         <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
         <877d86m978.ffs@tglx>
         <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
         <87pmlykksj.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-03 at 21:51 +0200, Thomas Gleixner wrote:
> 
> > There was no timer. If there's ever a timer on this base (BASE_DEF) then
> > this doesn't happen.
> 
> You said:
> 
> > > > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
> 
> which confused me. It's actually initialized to:
> 
>       base->clk + NEXT_TIMER_MAX_DELTA
> 
> but that's fine and it is overwritten by every timer which is inserted
> to expire before that. So that's not an issue as the prandom timer is
> firing and rearmed.

No, as I said before, there's never any timer with base 1 (BASE_DEF) in
the config we have. The prandom timer is not TIMER_DEFERRABLE (it
probably could be, but it's not now). There's no deferrable timer at
all. Once there is at least one, the warning goes away.

> That would not happen if next_expiry would stay at 0x13fff8acf. The
> first one in your trace expires at 5339070200, i.e.  0x13e3bbef8, which
> is way before that.

But it's not a deferrable timer, so it's on another timer wheel (base),
so it doesn't affect the "base 1" part above.

> Can you please apply the debug patch below and run with the same
> parameters as before?
> 
> Thanks,
> 
>         tglx
> ---
> Hint: I tried to figure out how to use that time travel muck, but did
>       not get to the point where I bothered to try myself. Might be
>       either my incompetence or lack of documentation. Clearly the bug
>       report lacks any hint how to reproduce that problem.

Well, the original bug report did have all the information, I gave the
link to it before:

https://lore.kernel.org/r/20220330110156.GA9250@axis.com

With that kernel config and command line, you can reproduce it easily.
All you need to know is to use "make ARCH=um" with that .config file :)


> +	trace_printk("RUN: now=%lu clk=%lu next_expiry=%lu
> recalc=%d\n",
> +		     jiffies, base->clk, base->next_expiry,
> +		     base->next_expiry_recalc);

IMHO all of this extra debug is a waste of time since you're not
differentiating the two bases anywhere. You'll just get confused (as
above) since timers do happen on BASE_STD, just not on BASE_DEF.

johannes
