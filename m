Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BA50EE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiDZCCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbiDZCCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:02:49 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CE12197D;
        Mon, 25 Apr 2022 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1650938384; x=1682474384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7YWa84Ggc9PbBc2yEEwZ6f7hUrSoU1ylmKnDzAKmLc=;
  b=RZyhxnA03enLNgj4Mu6mF9sn4hIt+Xtlm2JYgxD0vQVmw6VPiiK8h+iU
   4ePh0ckETpD1H4LZ5k3eGr5xMyRi50bdMMHfCMGyfzkiudc8KB6oel/gd
   qXWMy3BOaYtnLjH3A1rHsN3eEF3y3XxHz7dJkQFTUteoFml/ghzaexdQn
   w=;
X-IronPort-AV: E=Sophos;i="5.90,289,1643673600"; 
   d="scan'208";a="196211016"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-9ec26c6c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 26 Apr 2022 01:59:41 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-9ec26c6c.us-west-2.amazon.com (Postfix) with ESMTPS id DCEFA414D1;
        Tue, 26 Apr 2022 01:59:34 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 26 Apr 2022 01:59:34 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 26 Apr 2022 01:59:34 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Tue, 26 Apr 2022 01:59:34
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id C263620CB; Tue, 26 Apr 2022 01:59:33 +0000 (UTC)
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
Subject: [PATCH v6 2/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Date:   Tue, 26 Apr 2022 01:59:23 +0000
Message-ID: <20220426015926.22011-3-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426015926.22011-1-alisaidi@amazon.com>
References: <20220426015926.22011-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to the perf mem data struct to signal that a request caused a
cache-to-cache transfer of a line from a peer of the requestor and
wasn't sourced from a lower cache level.  The line being moved from one
peer cache to another has latency and performance implications. On Arm64
Neoverse systems the data source can indicate a cache-to-cache transfer
but not if the line is dirty or clean, so instead of overloading HITM
define a new flag that indicates this type of transfer.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d37629dbad72..7b88bfd097dc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1310,7 +1310,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.32.0

