Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC4857FBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiGYI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiGYI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:56:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B4FDB;
        Mon, 25 Jul 2022 01:56:33 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658739391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYo6KQq36FrGZdwkWqrhspBPqngXkT1wqCgCUDDtpPo=;
        b=N22faoZcSr7Bf3uxmEZt5Wx6ZGXSpkTzThaQAVBBO47KhyYH56bPq0VVIgWgYd0zVW7yDT
        bOPPhBhM6PH3aqHtorU8v6E0jhfOCicSoXNttBiWJRI+TMDoq/s1uE2Kmx+u3ZrvJ03E9x
        QQl0uyBVIbRD8Rlbe9qHZFXvMsrmLr/ebd9sUDBmCtYJhrgYq0YWVm60g4asWLM3ecn9eS
        X9DFDJ/J6kG2un7J7hKoS6pJIxhzSCtsMbTh4cbAMhsEvy5Z1fAA9TyDH8taC3jyai6pIe
        ROzYMvaTzy24EOEazDSQAAAngfFNq8JSPakGWVd+nALfounTA9U2uF9reX7R5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658739391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYo6KQq36FrGZdwkWqrhspBPqngXkT1wqCgCUDDtpPo=;
        b=g3YlO+AjCf+WhxcLnAVBL9RJ9ef07sdsZaXvNdzUnWbIkOJNMu25NI0f6Ys0jzPjUetaJL
        GGvZ/LWYzQU1ufCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Keeping <john@metanate.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] sched/core: Always flush pending blk_plug
Message-ID: <Yt5avpfSnen+NWUb@linutronix.de>
References: <20220708162702.1758865-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708162702.1758865-1-john@metanate.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 17:27:02 [+0100], John Keeping wrote:
> Looking at the history of the -rt patchset, in fact this change was
> present from v5.9.1-rt20 until being dropped in v5.13-rt1 as it was part
> of a larger patch [1] most of which was replaced by commit b4bfa3fcfe3b
> ("sched/core: Rework the __schedule() preempt argument").

Thanks for spotting that. The plan was to get rid of this with the
introduction of schedule_rtlock() but it somehow remained resilient.

Sebastian
