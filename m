Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A134C4C60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiBYRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiBYRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:03 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAEE1BA90C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:35:30 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E3D3E2A0;
        Fri, 25 Feb 2022 17:35:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E3D3E2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645810530; bh=xVDx4/GSY2zJkyT/gM/R6AZuIZFKi2N/VNg2nDidNbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YpngwjhdB/ODio2/bgj3wh3cWagorZlvDWa3zRG/E9hD5L4S4afRgCTmOxpo3VIiK
         JOabr1BqSrAcu0mZSP942hBbpU+iJywDZByt9PN7ORkJPW2Inm/kJymcQd3mgwGZ8u
         Qtp+cxLsC5DjIVBLJPWIItPdJDkwFmDuNA3q3fk3cf56KftaaMgM9q/nIA0R39PWgZ
         Z1t57DOZ372qkYwh0+RqVnJZuU06khcA1XEZJdX2IWMai+yGhZN9iLcA5L9NohsiNC
         phOk6QuxjvauwlapB+kfqbLRkq3+YprCGSsmzmtko97nRLZWIoMOxhx48fyB7yobor
         94o/rDUN7yM3Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v2 09/11] sched: Introduce per memory space current
 virtual cpu id
In-Reply-To: <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
 <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
Date:   Fri, 25 Feb 2022 10:35:29 -0700
Message-ID: <87k0dikfxa.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> This feature allows the scheduler to expose a current virtual cpu id
> to user-space. This virtual cpu id is within the possible cpus range,
> and is temporarily (and uniquely) assigned while threads are actively
> running within a memory space. If a memory space has fewer threads than
> cores, or is limited to run on few cores concurrently through sched
> affinity or cgroup cpusets, the virtual cpu ids will be values close
> to 0, thus allowing efficient use of user-space memory for per-cpu
> data structures.

So I have one possibly (probably) dumb question: if I'm writing a
program to make use of virtual CPU IDs, how do I know what the maximum
ID will be?  It seems like one of the advantages of this mechanism would
be not having to be prepared for anything in the physical ID space, but
is there any guarantee that the virtual-ID space will be smaller?
Something like "no larger than the number of threads", say?

Thanks,

jon
