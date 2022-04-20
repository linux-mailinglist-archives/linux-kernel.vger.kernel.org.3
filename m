Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F068508CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380448AbiDTQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:16:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A7C1AF32;
        Wed, 20 Apr 2022 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650471213; x=1682007213;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=doDCgt/6iTHZJsY84uF8MWPpluNZtoIMItHZs99x+54=;
  b=igu9c8lE+IyFCLT4YBe4PpOEsk6786vZn1oabyqg3Jyw0Lycao6emeeN
   kHww3Th+++YPg+NAr7vo8H5Y/86wjhybfUk0FHhHeq1G6hItoIJTcIzfx
   he2z2mjE1w9iJawUkae7l3VZ98wajuo/xg9nA29IbeOQpEOAKO0lyvI4X
   3iymkfEPm5WLfwpyJH2c/DXAs2NbJ9gFh3sFSeApgGvDRk38/iZ0fjdNJ
   MNKwL+l/2hAHTU5T1qmytyteaXo19X7GA4MiAEV009CSyo4XYnYD8oSAy
   2aaOG9ROBBUyVvynJHffi/gPdi8HJByr27lYyXzGZej8ftliPaaHkb8wL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261675314"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="261675314"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="555260889"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2022 08:56:23 -0700
Received: from debox1-desk4.lan (unknown [10.212.213.71])
        by linux.intel.com (Postfix) with ESMTP id 163DC580AE3;
        Wed, 20 Apr 2022 08:56:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for writes
Date:   Wed, 20 Apr 2022 08:56:21 -0700
Message-Id: <20220420155622.1763633-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420155622.1763633-1-david.e.box@linux.intel.com>
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to change in firmware flow, update mailbox writes to poll on ready bit
instead of run_busy bit. This change makes the polling method consistent
for both writes and reads, which also uses the ready bit.

Fixes: 2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 11f211402479..89729fed030c 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -245,8 +245,8 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-	/* Poll on run_busy bit */
-	ret = readq_poll_timeout(priv->control_addr, control, !(control & CTRL_RUN_BUSY),
+	/* Poll on ready bit */
+	ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
 				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
 
 	if (ret)
-- 
2.25.1

