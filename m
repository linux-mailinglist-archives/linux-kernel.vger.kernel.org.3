Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62246951E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbhLFLmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:42:55 -0500
Received: from foss.arm.com ([217.140.110.172]:54906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241994AbhLFLmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:42:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1621576;
        Mon,  6 Dec 2021 03:39:22 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A97C3F73D;
        Mon,  6 Dec 2021 03:39:20 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, leo.yan@linaro.com,
        Suzuki.Poulose@arm.com, James Clark <james.clark@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited event has no ring buffer
Date:   Mon,  6 Dec 2021 11:38:40 +0000
Message-Id: <20211206113840.130802-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211206113840.130802-1-james.clark@arm.com>
References: <20211206113840.130802-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using per-process mode and event inheritance is set to true, forked
processes will create a new perf events via inherit_event() ->
perf_event_alloc(). But these events will not have ring buffers assigned
to them. Any call to wakeup will be dropped if it's called on an event
with no ring buffer assigned because that's the object that holds the
wakeup list.

If the child event is disabled due to a call to perf_aux_output_begin()
or perf_aux_output_end(), the wakeup is dropped leaving userspace
hanging forever on the poll.

Normally the event is explicitly re-enabled by userspace after it wakes
up to read the aux data, but in this case it does not get woken up so
the event remains disabled.

This can be reproduced when using Arm SPE and 'stress' which forks once
before running the workload. By looking at the list of aux buffers read,
it's apparent that they stop after the fork:

  perf record -e arm_spe// -vvv -- stress -c 1

With this patch applied they continue to be printed. This behaviour
doesn't happen when using systemwide or per-cpu mode.

Reported-by: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d94f68c5bd..76217a3f9cdd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5993,6 +5993,9 @@ static void ring_buffer_wakeup(struct perf_event *event)
 
 	rcu_read_lock();
 	rb = rcu_dereference(event->rb);
+	if (!rb && event->parent)
+		rb = rcu_dereference(event->parent->rb);
+
 	if (rb) {
 		list_for_each_entry_rcu(event, &rb->event_list, rb_entry)
 			wake_up_all(&event->waitq);
-- 
2.28.0

