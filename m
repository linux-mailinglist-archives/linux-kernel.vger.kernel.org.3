Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0578453F451
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiFGDKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiFGDJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:09:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741EB0D3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:09:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHFgR1HRlzhYyt;
        Tue,  7 Jun 2022 11:08:51 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 11:09:47 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 11:09:47 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Wang Weiyang" <wangweiyang2@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [PATCH] drm/atomic: fix warning of unused variable
Date:   Tue, 7 Jun 2022 19:08:48 +0800
Message-ID: <20220607110848.941486-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the `unused-but-set-variable` warning as how other iteration
wrappers do.

Link: https://lore.kernel.org/all/202206071049.pofHsRih-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 include/drm/drm_atomic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 0777725085df..10b1990bc1f6 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1022,6 +1022,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	for ((__i) = 0; \
 	     (__i) < (__state)->num_private_objs && \
 		     ((obj) = (__state)->private_objs[__i].ptr, \
+		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
 		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
 	     (__i)++)
 
-- 
2.25.1

