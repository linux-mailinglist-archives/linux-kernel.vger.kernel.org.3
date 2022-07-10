Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379AA56CF49
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGJN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 09:29:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678412D34
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 06:29:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s21so2759353pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6SGihpgssqPHGXdvCDtBHTLs4yyN/NsGv3mxWPlRX8=;
        b=pQtD+Lij3g3SFoJvtPr7sSdNnU+dLwPU9a28z4D2JKBXyQ1B6MgfM3s87Fy49b2LvC
         j6HpnS6zFsIXVLek0tnupD7yRwdUGLLlATDaCzkH7Jhjao+AnI4tefB7vr2W5CcBuSva
         SSbjgMVAI44C/PS0LOoiFAQjUom5BDUOzLSIacI90siXQK0gOlYdGsQQbAcXcoJGG16b
         qiDbtb5gmH2iTN19c8Kf14bZHBHmppxz1qMfOHV7qKiJZmNCLHqmZak6Dpv7Y2LLLIC2
         YUCr1oppifk3i14zaD3MMDIqF91Y4Spx/TpjSj1UWjlTT8DhgkBgGbmZjY5jmA8TUBxb
         87lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6SGihpgssqPHGXdvCDtBHTLs4yyN/NsGv3mxWPlRX8=;
        b=dYNW9xOdIIn+67hFKqJbTk7wmpiTsjWRITMajttX3wfTeQG9O/v42eOvquGf49nUFv
         +A1XqJ3XTAR0B6MdkesTY0uBKo+zDLbliroa1WXJap7v38ojcpcLxranivAx0B3Np/xS
         TI5QIrIU09Ph5xvGyst4C7kAJPZHc9ybRdif9CfRCoSW8InW1Wsk59Vhy0ZySwIUgNG/
         ws6PPZVBCrnpBpI9OJRKRbLYIR2I1vouUy9Fz2HSfszhgt0umKglcuf5+TYni3ylvk5C
         krbwnuR7/J4gMgV/4i4e1w8bCVr1D5zhhVS56qYub3nhmhzzXola3ejih9yCneaIkjuf
         0uVA==
X-Gm-Message-State: AJIora+enoMizgyQ0AFukbSZC4rCLiM1bPIIDU7+yGUJ5Bcepk1J+4Fu
        gF0zeSU/nb72AC/vBimMcc0=
X-Google-Smtp-Source: AGRyM1sE31F8lmvr17IXEq3f/W4RJBFKDGkjunlunig4JtKWK/IHOifRAFTviUvqXTlmAOrvEb+TzQ==
X-Received: by 2002:a17:90b:2341:b0:1ef:819f:dfc4 with SMTP id ms1-20020a17090b234100b001ef819fdfc4mr11413503pjb.206.1657459769622;
        Sun, 10 Jul 2022 06:29:29 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.160.233.217])
        by smtp.gmail.com with ESMTPSA id g14-20020aa796ae000000b0052536c695c0sm3001586pfk.170.2022.07.10.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 06:29:29 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     Sebin Sebastian <mailmesebin00@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] drm/amdgpu: double free error and freeing uninitialized null pointer
Date:   Sun, 10 Jul 2022 18:59:09 +0530
Message-Id: <20220710132911.399325-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two coverity warning's double free and and an uninitialized pointer
read. Both tmp and new are pointing at same address and both are freed
which leads to double free. Freeing tmp in the condition after new is
assigned with new address fixes the double free issue. new is not
initialized to null which also leads to a free on an uninitialized
pointer.
Coverity issue: 1518665 (uninitialized pointer read)
		1518679 (double free)

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f3b3c688e4e7..d82fe0e1b06b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1660,7 +1660,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *new, *tmp = NULL;
+	uint32_t *new = NULL, *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1692,17 +1692,19 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		goto error_free;
 	}
 	ret = down_write_killable(&adev->reset_domain->sem);
-	if (ret)
+	if (ret) {
+		kfree(tmp);
 		goto error_free;
+	}
 
 	swap(adev->reset_dump_reg_list, tmp);
 	swap(adev->reset_dump_reg_value, new);
 	adev->num_regs = i;
 	up_write(&adev->reset_domain->sem);
+	kfree(tmp);
 	ret = size;
 
 error_free:
-	kfree(tmp);
 	kfree(new);
 	return ret;
 }
-- 
2.34.1

