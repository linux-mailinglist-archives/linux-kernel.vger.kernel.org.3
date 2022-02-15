Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A34B6529
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiBOIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:05:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiBOIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:05:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9E2654E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644912291; x=1676448291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y45v02Q4Yhlu+Z7MmUeFrzCK/xlZgbm1OeeQ2IVfrtE=;
  b=jtZOGP/GXTMREETeCMGlaoeir+Z4d4VPNmpKusv21DVNx6F5I1L/C4xv
   f9f4HmJMzU8ieCbdfL1AFgKxu+GC83o2aHKpDnI3cj8ZfJY5LixJ6pzfu
   p/4C3+x35Y/ffvAoEd3cFlTZpoOcRlBCbnezGbropBKaYYWDAt0LCzpjf
   XNxzfV7fGgBUzOfKI09+OP3L4JRUy4/H/z55sDkhG3/51nszn6UxYbOEN
   W0/Gsw+O7XoXoMz4ftVtE8Nt9Q4rDq0fXaeZ4Dve+FHzZqrwEqVml20MS
   HPsymZZ4VgmOpfvHPSHxgula3/OuMec2jAWOw4dNVKxjmUPQalYvUwF6s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336703233"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="336703233"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="703498884"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:04:49 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/4] mei: me: avoid link reset on shutdown
Date:   Tue, 15 Feb 2022 10:04:36 +0200
Message-Id: <20220215080438.264876-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215080438.264876-1-tomas.winkler@intel.com>
References: <20220215080438.264876-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Avoid lingering reset thread on driver shutdown.
If the firmware is down during a shutdown flow
do not initiate the link reset, simply disconnect
all clients and let shutdown flow finish

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 1 +
 drivers/misc/mei/hw-me.c  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 06734670a732..31264ab2eb13 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -2148,6 +2148,7 @@ void mei_cl_all_disconnect(struct mei_device *dev)
 	list_for_each_entry(cl, &dev->file_list, link)
 		mei_cl_set_disconnected(cl);
 }
+EXPORT_SYMBOL_GPL(mei_cl_all_disconnect);
 
 static struct mei_cl *mei_cl_dma_map_find(struct mei_device *dev, u8 buffer_id)
 {
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index fbc4c9581864..3a86c087bc9d 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1257,7 +1257,11 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/* check if ME wants a reset */
 	if (!mei_hw_is_ready(dev) && dev->dev_state != MEI_DEV_RESETTING) {
 		dev_warn(dev->dev, "FW not ready: resetting.\n");
-		schedule_work(&dev->reset_work);
+		if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
+		    dev->dev_state == MEI_DEV_POWER_DOWN)
+			mei_cl_all_disconnect(dev);
+		else if (dev->dev_state != MEI_DEV_DISABLED)
+			schedule_work(&dev->reset_work);
 		goto end;
 	}
 
-- 
2.34.1

