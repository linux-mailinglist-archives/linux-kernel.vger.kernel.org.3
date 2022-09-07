Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6C5B097D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIGQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIGQAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:00:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DA915CD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566403; x=1694102403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO/ygtyyqutcViUvWsaXsvt/Qi8P3M4tyR8fhZGvumg=;
  b=HPpl33S+4gWJv9hBeay5NyRyCX1LaKPhMshz3rB3KPegETjGjQr/RUZI
   qDmQGoDK5OKMx+rN7WfDySkxdN+ENCfhSv3II1F9zmuhuqlwYSPvMhvU3
   Rxru66+Ph2ZUkUOR/LZh4sxDpvbOXtEe8j6or55I8xxY0MOghdcUgrGiA
   c3TqCzpH0S7kXrQ1MiR2lbzVfVzDQVAcGLdg31IMZdhRdMiX1M/SZGjE0
   /YI66cVe+RZwI9canfLuPOY83QLH8U2PC6lOWqJfbPWlDRfqLzmIQ3QkL
   9UU6A7J2mVA4doA6m5z5eW/zrEXIq4fDAwgoppZSQbAI9JDBzE4qdFLLp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297701570"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297701570"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676248208"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:30 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: [PATCH v8 13/16] mei: drop ready bits check after start
Date:   Wed,  7 Sep 2022 18:58:10 +0300
Message-Id: <20220907155813.1427526-14-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907155813.1427526-1-tomas.winkler@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The check that hardware and host ready bits are set after start
is redundant and may fail and disable driver if there is
back-to-back link reset issued right after start.
This happens during pxp mode transitions when firmware
undergo reset. Remove these checks to eliminate such failures.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 1b4d5d7870b9..bac8852aad51 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -218,16 +218,6 @@ int mei_start(struct mei_device *dev)
 		goto err;
 	}
 
-	if (!mei_host_is_ready(dev)) {
-		dev_err(dev->dev, "host is not ready.\n");
-		goto err;
-	}
-
-	if (!mei_hw_is_ready(dev)) {
-		dev_err(dev->dev, "ME is not ready.\n");
-		goto err;
-	}
-
 	if (!mei_hbm_version_is_supported(dev)) {
 		dev_dbg(dev->dev, "MEI start failed.\n");
 		goto err;
-- 
2.37.2

