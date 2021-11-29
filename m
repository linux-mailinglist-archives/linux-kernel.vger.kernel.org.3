Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9844610D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbhK2JNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:13:22 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:2964 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242457AbhK2JLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:11:19 -0500
IronPort-SDR: Wny3Lx4GJzud1zi6ZQmG4zyraGjwtCoX2a5BvuI8qHvBMsBj1fCcZa/ewmmDVX1G4yL32uEfVg
 hYfVlOGHo9olGjLscwMXto90k1NYCFW7gFZHAg5bMSGx3w7FpvhAzKCr21BdapXP0z6NsUcLqC
 WFg4huF9ZSWpzXsVYjKpfzRY9S2QXOiguxqzAYwx/1C5fhw194YMHYlW2SwCymHjE7o97IcJMQ
 4IJcnkLG6/why/hgpdLBsiSNPBAN+g7A+yJibVUOV2MXIXNuOtXhmujolFdX+uznee6FCmzpwu
 LPfAZTwCmNjMhypYNtqIenPh
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="54329384"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="54329384"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Nov 2021 18:08:00 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 68A82E07FF;
        Mon, 29 Nov 2021 18:07:59 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9938FD995B;
        Mon, 29 Nov 2021 18:07:58 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 794D94004C629;
        Mon, 29 Nov 2021 18:07:58 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v4 2/3] libperf: Remove scaling process from perf_mmap__read_self()
Date:   Mon, 29 Nov 2021 18:06:26 +0900
Message-Id: <20211129090627.592149-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
References: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Remove the scaling process from perf_mmap__read_self(), and unify the
counters that can be obtained from perf_evsel__read() to "no scaling".

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c89dfa5f67b3..aaa457904008 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
 		count->ena += delta;
 		if (idx)
 			count->run += delta;
-
-		cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
 	}
 
 	count->val = cnt;
-- 
2.25.1

