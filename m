Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1246D630
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhLHO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:58:14 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:3723 "HELO
        mailgate02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229478AbhLHO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:58:13 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.33])
        by mailgate02.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 3D95E6006D217;
        Wed,  8 Dec 2021 22:52:36 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX08.didichuxing.com (172.20.15.138) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:52:35 +0800
Received: from localhost.localdomain (172.20.16.101) by
 BJSGEXMBX12.didichuxing.com (172.20.15.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:52:35 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.33
From:   Honglei Wang <wanghonglei@didichuxing.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
Subject: [PATCH v2 3/3] sched/fair: update burst feature description
Date:   Wed, 8 Dec 2021 22:52:23 +0800
Message-ID: <20211208145223.64958-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.20.16.101]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX12.didichuxing.com (172.20.15.142)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the burst feature description due to the burst periods
limit.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 Documentation/scheduler/sched-bwc.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 173c14110c85..eac39d42ebf9 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -65,6 +65,18 @@ there many cgroups or CPU is under utilized, the interference is
 limited. More details are shown in:
 https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
 
+We need to limit the burst periods to 2, because we found something interesting
+that with the feature, tasks have chance to get more cpu than quota in working
+periods. As every task could be scheduled out or sleep, the task group can get
+some more cpu for its burst workload in this way. But even if there's no burst
+workload, it can use those power to do daily jobs. If the average workload of a
+taskgroup is just a little bit higher than its quota, it can escape from the
+throttle and using the burst power for lots of periods.
+
+Permitting 2 periods for the burst cpu can help aovid such kind of 'stealing'
+and the task group won't lose its burst power if the periods refresh lands in
+the middle of a burst workloads.
+
 Management
 ----------
 Quota, period and burst are managed within the cpu subsystem via cgroupfs.
-- 
2.14.1

