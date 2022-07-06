Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16F568703
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGFLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiGFLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:44:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2B27FE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657107845; x=1688643845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7trpfv682c9MxdTP7vanTLNmy9tVpMFpAitmjY9UN1A=;
  b=Xi1aOnqqbRzo3JeXy0q71Q/tjUmTjEFCQikgA/36jKsd9Z3H7V7+gziW
   6Sx2rs/JD3FulWnBbOapxiUhOBj1/l5sgphdvSuqW4nlqixDZu08Ez4wG
   mc3lH2wGlW/fh/N8oJGPfjNTB9ZvFq21FS1mrJxuJKjJI0F/984n6lPRs
   o/Q7mf+QZAFsm8f0VwNukyUontAni3PvBAGimcNjvlPxNHsx4ntbkunp5
   Ttr2q+XX9XDz8b5POfG2nLgd+rIBKFpXW+5n0VuCYMnD6q1Y9KqCOpXgZ
   Yyy2pG+dSEHJMpPENZWF2VFwMYiVA4uHdhI+8mL5+Os6pY24unJE0ZxNX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347707445"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="347707445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:44:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="650630112"
Received: from sannilnx.jer.intel.com ([10.12.26.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:44:02 -0700
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
Subject: [PATCH v5 02/14] drm/i915/gsc: add slow_fw flag to the mei auxiliary device
Date:   Wed,  6 Jul 2022 14:43:33 +0300
Message-Id: <20220706114345.1128018-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706114345.1128018-1-alexander.usyskin@intel.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_fw flag to the mei auxiliary device info
to inform the mei driver about slow underlying firmware.
Such firmware will require to use larger operation timeouts.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 include/linux/mei_aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index 587f25128848..a29f4064b9c0 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -11,6 +11,7 @@ struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
 	struct resource bar;
+	bool slow_fw;
 };
 
 #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
-- 
2.34.1

