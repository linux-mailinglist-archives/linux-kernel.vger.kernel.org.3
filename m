Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C631B504E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiDRJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiDRJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:34:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C62B16584;
        Mon, 18 Apr 2022 02:32:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j8so11889270pll.11;
        Mon, 18 Apr 2022 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+195qXfSy+1LA8x1YeekJMgKTeLBXHFiPCdorrFsSmY=;
        b=S9FLinlvmsTUmvcYZaE7lS7URLC2fH5qKRsJon4tQiByLM3ozGazHdR3F0jvWoydk0
         nAIJYiDx1gIGlDo5PCpi2xcrRJLbZmXcX4sGla33my0scO4CEtBeBGLePzrQHHfS29hV
         ClkpBLQs1/Xojb9qki1paTANFxUjXTR75c1fbi2WMDdyeTdMeP3OMkGeUNkf1KQAFcVP
         HrJ5eTHgVB66cDGy1jLVma0vH/gst3kHDfgURyYJPXHL6TZO6mTk6KGELvbsiyhzppKU
         q+gMG/2RAp3JTRGZnxO8YUf343t2eGwflhIhgjS9yH7gDP/Pac6SbZIVXTKzra+S3ziH
         8V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+195qXfSy+1LA8x1YeekJMgKTeLBXHFiPCdorrFsSmY=;
        b=7KJZ/HdCxL4098z812Xa+cm5fpNu/qQd6dcQSnc9SWLckcGrA5uEH9r+OWiFTML8+4
         ubOpWbil5C4KVicmDQIv0/bM2Wh4uHGaACgwGNrl78WPNRhuBpNbCLcYkUgmAG5uuLrX
         KSLbtZlduOFmgVpP3z2Rbq+2ZeWA838hm20k8rTe5s0TJSCR5IMoP0cZOcCASRL5c+We
         MbYD5q8XTOqpUc2l/4fry2xC9V60PMGInZGuYncGOQTCxNQGHR2WgNBKwb8cD6Hhy2sP
         TkLD2raNzxh0gMFV0jtCTd+DVhPHQG4cRaA0eBTou3H1WChdPQsOSU7OLJyfeJfmbmpP
         UcYg==
X-Gm-Message-State: AOAM530aZ7d7GzDZ7V7YKwsaWeNt+mElUnWbyx53r2q2jxniZ17aoAd+
        bVhWzlOyMSkAb3+6EDU2vQaxp8c9rwlJ/gHu
X-Google-Smtp-Source: ABdhPJzCixskcytuhybhqhKIDydM/sMYkjYkUpG1m+SYtDGyds0EnaOyrYt48WDhneAImCbqp/a5ag==
X-Received: by 2002:a17:90a:550e:b0:1cd:e722:8b82 with SMTP id b14-20020a17090a550e00b001cde7228b82mr17392126pji.223.1650274323848;
        Mon, 18 Apr 2022 02:32:03 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm12472393pfu.76.2022.04.18.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:32:03 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] rpmsg: virtio: fix possible double free in rpmsg_probe()
Date:   Mon, 18 Apr 2022 17:31:44 +0800
Message-Id: <20220418093144.40859-1-hbh25y@gmail.com>
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

vch will be free in virtio_rpmsg_release_device() when
rpmsg_ns_register_device() fails. There is no need to call kfree() again.

Fix this by changing error path from free_vch to free_ctrldev.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3ede25b1f2e4..603233f0686e 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -973,7 +973,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 		err = rpmsg_ns_register_device(rpdev_ns);
 		if (err)
-			goto free_vch;
+			goto free_ctrldev;
 	}
 
 	/*
@@ -997,8 +997,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_vch:
-	kfree(vch);
 free_ctrldev:
 	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
 free_coherent:
-- 
2.25.1

