Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7955061BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiDSBlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiDSBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:40:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44C2317D;
        Mon, 18 Apr 2022 18:38:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c1so12463401qkf.13;
        Mon, 18 Apr 2022 18:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+wycLbtOGXfx3rrJ8YJAcjSMtOkWcA7L4SAeEXTlpk=;
        b=KuHwDA8ZkRKEWblQ0FoA9kY8ZMJKY/Tyfsk1CHA3Y5cMY7z0WM64lb+55tASiqvSDc
         C2M8Z31xHCidij1WbgEo3ClbIPCkkPj8waHFaS1EdCU78mL/C8Xg1hfBOazNdCJF5eKQ
         qNQxqR0pLOUbxtuw3z7LtkOzG0vrmX6PLvuLp6rkBYNuWuYs/bgJAfsHXGwCrgEUbNgV
         TRPt8on0LUafnwEQ7YN7UT/5mcrTw/rdkxQI8wwWXvy/N9d4aKo4h3Ja+vEDQ8Lsd78u
         9tVU7tkXberW0tv9bL99VSW6wlsbCmMc0beg9gth7dkmT7560rKThghxpBdm0EbQTsL6
         rGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+wycLbtOGXfx3rrJ8YJAcjSMtOkWcA7L4SAeEXTlpk=;
        b=GczMJlWh30hNJFjzotQYaat2vvXXd3dQxoCC+yRz5q11hoiBGMwEOybLv2YWlVYBJP
         TB4e15GlMRwDeQuHQjBnK2pYWhuQLRhZmUhcFaN/sWyyh0Kk/yqGtP8VVgrO6y+vS7Q4
         t92ijovEiA3Wx8Ih+6j6Q3Xm3vVAG3e/myncOQzlGh/YDWQ1S1UElGzYWD1Mq7V+jtQF
         cXoEC2W71r3MW5Z+iRIGn48WdGfjekTrEeHQ8nwl6IL8RdS2lOZkO0M39/CL17hje66M
         p5bgArs42oT5KWcpn8Lxqvu2hLbrZZL7WZhJ+q4MaxnhTWpirna0De/hYI+/CtA8NwQE
         GJow==
X-Gm-Message-State: AOAM532WspcBHTo0irZsJQRAwJ6UlEy23H0i2snjMG3NnEsyAZcu6e8G
        oPC5DvaX0aJgarJNBdDX8IA=
X-Google-Smtp-Source: ABdhPJx1J+AjddBh73DZ2JT0UHDYN70XKTlC1pvcUhbKxwhfHiatwNYFN8O2a9prNZDLiqVhR+wMBQ==
X-Received: by 2002:a37:aad5:0:b0:69e:a0ba:ffa3 with SMTP id t204-20020a37aad5000000b0069ea0baffa3mr4295285qke.317.1650332296428;
        Mon, 18 Apr 2022 18:38:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 12-20020a37080c000000b0069ea5b5e1d2sm1904157qki.83.2022.04.18.18.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:38:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] media: amphion: fix error check return value of debugfs_create_file()
Date:   Tue, 19 Apr 2022 01:38:09 +0000
Message-Id: <20220419013809.2561635-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If an error occurs, debugfs_create_file() will return ERR_PTR(-ERROR),
so use IS_ERR() to check it.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/media/platform/amphion/vpu_dbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 376196bea178..5cef1fd41a74 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -413,7 +413,7 @@ int vpu_inst_create_dbgfs_file(struct vpu_inst *inst)
 					    vpu->debugfs,
 					    inst,
 					    &vpu_dbg_inst_fops);
-	if (!inst->debugfs) {
+	if (IS_ERR(inst->debugfs)) {
 		dev_err(inst->dev, "vpu create debugfs %s fail\n", name);
 		return -EINVAL;
 	}
@@ -451,7 +451,7 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
 						    vpu->debugfs,
 						    core,
 						    &vpu_dbg_core_fops);
-		if (!core->debugfs) {
+		if (IS_ERR(core->debugfs)) {
 			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
 			return -EINVAL;
 		}
@@ -463,7 +463,7 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
 							  vpu->debugfs,
 							  core,
 							  &vpu_dbg_fwlog_fops);
-		if (!core->debugfs_fwlog) {
+		if (IS_ERR(core->debugfs_fwlog)) {
 			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
 			return -EINVAL;
 		}
-- 
2.25.1


