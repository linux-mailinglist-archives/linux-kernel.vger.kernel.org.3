Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E55A8331
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiHaQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiHaQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947EC22B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2149661987
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF4C433D6;
        Wed, 31 Aug 2022 16:27:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iGxgpTTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661963235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc7ZMzWIg2Aa7xrlV4BdxZVrgJWRYtqIuFVeV6Gg4IE=;
        b=iGxgpTTP1prXuHYoBzw1GJh9fg1UPFcG/IzfO5bHyAAGWLW0GO1KiftYekgo7EOAoDMpch
        rRlNdNadAmvraop9QHI0UaXgmOLybsIb7e8apmqfAjCjVNcaRWdvvPr6L+tpeBsU6Yk4s/
        3MI9dizyQ3LNc0LW62pbMVwZEyV+1jo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1da25cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 31 Aug 2022 16:27:15 +0000 (UTC)
Date:   Wed, 31 Aug 2022 12:27:12 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw+L4JT1yuXnbIbI@zx2c4.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
 <Yw0XRtgh2dmSM+T1@linutronix.de>
 <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
 <Yw3i2N8J7yz3jnyt@linutronix.de>
 <Yw4rsdA7xu4+UrLi@zx2c4.com>
 <Yw5dqweo0bQDvPkP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yw5dqweo0bQDvPkP@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:57:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-30 11:24:33 [-0400], Jason A. Donenfeld wrote:
> > Hi Sebastian,
> Hi Jason,
> 
> > On Tue, Aug 30, 2022 at 12:13:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > The first patch did so yes. The second simply retried in two secs and
> > > this shouldn't be problematic.
> > 
> > This seemed pretty bad too, because now you potentially miss up to 2
> > seconds of messages AND it adds more complexity.
> 
> It is early at boot and it could be reduced to one if it helps. I
> remember you had a suggestion where we would lose always the first print
> out on RT you said it is okay since you can't rely on that…

I mean, the mechanism now is simple and doesn't fail. What you're
suggesting is more complex and fails sometimes. So,

> > I'm fine with changing things up to accommodate RT, but not when the
> > result is so obviously worse than before.
> 
> I don't think it is worse. This is your opinion and I did not hear any
> other feedback so far.

so, I think it's beyond a matter of opinion and is actually objectively
worse.

And it's not like I even care particularly much about vnsprintf; as I
said before, none of this really matters _that_ much. But I *do* very
much object to dirtying up random bits of code and making things
actually worse in the name of RT, especially when there are other
solutions being considered. Namely:

> > In my tests I can't see any latency difference with using raw spinlocks
> > in random.c. Maybe I'm doing things wrong? But I'm not seeing anything
> > change...
> 
> You need to look at the maximum latency that may happen. Also the other
> thing is that there is no need to add raw_spinlock_t locking if it can
> be avoided.

I really am having trouble fashioning a test that shows a higher maximum
latency. All the RNG critical sections are really short in the end. So I
dunno... seems like not a big deal to me. If you're seeing different
numbers, can you post them and how you came up with them? If I can
reproduce it, maybe it's possible for me to do something about that
latency. But so far I'm not seeing any latency spike...

Jason
