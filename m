Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D2567025
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiGEOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiGEOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:21 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031C820F6A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=InYC8
        SXGCUr2SbxJw+eNF1Llgvx8IFbTt02Np0AXcRM=; b=hYQrstqfPF4JRb4R0SFN8
        jS4VvImduc1Bo97gYtxIVti+8UltclstQHX0Gp5Hm6UuV58UrUdCmyPgWCMQPWug
        TJ5JrkjCFm5Qv1nVjSarCp7sudfiw4UEnmiGYs+wtf7jLMgsLsOShN1Lz60V9RHL
        xCIUi4iG0anD41SCDaNDCw=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp1 (Coremail) with SMTP id GdxpCgA3TqGcQMRiNFCtMg--.33524S4;
        Tue, 05 Jul 2022 21:46:11 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Jack.Xiao@amd.com, Hawking.Zhang@amd.com, mukul.joshi@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] drm/amdgpu/mes: Fix an error handling path in amdgpu_mes_self_test()
Date:   Tue,  5 Jul 2022 21:46:03 +0800
Message-Id: <20220705134603.2248455-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3TqGcQMRiNFCtMg--.33524S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DKr1UKw47Kr1kWFWDCFg_yoW8JF4xpF
        yfJFsrtry8ZF4jya4UCa4UZas8tw1xX3WUKF4F934S93s8KF98Gwn5tF1xAa4DKFZ8uFZx
        Jr97X34xZF1q9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRIPfLUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFQM1jF5mLp8E1AAAs2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if amdgpu_mes_ctx_alloc_meta_data() fails, we should call amdgpu_vm_fini()
to handle amdgpu_vm_init().

Add a new lable before amdgpu_vm_init() and goto this lable when
amdgpu_mes_ctx_alloc_meta_data() fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 69a70a0aaed9..7c196b8ac49f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1157,7 +1157,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	r = amdgpu_mes_ctx_alloc_meta_data(adev, &ctx_data);
 	if (r) {
 		DRM_ERROR("failed to alloc ctx meta data\n");
-		goto error_pasid;
+		goto error_fini;
 	}
 
 	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
@@ -1215,6 +1215,8 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	BUG_ON(amdgpu_bo_reserve(ctx_data.meta_data_obj, true));
 	amdgpu_vm_bo_del(adev, ctx_data.meta_data_va);
 	amdgpu_bo_unreserve(ctx_data.meta_data_obj);
+
+error_fini:
 	amdgpu_vm_fini(adev, vm);
 
 error_pasid:
-- 
2.25.1

