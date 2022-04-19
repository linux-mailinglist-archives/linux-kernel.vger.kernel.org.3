Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31E506B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiDSL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiDSL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:58:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC21CB01
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:56:17 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjMbW1YtLzCqwN;
        Tue, 19 Apr 2022 19:51:51 +0800 (CST)
Received: from container.huawei.com (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:56:15 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: of: fix a potential double put bug
Date:   Tue, 19 Apr 2022 20:14:08 +0800
Message-ID: <20220419121408.1291270-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execute the following coccinelle rule:
$make coccicheck COCCI=scripts/coccinelle/iterators/device_node_continue.cocci

Get an error report as following:
./drivers/gpu/drm/drm_of.c:292:2-13: ERROR: probable double put.

Device node iterators put the previous value of the index variable,
when find_panel_or_bridge() return non-zero, it will causes a double put.

Fixes: 67bae5f28c89 ("drm: of: Properly try all possible cases for bridge/panel detection")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/gpu/drm/drm_of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index f4df344509a8..8c3c0bca1af1 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -289,11 +289,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 			continue;
 
 		ret = find_panel_or_bridge(node, panel, bridge);
-		of_node_put(node);
 
 		/* Stop at the first found occurrence. */
-		if (!ret)
+		if (!ret) {
+			of_node_put(node);
 			return 0;
+		}
 	}
 
 	return -EPROBE_DEFER;
-- 
2.25.1

