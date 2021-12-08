Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE746D617
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhLHOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:53:49 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:2515 "HELO
        mailgate02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231620AbhLHOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:53:49 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.44])
        by mailgate02.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 265386006D20D;
        Wed,  8 Dec 2021 22:50:13 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX11.didichuxing.com (172.20.15.141) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:12 +0800
Received: from localhost.localdomain (172.20.16.101) by
 BJSGEXMBX12.didichuxing.com (172.20.15.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:12 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.44
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
        <linux-kernel@vger.kernel.org>
CC:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
Subject: [PATCH v2 0/3] improvement of cpu burst
Date:   Wed, 8 Dec 2021 22:50:01 +0800
Message-ID: <20211208145001.64580-1-wanghonglei@didichuxing.com>
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

This patch set does a bit improvement for cpu burst feature including
1. Avoid burst associated statistic and calculation if the cpu.max.burst is
not set in the cgroup.
2. Limit the burst periods to 2 to avoid the quota 'stealing'

Changes in v2:
- Permitting 2 periods for burst.
- Add a separate patch to avoid burst stuff if the burst is not set at all.

Honglei Wang (3):
  sched/fair: avoid burst statistic if it's not set
  sched/fair: prevent cpu burst too many periods
  sched/fair: update burst feature description

 Documentation/scheduler/sched-bwc.rst | 12 ++++++++++++
 kernel/sched/fair.c                   | 18 +++++++++++++++---
 kernel/sched/sched.h                  |  1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.14.1

