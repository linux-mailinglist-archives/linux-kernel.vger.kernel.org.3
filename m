Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32FB49E196
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiA0LuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:50:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiA0LuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:50:15 -0500
Date:   Thu, 27 Jan 2022 11:50:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643284214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxoBIIi2THpBDEX4AWHF0UKBEf7SvP/svreQCeoRNHo=;
        b=pi6jf8nBA+/a8TY8KzXh5oYD+VNscMzihrZHEfJGYT0X1itYicpVkNzUaVxJVeOyjr9TEP
        vVDQ9Fgk2W9ehlijMst4lQkYcx07Fh+JRhmqLj+D4KH6BOINC6zRm1u01NGtCkf3EKne/e
        DZSqLg+4/ikIhL34E5giVSFyCeLzWc6mbXtFdCk7AG41lG9R8S/AjY8UOPH9N6CQJM1u5v
        ln/XNZUUGEqODfhS37+FGgk/h2T+w2nJP68CXbml5VauBJp1N0mI6B7JfwP5ApNs4Qg3xT
        5Q2quXaikU+g0e+gB8Nwd1jDUHE6dfquB2FXTf6NCYJdHm4Y9aR/6Pg+Vz+AAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643284214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxoBIIi2THpBDEX4AWHF0UKBEf7SvP/svreQCeoRNHo=;
        b=9V/yQikwBCuUPPaPXo63xA3SiEY/+IPe+C1n89+oR03W1xYSdkzqtKBAyg1C9gnOsMjKqf
        VuBx8CN7nYkC7QAQ==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Always wake the parent event
Cc:     Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206113840.130802-2-james.clark@arm.com>
References: <20211206113840.130802-2-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <164328421307.16921.440649491005973301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     961c39121759ad09a89598ec4ccdd34ae0468a19
Gitweb:        https://git.kernel.org/tip/961c39121759ad09a89598ec4ccdd34ae0468a19
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Mon, 06 Dec 2021 11:38:40 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jan 2022 15:06:06 +01:00

perf: Always wake the parent event

When using per-process mode and event inheritance is set to true,
forked processes will create a new perf events via inherit_event() ->
perf_event_alloc(). But these events will not have ring buffers
assigned to them. Any call to wakeup will be dropped if it's called on
an event with no ring buffer assigned because that's the object that
holds the wakeup list.

If the child event is disabled due to a call to
perf_aux_output_begin() or perf_aux_output_end(), the wakeup is
dropped leaving userspace hanging forever on the poll.

Normally the event is explicitly re-enabled by userspace after it
wakes up to read the aux data, but in this case it does not get woken
up so the event remains disabled.

This can be reproduced when using Arm SPE and 'stress' which forks once
before running the workload. By looking at the list of aux buffers read,
it's apparent that they stop after the fork:

  perf record -e arm_spe// -vvv -- stress -c 1

With this patch applied they continue to be printed. This behaviour
doesn't happen when using systemwide or per-cpu mode.

Reported-by: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211206113840.130802-2-james.clark@arm.com
---
 kernel/events/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 479c9e6..b1c1928 100644
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
 
