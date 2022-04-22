Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D850ADA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443300AbiDVCPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDVCPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:15:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCF4B1C0;
        Thu, 21 Apr 2022 19:12:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d14so4635790qtw.5;
        Thu, 21 Apr 2022 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm+mwceUxcKf/fZ1vVM8wv5jCau21BJLiGeCoTMm/Gk=;
        b=qdAGwVf7vPb+pu5ZRN/hGrqoktVvGuCfK4ZouJOkeu0qaRNunRm2B60t+w3LLHTc1U
         Yb3u3gaZ+3gqwzKDP8/dtHxyjeqxj5BmE77X8isv2rukBTogkKrpjMxH8cJwRxMLnI2k
         XK4LUFC2yb87bGmEsIQBeMAC04WG3lrlGYQptQstHIzqSOPp4I3RB691Ays5ccpo7xVx
         RpErQlumgDh2mAKQ/tsxZCeVr4PlRvNc+/n3Kr92sgnwIQcvGGz97nAZmRt+p4x7D9aB
         QQeSavZ0wUq0Evo3eLkTHii/dQvx1O/bf3jUFKPvzFfzgjbxtwhUDSRCdRRWjKBJlWz1
         o2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm+mwceUxcKf/fZ1vVM8wv5jCau21BJLiGeCoTMm/Gk=;
        b=RHk+hK1Fb6YMMCcpaQ0Hm6idldvAb9wOtdGH1BblQIQs9/wCo6UdsnOgymluSZHHTw
         53i+ja8+fbgYsvuONi52rjDiplu9wm8DN7bs3t4g17Irbo9dCZRVmRNvzCL5NUpItFcS
         hfOLwlOa2YOD4VHM0MmybLsc8e2p4d3YunR2I3fn/grNo32FDET51VP8ahyAwfZyYN30
         G/MBfHVHp9w8qR8xRbSTUL1+z3+sDy+zgmQdR0LNYKRl1NAtNVTZRPbeOLd9mqPq0S8a
         30X72J3e0jzWDxVkS82D+Ng+EB1dKzbgPiVgtzvW9NKUP/7xiqCs18OJ2AOVsJ3MKugm
         9RFw==
X-Gm-Message-State: AOAM530LU2G1RgnanhZ3XsKmXgO93jNW+04gY1mTOhlAW5G/Zd6nQxcY
        rm7kFA1/gFTG6aEIqLaPjco=
X-Google-Smtp-Source: ABdhPJxojN7D2vVmc8j3S5pj/VvsuFm2OYk8PC6gVi9pubbqqkuPKYNYUtrYtazOWPHVY8cYEdTQTQ==
X-Received: by 2002:a05:622a:144e:b0:2f3:4da8:6a77 with SMTP id v14-20020a05622a144e00b002f34da86a77mr1686232qtx.574.1650593578153;
        Thu, 21 Apr 2022 19:12:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 67-20020a370b46000000b0069ed3db4b8bsm330814qkl.89.2022.04.21.19.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:12:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     hverkuil-cisco@xs4all.nl
Cc:     cgel.zte@gmail.com, eagle.zhou@nxp.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        lv.ruyi@zte.com.cn, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] media: amphion: no need to check return value of debugfs_create functions
Date:   Fri, 22 Apr 2022 02:12:46 +0000
Message-Id: <20220422021246.2731824-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

When calling debugfs functions, there is no need to ever check the
return value. The function can work or not, but the code logic should
never do something different based on this.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: remove all the debugfs checks
---
 drivers/media/platform/amphion/vpu_dbg.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 376196bea178..da62bd718fb8 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -413,10 +413,6 @@ int vpu_inst_create_dbgfs_file(struct vpu_inst *inst)
 					    vpu->debugfs,
 					    inst,
 					    &vpu_dbg_inst_fops);
-	if (!inst->debugfs) {
-		dev_err(inst->dev, "vpu create debugfs %s fail\n", name);
-		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -451,10 +447,6 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
 						    vpu->debugfs,
 						    core,
 						    &vpu_dbg_core_fops);
-		if (!core->debugfs) {
-			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
-			return -EINVAL;
-		}
 	}
 	if (!core->debugfs_fwlog) {
 		scnprintf(name, sizeof(name), "fwlog.%d", core->id);
@@ -463,10 +455,6 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
 							  vpu->debugfs,
 							  core,
 							  &vpu_dbg_fwlog_fops);
-		if (!core->debugfs_fwlog) {
-			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
-			return -EINVAL;
-		}
 	}
 
 	return 0;
-- 
2.25.1

