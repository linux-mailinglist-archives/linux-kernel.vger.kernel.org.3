Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3F4ED98E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiCaMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiCaMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:23:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780191E8CEE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:21:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so33512905wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
        b=nKe2aqosp4lwdJRB+hSU+XNR1oThOneKPkDihQtBZOlZOnPTzNgUPX5gnckK8WBuv8
         Uznow3jCpIQ+eC00Mp7PiL3JPxLo0Ac1n7NKxoRH0M1Cmr/p/wJvLu1yVR6+ul7hVRMf
         DaneWKHcTokDYM/kXvV8XeXSyY/pv1ZTveGJiHzKKh43CQ6X5cfYFHMvA9uC/mZRb2ZI
         wOcu3kJSypzkGj3vBk0g3itjUTg8b16j9GDRCUNxCE4trfPhhWGV6TbdydwvrDJk7/D7
         8S7yRvp1OAsS36+aro0Od+esCI2yXogAO7lzEPyU/KXEJWB5w6Iq6OsZVPYHf4vNzAmG
         accw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
        b=Ef43HWXRVW7ixETM3SurxUDEIOupAHtmr/UJaJHyUiDLSx2EgwDwYxXq8G6QFxBHMb
         RBI76kGZyR1N6coZBZ+G21HiEXQAF4F57FzoJDuwLiypniIsBzFU6yW8qLWNXKA/yytW
         yT6oUqPCO+xctUhGanACM/J3b+AflJKaFnNgbPK4E74iEVLHwjVyD23IkgWSpttpdxOy
         /0AOEI3TFTR2Dc2YMSIGbQnC3OoNq8bVtupbTBAQebkIfnyo8t0c3k9vD7ljQURIryOf
         SlKd0bhabxXcHBtH5dHGaUI1+FQyNTF+w0tMPBxfd1c33JfvpdhsITq7FDN95rdrsIbd
         586w==
X-Gm-Message-State: AOAM532T9c1ciscg9GhUzTZr1EHADgkqPLqX7JcA975+LAVezk5yifgL
        A+ZiqoZijCo9yuEeqxDPgwgUjA==
X-Google-Smtp-Source: ABdhPJx/hLdsk0FmeDLpZSsSiExlN50kzyaGwP5OBjNfReLULHNPPVA8ar7byZkgveP76YNoaa42hA==
X-Received: by 2002:a05:6000:1a88:b0:204:1f4f:1c2 with SMTP id f8-20020a0560001a8800b002041f4f01c2mr4115718wry.642.1648729283038;
        Thu, 31 Mar 2022 05:21:23 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm21892839wrr.100.2022.03.31.05.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:21:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdkfd: Create file descriptor after client is added to smi_clients list
Date:   Thu, 31 Mar 2022 13:21:17 +0100
Message-Id: <20220331122117.1538913-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures userspace cannot prematurely clean-up the client before
it is fully initialised which has been proven to cause issues in the
past.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

CAVEAT: This patch is completely untested
        I can't seem to find a configuration strategy to compile test this
        allyesconfig and allmodconfig do not appear sufficient

v2: Also remove Client from RCU list in error path

 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 24 +++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index e4beebb1c80a2..f2e1d506ba211 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -247,15 +247,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 		return ret;
 	}
 
-	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
-			       O_RDWR);
-	if (ret < 0) {
-		kfifo_free(&client->fifo);
-		kfree(client);
-		return ret;
-	}
-	*fd = ret;
-
 	init_waitqueue_head(&client->wait_queue);
 	spin_lock_init(&client->lock);
 	client->events = 0;
@@ -265,5 +256,20 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	list_add_rcu(&client->list, &dev->smi_clients);
 	spin_unlock(&dev->smi_lock);
 
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
+			       O_RDWR);
+	if (ret < 0) {
+		spin_lock(&dev->smi_lock);
+		list_del_rcu(&client->list);
+		spin_unlock(&dev->smi_lock);
+
+		synchronize_rcu();
+
+		kfifo_free(&client->fifo);
+		kfree(client);
+		return ret;
+	}
+	*fd = ret;
+
 	return 0;
 }
-- 
2.35.1.1021.g381101b075-goog

