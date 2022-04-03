Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD14F0B89
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359646AbiDCRVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbiDCRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:21:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87F25E9F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1A6lCTEsUjFcpHGOtwRNck1KGF0Efo/Uou800fr0e80=;
        t=1649006361; x=1650215961; b=lLpiD5jusalnv662Rqkb9Rn/24xAz/4a/R0dFYvtScSnxvs
        +f8LBqquOSeuZhmg/JUw2Ph5aH8LwfkSH7ljgueFWWJPa9Im2z8akA54All5aUbJCsppVAHhuNjiP
        8hPjQZsPIuAH4w4oTfYzUjk7zLZ91RYxDnMIHxjyJrMAjeROKpFwX6jnzKMpcECy3iG+2esllSIp0
        u1F+pDEVtbuuL7u+oWa60caKrIUiokD94raQ1M1Dfkev8VAfQDlGPOH2kZQf9sh5ALhf/I1I/l/Q8
        YnuQrwpPfH2MAHpST5vxowwKTgwZ2sp/idC6soQy0BQl9s7Au3d7o75118sshbhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nb3sk-004Ngx-2d;
        Sun, 03 Apr 2022 19:19:18 +0200
Message-ID: <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Sun, 03 Apr 2022 19:19:17 +0200
In-Reply-To: <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
         <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
         <877d86m978.ffs@tglx>
         <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
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

On Sun, 2022-04-03 at 19:13 +0200, Johannes Berg wrote:
> On Sun, 2022-04-03 at 18:18 +0200, Thomas Gleixner wrote:
> > On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> > > At init, we get
> > > 
> > > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > 
> > > which makes sense, jiffies is set up to wrap very quickly after boot.
> > > 
> > > The warning triggers when we have jiffies=0x13fff9600, so it's just
> > > after the "next_expiry", so in this code:
> > 
> > which does not make sense.
> 
> If you say so, I have no idea :)
> 
> > If next_expiry is 0x13fff8acf and jiffies
> > advanced to 0x13fff9600 when the warning triggered, then either it
> > missed to expire the timer at 0x13fff8acf or it failed to recalculate
> > next_expiry.
> 
> There was no timer. If there's ever a timer on this base (BASE_DEF) then
> this doesn't happen.
> 
> So it has to be the latter, but I'm trying to understand in the code
> where it would*ever* recalculate next_expiry if it in fact never
> expires?
> 

Actually, in a sense, this *is* the case of (just) recalculating
next_expiry, no? We just never set next_expiry_recalc since there was
never any timer on this?

So actually this also makes the warning go away:

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1729,6 +1733,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
+		base->next_expiry_recalc = !levels;
 
 		while (levels--)
 			expire_timers(base, heads + levels);
@@ -2005,6 +2010,7 @@ static void __init init_timer_cpu(int cpu)
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry_recalc = true;
 		timer_base_init_expiry_lock(base);
 	}
 }


johannes
