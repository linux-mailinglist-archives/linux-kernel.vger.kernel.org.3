Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD564B2BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352096AbiBKR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:26:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiBKR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BBEEB;
        Fri, 11 Feb 2022 09:26:39 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:26:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644600397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3R4ppzYSshZrFnJmta5i+WEKFHmi/QTgBEL2KXubIQ=;
        b=MVXPCRUBQSCJ3fkc1AzojxgJhBQBpLleV3NqRRMpyA0oRHIY/eBtVYYrQkXxLe80g+I3ES
        TTTDHhAV3CGfelkEPQR0HpkGKfOCstkJbhZYSQOsgpYeY8TRZcQRQABiM5/yEXpQczTwLW
        VI8P1vYrHkLDi2bI795O3NkDU2bl7TUHjNwr9/0crGqhmkxUvNtKo7bWm6jfavZIilcDpP
        maL11YUThg45uy0ENVrLPEe+wzjKpQvW070TnVHSdnau6rn59IRXC4uJ44DGyfKV+PbIjZ
        y3BQFACMB2p5EV9Dxzae0DlLLnXSnqrAbB3qFXMAgS1vmUMhYTUI7x6Fp25+JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644600397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3R4ppzYSshZrFnJmta5i+WEKFHmi/QTgBEL2KXubIQ=;
        b=wJBO3vyNVpapVNfIGpvTr/15NNiVFrjawzsYn+3YpqGJ5anigRq/RPLr3F6/KXXcJaaQaP
        wEUUSLdHtFLxsmDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
Message-ID: <YgacTN2zHeBhWw5d@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
 <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <YgaV0UZO1KfmtLLh@linutronix.de>
 <CAHmME9qR02XCX48D+AoT1rOFyNo_GXubyHPzoX01BYkJDX7p1A@mail.gmail.com>
 <YgaZuShru2HQiFXg@linutronix.de>
 <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oZMFN80M98Mt6JysPSMTJoXfKTjHuxG6BQSsC=+0z5fg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 18:17:57 [+0100], Jason A. Donenfeld wrote:
> On Fri, Feb 11, 2022 at 6:15 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > A CPU hotplug notifier which removes unconditionally that bit when the
> > CPU goes down or sets it to 0.
> > We can keep it as it. Just an idea for later maybe ;)
> 
> I looked into it and it seemed like the plumbing was kind of miserable
> for that. If you want to take a stab, though, that might be an okay
> followup patch, and then we can assess atomics vs notifier. I think
> notifier will wind up being a lot clunkier, though.
> 
> Sounds like we should be all set for the v7 I sent out?

Sure. I can do the CPU-HP notifier later one once we are done with
everything. I acked the v7, don't see a road block.

> Jason

Sebastian
