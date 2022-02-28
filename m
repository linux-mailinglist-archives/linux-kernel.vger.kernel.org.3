Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813F44C7866
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiB1S7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiB1S7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:59:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8462CC;
        Mon, 28 Feb 2022 10:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFCCAB810DB;
        Mon, 28 Feb 2022 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C1DC340F2;
        Mon, 28 Feb 2022 18:58:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VCWF4Bxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646074697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGBLvUwxCfj+fep4C2uzBBsHHAtZqevXsUStypuqdbU=;
        b=VCWF4Bxuyr+RXJM6ITDTf88mbFglLf39UfH8vUHhKsdqrdeEaLkHtTAwhk8W6lZnw/jeLP
        1HXfQV2iK+1JRmGaF6Y7th022Impv9B4GEeNtbAoz65mSbvz3xwhEL85HpduLZo/XCt0wK
        c3JBr9tQJIFiupfeSJ1YFEOVPXDVeqY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 171f2415 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 18:58:17 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2d68d519a33so119525817b3.7;
        Mon, 28 Feb 2022 10:58:17 -0800 (PST)
X-Gm-Message-State: AOAM531heUgqi3sxCsEKE+a4T7aDzt8OW29Y2Z+hg1DERNGi6uaWLJoO
        V6tYDM/0MeylUR5dNvSTclVuapU8jkxiwAodPd8=
X-Google-Smtp-Source: ABdhPJxaTul8hqPu8UErCAjxykGEG2KpUde+4nXvrW51yM/CwY4RIC071WxchyDjhsJ2Tw95+g9yCuqkz1oGEgKACWk=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr22843263ywe.404.1646074695845; Mon, 28
 Feb 2022 10:58:15 -0800 (PST)
MIME-Version: 1.0
References: <Yh0QlQ8aqttjlnKt@linutronix.de>
In-Reply-To: <Yh0QlQ8aqttjlnKt@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 19:58:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9rqhUcVD+rE5NEcvRu6G79aNkf8RZwXZnWtHNmTf3rfaw@mail.gmail.com>
Message-ID: <CAHmME9rqhUcVD+rE5NEcvRu6G79aNkf8RZwXZnWtHNmTf3rfaw@mail.gmail.com>
Subject: Re: RFC: Intervals to schedule the worker for mix_interrupt_randomness().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

I'm actually trying quite hard not to change the details of entropy
gathering for 5.18. There are lots of little arguments for why each
little thing is the way it is, and these have built up over a long
period of time, and reworking /that/ requires some anthropological
work to understand all the original intents, which I consider to be a
bit of a different "project" from what I'm working on now with
random.c. So I'd like to minimize changes to the semantics. Right now,
those semantics are:

A) crng_init==0: pre_init_inject after 64 interrupts.
B) crng_init!=0: mix_pool_bytes after 64 interrupts OR after 1 second
has elapsed.

In trying to "reverse engineer" what the rationales for (A) and (B)
might be, I imagine the reasoning breaks down to:

A) Since crng_pre_init_inject will increase crng_init_cnt by 16, we
want to make sure it's decently entropic [maybe? kind of a weak
argument perhaps].
B) We're crediting only 1 bit in this case, so let's consider that to
have accumulated after 64 fairly fast interrupts, which may be
"regular", or after a fewer amount that occur within a second, since
these might be irregular, and so perhaps more entropic per-each. That
sounds mostly sensible to me, and rather conservative too. So it seems
okay with me.

Maybe we can revisit these for 5.19, but I'd like not to tinker too
much with that for now. I think I can actually argue both for and
against the points I tried to synthesize in (A) and (B) above. It's
also related to what we collect, which you alluded to in your message.
Right now we're collecting:

1) random_get_entropy() (i.e. RDTSC): this is the big huge important
thing that's captured.
2) jiffies: does this matter if we're already gathering RDTSC? I can
see an argument both ways. More analysis and thought required
3) the irq number: maybe it matters, maybe it doesn't.
4) the return address: maybe it matters, maybe it doesn't.
5) the value of some register: maybe it matters, maybe it doesn't.

Maybe this could be reduced to only capturing (1); maybe we benefit
from having all of (1)-(5). Again, I can see the argument both ways,
and I think that needs a lot more investigation and thought, and if
that's to happen, it really seems like a 5.19 thing rather than a 5.18
thing at this point.

But all this brings me to what I'm really wondering when reading your
email: do your observations matter? Are you observing a performance or
reliability issue or something like that with those workqueues
pending? Is this whole workqueue approach a mistake and we should
revert it? Or is it still okay, but you were just idly wondering about
that time limit? As you can tell, I'm mostly concerned with not
breaking something by accident.

Regards,
Jason
