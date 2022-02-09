Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EA4AE6B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiBICkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiBIBjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:39:48 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D05C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:39:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V3yNqjc_1644370781;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3yNqjc_1644370781)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 09:39:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, Felix.Kuehling@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdkfd: Fix NULL but dereferenced coccicheck error
Date:   Wed,  9 Feb 2022 09:39:40 +0800
Message-Id: <20220209013940.71348-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:2087:27-38: ERROR: bo_buckets
is NULL but dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 64e3b4e3a712..636391c61caf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1982,10 +1982,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	void *mem;
 
 	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
-	if (!bo_buckets) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!bo_buckets)
+		return -ENOMEM;
 
 	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
-- 
2.20.1.7.g153144c

