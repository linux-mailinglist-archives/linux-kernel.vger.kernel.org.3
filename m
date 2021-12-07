Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932E446B5C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhLGI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:49 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:49808 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232542AbhLGI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:43 -0500
IronPort-SDR: MfCdl5eTMxYMJqvel8MjlevT8qjdhHT+JwPVBNgX+5KOwgALYea7Rm6yNu9itmaUkzSNBGN1JU
 r6nJjIo0i8sKIiFnxFpweQd8IyzRgZUTzIEZMmxM0j4ZVCYY5Vitdl14geMsay3bCl+rFND/1y
 LIInuqiPNuN5VhaecO8KKRzm0B2vbO7dnY/IhzvjOcYAxf8+XMNoxM2DA9762SHvhz6Wa0mn5b
 q78wtJmS+ZaTQzjUst+O4Ttz9zun2NHo1R4VoOflH3yPeSyRAhAgASSnAGxlLU0/zT99Mwd3z8
 9uqrlRs9JdXhVBIZLB38B5HN
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="34260854"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="34260854"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Dec 2021 17:25:11 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3809DEDC74;
        Tue,  7 Dec 2021 17:25:09 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1F477C9271;
        Tue,  7 Dec 2021 17:25:09 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id F3CE340061D47;
        Tue,  7 Dec 2021 17:25:08 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v5 2/3] libperf: Remove scaling process from perf_mmap__read_self()
Date:   Tue,  7 Dec 2021 17:22:44 +0900
Message-Id: <20211207082245.604654-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
References: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
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

