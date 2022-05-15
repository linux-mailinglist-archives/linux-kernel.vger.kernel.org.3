Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E898F52784E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiEOOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEOOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:54:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F8718E18
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:54:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652626488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wKIWrX6o2S06a0AaFujZEJzGz1hzOWevfCkrsHRsKQ=;
        b=jwXavC7UPCcnlMyaW632SeiX5Rae6xCzb8CUbHOvgT18gTSpfVl6+PlnLfFOEP+sqtLHAB
        GiXAzsXA3GkrclI/nL9yvKp671zDTuF7NKplSKKpLca8+OlTbRZZi/h6RW7U5DGsHWAzYc
        od2L5566tmzscUsWR7YZYa94k1AqI1YieYs6Mo6DZXPbHr8nQ+EsAVJ/bXneE4nyuV2Ks4
        dfTvARaWBe/KnY2+jpXB0sBC8FTqoD0npNy4DPVq4cVMKGqSmRsCcJwOpBZTgzhA33zjfT
        LEgxrXcHf/K9kpBt3WXH6SyyltdrrmFRMHpElkzf2zelxtAtHWCU3vwkiYu5MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652626488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wKIWrX6o2S06a0AaFujZEJzGz1hzOWevfCkrsHRsKQ=;
        b=p09jeXomYeWlE/8OMd30DDULGp7XBvjqx188DpxvsgDMsaCfYreIYLyXSZHxX9a2JUE8tN
        wMx99nw/s7m8ZZAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [x86/uaccess] 9c5743dff4:
 WARNING:at_arch/x86/mm/extable.c:#ex_handler_fprestore
In-Reply-To: <8735hbryn6.ffs@tglx>
References: <20220513085455.GB21013@xsang-OptiPlex-9020>
 <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
 <8735hbryn6.ffs@tglx>
Date:   Sun, 15 May 2022 16:54:47 +0200
Message-ID: <87pmkerglk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15 2022 at 10:25, Thomas Gleixner wrote:
> On Fri, May 13 2022 at 09:52, Linus Torvalds wrote:
> The code which copies the ptrace supplied state has a pile of sanity
> checks to catch invalid state, but I wouldn't bet my hat on it that it's
> 100% complete. We can be more defensive here, but I would be surprised.
>
> Something like the untested below. I'll expose it to some testing to see
> what explodes.

I was not able to get something broken past the existing sanity checks
which was caught by the trial restore. I seems the FPU units are pretty
resilent against random nonsense except for the XSTATE header and the
MXCRS content. Though I ponder to just add that trial restore due to
paranoia.

Thanks,

        tglx
