Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C74ACF86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiBHDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBHDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:17:10 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 19:17:08 PST
Received: from qq.com (smtpbg410.qq.com [113.96.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2DBC061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:17:08 -0800 (PST)
X-QQ-mid: bizesmtp5t1644290101twk3qzvo1
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Feb 2022 11:14:55 +0800 (CST)
X-QQ-SSF: 01400000002000B0G000B00A0000000
X-QQ-FEAT: JykYnMR+PRaregM+pIQhKrCVgehtTaXMsvfTUbZBq8GKqCGcWGTTX7/H02IY0
        Xny1+TYdI5N9onp89RFeBj7W2HlImuB/4IoErmVjLgtrwJTgNKSxyDNihuFgEpKWpzbv5bR
        Vxub8i3/Evxpe50Kb/Q7g+dtHYPsPiD+HDeuEAAVA8FeczBi+gziHPKcub94J8vSQvwEeQm
        i819Rfxt1S+Sv1tgFKqD/ry5UP8pRPJrWdzQUU4BGQpb/5ipMlZTZOs53G2sSTW6+P4Pb4X
        TNcJv7LkJcpk8xR/UdoWvUKJ0vJ7ABvV/M8t4c+ykCKXr+rRmoy8hD7LhmC3f6gV/7yBD4g
        FdjG1sx
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH v2 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date:   Tue,  8 Feb 2022 11:14:54 +0800
Message-Id: <20220208031454.24232-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after the buffer object is successfully mapped, call radeon_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..0558d928d98d 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -497,6 +497,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	handle = msg[2];

 	if (handle == 0) {
+		radeon_bo_kunmap(bo);
 		DRM_ERROR("Invalid UVD handle!\n");
 		return -EINVAL;
 	}
@@ -559,12 +560,10 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 		return 0;

 	default:
-
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
-		return -EINVAL;
 	}

-	BUG();
+	radeon_bo_kunmap(bo);
 	return -EINVAL;
 }

--
2.20.1



