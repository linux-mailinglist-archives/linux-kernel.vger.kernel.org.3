Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0610B508CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380382AbiDTQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355118AbiDTQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:11:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579731227;
        Wed, 20 Apr 2022 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650470897; x=1682006897;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vJzQon2YEQAxP+wKoJedMbeahF5JTPiVjBzVDAVVuhg=;
  b=dzLOZubnysi2dhLrFX/FSrUYFceEtrvjsjBbBJes4B6IvlcvWbJetxXh
   fN/1AZqeKAJusVcNVgQWiP1v5vO2iiL78SneNyeYRysUMLVz9v+QRYCCi
   HQ6cpn1x5ZC4hbvnUIf8apuLjrCaeo4AE3/A3e/glEr6+A5WfgrjV344M
   XnFfep94ij4zOWa9bRgbIplYkq7SuwRnZvek6+apzwe5Yi03lHFnqarFm
   ivWf+qpNMzywBwK/OtMg5fS5k6DWAFuUZrHnie5rto8LZU3a0dXe8/jr/
   7//r8YRE2inqpWZTvrkBC8GzG/cC7UtUKR3wIC8qV8ASvHdKjgMxK/Kl2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244004001"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="244004001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="702687380"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 08:56:23 -0700
Received: from debox1-desk4.lan (unknown [10.212.213.71])
        by linux.intel.com (Postfix) with ESMTP id E33F6580812;
        Wed, 20 Apr 2022 08:56:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86/intel/sdsi: Handle leaky bucket
Date:   Wed, 20 Apr 2022 08:56:20 -0700
Message-Id: <20220420155622.1763633-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420155622.1763633-1-david.e.box@linux.intel.com>
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent an agent from indefinitely holding the mailbox firmware has
implemented a leaky bucket algorithm. Repeated access to the mailbox may
now incur a delay of up to 2.1 seconds. Add a retry loop that tries for
up to 2.5 seconds to acquire the mailbox.

Fixes: 2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 32 ++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 11d14cc0ff0a..11f211402479 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -51,6 +51,8 @@
 #define MBOX_TIMEOUT_US			2000
 #define MBOX_TIMEOUT_ACQUIRE_US		1000
 #define MBOX_POLLING_PERIOD_US		100
+#define MBOX_ACQUIRE_NUM_RETRIES	5
+#define MBOX_ACQUIRE_RETRY_DELAY_MS	500
 #define MBOX_MAX_PACKETS		4
 
 #define MBOX_OWNER_NONE			0x00
@@ -263,7 +265,7 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
 {
 	u64 control;
 	u32 owner;
-	int ret;
+	int ret, retries = 0;
 
 	lockdep_assert_held(&priv->mb_lock);
 
@@ -273,13 +275,29 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
 	if (owner != MBOX_OWNER_NONE)
 		return -EBUSY;
 
-	/* Write first qword of payload */
-	writeq(info->payload[0], priv->mbox_addr);
+	/*
+	 * If there has been no recent transaction and no one owns the mailbox,
+	 * we should acquire it in under 1ms. However, if we've accessed it
+	 * recently it may take up to 2.1 seconds to acquire it again.
+	 */
+	do {
+		/* Write first qword of payload */
+		writeq(info->payload[0], priv->mbox_addr);
+
+		/* Check for ownership */
+		ret = readq_poll_timeout(priv->control_addr, control,
+			FIELD_GET(CTRL_OWNER, control) == MBOX_OWNER_INBAND,
+			MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_ACQUIRE_US);
+
+		if (FIELD_GET(CTRL_OWNER, control) == MBOX_OWNER_NONE &&
+		    retries++ < MBOX_ACQUIRE_NUM_RETRIES) {
+			msleep(MBOX_ACQUIRE_RETRY_DELAY_MS);
+			continue;
+		}
 
-	/* Check for ownership */
-	ret = readq_poll_timeout(priv->control_addr, control,
-				 FIELD_GET(CTRL_OWNER, control) & MBOX_OWNER_INBAND,
-				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_ACQUIRE_US);
+		/* Either we got it or someone else did. */
+		break;
+	} while (true);
 
 	return ret;
 }
-- 
2.25.1

