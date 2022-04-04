Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E452A4F149A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiDDMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbiDDMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E513D38
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:17:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649074635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3paIMz/GqzZqhnV1rYs16IZUOIwLYDm9lWchrpB/ysQ=;
        b=z+zZhSG5dqYDLM0DGDrgIR/4ZbBT9F4bvw3oQzfzr5SFOGYyzgCHTAQQHQqBrhkiet10hd
        hwonO+a8HQcVGibG7PGD6dfQSXFHLXzNy/oo/BQ/KCSlAjEf7KetlruCTw+GK034PVxgj1
        CoGMPg4xEyxCB9Dh0Gz+wjrxfxByF7EKmnH+cBs4U2D44n6Ppqo0Nt0D5lXZSI45gTw+1E
        1zUuWqj/VcOm9PJgdBx/kVSTGaxlXCuQJKiTRkyhWch1SG+a8hi0Y3RfNJVwYC7a9MAkzq
        d1xBoyKrILMcCBXvAsnHMapyO5gLe0sz5ti3T1nGXmeYN4M+xojn+F9wNN0vKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649074635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3paIMz/GqzZqhnV1rYs16IZUOIwLYDm9lWchrpB/ysQ=;
        b=9g+QxgSjxxOBc+UPabCDMUM/4gwbozi4/ZohIQVL2iTy0SiIajIB8kX+KQbtNt63v6FwKj
        ppE1HzRHrE2BVmDA==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <85f7ce7bc7ddcf1f67b52375b7fabaca8d254e5a.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <87pmlykksj.ffs@tglx>
 <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
 <87ee2dl041.ffs@tglx>
 <85f7ce7bc7ddcf1f67b52375b7fabaca8d254e5a.camel@sipsolutions.net>
Date:   Mon, 04 Apr 2022 14:17:15 +0200
Message-ID: <871qydjb5g.ffs@tglx>
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

On Mon, Apr 04 2022 at 10:37, Johannes Berg wrote:
> On Mon, 2022-04-04 at 10:32 +0200, Thomas Gleixner wrote:
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1724,9 +1724,8 @@ static inline void __run_timers(struct t
>>  		/*
>>  		 * The only possible reason for not finding any expired
>>  		 * timer at this clk is that all matching timers have been
>> -		 * dequeued.
>> +		 * dequeued or no timer has been ever queued.
>>  		 */
>> -		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
>> 
>
> So I'm pretty sure we don't even need to test a patch simply removing
> the WARN_ON_ONCE() since the entire problem Vincent reported was hitting
> the WARN_ON_ONCE :)

:)

> (And I'm pretty sure I did at some point test some additional condition
> inside it)
>
> Are you going to merge that patch?

Let me write a coherent changelog.
