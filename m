Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8644F0B33
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359371AbiDCQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiDCQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:20:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD0BAE4D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:18:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649002732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAewAqVHqiv1/qOhXJTMX0jz7jAm8m6A2sT3Ddeu93k=;
        b=Ok9Rt31gL3UjwMJW8njQDOCzwZFRBtLee1JQ/nYFYlgSRRtY/HioJeQB9GAqfq4Vk04iRY
        CfStC85dr6e2/8X5W9CiKjDwUNkGw9KmJ2X5eZ4cLnsvCLQR4CBbWwLfzBNPczhRnD1L3z
        eqfXnD5+uowTcsrGty0vS7quKY6oUmwv1u8ybm+sc0+EE16O01ovWUObIePhEw1+4Hyleg
        9EEbcaLVlF3aGncv/u7LcQgsgQQvxtLju7mtVOrTs9SfwkHLv/paCxQFe1SfjJ6vu9OKw7
        zobdNvjin5c8SBttkCd6SGga3ZPm7c7BpTFogv/QH4BfZXVMdfr+zlCCq0CsZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649002732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAewAqVHqiv1/qOhXJTMX0jz7jAm8m6A2sT3Ddeu93k=;
        b=TM3K0tDlcg4YJggDatQjquSGYSrF8oJDi8eo0tsEwTxto2IKHUOzzua/lw73d2mPcrY1C1
        JS7K7W35z3q+qYBw==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
Date:   Sun, 03 Apr 2022 18:18:51 +0200
Message-ID: <877d86m978.ffs@tglx>
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

On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> At init, we get
>
> init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
>
> which makes sense, jiffies is set up to wrap very quickly after boot.
>
> The warning triggers when we have jiffies=0x13fff9600, so it's just
> after the "next_expiry", so in this code:

which does not make sense. If next_expiry is 0x13fff8acf and jiffies
advanced to 0x13fff9600 when the warning triggered, then either it
missed to expire the timer at 0x13fff8acf or it failed to recalculate
next_expiry.

Could you enable all [hr]timer tracepoints on the kernel command line,
set panic on warn and ftrace_dump_on_oops which should spill out the
tracebuffer on the console and provide the output. That should at least
give us an hint what's going on.

Thanks,

        tglx


