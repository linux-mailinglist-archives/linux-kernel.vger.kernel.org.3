Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C15B0962
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIGP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIGP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:59:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47AB8F19
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566357; x=1694102357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TyuRlis55UMm+cKEWzJQdtL+A9hqNaNXtqYaGsH3QG4=;
  b=TCEXCl8g0M6ALugucF5n9z6ZlTdIdgrmdcH21+Im6cV2Zt+XQjVhcRuL
   /0brC7jcGW5ALU8sT6QNqqAPw1yNa5+gGNJ8S4F3k/e7JLl6Zi65THC06
   dezhCQalJ4EcgEpFHdwvVXDdWE/zxLRTiYeA0Vm+3eCFjp9kDrt080kNz
   rz8A1BJB4em/LNa1UOFYLER6CWigWxoiZgwCvzAbNXGeJ7RWGdV5sR57S
   DSWdw2U+REFM0iR+fiVyl6Q7rKXOVe1OC1zxzBOz5KTEfrYXpdZK6R7qm
   ilgeUlIL4yh4Robr872KaaKGDR1yaGNEhcsefsVIc8iZIQ4lRhNTJpA9/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297701136"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="297701136"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:59:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676247706"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:58:58 -0700
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
Subject: [PATCH v8 05/16] drm/i915/gsc: add GSC XeHP SDV platform definition
Date:   Wed,  7 Sep 2022 18:58:02 +0300
Message-Id: <20220907155813.1427526-6-tomas.winkler@intel.com>
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

Define GSC on XeHP SDV (Intel(R) dGPU without display)

XeHP SDV uses the same hardware settings as DG1, but uses polling
instead of interrupts and runs the firmware in slow pace due to
hardware limitations.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 73498c2574c8..e1040c8f2fd3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -56,6 +56,19 @@ static const struct gsc_def gsc_def_dg1[] = {
 	}
 };
 
+static const struct gsc_def gsc_def_xehpsdv[] = {
+	{
+		/* HECI1 not enabled on the device. */
+	},
+	{
+		.name = "mei-gscfi",
+		.bar = DG1_GSC_HECI2_BASE,
+		.bar_size = GSC_BAR_LENGTH,
+		.use_polling = true,
+		.slow_firmware = true,
+	}
+};
+
 static const struct gsc_def gsc_def_dg2[] = {
 	{
 		.name = "mei-gsc",
@@ -107,6 +120,8 @@ static void gsc_init_one(struct drm_i915_private *i915,
 
 	if (IS_DG1(i915)) {
 		def = &gsc_def_dg1[intf_id];
+	} else if (IS_XEHPSDV(i915)) {
+		def = &gsc_def_xehpsdv[intf_id];
 	} else if (IS_DG2(i915)) {
 		def = &gsc_def_dg2[intf_id];
 	} else {
-- 
2.37.2

