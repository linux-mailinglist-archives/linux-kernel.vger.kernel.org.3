Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB846A063
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443910AbhLFQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:01:34 -0500
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1391626AbhLFPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:46:11 -0500
X-Greylist: delayed 2388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 10:43:49 EST
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 1B6F04nv024882
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:00:04 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1B6F03xs020369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:00:03 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Dec 2021 07:00:03 -0800
Received: from hackbox.wrs.com (128.224.56.205) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 6 Dec 2021 07:00:02 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH 0/2] sched/nohz: disallow non-existent cores from nohz-full
Date:   Mon, 6 Dec 2021 09:59:48 -0500
Message-ID: <20211206145950.10927-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple months back I sent a fix to reconcile rcu_nocbs= input
restrictions with nohz_full= input restrictions; with the latter being
more restrictive than the former.

However, in relaxing the nohz_full restrictions, I made it possible to
boot with a nohz_full= parameter that contains nothing but nonexistent
and not-possible cores - which will trigger a WARN.

This fixes the original reconcile commit by explicitly coding our
allowed values just like RCU does, and changes the WARN_ON to a
WARN_ON_ONCE, since it needlessly rendered the machine unusable.

---

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Paul Gortmaker (2):
  sched/isolation: really align nohz_full with rcu_nocbs
  tick/nohz: WARN_ON --> WARN_ON_ONCE to prevent console saturation

 kernel/sched/isolation.c | 12 ++++++++++++
 kernel/time/tick-sched.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.17.1

