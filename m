Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD24F9DD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiDHT4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiDHT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:56:09 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092ED1A5D4E;
        Fri,  8 Apr 2022 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649447646; x=1680983646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQvZbOGfRySa1kgB4u+TLmXxiPqef8NnczamZP/eew8=;
  b=Vxbpbf35ZZx9hgdkkXc7OQVsQr1dUH4zIsgi8gxvK/ptpQFRtPFSmoab
   SwZYOwrwONivtbFF1uGDsmotA8kA6t6X/kePmFEpwT4GcBIHamlyskPav
   8603jvo07B3Mr2vwGY4UG6UzlxhLUpZX4sTKxRTk2DsMnNqMOEsLSVHcM
   g=;
X-IronPort-AV: E=Sophos;i="5.90,245,1643673600"; 
   d="scan'208";a="209212596"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-6435a935.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 08 Apr 2022 19:54:04 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-6435a935.us-west-2.amazon.com (Postfix) with ESMTPS id 6C47A417C3;
        Fri,  8 Apr 2022 19:53:58 +0000 (UTC)
Received: from EX13D02UWC003.ant.amazon.com (10.43.162.199) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:56 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC003.ant.amazon.com (10.43.162.199) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:56 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 8 Apr 2022 19:53:56 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 750242577; Fri,  8 Apr 2022 19:53:55 +0000 (UTC)
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
Subject: [PATCH v5 3/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Date:   Fri, 8 Apr 2022 19:53:42 +0000
Message-ID: <20220408195344.32764-4-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408195344.32764-1-alisaidi@amazon.com>
References: <20220408195344.32764-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
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
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 82858b697c05..c9e58c79f3e5 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1308,7 +1308,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.32.0

