Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C0550B01
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiFSNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiFSNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:38:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E3CE21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655645895; x=1687181895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYZG1amkkydTFSBCroQ3sciekwSL9RQh1BuuV3tEt8I=;
  b=HSI7ruIIQpb+1IqaqfDHzmRUj80ShjBSt4MTwfB7r2ySylSAkIB1d55Y
   GsCeKTLjzes6Ckv4bH//KNQ9nTMBvtRL9c6bifpJCX3uzmh4Nc2L9TRLg
   wDwpdK4r470sn5VVtS3vh7yj4rtiLbYRMDdqiSttLuU9CjOL+0WxWVYvg
   tZYcyzpzgOSDNue0fbBxa6IJ1dUKdxaF4Wh4afdKreTb0l6fk5sI+BjUy
   tAUJfJJymehGBhBmMAC+NDmNCED2zGY1NN6mNf62CqBBkh3mQteoSNZDi
   MXcwzpKvBPsfhpGSlO8N0uVCMi3GMdfklyUu/hYF1jpceQZlSzaP0yxhZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305164730"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305164730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:38:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676158605"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:38:12 -0700
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
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v3 12/14] mei: gsc: add transition to PXP mode in resume flow
Date:   Sun, 19 Jun 2022 16:37:19 +0300
Message-Id: <20220619133721.523546-13-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220619133721.523546-1-alexander.usyskin@intel.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Added transition to PXP mode in resume flow.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index c8a167b57cc9..71f247f5e7ca 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -182,11 +182,22 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
 static int __maybe_unused mei_gsc_pm_resume(struct device *device)
 {
 	struct mei_device *dev = dev_get_drvdata(device);
+	struct auxiliary_device *aux_dev;
+	struct mei_aux_device *adev;
 	int err;
+	struct mei_me_hw *hw;
 
 	if (!dev)
 		return -ENODEV;
 
+	hw = to_me_hw(dev);
+	aux_dev = to_auxiliary_dev(device);
+	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+	if (adev->ext_op_mem.start) {
+		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
+		dev->pxp_mode = MEI_DEV_PXP_INIT;
+	}
+
 	err = mei_restart(dev);
 	if (err)
 		return err;
-- 
2.32.0

