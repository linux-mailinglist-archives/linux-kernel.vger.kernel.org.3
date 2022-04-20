Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D37508D00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380453AbiDTQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380426AbiDTQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:18:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D122656D;
        Wed, 20 Apr 2022 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650471362; x=1682007362;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=keqVj2ktPIEk/4jLO/r0b+85IqTBeW/fcCjhz3HKa1o=;
  b=CSjOiaCnL2oGsJ2jnGOq0k5sj+EbVfzDnJB3xseK00AyfF9kkkLMnal3
   xqDW2/nAMyyT0BAyXd+lj3aQJg7fbi2G5AWzp61N1Q0r83I6txyp6JLEV
   90zk7Kk+uG+zAvmEzkVHkBb83lYxSaSpNjfDAhy6stSXV+zKvE8luPsG6
   LMmd1ehhWlwyVBkv+mTBPYHWY4RyO9IyLAiTJg0Js5jI3avIy1k8feqdi
   wQlRdgcAREHTwPx7Bm7wxg6XuyBVJYewr6Un+2A8d9Bnr5+uJmCSDFGQM
   Ep4UOBmrnYjMRi1bURr7i0SDzJHBLcgSrVzrn/E1u+/6EI+vnnGfYDEv2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289180633"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="289180633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="614468146"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 08:56:23 -0700
Received: from debox1-desk4.lan (unknown [10.212.213.71])
        by linux.intel.com (Postfix) with ESMTP id 449FE58088F;
        Wed, 20 Apr 2022 08:56:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86/intel/sdsi: Fix bug in multi packet reads
Date:   Wed, 20 Apr 2022 08:56:22 -0700
Message-Id: <20220420155622.1763633-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420155622.1763633-1-david.e.box@linux.intel.com>
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug that added an offset to the mailbox addr during multi-packet
reads. Did not affect current ABI since it doesn't support multi-packet
transactions.

Fixes: 2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 89729fed030c..c830e98dfa38 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -83,7 +83,7 @@ enum sdsi_command {
 
 struct sdsi_mbox_info {
 	u64	*payload;
-	u64	*buffer;
+	void	*buffer;
 	int	size;
 };
 
@@ -165,9 +165,7 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 	total = 0;
 	loop = 0;
 	do {
-		int offset = SDSI_SIZE_MAILBOX * loop;
-		void __iomem *addr = priv->mbox_addr + offset;
-		u64 *buf = info->buffer + offset / SDSI_SIZE_CMD;
+		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
 		u32 packet_size;
 
 		/* Poll on ready bit */
@@ -198,7 +196,7 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 			break;
 		}
 
-		sdsi_memcpy64_fromio(buf, addr, round_up(packet_size, SDSI_SIZE_CMD));
+		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
 
 		total += packet_size;
 
-- 
2.25.1

