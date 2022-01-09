Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD4488AD5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiAIRK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiAIRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:09:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0965C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 09:09:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 5E8CB1F4380E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641748170;
        bh=xeOXH/rxXIFjWYifYSehO8x4iP5GuWnkz6SV02KDtok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX4xDw5eao1mYAO6qY0Xl3o7kbpL47cichIYhJ+JmOdgZs+zK4ncmzh8rbkpBjxZ2
         pvZnnOjc9pm9XXiWlq0GJa18TyeB28qwtgeZ+pg5Oueyxj1YIpyeMGdRk7J4pKwApz
         0YS+DqMOYk0IHflUCvhxZBHcbDhUlqTMZW8u7kWH90mpRBJwUWhcPsyTCJzbvk7/V6
         NSsnAfBCclq8yOOsCIngecYzFgXPeCDbAfTR8tEn4Lmnbeg8HBzDAZZEw1+/MdEFUj
         MUtvOnEY5Xup/WF6zmiS220e5Y8JlnhPhlf8LDhhIHewQpIZoxh2AW/3IQYoM88XH2
         7LM3Je6iWXuZQ==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panfrost: Merge some feature lists
Date:   Sun,  9 Jan 2022 12:09:19 -0500
Message-Id: <20220109170920.2921-3-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
References: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we only list features of interest to kernel space, lots of GPUs
have the same feature bits. To cut down on the repetition in the file,
merge feature lists that are identical between similar GPUs.

Note that this leaves some unmerged identical Bifrost feature lists, as
there are more features affecting Bifrost kernel space that we do not
yet hanlde.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_features.h | 40 ++++----------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
index f557fad5d5ff..34f2bae1ec8c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_features.h
+++ b/drivers/gpu/drm/panfrost/panfrost_features.h
@@ -27,14 +27,9 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
 	BIT_ULL(HW_FEATURE_V4))
 
-#define hw_features_t620 (\
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
-	BIT_ULL(HW_FEATURE_V4))
-
-#define hw_features_t720 (\
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
-	BIT_ULL(HW_FEATURE_V4))
+#define hw_features_t620 hw_features_t600
 
+#define hw_features_t720 hw_features_t600
 
 #define hw_features_t760 (\
 	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
@@ -42,26 +37,13 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_XAFFINITY) | \
 	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT))
 
-// T860
-#define hw_features_t860 (\
-	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
-	BIT_ULL(HW_FEATURE_PWRON_DURING_PWROFF_TRANS) | \
-	BIT_ULL(HW_FEATURE_XAFFINITY) | \
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT))
+#define hw_features_t860 hw_features_t760
 
-#define hw_features_t880 hw_features_t860
+#define hw_features_t880 hw_features_t760
 
-#define hw_features_t830 (\
-	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
-	BIT_ULL(HW_FEATURE_PWRON_DURING_PWROFF_TRANS) | \
-	BIT_ULL(HW_FEATURE_XAFFINITY) | \
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT))
+#define hw_features_t830 hw_features_t760
 
-#define hw_features_t820 (\
-	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
-	BIT_ULL(HW_FEATURE_PWRON_DURING_PWROFF_TRANS) | \
-	BIT_ULL(HW_FEATURE_XAFFINITY) | \
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT))
+#define hw_features_t820 hw_features_t760
 
 #define hw_features_g71 (\
 	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
@@ -82,15 +64,7 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
 	BIT_ULL(HW_FEATURE_COHERENCY_REG))
 
-#define hw_features_g51 (\
-	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
-	BIT_ULL(HW_FEATURE_PWRON_DURING_PWROFF_TRANS) | \
-	BIT_ULL(HW_FEATURE_XAFFINITY) | \
-	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
-	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
-	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
-	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
-	BIT_ULL(HW_FEATURE_COHERENCY_REG))
+#define hw_features_g51 hw_features_g72
 
 #define hw_features_g52 (\
 	BIT_ULL(HW_FEATURE_JOBCHAIN_DISAMBIGUATION) | \
-- 
2.34.1

