Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031704CF419
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiCGI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiCGI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:56:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CBC1BEA7;
        Mon,  7 Mar 2022 00:55:15 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:55:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646643312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoVzBf1uXNcTzGiPbR/fg/8odB0x/Dhp0N0m6GdxpLc=;
        b=41o4gWkezgvWk2XDLJwhHNQd6xE5gchpopyr67bC28C+0MAqDQU5Q+J/CYaqkDucEHKu5P
        j7QCHtamiLiAGWTuOIWB3S+i49YXDYtFniewiIr/ydSxb8cBGfotgNF2m3mEOpx73MMcPR
        GrwVjWiyr/tpjaJpf4fI0Nkx9053gTZBh+1IYrIdN5TkgxCf2FrJ6U5CtWxrZxuOVFfYzw
        Yhh8LzkHg2j8HrEZVTsbcO7RkYhzyRX1ZvfcASdd87cFpIfp+yN8M9xZ9GzOvDQyWkSabP
        AemowUH/V58vsQEjl3ulifi/opRG9zcLSumiIrE5MTO6VLAmC2RIA0GJfto9iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646643312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoVzBf1uXNcTzGiPbR/fg/8odB0x/Dhp0N0m6GdxpLc=;
        b=md/CxHPZCzL2m9kymyQ2UtneZu8bff63noOjI8mU80fRT5BDsn+PxWkt3keVIigL1h0u9g
        +JTvhpl/d4aVXRBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
Message-ID: <YiXIb43PR4bayMHw@linutronix.de>
References: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-06 18:17:54 [+0800], Yunhao Tian wrote:
> Hi everyone,
Hi,

> I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
> RK3308 board. I set up f_rndis gadget with the following script, and
> plugged my board to a x86 Linux computer running 5.15.25 kernel:

Is this 5.15.24-rt31 as-is or are there other patches involved?
What UDC is used here?

=E2=80=A6
> [ 25.993834] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #80!!!
that is sched

=E2=80=A6
> [ 25.995885] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #180!!!

that is additionally hrtimer.
I did touch hrtimer but I did not yet touch sched so I account myself as
50% innocent.
You don't have by chance change the thread affinity of tasks/ interrupt
threads? The SoC has 4 cores if I see this right.

> If I turn off PREEMPT_RT, there won't be any errors while downloading.
>=20
> I believe this problem is not tied to any specific board, and anyone
> can reproduce this problem using a Raspberry Pi (Although I didn't try
> because I don't have one). I would like to ask for assistance
> regarding this problem.

Let me try dummy_udc=E2=80=A6

Sebastian
