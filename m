Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBD529713
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiEQCDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiEQCDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:03:38 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33AE3D4B4;
        Mon, 16 May 2022 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1652753018; x=1684289018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RH4NY3LgKyIMfFCFEPfnvpR+HU0x+4DijSbdTYrrpUE=;
  b=k4qttR4kl/oHHSaSUnsCfiEw+s2e2ppT5jy7cuc0HuTsOvgKHJg/M712
   bY0cH3qZ90cbbQ532fqg2oz8OQ8saJNMRfLSLLl+/eYvGc0MH6HB+jMKX
   4c1mwczlf1dlfD61kiYq3lT7PS2x8BDS0YIp67zGANAM/0JSJ/n7aVJ1V
   g=;
X-IronPort-AV: E=Sophos;i="5.91,231,1647302400"; 
   d="scan'208";a="203649408"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 17 May 2022 02:03:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com (Postfix) with ESMTPS id 6334B422CF;
        Tue, 17 May 2022 02:03:34 +0000 (UTC)
Received: from EX13D02UWC003.ant.amazon.com (10.43.162.199) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 17 May 2022 02:03:34 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC003.ant.amazon.com (10.43.162.199) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 17 May 2022 02:03:33 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Tue, 17 May 2022 02:03:33
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 9501C215F; Tue, 17 May 2022 02:03:33 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>, <acme@kernel.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <alexander.shishkin@linux.intel.com>,
        <andrew.kilroy@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>, <will@kernel.org>
Subject: [PATCH v9 3/5] perf mem: Print snoop peer flag
Date:   Tue, 17 May 2022 02:03:24 +0000
Message-ID: <20220517020326.18580-4-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517020326.18580-1-alisaidi@amazon.com>
References: <20220517020326.18580-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Since PERF_MEM_SNOOPX_PEER flag is a new snoop type, print this flag if
it is set.

Before:
       memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)

After:

       memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
---
 tools/perf/util/mem-events.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index efaf263464b9..db5225caaabe 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -410,6 +410,11 @@ static const char * const snoop_access[] = {
 	"HitM",
 };
 
+static const char * const snoopx_access[] = {
+	"Fwd",
+	"Peer",
+};
+
 int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -430,13 +435,20 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		}
 		l += scnprintf(out + l, sz - l, snoop_access[i]);
 	}
-	if (mem_info &&
-	     (mem_info->data_src.mem_snoopx & PERF_MEM_SNOOPX_FWD)) {
+
+	m = 0;
+	if (mem_info)
+		m = mem_info->data_src.mem_snoopx;
+
+	for (i = 0; m && i < ARRAY_SIZE(snoopx_access); i++, m >>= 1) {
+		if (!(m & 0x1))
+			continue;
+
 		if (l) {
 			strcat(out, " or ");
 			l += 4;
 		}
-		l += scnprintf(out + l, sz - l, "Fwd");
+		l += scnprintf(out + l, sz - l, snoopx_access[i]);
 	}
 
 	if (*out == '\0')
-- 
2.32.0

