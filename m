Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4348530120
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 07:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiEVFuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiEVFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 01:50:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439C40932
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653198600; x=1684734600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hqW5dtCkp+lQBUQ3TJWA0FI1FzCBjujuUuvhAgieM3Q=;
  b=G7LD+Fqp232EM2nFO2OGLqMUudCIvE94ScsoztqfpF1Qp2Nq07ecOxbp
   syinkotBnK02hUrOQw6yiFmEYww8nHrwfTBQfOniQEZOmtVwE7zXk1bIV
   o0FGH7P4HfJH1p4r/n/mmqXPALMgvOo7jNH+h7o1Fl1ATLf1/3KcBl0Hc
   fgIK9//f/CpfW4HSuEy0WzV/+MeOp3z9FAqMpbvaie+UVi8nVjy5Q2nbm
   l4qjTv6gFgC5nmQIwt8z7500t7fj+7KrQPfKqw9zPXqffHFy59wgmMAsY
   sM1vZydmmZhPU1gOOBUW/RBeR1AiTK1+nM1qXnavjd0lKl8e9VcyR1c2S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="336002731"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="336002731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 22:49:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="600047765"
Received: from unknown (HELO jiaqingz-server.sh.intel.com) ([10.239.48.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 22:49:58 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 1/2] mtd: spi-nor: macronix: Add support for mx66l2g45g
Date:   Sun, 22 May 2022 13:48:01 +0800
Message-Id: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..1c45829be5ef 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -95,6 +95,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "mx66l2g45g",  INFO(0xc2201c, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
-- 
2.34.1

