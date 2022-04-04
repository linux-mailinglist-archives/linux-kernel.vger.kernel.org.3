Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D044F1110
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiDDIjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiDDIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:39:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A401EC5E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2nsvGIYIk6NhoSJKiB+v8THIdOWwPJhM2cxes4Gyo/E=;
        t=1649061455; x=1650271055; b=n3w2s1RS6UpkVK+KQbo+yTmOoZl1VFmCU5R9+OOZNxcKtxX
        qb/VKHZJ3fGO7f8EqiaF0g/rxrRv99whDoW3wKn5oM3Hh/hTHhri+z38OfRk96rS+mpLIAnYko4Hm
        rlxG44UJRW1EwVMF3vmug+sIF9xIkTsRhK9xJE0McJi3baCdMDeuM0E4G1/M8k7ZLKuGeu3ekJhsr
        u5C8GW6gi+7qSDMwjtYtuMdubN+MTv21s54JNpqHdzV3/nu5yDpRLDxtRRWduMwtnQD7LccsQIIbE
        1nrc6eSWvvhd5754ks3ZBOb4rkqzy45ot7wv+P6GDMP05Rwn4B8CsMMaRXarYxRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbIDL-004kDX-Fd;
        Mon, 04 Apr 2022 10:37:31 +0200
Message-ID: <85f7ce7bc7ddcf1f67b52375b7fabaca8d254e5a.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Mon, 04 Apr 2022 10:37:30 +0200
In-Reply-To: <87ee2dl041.ffs@tglx>
References: <20220330110156.GA9250@axis.com>
         <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
         <877d86m978.ffs@tglx>
         <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
         <87pmlykksj.ffs@tglx>
         <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
         <87ee2dl041.ffs@tglx>
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

On Mon, 2022-04-04 at 10:32 +0200, Thomas Gleixner wrote:
> On Mon, Apr 04 2022 at 09:02, Johannes Berg wrote:
> > On Sun, 2022-04-03 at 21:51 +0200, Thomas Gleixner wrote:
> > > but that's fine and it is overwritten by every timer which is inserted
> > > to expire before that. So that's not an issue as the prandom timer is
> > > firing and rearmed.
> > 
> > No, as I said before, there's never any timer with base 1 (BASE_DEF) in
> > the config we have. The prandom timer is not TIMER_DEFERRABLE (it
> > probably could be, but it's not now). There's no deferrable timer at
> > all. Once there is at least one, the warning goes away.
> 
> Groan. I overlooked the deferrable part. Yes, you are right. next_expiry
> of the deferrable base is stale when there is no timer queued up to the
> point where base->clk reaches the initial next_expiry value. So the
> check is bogus.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1724,9 +1724,8 @@ static inline void __run_timers(struct t
>  		/*
>  		 * The only possible reason for not finding any expired
>  		 * timer at this clk is that all matching timers have been
> -		 * dequeued.
> +		 * dequeued or no timer has been ever queued.
>  		 */
> -		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
> 

So I'm pretty sure we don't even need to test a patch simply removing
the WARN_ON_ONCE() since the entire problem Vincent reported was hitting
the WARN_ON_ONCE :)

(And I'm pretty sure I did at some point test some additional condition
inside it)

Are you going to merge that patch?

johannes
