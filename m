Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA10446E8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhLINND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhLINNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:13:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A2C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2V4V6NMGVwQrAIV0QOaBKk3FGwCdVOJFA9GJWNNgXw=; b=ZGmdIxZRdXmTz64EfjUbw8C435
        vP8R1Cu4t+LZ5p9X0XB5vz7rAidvCfcM5Ltb7kQQKSjoUcllsby9+5mkJVlo95JHJBvcmIdft4pud
        ncYwvprXerzrcFOPQMAE0MGrdRLDeJmc7gGsQESHDOZ/6xHEXZgjJ9+TaYwl5C9xqriE+ZVFVjDeC
        PX3p1hu2lowd5uHjZ8+EcM+UWlzFCVlFw9xSSVf/Trhw/+PLVeQZ41H6Qyu6Yl7/kdlTGEvwuQOM5
        U7yxG6B0gpMWakq1DAioc6IcwTAvRapVs5/kX9jLUsWqxKRoWlx2aHwt8tMuA6vWHmM7iRLdHdhke
        nPCH/VxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvJAP-009MkL-6G; Thu, 09 Dec 2021 13:08:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EF0B300079;
        Thu,  9 Dec 2021 14:08:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 496722BB99CC4; Thu,  9 Dec 2021 14:08:56 +0100 (CET)
Date:   Thu, 9 Dec 2021 14:08:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Honglei Wang <wanghonglei@didichuxing.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
Subject: Re: [PATCH v2 2/3] sched/fair: prevent cpu burst too many periods
Message-ID: <YbH/6H+QtjFlw+19@hirez.programming.kicks-ass.net>
References: <20211208145038.64738-1-wanghonglei@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208145038.64738-1-wanghonglei@didichuxing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:50:38PM +0800, Honglei Wang wrote:
> Tasks might get more cpu than quota in persistent periods due to the
> cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
> burstable CFS controller").

> For example, one task group whose quota is
> 100ms per period and can get 100ms burst, and its avg utilization is
> around 105ms per period.

That would be a mis-configuration, surely..

> Once this group gets a free period which
> leaves enough runtime, it has a chance to get computting power more
> than its quota for 10 periods or more in common bandwidth configuration
> (say, 100ms as period).

Sure, if it, for some miraculous reason, decides to sleep for a whole
period and then resume, it can indeed consume up to that 100ms extra,
which, if as per the above, done at 5ms per perios, would be 20 periods
until depleted.

> It means tasks can 'steal' the bursted power to
> do daily jobs because all tasks could be scheduled out or sleep to help
> the group get free periods.

That's the design,,

> I believe the purpose of cpu burst is to help handling bursty worklod.
> But if one task group can get computting power more than its quota for
> persistent periods even there is no bursty workload, it's kinda broke.

So if that was were bursty, it could consume that 100ms extra in a
single go and that would be fine, but spreading that same amount over 20
periods is somehow a problem? -- even though the interference is less.

> This patch limits the burst to 2 periods so that it won't break the
> quota limit for long. Permitting 2 periods can help on the scenario that
> periods refresh lands in the middle of a burst workload. With this, we
> can give task group more cpu burst power to handle the real burst
> workload and don't worry about the 'stealing'.

I've yet so see an actual reason for any of this...
