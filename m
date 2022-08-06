Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75558B571
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiHFM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiHFM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:27:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B31911477
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788847; x=1691324847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nVBgBDLHbjGfV5g+FvesOoxRPL0tZHzGa2+17l2dWGU=;
  b=iQe6IY/gqYHsYYjZh4dhG3gklU5rBP2fo6aY1+4LkU7LT4I4xciXZC9+
   XK1WjSkkmCwmvbwhNXvwbs4CsMRnqlL2Avc8gMOQpiW0tLej+Xaxu/FAM
   u9jcSTParzc5qNFhK6cb46ZYQFl6XD5bgujdpr+XKi2aLk6QDcADZqy9V
   n9vCY4C/bFNh/ayXCYIlfJzd0ndIPUYZBahFm/htQtFw8MnUaJRKYqG0C
   xd5NsJdVgCiuNMWmaLu1+zgTit8vbi3DGXKcvQ9BoS4IvWAZ99zteU6VZ
   2LMOtc61J3V8e7oYYeIaFPO1cKIatX9PoEmE3WQc3CEeNM6UJQnPrypw0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121887"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329052"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:23 -0700
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
Subject: [PATCH v7 04/15] drm/i915/gsc: add slow_firmware flag to the gsc device definition
Date:   Sat,  6 Aug 2022 15:26:25 +0300
Message-Id: <20220806122636.43068-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122636.43068-1-tomas.winkler@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add slow_firmware flag to the gsc device definition
and pass it to mei auxiliary device, this instructs
the driver to use longer operation timeouts.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index e0236ff1d072..73498c2574c8 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -41,6 +41,7 @@ struct gsc_def {
 	unsigned long bar;
 	size_t bar_size;
 	bool use_polling;
+	bool slow_firmware;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -145,6 +146,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	adev->bar.end = adev->bar.start + def->bar_size - 1;
 	adev->bar.flags = IORESOURCE_MEM;
 	adev->bar.desc = IORES_DESC_NONE;
+	adev->slow_firmware = def->slow_firmware;
 
 	aux_dev = &adev->aux_dev;
 	aux_dev->name = def->name;
-- 
2.37.1

