Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E54B91E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiBPT4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiBPTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:55:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742C2B102D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645041336; x=1676577336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qaXlIXFhIN9tehgyDrdX1dF/Xq+y/hTt5Kno4Tv1zBk=;
  b=SwexBMBOo3Xe6saqS1ucai4o+V2GBKIXqag/WFMRCPPTHBUGyqWxxAuh
   GotwgbHFP7sUABI35dT/bxO9xHf7uKh+sUe2fj1a0Qc7nvvpBxSqoRw0k
   ITnIFTkOUv/SWIB0uCDzOuZhBJrR/2jjs/KCjo0P9pqoV31NsOkZrPCAo
   3dKQWXjp3JgT5+R4w2w40WmyR08882Y8Mjwt9VuqooOraqV8j77GCT0aQ
   MQ4FMb7qnZn04qCyHzO2JHv+wVJoMds6pdvC35lOZravJtuycb4N9+uqB
   CDsJr5KbVjnC4e1mcGqpb+6KKtxcJ/uYpZup4lHcs+GRix0IIiRaSdez8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275294438"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="275294438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:55:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="545140434"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:55:32 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] mei: gsc: setup char driver alive in spite of firmware handshake failure
Date:   Wed, 16 Feb 2022 21:54:57 +0200
Message-Id: <20220216195459.3918414-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216195459.3918414-1-alexander.usyskin@intel.com>
References: <20220216195459.3918414-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
V6: Rebase
V7: add Greg KH Reviewed-by
V8: Rebase
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

