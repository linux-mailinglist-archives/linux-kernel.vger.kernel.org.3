Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA859F593
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiHXIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHXIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:46:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73713760C0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:46:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25AA133E2C;
        Wed, 24 Aug 2022 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661330780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1R7cZUsc2fn/t37c3fEsagGYCq4jTZL5Wsi9k90xnQ=;
        b=gxSeHo2v24f+QMBW28R3LpHR2fWzLEnk/mZuTjiBKjHcdwpVCRoLy99YGOISEPdZZfpgRc
        usPGkDO3G1J+f8jVwXrH/nna7soyzdiusnrvyUwQT4s3II+YMmEHIXz5CZjdexE3FItnfY
        iUYDWuD8SkWf3zABIkvKf73YSG+vAf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661330780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1R7cZUsc2fn/t37c3fEsagGYCq4jTZL5Wsi9k90xnQ=;
        b=xcSrk6KPbZpuO2WzW41OGBitBZ0DUN/nwRrld99UZaP1V5IrppOzjCFu8npjE4uDa+huNx
        Dc9DFK9sSiNKoSDw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0FC862C141;
        Wed, 24 Aug 2022 08:46:18 +0000 (UTC)
Date:   Wed, 24 Aug 2022 09:46:14 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: select waker's cpu for wakee on sync wakeup
Message-ID: <20220824084614.kykmtbhyawcei67z@suse.de>
References: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:37:50PM +0800, Peng Wang wrote:
> On sync wakeup, waker is about to sleep, and if it is the only
> running task, wakee can get warm data on waker's cpu.
> 
> Unixbench, schbench, and hackbench are tested on
> Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (192 logic CPUs)
> 
> Unixbench get +20.7% improvement with full threads mainly
> because of the pipe-based context switch and fork test.
> 
> No obvious impact on schbench.
> 
> This change harms hackbench with lower concurrency, while gets improvement
> when concurrency increases.
> 

Note that historically patches in this direction have been hazardous because
it makes a key assumption "sync wakers always go to sleep in the near future"
when the sync hint is not that reliable. Networking from a brief glance
still uses sync wakeups where wakers could have a 1:N relationship between
work producers and work consumers that would then stack multiple tasks on
one CPU for multiple consumers. The workloads mentioned in the changelog
are mostly strictly-synchronous wakeups (i.e. the waker definitely goes
to sleep almost immediately) and benefit from this sort of patch but it's
not necessarily a universal benefit.

Note that most of these hazards occurred *LONG* before I was paying much
attention to how the scheduler behaved so I cannot state "sync is still
unreliable" with absolute certainty. However, long ago there was logic
that tried to track the accuracy of the sync hint that was ultimately
abandoned by commit e12f31d3e5d3 ("sched: Remove avg_overlap"). AFAIK,
the sync hint is still not 100% reliable and while stacking sync works
for some workloads, it's likely to be a regression magnet for network
intensive workloads or client/server workloads like databases where
"synchronous wakeups are not always synchronous".

-- 
Mel Gorman
SUSE Labs
