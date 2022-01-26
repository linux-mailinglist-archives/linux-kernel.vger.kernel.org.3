Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB149C6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiAZJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:48:39 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:54886 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiAZJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:48:37 -0500
X-Greylist: delayed 1824 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 04:48:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7+gQH
        ova1ewkBfJn3FFDQ+n/FuOVx0d3gWZmjoaJ1o8=; b=SrQkLJJwtPGN3KkoORFKj
        WpGAqajGI+h9X4EGjpGVijTUKkeY9W3bcNYl01vdk4RtjwdCKishi2PTmBUnWArF
        JAgaDKzuu5Yf773OYnqJK5EEzw3rf8UMwJ2opKWQPifgDkQWiyA+uHflurjo+6pm
        eIlWy1VBseBREQ5jkEzgF8=
Received: from CD-huangqu.Hygon.cn (unknown [175.152.51.41])
        by smtp3 (Coremail) with SMTP id DcmowAAngeVWEfFh6zUzAA--.15463S2;
        Wed, 26 Jan 2022 17:16:07 +0800 (CST)
From:   jinsdb@126.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jinsdb@126.com
Subject: [PATCH] drm/amdgpu: Wrong order for config and counter_id parameters
Date:   Wed, 26 Jan 2022 17:16:02 +0800
Message-Id: <20220126091602.1647-1-jinsdb@126.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAngeVWEfFh6zUzAA--.15463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWUZr1rZw47Xry5tw48Crg_yoW8JryDpr
        WrJryDtFWkAFnFq3yDua4vvFyDA3ZFva4Skr1UJ34a9a45A34rZrW3JF12yF1UWrWrCrW7
        tFn7GayUuFnFvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHUDJUUUUU=
X-Originating-IP: [175.152.51.41]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbijB+UDlpEGQnX8gAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huangqu <jinsdb@126.com>

Wrong order for config and counter_id parameters was passed, when calling df_v3_6_pmc_set_deferred and df_v3_6_pmc_is_deferred functions.

Signed-off-by: huangqu <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 43c5e3ec9..f4dfca013 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -458,7 +458,7 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,

 #define DEFERRED_ARM_MASK	(1 << 31)
 static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
-				    int counter_idx, uint64_t config,
+				    uint64_t config, int counter_idx,
 				    bool is_deferred)
 {

@@ -476,8 +476,8 @@ static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
 }

 static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
-				    int counter_idx,
-				    uint64_t config)
+				    uint64_t config,
+				    int counter_idx)
 {
 	return	(df_v3_6_pmc_has_counter(adev, config, counter_idx) &&
 			(adev->df_perfmon_config_assign_mask[counter_idx]
--
2.31.1

