Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301B74E68BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbiCXSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352687AbiCXSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:35:30 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D233467B;
        Thu, 24 Mar 2022 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648146838; x=1679682838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8YIluzwYSUomOcH0PCqAsR3TehTTHIumqCtmL6dHCMg=;
  b=Go45o7bK/Ni3uVoSgPG2t0Ctej1eCTYEk4Q8gSm6Tc9B64XMJclsdn6z
   iVEh1DHOZ263RD35RnzSi7iHEqJv2KgEJe77Qc9sd7WMIGTNR3eztL+Ci
   KcGZE+tA/x6lagfznJzw0oa6qWACT0XH/zQge1+Wwk6Ixr2Men8q29OBg
   0=;
X-IronPort-AV: E=Sophos;i="5.90,208,1643673600"; 
   d="scan'208";a="187546947"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 24 Mar 2022 18:33:56 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com (Postfix) with ESMTPS id C839EC091C;
        Thu, 24 Mar 2022 18:33:50 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 24 Mar 2022 18:33:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 24 Mar 2022 18:33:39 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Thu, 24 Mar 2022 18:33:38
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 15E9C2573; Thu, 24 Mar 2022 18:33:39 +0000 (UTC)
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
Subject: [PATCH v4 4/4] perf mem: Support HITM for when mem_lvl_num is any
Date:   Thu, 24 Mar 2022 18:33:23 +0000
Message-ID: <20220324183323.31414-5-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324183323.31414-1-alisaidi@amazon.com>
References: <20220324183323.31414-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For loads that hit in a the LLC snoop filter and are fulfilled from a
higher level cache on arm64 Neoverse cores, it's not usually clear what
the true level of the cache the data came from (i.e. a transfer from a
core could come from it's L1 or L2). Instead of making an assumption of
where the line came from, add support for incrementing HITM if the
source is CACHE_ANY.

Since other architectures don't seem to populate the mem_lvl_num field
here there shouldn't be a change in functionality.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Tested-by: German Gomez <german.gomez@arm.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/mem-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index e5e405185498..084977cfebef 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -539,6 +539,15 @@ do {				\
 					stats->ld_llchit++;
 			}
 
+			/*
+			 * A hit in another cores cache must mean a llc snoop
+			 * filter hit
+			 */
+			if (lnum == P(LVLNUM, ANY_CACHE)) {
+				if (snoop & P(SNOOP, HITM))
+					HITM_INC(lcl_hitm);
+			}
+
 			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
 				stats->lcl_dram++;
 				if (snoop & P(SNOOP, HIT))
-- 
2.32.0

