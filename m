Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7414485015
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiAEJgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:36:11 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33436 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238896AbiAEJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:36:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V10PFNA_1641375366;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V10PFNA_1641375366)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 17:36:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jani.nikula@linux.intel.com, airlied@linux.ie
Cc:     daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] drm/i915/fbc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed,  5 Jan 2022 17:36:05 +0800
Message-Id: <20220105093605.66436-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/i915/display/intel_fbc.c:1757:0-23: WARNING:
intel_fbc_debugfs_false_color_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 160fd2bdafe5..9ab844ea7992 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1754,10 +1754,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
-			intel_fbc_debugfs_false_color_get,
-			intel_fbc_debugfs_false_color_set,
-			"%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
+			 intel_fbc_debugfs_false_color_get,
+			 intel_fbc_debugfs_false_color_set,
+			 "%llu\n");
 
 static void intel_fbc_debugfs_add(struct intel_fbc *fbc)
 {
-- 
2.20.1.7.g153144c

