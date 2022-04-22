Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194B850B5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385078AbiDVLMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447049AbiDVLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:12:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61865622C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AGKq+PyA9mo8Ay12CxWSRyAIOyUJ7wvIv5RuoItVCRc=; b=e9qnxNqh4OFX9wncCbqzr1BvPn
        czcs4J3+MB/STpGvYLgtFv1INvPUBLtZsa0QFq3Kl7byLfjcsLPLuu4VdOi303mJJIgyLVyTwXy3S
        QfQglHjg72c8HJgXZuiGliV0Nlwuxa/NujdddQKfMaRidLsJg055aDJ+rZbdaw/LzuI8qzKcvL7ld
        388IE7nT5SEqqi4R+cicz+V0/y1sL8L35klxp+pl2jMuBF8QSnqWmt1Hxuzh28ZBxK/CUv1IAzFgt
        jM9FIuNe646B4NzutPs10kJBe1eysUdZpCyqDLbEUIc5WrdY5VcxiarID7jSzaDuEfvCKAxBJ0S8Z
        mZdu5yXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhr9u-007ftu-9S; Fri, 22 Apr 2022 11:09:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0683A9861AB; Fri, 22 Apr 2022 13:09:04 +0200 (CEST)
Date:   Fri, 22 Apr 2022 13:09:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
Message-ID: <20220422110903.GW2731@worktop.programming.kicks-ass.net>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:12:25PM +0000, Delyan Kratunov wrote:
> Hi folks,
> 
> While working on bpf tooling, we noticed that the sched_switch tracepoint
> signature recently changed in an incompatible manner. This affects the
> runqslower tools in the kernel tree, as well as multiple libbpf tools in iovisor/bcc.
> 
> It would be a fair amount of churn to fix all these tools, not to mention any
> non-public tools people may be using.

So on the one hand, too bad, deal with it. None of this is ABI.

> If you are open to it, here's a
> description and a patch that moves the new argument to the end,
> so existing tools can continue working without change (the new argument
> just won't be extracted in existing programs):

And on the other hand; those users need to be fixed anyway, right?
Accessing prev->__state is equally broken.

Yes, the proposed hack is cute, but I have very little sympathy for any
of this. These are in-kernel interfaces, they change, there must not be
any impediment to change.

If bpf wants to ride on them, it needs to suffer the pain of doing so.
