Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D675B1AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIHK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIHK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:56:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CFB4DF31
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:56:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2889mlT9030782;
        Thu, 8 Sep 2022 10:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=lYxAtXx8X/EDiK+zc3gC/WUgjZew/BLsc6IP9dnEjEg=;
 b=ACBJyOBZH4BJLQAofsJnwQAkFOxCtpDrw8++6oGra7GanGm6f4PpDMviYdo9M/LEm9YK
 5IUq57AO2BjolmTjCFf7sqHIJPCWVbSKJ0hALdMkj6eu07AK+BTYXjNGyQf22E5C1kLw
 AEIy/t5lS099PKnZCaSn2GdhuowzN6QBMboeKYee4jz1Pzb8cwOTpUYMFgSg6RCJzpfw
 fHTMXfuK0IQ/QvkBBgY4eMEcTe8BzyF4D3kyJ1N2R8ZXYleWaZt/N16ApqAovucswPtl
 Oq3QBgSFMUsxfYHSDYK7romqcHUlmEwrK4xEPVzassu1M6+CKf3lJofN6dsDup4C0afh rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2kh9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 10:56:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2887jnYj022690;
        Thu, 8 Sep 2022 10:56:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc58723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 10:56:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288Aua4t002410;
        Thu, 8 Sep 2022 10:56:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc5871m-1;
        Thu, 08 Sep 2022 10:56:36 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, dan.carpenter@oracle.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Igor Torrente <igormtorrente@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: fix variable dereferenced before check warning
Date:   Thu,  8 Sep 2022 03:56:23 -0700
Message-Id: <20220908105623.72777-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080039
X-Proofpoint-GUID: WiZDPMydGAJBt39ef98fwTNIvd0sTP6u
X-Proofpoint-ORIG-GUID: WiZDPMydGAJBt39ef98fwTNIvd0sTP6u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:

drivers/gpu/drm/vkms/vkms_plane.c:110 vkms_plane_atomic_update() warn:
 variable dereferenced before check 'fb' (see line 108)

Fix the warning by moving the dereference after the NULL check.

Fixes: 8ba1648567e2 ("drm: vkms: Refactor the plane composer to accept new formats")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index f4319066adcc..c3a845220e10 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -105,11 +105,12 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	struct drm_shadow_plane_state *shadow_plane_state;
 	struct drm_framebuffer *fb = new_state->fb;
 	struct vkms_frame_info *frame_info;
-	u32 fmt = fb->format->format;
+	u32 fmt;
 
 	if (!new_state->crtc || !fb)
 		return;
 
+	fmt = fb->format->format;
 	vkms_plane_state = to_vkms_plane_state(new_state);
 	shadow_plane_state = &vkms_plane_state->base;
 
-- 
2.31.1

