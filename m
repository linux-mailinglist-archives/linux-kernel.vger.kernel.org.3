Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25204D6FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiCLP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiCLP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:28:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9E22452A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:27:19 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22CCRU4i017947;
        Sat, 12 Mar 2022 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=jfbNLTl7GzjDZERVcok4JsMqfBnV6PsTYk/IMnAwoaE=;
 b=cDuPwsZXCiSCo/lxxHmSbRF6Dp6/d7V8odsbTEZhzXkXO6e+NW/gTE7aZsyIq2s8rN9w
 pFNJgvmmr/zovWdsRrFPmTVBJF+EI9WncUDyb3GSUAkhhT42LpOcaoDCIWgof4Frbo4u
 wpuXxmqG6iLVIjrfS+jh8YjPASxrgGQ1L11ZaaDDq3gTOogYr45xaNfLM2T9sRGXIozX
 j9xpJXhS9krgnU47KB8IfJLyC7O+Ed+B7OwZzYDHeBjAXTOUv3ixhIdt8Z2knZjWzMFR
 FlQoNHc6RzOCYro24ZopSfynRR0+1JpYztNgvssPZQJKOj8D8l7RmVFj7bNvgODFzqB5 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erm2t8msv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 15:27:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22CFGgGF134208;
        Sat, 12 Mar 2022 15:27:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3ermyg0vvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 15:27:13 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22CFMxlK142703;
        Sat, 12 Mar 2022 15:27:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by userp3020.oracle.com with ESMTP id 3ermyg0vvt-1;
        Sat, 12 Mar 2022 15:27:13 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, dan.carpenter@oracle.com,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Use kvcalloc
Date:   Sat, 12 Mar 2022 07:26:55 -0800
Message-Id: <20220312152656.51625-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fyYtQ-N5xE1S2b_SZs_EiEHN1pTNQlkW
X-Proofpoint-ORIG-GUID: fyYtQ-N5xE1S2b_SZs_EiEHN1pTNQlkW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvcalloc is same as kvmalloc_array + __GFP_ZERO.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c7ed2e1cbab6..f7d37228461e 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -308,9 +308,8 @@ v3d_lookup_bos(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	job->bo = kvmalloc_array(job->bo_count,
-				 sizeof(struct drm_gem_cma_object *),
-				 GFP_KERNEL | __GFP_ZERO);
+	job->bo = kvcalloc(job->bo_count, sizeof(struct drm_gem_cma_object *),
+			   GFP_KERNEL);
 	if (!job->bo) {
 		DRM_DEBUG("Failed to allocate validated BO pointers\n");
 		return -ENOMEM;
-- 
2.31.1

