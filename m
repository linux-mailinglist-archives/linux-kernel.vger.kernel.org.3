Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4927F585857
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiG3Dte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiG3Dtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:49:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE316743C1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:49:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so8186176pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r+qywY7kA8NvmShf93wAGS9Ca1t7b/va4t24ai1ehT8=;
        b=UDfKysp5lzZLUsS6TLfawDoxrvAJHSrRbbd+WNAV1yd1P5Qz0LIH1Yky4tygHDXfCL
         ehuKX/ILB2P33EgRpn6G3rmDRZ7CR2nn7PXWm1XHK+CheH8ezNZ4Be7+cCsepJhNy4kE
         TPk1C40Wfl5ZRlerYdsxPlaT4NbHrmaXlK19UyZBqjvJjwjB8JkiMzo7Nj1swKj2Pl9y
         AKi6LM4cHuD9b/HtvpD3MAEu3wwmnKomq3EPnaEI6h4XNTVY4xTmrG9HSpZePE+U9rTE
         n325lXzL+z5wlT8qJLspovrsZ0jOtB/m/Vtq1KO5+YmZS/nwSAVgfWPpMGaNRJrcbk1d
         T04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r+qywY7kA8NvmShf93wAGS9Ca1t7b/va4t24ai1ehT8=;
        b=1sUXn3+piUgodBwf/yJYtfvr6A9ldkmesUjm1hqCi30cxnZbmIhrxUUrzlJ4gLcb3P
         DI8LtYrFg7oUi5bb9SeH4TNo9P/xM/VUQNFCodcd4SviCTaxFEZqCANQjKooHVIxYD62
         TDUsAR+57ZQNefNVYuIkY+XkpfdAZ0HFy5pcFzFT4XnhcpG6qe4PFix0LODh1VXmtpCT
         Bs92O3aBEU9lvxZEPPOTesSbLrl/wbB+L9pKDM5DfXIHKc2aDk9CpAL8EZfyqxUXl+hM
         lv22fu6OE3cU36YUXF1LamiL+epCxKcYsr8PLxeZLAu5Kxvfb2pZzlpVYtQXTfW3qlFU
         okaQ==
X-Gm-Message-State: ACgBeo2sfTHm/2380UcOUcRYv0iqrGVSTa9IfUjaa8ES6u9w/9zMUTrH
        qwgQL5TR1SkQbNqOK+rI/sQ=
X-Google-Smtp-Source: AA6agR5uP0KjleeQ3OK0KIGRTTGFjlItDsxKI5u+6bkvdhYY/TyovEbYNU2MNFjSDEaQNVCll+T2Ow==
X-Received: by 2002:a17:90b:4a0d:b0:1f0:3400:52df with SMTP id kk13-20020a17090b4a0d00b001f0340052dfmr7554091pjb.154.1659152970292;
        Fri, 29 Jul 2022 20:49:30 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.183.83.122])
        by smtp.gmail.com with ESMTPSA id 21-20020a621715000000b0052d194a65fesm192613pfx.63.2022.07.29.20.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 20:49:29 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Evan Quan <evan.quan@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 -next] drm/amdgpu: double free error and freeing uninitialized null pointer
Date:   Sat, 30 Jul 2022 09:16:58 +0530
Message-Id: <20220730034923.25500-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a double free and an uninitialized pointer read error. Both tmp and
new are pointing at same address and both are freed which leads to
double free. Adding a check to verify if new and tmp are free in the
error_free label fixes the double free issue. new is not initialized to
null which also leads to a free on an uninitialized pointer.

Suggested by: S. Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
Changes in v2:
Updated patch body as suggested by André Almeida <andrealmeid@igalia.com>
Reworked to implement a check in error_free for fixing double free error
as suggested by S. Amaranath <Amaranath.Somalapuram@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e2eec985adb3..cb00c7d6f50b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1705,7 +1705,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *new, *tmp = NULL;
+	uint32_t *new = NULL, *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1747,7 +1747,8 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	ret = size;
 
 error_free:
-	kfree(tmp);
+	if (tmp != new)
+		kfree(tmp);
 	kfree(new);
 	return ret;
 }
-- 
2.34.1

