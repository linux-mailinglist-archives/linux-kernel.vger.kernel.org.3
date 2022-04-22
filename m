Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA450BB94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449376AbiDVPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353530AbiDVPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:24:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDDD4CD5B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:21:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650640879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2C74eQtV1tDeVvwP4XC8v75d8+iovvPiCBH5yMOtWUo=;
        b=JGLac8yaxHXFsl6LRkS3T9DujkzgRg5BdUyEyJHykcgbZDBefv2ynv/JruVmiPTjoJzi4t
        VSnKp3VKmHNJyeKPlzlga3WouCCok9Ci0sRKYsyfq4z6adNG21jXmN2WRzgybrswWVxq5v
        XejyPUFSIVOOzXuCZ9V9sThNd303fUengzw7SgLO6K6CTTWpQoiCUFkffvMiM9IA5Kacrc
        A706q916jxrFZlXri/e5JIsQIx2z+SkH3olHBZdFrgi/OLcOnOF1iv32BgIAu81pJac5h9
        VOQakKo2S3NWC0ssi9ZvRbQKjqRz6uBr1uHm1zlUsrbqLBRFfpOZsLQc9jyM1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650640879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2C74eQtV1tDeVvwP4XC8v75d8+iovvPiCBH5yMOtWUo=;
        b=fKn2lypPWviyC/ZlCqyxZULmXcCIDoccbmfLNHiWY2bM6rKkhO2RYDVCWl+z0d6LKb4jf7
        iTYiw6pHd3Jy9bCw==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, rafael@kernel.org
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
In-Reply-To: <e59d076bc05ed319732ac3e234e423affae1cafe.camel@sipsolutions.net>
Date:   Fri, 22 Apr 2022 17:21:18 +0200
Message-ID: <87ilr15ekx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22 2022 at 15:53, Johannes Berg wrote:
> On Fri, 2022-04-22 at 15:41 +0200, Johannes Berg wrote:
>> On Tue, 2022-04-19 at 15:57 +0530, Mukesh Ojha wrote:
>> >    INIT_DELAYED_WORK
>> >    schedule_delayed_work
>> > 
>> 
>> Wouldn't it be easier to simply schedule this before adding it to sysfs
>> and sending the uevent?

Only if it's guaranteed that the timer will not expire before
add_device() succeeds. It's likely, but there is virt....

> Hm. I think that would solve this problem, but not all of the problems
> here ...
>
> Even with your change, I believe it's still racy wrt. disabled_store(),
> since that flushes the work but devcd_data_write() remains reachable
> (and might in fact be waiting for the mutex after your change), so I
> think we need an additional flag somewhere (in addition to the mutex) to
> serialize all of these things against each other.

Plus there is disabled_store() which iterates over the devices and
reschedules the work. How is that supposed to be protected against a
concurrent devcd_del()?

Why needs disabled_store() to do that at all?

Thanks,

        tglx
