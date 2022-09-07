Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0B5B0F81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiIGVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiIGVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:51:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CDBD15D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587517; x=1694123517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGxae1nA6Nr/6+rxbpBDV1g74jZ8OEr+jGn8KW/3em0=;
  b=ByYw6y7YKMOb+woxIsPWT/DiukzPoCv+spOW7B/lsTV9qQqsn1Pu0ijO
   qBbuIhPK0y0jhAHoQAhMSSALMBCLTQqpPYGN7gFq+ij/1O/bzzSQnniNI
   AeXYGuDwUdve/j3UGwdNOCrhgYWqxYuAEHR2P6uoUizFC/GdPqV8Ia54B
   E+XspznUlGX18HBfJA0N6JVAzmyDRiVommqTOR1AfQC0AfvmOzSdF8yZ8
   lr181wElehO/pS5YahybUJU0XyZPUpgIZ9FtQoa4G60Q2ZwFcPGDMpQ87
   O+YmAoraZdVhe1q08tfmDjBI/nRpPOUyYK4321M+vte1GWTi8GsBNxPqg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740287"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790207877"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:46 -0700
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
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v9 05/16] drm/i915/gsc: add GSC XeHP SDV platform definition
Date:   Thu,  8 Sep 2022 00:51:02 +0300
Message-Id: <20220907215113.1596567-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907215113.1596567-1-tomas.winkler@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

Define GSC on XeHP SDV (Intel(R) dGPU without display)

XeHP SDV uses the same hardware settings as DG1, but uses polling
instead of interrupts and runs the firmware in slow pace due to
hardware limitations.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V9: Rebase

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

