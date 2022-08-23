Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7359D170
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiHWGo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHWGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:44:28 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C66E613DF6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vA5Ae
        AbhZveLwqZvzwPuBdbrG2MlvxHo52QrIh29FRE=; b=VMJYcQr4/atAFWSfxtbY8
        2ZHocm3hno7C6gSY0TqUpBOJxV1L/ItDKJKGHm9DPH9RcYOoP6w5tOWVkyjJbZ7j
        A1tM0WazplM7ge+0g8EKtt79vL7Llon1BFmJ3sj+BdQyzTORZKIERn3dP1UiIg3Q
        Wlzu0Mnl/0NEm7d2mhe1kE=
Received: from CD-PF1FQ4FS.Hygon.cn (unknown [175.152.51.41])
        by smtp8 (Coremail) with SMTP id NORpCgDXqgw4dwRj9dGVAQ--.54535S2;
        Tue, 23 Aug 2022 14:44:10 +0800 (CST)
From:   jinsdb@126.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jinsdb@126.com
Subject: [PATCH] drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly
Date:   Tue, 23 Aug 2022 14:44:06 +0800
Message-Id: <20220823064406.1874-1-jinsdb@126.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDXqgw4dwRj9dGVAQ--.54535S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3AFWDZrWkGF1UtFykGrg_yoWfWrc_AF
        WYq3sY9r47uFn2qryxZr43Wa4jvFn5uF4fWr1UJa4Fyry2q397Xa47urn2qr18uF4fuF13
        u3ZIgry5JasxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZzVj7UUUUU==
X-Originating-IP: [175.152.51.41]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbijBpmDlpEJFGYIwAAsu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Huang <jinsdb@126.com>

The mmVM_L2_CNTL3 register is not assigned an initial value

Signed-off-by: Qu Huang <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 1da2ec692057e..b8a987a032a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -176,6 +176,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);

+	tmp = mmVM_L2_CNTL3_DEFAULT;
 	if (adev->gmc.translate_further) {
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
--
2.31.1

