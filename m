Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8DD529716
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiEQCD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiEQCDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:03:41 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC03E0DC;
        Mon, 16 May 2022 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1652753021; x=1684289021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Co6ZCtQl7dAoI2uebo1D1QUugEUgi2UYTVOs/yZ+Jsw=;
  b=Kv3UUAEAJ38QwM4Fet3VGIXGzVJ/mWxQFSCUR6AKB9kHx0FmqRIoFIJq
   rt0dIRsDB8aX6BfPrOLUbGY52S2IziTfwhKuMZR55c21qzR8kK6UBK2bB
   6Bnzq5l7CtkD8kd2415M43cel09ahk6ikAljah1ti2SsDuXJmzrgaI0Cv
   A=;
X-IronPort-AV: E=Sophos;i="5.91,231,1647302400"; 
   d="scan'208";a="203649419"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-0168675e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 17 May 2022 02:03:39 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-0168675e.us-east-1.amazon.com (Postfix) with ESMTPS id 575E4A2762;
        Tue, 17 May 2022 02:03:33 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 17 May 2022 02:03:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 17 May 2022 02:03:32 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Tue, 17 May 2022 02:03:32
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 561AB2128; Tue, 17 May 2022 02:03:31 +0000 (UTC)
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
Subject: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf c2c
Date:   Tue, 17 May 2022 02:03:21 +0000
Message-ID: <20220517020326.18580-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
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

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores so we can detect situtions like cache line
contention and transfers on Arm platforms. 

This changes enables future changes to c2c on a system with SPE where lines that
are shared among multiple cores show up in perf c2c output. 

Changes is v9:
 * Change reporting of remote socket data which should make Leo's upcomping
   patch set for c2c make sense on multi-socket platforms  

Changes in v8:
 * Report NA for both mem_lvl and mem_lvl_num for stores where we have no
   information

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

