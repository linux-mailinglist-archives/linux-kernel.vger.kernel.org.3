Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697950DA83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiDYHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiDYHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD9D0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872970; x=1682408970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OV6VMILmyzhR8I/JWP2D88lk4Dzd2WOr905NSjbU+2c=;
  b=YGjrryc80QQ3/C+VByZoJ+CtGfEodJTazDtA7eoGism6L3cCuLamAM7t
   ZObbfledaJWze9RtcoeYRMcJoVcfyb6UjIVKdqrqybBkSqPN7O1iswh4g
   MSIjpnQMVEsqVJgYr8WxfxydQWEZl0oeEOsUeyzENUFlhaJJW6+bkxd+2
   XdOkAOL6XE9SzKdqPi6M5ri28jlGzkkWVu8EVmbtOVmd4oJYlN5rL+l35
   5ZMp4fJuyZeGPwL3T0CTZBwFlNoTAICTgFGCwg1cgDW9LG8JM4RSreYZg
   JsDWQ6A76Na2XxlD+9cMQytl+CD/4ZQJJ9nWnDO0bFy+/Rvb/GdbR+2Fr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973693"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973693"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557599928"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:26 -0700
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
Subject: [PATCH v2 05/14] drm/i915/gsc: add GSC XeHP SDV platform definition
Date:   Mon, 25 Apr 2022 10:48:52 +0300
Message-Id: <20220425074901.3991274-6-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425074901.3991274-1-alexander.usyskin@intel.com>
References: <20220425074901.3991274-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f963c220bbff..bfc307e49bf9 100644
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
+		.slow_fw = true,
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
2.32.0

