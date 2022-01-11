Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665148D05E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiAMCPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:15:49 -0500
Received: from ec2-13-52-33-57.us-west-1.compute.amazonaws.com ([13.52.33.57]:15055
        "EHLO aurora.tech" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231594AbiAMCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:15:42 -0500
Received: by aurora.tech (Postfix, from userid 1001)
        id E6C3E16402F3; Tue, 11 Jan 2022 15:33:15 -0800 (PST)
From:   Alison Chaiken <achaiken@aurora.tech>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, paulmck@kernel.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com, Alison Chaiken <achaiken@aurora.tech>
Subject: [PATCH 0/5] handle kthread_prio kernel cmdline parameter consistently
Date:   Tue, 11 Jan 2022 15:32:49 -0800
Message-Id: <20220111233253.21692-1-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PREEMPT_RT=y, RCU_SOFTIRQ work is moved to dedicated rcuc
per-core threads.  The rcutree.kthread_prio kernel cmdline parameter
controls the priority of those threads.

A provided kthread_prio kernel cmdline parameter also elevates the
priority of rcuog threads, but only if they are launched from
rcu_spawn_gp_kthread(), not if they are launched from
rcu_spawn_one_nocb_kthread().  Fix this inconsistency.

When CONFIG_RCU_NOCB_CPU=y, an rcu_nocbs command-line parameter
offloads the work of rcuc on designated cores to new rcuop threads
that are not pinned to the cores whose expired grace-period timer
callbacks they run.  While rcuop threads have the same function as
rcuc threads, their priority is not controlled by the kthread_prio
parameter.  Add this feature and update the documentation accordingly.

Alison Chaiken (4):
  RCU: move kthread_prio bounds-check to a separate function
  RCU: make priority of grace-period thread consistent
  RCU: elevate priority of offloaded callback threads
  RCU: update documentation regarding kthread_prio cmdline parameter

 .../admin-guide/kernel-parameters.txt         |  2 +
 kernel/rcu/tree.c                             | 42 +++++++++++--------
 kernel/rcu/tree_nocb.h                        |  7 ++++
 3 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.32.0

