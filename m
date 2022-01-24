Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A49497E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiAXLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiAXLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:49:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0FC06173B;
        Mon, 24 Jan 2022 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rhbjJTmqd5tZTkgA/KwMX4MpVPczaR//yrEabwmA5DE=; b=jGUh7/30gxNr5h81Wbj1YFZ1e+
        belLDbFGWSAcyrXV/ZURukvaBCKkQTNAeN3+gyXLX7KzG04EKyTJnsG5DMw8D7xPL7IK5pV02nwFu
        tU2wrFcRnYaAVMUOEEcWlqL+kEUDglVQwPk3O4cRtaLxSwdAjjM+G7oJ4M90RYKeuWZxy4jkkUaqf
        RQS3c4l0pvN2a3mraApvw812rWP691H1zbjbR7Ck1Ak8FscJx9YRKux1xLtfd0FHAFCCGwDhf3KVb
        Y7Ij1joSN/61zXMW3fETWKGzCcFUuUrVYYdCos63Sutx3xkNcWo/vNlLDW3uJCczsSW6RLe7E7I70
        +SkeBlSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBxqi-0039Ed-N9; Mon, 24 Jan 2022 11:49:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE95E3002C5;
        Mon, 24 Jan 2022 12:49:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91C81201A135B; Mon, 24 Jan 2022 12:49:27 +0100 (CET)
Date:   Mon, 24 Jan 2022 12:49:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com, Suzuki.Poulose@arm.com,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited
 event has no ring buffer
Message-ID: <Ye6SR0yxTrkNUQF6@hirez.programming.kicks-ass.net>
References: <20211206113840.130802-1-james.clark@arm.com>
 <20211206113840.130802-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206113840.130802-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:38:40AM +0000, James Clark wrote:
> When using per-process mode and event inheritance is set to true, forked
> processes will create a new perf events via inherit_event() ->
> perf_event_alloc(). But these events will not have ring buffers assigned
> to them. Any call to wakeup will be dropped if it's called on an event
> with no ring buffer assigned because that's the object that holds the
> wakeup list.
> 
> If the child event is disabled due to a call to perf_aux_output_begin()
> or perf_aux_output_end(), the wakeup is dropped leaving userspace
> hanging forever on the poll.
> 
> Normally the event is explicitly re-enabled by userspace after it wakes
> up to read the aux data, but in this case it does not get woken up so
> the event remains disabled.
> 
> This can be reproduced when using Arm SPE and 'stress' which forks once
> before running the workload. By looking at the list of aux buffers read,
> it's apparent that they stop after the fork:
> 
>   perf record -e arm_spe// -vvv -- stress -c 1
> 
> With this patch applied they continue to be printed. This behaviour
> doesn't happen when using systemwide or per-cpu mode.
> 
> Reported-by: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---

Would this be the better patch?


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 479c9e672ec4..b1c1928c0e7c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5985,6 +5985,8 @@ static void ring_buffer_attach(struct perf_event *event,
 	struct perf_buffer *old_rb = NULL;
 	unsigned long flags;
 
+	WARN_ON_ONCE(event->parent);
+
 	if (event->rb) {
 		/*
 		 * Should be impossible, we set this when removing
@@ -6042,6 +6044,9 @@ static void ring_buffer_wakeup(struct perf_event *event)
 {
 	struct perf_buffer *rb;
 
+	if (event->parent)
+		event = event->parent;
+
 	rcu_read_lock();
 	rb = rcu_dereference(event->rb);
 	if (rb) {
@@ -6055,6 +6060,9 @@ struct perf_buffer *ring_buffer_get(struct perf_event *event)
 {
 	struct perf_buffer *rb;
 
+	if (event->parent)
+		event = event->parent;
+
 	rcu_read_lock();
 	rb = rcu_dereference(event->rb);
 	if (rb) {
@@ -6763,7 +6771,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
 		goto out;
 
-	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
+	rb = ring_buffer_get(sampler);
 	if (!rb)
 		goto out;
 
@@ -6829,7 +6837,7 @@ static void perf_aux_sample_output(struct perf_event *event,
 	if (WARN_ON_ONCE(!sampler || !data->aux_size))
 		return;
 
-	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
+	rb = ring_buffer_get(sampler);
 	if (!rb)
 		return;
 
