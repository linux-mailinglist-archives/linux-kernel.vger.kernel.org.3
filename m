Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AC530121
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiEVFuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiEVFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 01:50:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE14093B
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653198602; x=1684734602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lURrqWQ4Bp3TuV0mtrGGqW8+CVdAW7nh+lfYSkx6HmI=;
  b=LiSlFl0cotNIXWeNCQkPSxTgtct1SahfhTI3KxgC7BorHoC4EKoI81R9
   UaXC4sf2cbzjwVJkJYgWegY39ZJ+a0hqqjNZMKB5B7BBAREuYuseK8/ZI
   SKsDhllPzuRS6sh/4c8LBQl4ljnR+BTKdPhfC9FiIlktpIvqPNjyn3EKL
   nRzJbL0qXnZY/QNElNkKiqHZjuU5rPmL3jLLWF04FRzTedQocMVNZT7tk
   sRfndVlpCtIznJ5c+Shzdt+AD7C7o/J8pzbuQ9gev/xUgdEcquB0uoW/9
   rIxYibiPuhMyFUHxejZVfrvfaeWpLAKLOFOLPzCENyc4cuMGemK8oWvxW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="336002732"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="336002732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 22:50:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="600047771"
Received: from unknown (HELO jiaqingz-server.sh.intel.com) ([10.239.48.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 22:50:00 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 2/2] mtd: spi-nor: micron: Add SPI_NOR_DUAL_READ flag on mt25ql02g
Date:   Sun, 22 May 2022 13:48:02 +0800
Message-Id: <20220522054802.1719443-2-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
References: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
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

The Micron mt25ql02g supports x2 width dual mode operation. This patch
adds the SPI_NOR_DUAL_READ flag to its flash_info entry.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/mtd/spi-nor/micron-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 8a20475ce77a..da0251c1a263 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -233,7 +233,7 @@ static const struct flash_info st_nor_parts[] = {
 	},
 	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096)
 		FLAGS(NO_CHIP_ERASE)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096)
-- 
2.34.1

