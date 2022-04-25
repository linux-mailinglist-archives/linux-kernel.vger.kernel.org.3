Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB250DA84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiDYHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiDYHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4BD132
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872967; x=1682408967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSmcXoZx1tsMcQcOYD1yikOteulbwH8GaQawx8yjFP0=;
  b=niK6O4ZdBmsyddrTojpudU3N4GLM3vxSJxP5OQnUz95S1nzJjWxGP9cV
   cCYCf/cPWKSSMZn31UkmM7iOK8n1XXPOdt7BGJ7cjKSPsk5fVCfrCzOHV
   VXsyWVK+ehcTJZuJVrv41QwrNLgGc0KAOk7Sfp2kbZIM8GtFZUHwKN2+7
   87sKOrjkW8bHWKia5mhOZgE9wwe6puppIZwD6TsKxalofbvf+etgIggT2
   8duUMl0f0yOWHKaBIYE7/hUNKDCHa6zR2UPxQavso9GFjT05rR6J7sux/
   j1aoBePQTROqGZpGFaYyZAz1hgNC+ocAvhnXnYyw7f7zUCjIGCNn207M7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973687"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557599901"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:23 -0700
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
Subject: [PATCH v2 04/14] drm/i915/gsc: add slow_fw flag to the gsc device definition
Date:   Mon, 25 Apr 2022 10:48:51 +0300
Message-Id: <20220425074901.3991274-5-alexander.usyskin@intel.com>
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

Add slow_fw flag to the gsc device definition
and pass it to mei auxiliary device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index e0236ff1d072..f963c220bbff 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -41,6 +41,7 @@ struct gsc_def {
 	unsigned long bar;
 	size_t bar_size;
 	bool use_polling;
+	bool slow_fw;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -145,6 +146,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	adev->bar.end = adev->bar.start + def->bar_size - 1;
 	adev->bar.flags = IORESOURCE_MEM;
 	adev->bar.desc = IORES_DESC_NONE;
+	adev->slow_fw = def->slow_fw;
 
 	aux_dev = &adev->aux_dev;
 	aux_dev->name = def->name;
-- 
2.32.0

