Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35535837CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiG1EPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1ENT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:13:19 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA49952DE8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bVVbS
        M5uGOf1wQEjz212orLlRtzz2wOPJ7P2wmRhbqc=; b=Kb6nFxQH7BAHPKno+61xE
        i6OFctarBlgLbjpmQIMnQ41xvDdiFeFdjomGEMJK6mteo2A9mVhnjUD0Qndj+pDE
        AP6oBG0QvxhXwBM2VJv3Yrj3JJ7WRqbDxnZfz1lj5WxXvIZSJBlWqlTBv3f+St7m
        0Xwl8FGzIrZoYDezXxe73w=
Received: from localhost.localdomain (unknown [221.222.55.182])
        by smtp4 (Coremail) with SMTP id HNxpCgDnANnHDOJitLtRRQ--.29129S4;
        Thu, 28 Jul 2022 12:13:04 +0800 (CST)
From:   Wentao_Liang <Wentao_Liang_g@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Wentao_Liang <Wentao_Liang_g@163.com>
Subject: [PATCH] drivers:gpu:drm:amd:amdgpu:amdgpu_cs.c:fix a potential use-after-free
Date:   Thu, 28 Jul 2022 20:12:37 +0800
Message-Id: <20220728121237.9201-1-Wentao_Liang_g@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDnANnHDOJitLtRRQ--.29129S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rWFyUur1DKry5Kw4xXrb_yoW8XFWfpF
        4rGw1qkrykZF1aq347AFyvqF90kw1avFyfKr4UCwnI93W5AF95tr1rtrW0gF17CrZ7CF42
        qr9Fq3y3uanFvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpGQDUUUUU=
X-Originating-IP: [221.222.55.182]
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/xtbB0RBML1zICF+cLQAAsQ
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in line 1535, "dma_fence_put(fence);" drop the reference to fence and may
cause fence to be released. However, fence is used subsequently in line
1542 "fence->error". This may result in an use-after-free bug.

It can be fixed by recording fence->error in a variable before dropping
the reference to fence and referencing it after dropping.

The bug has been confirmed by Christian König on 2021-08-16. Now, I
resend this patch with my real name. I hope the patch can be updated
in a near future.

Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b28af04b0c3e..1d675a5838f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1518,7 +1518,7 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 				     struct drm_amdgpu_fence *fences)
 {
 	uint32_t fence_count = wait->in.fence_count;
-	unsigned int i;
+	unsigned int i, error;
 	long r = 1;
 
 	for (i = 0; i < fence_count; i++) {
@@ -1533,14 +1533,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
 		dma_fence_put(fence);
+		error = fence->error;
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
 
-		if (fence->error)
-			return fence->error;
+		if (error)
+			return error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
-- 
2.25.1

