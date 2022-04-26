Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A850FFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351318AbiDZODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351308AbiDZOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:02:59 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D8191443;
        Tue, 26 Apr 2022 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1650981591; x=1682517591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guELJia/o02QnxPE6K799UgBtdQM7PcWJOCYwYeJGP4=;
  b=OVKGU65jsIEpyeVnYwDDxpkqEgDy3yy+JEjIWlm3vfTPilM4F4U5JKof
   mdwlQg55R+t9mvLfhWOvJEiUZHL7uclFE+OOc9Q4msr1M6325jWwEPowV
   VmGFMBJug+lTNIQtThNAueC30MXiwAQ+kLiK54iB69g2K+0ChVa7uCRPm
   w=;
X-IronPort-AV: E=Sophos;i="5.90,291,1643673600"; 
   d="scan'208";a="197784636"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 26 Apr 2022 13:59:48 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com (Postfix) with ESMTPS id 92A9285379;
        Tue, 26 Apr 2022 13:59:47 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 26 Apr 2022 13:59:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 26 Apr 2022 13:59:46 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Tue, 26 Apr 2022 13:59:46
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 4B3A420EE; Tue, 26 Apr 2022 13:59:45 +0000 (UTC)
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
Subject: [PATCH v4 0/4] perf: arm-spe: Decode SPE source and use for perf c2c
Date:   Tue, 26 Apr 2022 13:59:32 +0000
Message-ID: <20220426135937.18497-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
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

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores so we can detect situtions like cache line
contention and transfers on Arm platforms. 

This changes enables future changes to c2c on a system with SPE where lines that
are shared among multiple cores show up in perf c2c output. 

Changes in v7:
 * Minor change requested by Leo Yan

Changes in v6:
  * Drop changes to c2c command which will come from Leo Yan

Changes in v5:
  * Add a new snooping type to disambiguate cache-to-cache transfers where
    we don't know if the data is clean or dirty.
  * Set snoop flags on all the data-source cases
  * Special case stores as we have no information on them

Changes in v4:
  * Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/ 
  * Add neoverse-v1 to the neoverse cores list

Ali Saidi (4):
  tools: arm64: Import cputype.h
  perf arm-spe: Use SPE data source for neoverse cores
  perf mem: Support mem_lvl_num in c2c command
  perf mem: Support HITM for when mem_lvl_num is any

 tools/arch/arm64/include/asm/cputype.h        | 258 ++++++++++++++++++
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
 tools/perf/util/arm-spe.c                     | 110 +++++++-
 tools/perf/util/mem-events.c                  |  20 +-
 5 files changed, 383 insertions(+), 18 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/cputype.h

-- 
2.32.0

