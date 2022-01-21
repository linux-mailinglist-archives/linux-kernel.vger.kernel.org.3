Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B4495E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380222AbiAULsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:48:15 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44820 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbiAULsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:48:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2RfKTK_1642765682;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V2RfKTK_1642765682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 19:48:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     evan.quan@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/pm: remove useless if
Date:   Fri, 21 Jan 2022 19:48:00 +0800
Message-Id: <20220121114800.95459-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the following coccicheck warning:

./drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c:7035:2-4: WARNING: possible
condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 23ff0d812e4b..7427c50409d4 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7032,10 +7032,7 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
 	ret = si_resume_smc(adev);
 	if (ret)
 		return ret;
-	ret = si_set_sw_state(adev);
-	if (ret)
-		return ret;
-	return 0;
+	return si_set_sw_state(adev);
 }
 
 static void si_set_vce_clock(struct amdgpu_device *adev,
-- 
2.20.1.7.g153144c

