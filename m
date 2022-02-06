Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35034AAF65
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiBFNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiBFNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:14:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127B8C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644153295; x=1675689295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPfAnYrchtvqrYB1kUbBqN/6hGrrdhKHKY7ccrDfJNE=;
  b=PeN55NotAo40LpwgmT/uZ4sFpaOvM3mrlfJI1okYG1c7lah5Usx07a//
   SIE3Wfzn8Fvub41GONA9XqztTWXhnNq818CgBDD3Ar/38ZFN8jJcKSV3V
   wtSSI08BbfFBWTFadOSiu/FEwgkNFGa7iK8QDCkUME6O8yVHok1HxkoPZ
   IlHC7AG8IFj9YlxtumxSZtJoipVB3O6mg3ApoNPIQsTEJt80umrwLcizC
   oZIQbJZAQnT33aapqXoCsKMqKAbg8XUHgA/+zJATHIX/hxJmxPwot4QcC
   AfgQP69eY7Lm5xXJAxJD5g28R0L07kadiyRMzlyfaf7s+h7rhszV0uCBy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="334981232"
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="334981232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 05:13:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="539750877"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 05:13:49 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] mei: gsc: setup char driver alive in spite of firmware handshake failure
Date:   Sun,  6 Feb 2022 15:13:20 +0200
Message-Id: <20220206131322.3246403-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206131322.3246403-1-alexander.usyskin@intel.com>
References: <20220206131322.3246403-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup char device in spite of firmware handshake failure.
In order to provide host access to the firmware status registers and other
information required for the manufacturing process.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V5: Rebase
---
 drivers/misc/mei/gsc-me.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 0afae70e0609..cf427f6fdec9 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -79,11 +79,12 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 	pm_runtime_set_active(device);
 	pm_runtime_enable(device);
 
-	if (mei_start(dev)) {
-		dev_err(device, "init hw failure.\n");
-		ret = -ENODEV;
-		goto err;
-	}
+	/* Continue to char device setup in spite of firmware handshake failure.
+	 * In order to provide access to the firmware status registers to the user
+	 * space via sysfs.
+	 */
+	if (mei_start(dev))
+		dev_warn(device, "init hw failure.\n");
 
 	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(device);
-- 
2.32.0

