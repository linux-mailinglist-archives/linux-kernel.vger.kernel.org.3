Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3755FEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiF2Lai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiF2LaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:30:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CFC3ED20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502207; x=1688038207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/85/eyRN1L9TltGLFuKC2cH1Xmg0KUkghA6blKh6CJU=;
  b=V0fFKAE0/wqkYg6um/i++ut7z9/KQsHR9iADnJbW0iA2laGnDoYfmrGS
   3Dshs7Dj/sLInpF8mzkLNmQpWyTN0abP0H/M/WFlFRltxwXk/Nug1SMpj
   KXDkI+eOTRWYC6DubpJNzeuVeNZ90wm9kaT44z/x3RJvHzYWavV/kdzkX
   Y8vuLricCVKswQq6DhWXc0sZr/Ygf+rztK4SkkJR/JcGkYCEKbpxu1GNs
   9ExJHxO1BlY8+4mWAGW0Jwb2HUBj0GdCrre/zzwuRVGAJOtQFjRVncGAQ
   I1JATPJAXgVGsXfGIyOjyW9avKdplY3g4SYKZd59Uvjw1w8wGZ7BLoLC1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368319350"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368319350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:30:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647353373"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:30:04 -0700
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
Subject: [PATCH v4 12/14] mei: gsc: add transition to PXP mode in resume flow
Date:   Wed, 29 Jun 2022 14:29:11 +0300
Message-Id: <20220629112913.1210933-13-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629112913.1210933-1-alexander.usyskin@intel.com>
References: <20220629112913.1210933-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

