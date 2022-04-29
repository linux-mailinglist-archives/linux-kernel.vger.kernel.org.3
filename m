Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225FB515345
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379876AbiD2SHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358440AbiD2SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:07:52 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F78AD4C64
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:04:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8ACD522394;
        Fri, 29 Apr 2022 18:04:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BAB8521AD5;
        Fri, 29 Apr 2022 18:04:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651255471; a=rsa-sha256;
        cv=none;
        b=e2vW5LDOABtcDwMO9nrpDnKWl7foC30cIcJzw8vmDM3jy35sn7pIckXBsig6b5LWhktt3Y
        i0xsnsGmyiSIvt3U75CrVvRl8aCNl7bd90QYp0aS7LhfRb9m6qkFZg6wBG/4wIgRzcSdWi
        TvULqjK9FpOILn/tOLWRykfMTm0NnE/JjtY2/NgHea8cvt6P235b+Cf8si7mWP5M1PMV7h
        xSjyTiE2ljMU95OyLIkD1tE1csdIDF2iJRxBv01q9W7qIuzYRPTIKuOQYonNTdPAtu2SId
        MNlNZceQBUzqrRQqkLB7lKoJOxlw64LqtIl6EbuNjdsP+qOP3o+4me1hVHhjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651255471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=x7QY8w9HZbfutoKEmDXdfj5zyEYHVxBD/6XSq0S0Jz0=;
        b=hNCLU9ArDFxQFmeq0mKDn2x8F2ewqx7bxztaCeiQ/EkWUZXj3xLR4FrTXoGwbSxmX/N8wQ
        yS+DDypwjtODJM378KIfcfWLQ6nsJT+sojqR1b3oezvGDTELVoc61++c3ieCnrkGvZyqjg
        gWZ2qvUa1eAjL2K1pfC2e7slLOlG5y3CcR7rss5DuEa3RTwgP09jEh0WSBbvSbpNMLrJxK
        06QYEYGF36w+V+FGd9ceJ6ecDwQG+JbxpSChzqbX4BPK1K0gOwnFQvOeUA7Nv/26r6OMQm
        RxpT4ZdaimzDNBEDsXIQ/KeGg12sZ603GsNaeM+GQ17SCVZkSYQWmGoE8eA04A==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-wtlq9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.121 (trex/6.7.1);
        Fri, 29 Apr 2022 18:04:32 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Skirt: 2b4f6c645ed48411_1651255472207_305874068
X-MC-Loop-Signature: 1651255472207:3564681490
X-MC-Ingress-Time: 1651255472207
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4KqgNv0mBfz1N6;
        Fri, 29 Apr 2022 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651255471;
        bh=x7QY8w9HZbfutoKEmDXdfj5zyEYHVxBD/6XSq0S0Jz0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rFwoUTerPiXPjmqnj3cPqtG0Y8QZVrh6rZCTf65p6ANTDQfugW5e3Q2KfhH0VbVfG
         0PDo1AKMToBWhgGP/lSbP2bRKUdtpLoXOqAO4QvbMM1oeYh3Bclou/+64XUaqblyry
         XCfbO+Bg6tPBj+igNS0KjxyRzjQwUT/MXKLTmI+x2mD/Q2cmUYGxvvesJl28rZZAZQ
         TrSmTKBo3AhRiYydCbowexr6IDwjtT3sfO8JIm+QAFcKPXBgmJXqX6c0VJBwVm9rMV
         s82lrYYoIvA+gay72JPPCqaFygpu74n/dFpFDJwlglpPtuEyHW8LzF1VerjQrqIp0l
         vBP6I4K5JAhow==
Date:   Fri, 29 Apr 2022 10:53:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "manfred@colorfullife.com" <manfred@colorfullife.com>
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Message-ID: <20220429175304.kv3cfgrsea65afej@offworld>
References: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
 <20220428205001.hiuzwpn5emxtrh4s@offworld>
 <87zgk4ooi6.ffs@tglx>
 <5FEE7AB6-7560-4998-A7A3-B60A4B32E1DE@oracle.com>
 <87tuacomps.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87tuacomps.ffs@tglx>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022, Thomas Gleixner wrote:

>No. What I meant is a function which handles this internally, not an inline
>function which has to be invoked on various call sites.

Originally I was also thinking about it on a per-user basis, but
after more thought I agree it's better if it is done by the hrtimer.

Something like so?

Thanks,
Davidlohr

---------------8<-----------------------------------------------------
[PATCH] hrtimer: Ignore slack time for RT tasks

While in theory the timer can be triggered before expires+delta,
for the cases of RT tasks they really have no business giving
any lenience for extra slack time, so override any passed value
by the user and always use zero.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  kernel/time/hrtimer.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..5ef0f1651040 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2297,6 +2297,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
		return -EINTR;
	}

+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
	hrtimer_sleeper_start_expires(&t, mode);
@@ -2326,6 +2333,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
   * actual wakeup to a time that is both power and performance friendly.
   * The kernel give the normal best effort behavior for "@expires+@delta",
   * but may decide to fire the timer earlier, but no earlier than @expires.
+ * For scenarios under realtime constraints, @delta is always zero.
   *
   * You can set the task state as follows -
   *
--
2.36.0
