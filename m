Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A304D4B71AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiBOQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiBOQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEF8A6C3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644942724; x=1676478724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kOl4ZoUw8hbyoH6yx63ZM9ci77NdjsTJQdRP7iPomh8=;
  b=DHB8eV1vQOXuSCSXIlRjrlOKfixacZt9KHcim9qigyQFxCVvoQdpPcHv
   HcUD8PF+wobnBfQe09uSDTHt/nvi41Rsp8j7+Q7ihhwNiIHM6rZ2dbISy
   ucmBbZiRkR72TYoynYPCXEU7j8h7hkApU1pjFRrt2qdaGEiiWwYdF6NuC
   ZqFourOdenRgwmYSg6KCYdK6weFlWXbn1SPeoECGTHvd8YQHwe821mAig
   OhU/Ru3Z3mRw+6UzXEQ2DBlR0dOvfchefGSrCBulWcqMvNKSkVza4yy9y
   wbo34Q6mSYqCbhTAGHl9VFAC6udh3Kv+W5JOAaNoe07XHyDtZNN4ovaEq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="231018135"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231018135"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="539411451"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2022 08:31:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DA3D107; Tue, 15 Feb 2022 18:32:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/1] drm/i915/selftests: Replace too verbose for-loop with simpler while
Date:   Tue, 15 Feb 2022 18:32:13 +0200
Message-Id: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to parse for-loop which has some magic calculations inside.
Much cleaner to use while-loop directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_syncmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 47f4ae18a1ef..26981d1c3025 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -36,10 +36,10 @@ __sync_print(struct i915_syncmap *p,
 	unsigned int i, X;
 
 	if (depth) {
-		unsigned int d;
+		unsigned int d = depth;
 
-		for (d = 0; d < depth - 1; d++) {
-			if (last & BIT(depth - d - 1))
+		while (d--) {
+			if (last & BIT(d))
 				len = scnprintf(buf, *sz, "|   ");
 			else
 				len = scnprintf(buf, *sz, "    ");
-- 
2.34.1

