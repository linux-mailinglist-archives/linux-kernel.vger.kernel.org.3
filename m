Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416AD50F0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiDZGJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbiDZGJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:09:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BA3BA5D;
        Mon, 25 Apr 2022 23:06:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so1593129pjf.3;
        Mon, 25 Apr 2022 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5B5tUFMzlxSfom417st/n+sajnHc/81JexubgBewTM=;
        b=cjBliUXK+67eB8pugmyCFVT+uskSB4P9S6NfwmRLKtKpV320sgmZfMbMu6y7L2hrhX
         Tq42n3Nh7sNiXGMP7qhMCpp5Tq2f3QMOvwqGX1ylKz2PUlPXlBC1aKJBNk2wDVWdUSM2
         AcomuMNPtE6LUcokRmfcPml34/0/zUSK9leDTCrEmya2G+GbZm1VH2WXKlbxJjmXdSFr
         Tsin56ooNLP9z6xQfg7Rll7NeoWaoK5w19ZW742eCNEHYRP4iYE+LCOrO2fEKHbGKhay
         nUzNQVUWhVKDWg4nYY1VFGjuaBcwWNCmhc9h0SPv0voPMI1uACtUqN2sQw3DjrXQ+dkq
         HQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5B5tUFMzlxSfom417st/n+sajnHc/81JexubgBewTM=;
        b=tV3+63nPMGNSP355XvU70B+kkKCS07y2rMEtF7TxlVR+QDyFScNBHyI4UtthHX2ETd
         tqy8+t/ta0YwEaffjWD8To+9i3Zbcxg5KVXXWyh9Xnu2KWUJGd5MWninNFKuH9QlDDU+
         rMZiH4kRKQvIZ/CDOYvdhECsTXRNtcSATWS6kB1PtnVNfTjR+Nh1isSkpRPImevWLh7j
         HgJsZv4+f4r5uvnHfgSD9t+EhlT0aAcLhe5kSxmgZ3QZx3TRicxZdzT+WF7RpTMflrSI
         7/kKvvKRgepmLMJ2+Ah9DxHTeq/z2G3l1cU+VMrvkZ43vnpLUP2oYX5w2Q0rQugJZpe8
         zHEg==
X-Gm-Message-State: AOAM530VO9VamN1g6C62P25HiKt5+wzJsWVmSOS1eItLcPjt0wFs+yUQ
        3dgsEP84YM0SSo1xObFmej88sddCsik=
X-Google-Smtp-Source: ABdhPJz+MZ0gTzEQu/nIvsFW0/mTwW1gJKk1gin2GA6OY5WwKRcuV/LJaHvr0E7vDu+kssRncMF1iQ==
X-Received: by 2002:a17:90a:1946:b0:1d2:d49b:1db with SMTP id 6-20020a17090a194600b001d2d49b01dbmr36098619pjh.30.1650953167967;
        Mon, 25 Apr 2022 23:06:07 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b0050a5867dd73sm13969135pfu.157.2022.04.25.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:06:07 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 1/3] rpmsg: virtio: fix possible double free in rpmsg_probe()
Date:   Tue, 26 Apr 2022 14:05:34 +0800
Message-Id: <20220426060536.15594-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426060536.15594-1-hbh25y@gmail.com>
References: <20220426060536.15594-1-hbh25y@gmail.com>
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

vch will be free in virtio_rpmsg_release_device() when
rpmsg_ns_register_device() fails. There is no need to call kfree() again.

Fix this by changing error path from free_vch to free_ctrldev.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3ede25b1f2e4..0130d0ba548c 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -973,7 +973,8 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 		err = rpmsg_ns_register_device(rpdev_ns);
 		if (err)
-			goto free_vch;
+			/* vch will be free in virtio_rpmsg_release_device() */
+			goto free_ctrldev;
 	}
 
 	/*
@@ -997,8 +998,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_vch:
-	kfree(vch);
 free_ctrldev:
 	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
 free_coherent:
-- 
2.25.1

