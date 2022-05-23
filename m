Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815253143E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiEWPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiEWPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:05:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C15C369
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653318320; x=1684854320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GqBSoJu3ldq8Yjer/WKHt/G1jAH46RUioQAqT3NrMaM=;
  b=H6cP1hz35ZV45CamKEBBq4y0bkhs4zFrLWQdfe2QFW/4NB1GOpYZndML
   ozZFDO7SxAqEh/ZiawFstPvxr7MnU4Dslom0gq/tEuCALr292f3H7yXf6
   Ou9pr4pZwu9R2TcgRbtKgbftzF2JBp2Xf2VRvDSyD+PxNC8CrsWG3j1JN
   XHhdbQ2nNAZCpVJFp/ezlBs+P7MmZ5wJQsBWbw83j2ASVSdGi7F7jBhLX
   mj/06TkeTj78tlOX4nStvU/RpcHQ3ktZNSfRXwhdvWUi8x4EBPirDJ3oA
   vWclzVhg6EQDfSXVcG40zg1TutOY+mrBMtEp+y8zqPMLRdEHxYw6LzKUh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272064807"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272064807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:05:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="548015532"
Received: from unknown (HELO jiaqingz-server.sh.intel.com) ([10.239.48.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:05:17 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3] mtd: spi-nor: macronix: Add support for mx66l2g45g
Date:   Mon, 23 May 2022 23:03:35 +0800
Message-Id: <20220523150334.1758649-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
x1, x2, and x4 operation modes.

Tested read/write/erase with Aspeed AST2600 BMC SoC operating in x2
mode at 50MHz, using Aspeed spi-mem driver.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/mtd/spi-nor/macronix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..33d02a01b381 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -95,6 +95,8 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	// TODO: Use SNOR_ID3() for "mx66l2g45g"
+	{ "mx66l2g45g",  INFO(0xc2201c, 0, 0, 0) PARSE_SFDP },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
-- 
2.34.1

