Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3244DE20D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiCRUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbiCRUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:00:49 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2018BCF9;
        Fri, 18 Mar 2022 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647633570; x=1679169570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U+moaLi59+BQm7Q4OgIusu1BC18OCx6kr1I58AQfNVM=;
  b=KNm+95+i1jmmf0rgkABklSRSfHjhi3XJMMaswYkA62/KtcUIecoWaNv+
   ky91qf5ZkLFvEPBmT/72FxQgP8HnO64IFA9YfhlnlbTH6mIIAoRaUmz2R
   npedEFo1zb6sDqi+KwNeKk++opPVpySco7sJ2hWgzO8W056DhiehWzIp5
   k=;
X-IronPort-AV: E=Sophos;i="5.90,192,1643673600"; 
   d="scan'208";a="72160465"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 18 Mar 2022 19:59:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id 66E594200E;
        Fri, 18 Mar 2022 19:59:28 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:27 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 18 Mar 2022 19:59:27 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 18 Mar 2022 19:59:26
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 8507317C1; Fri, 18 Mar 2022 19:59:25 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <andrew.kilroy@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <lihuafei1@huawei.com>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: [PATCH v3 0/2] perf: arm-spe: Decode SPE source and use for perf c2c
Date:   Fri, 18 Mar 2022 19:59:10 +0000
Message-ID: <20220318195913.17459-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores so we can detect situtions like cache line contention
and transfers on Arm platforms. 

This changes enables the expected behavior of perf c2c on a system with SPE where
lines that are shared among multiple cores show up in perf c2c output. 

These changes switch to use mem_lvl_num to encode the level information instead
of mem_lvl which is being deprecated, but I haven't found other users of
mem_lvl_num. 

Changes in v3:
  * Assume ther are only three levels of cache hierarchy
  * Split the mem_lvl_num and HITM changes in c2c into two seperate patches

Ali Saidi (3):
  perf arm-spe: Use SPE data source for neoverse cores
  perf mem: Support mem_lvl_num in c2c command
  perf mem: Support HITM for when mem_lvl_num is any

 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
 tools/perf/util/arm-spe.c                     | 109 +++++++++++++++---
 tools/perf/util/mem-events.c                  |  20 +++-
 4 files changed, 124 insertions(+), 18 deletions(-)

-- 
2.32.0

