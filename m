Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EA5911BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiHLNwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiHLNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:52:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ABFA8CC7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660312338; x=1691848338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDcTxaIToZQYcdvOhNn0jX4NVqCzNEAbPACHR8cmaC4=;
  b=yd4qGOY4BcLwV1FIMNPdC3dt2SUazuQy3VqVGBcURYXm2ljSCdfAgd79
   MfzRtnlKIxRfPR0jAeYms/mVVnAOlqFCmogD0yfMhoEFhY8TKCzqEN3lM
   Se0GE21S0MIKGhAQrRKQ0y3kmzkikY1EDwgRjTm2P4Npuw+RyGuVa5GK/
   3xTwIRghh3ZylJUY6DZGnFsTVPpI9RtQBD1p+PczhUIx8VBIyIIZuWi5E
   v/yc4TYJeORQPkQgI36ji/DsAIS+bVd481KIzWY9culrChwpTrtMvNLlz
   3/c8pHcttHoACQ7TiWi9Gggj5cFyqYgVcca8I25ahjvxV2pO6Mjd8nr+3
   g==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="176000719"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 06:52:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 12 Aug 2022 06:52:16 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 06:52:14 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
CC:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] perf: riscv: fix broken build due to struct redefinition
Date:   Fri, 12 Aug 2022 14:51:20 +0100
Message-ID: <20220812135119.1648940-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building riscv/for-next produces following error:
drivers/perf/riscv_pmu_sbi.c:44:7: error: redefinition of 'sbi_pmu_ctr_info'
union sbi_pmu_ctr_info {
      ^
arch/riscv/include/asm/sbi.h:125:7: note: previous definition is here
union sbi_pmu_ctr_info {

This appears to have been caused by a merge conflict resolution between
riscv/for-next & riscv/fixes, causing the struct define not being
properly moved to its header.

Fixes: 9a7ccac63f9c ("perf: riscv_pmu{,_sbi}: Miscallenous improvement & fixes")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/perf/riscv_pmu_sbi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index e7c6fecbf061..6f6681bbfd36 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -41,20 +41,6 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
 	NULL,
 };
 
-union sbi_pmu_ctr_info {
-	unsigned long value;
-	struct {
-		unsigned long csr:12;
-		unsigned long width:6;
-#if __riscv_xlen == 32
-		unsigned long reserved:13;
-#else
-		unsigned long reserved:45;
-#endif
-		unsigned long type:1;
-	};
-};
-
 /*
  * RISC-V doesn't have hetergenous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
-- 
2.36.1

