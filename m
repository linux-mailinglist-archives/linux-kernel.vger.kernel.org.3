Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861B4EEBBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbiDAKqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbiDAKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:46:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8D11D7622
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:44:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so3233091wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
        b=HbG77bUNR/dvt30m/QBpA8piF/+YlegdM96y584csG/mlvjKNRDO73e08vwf0mqs9n
         nXnZO86NQN6IEdJUFwjoCwe4W9FKSFBlFS3rNuGS5UI7HdZLDEONcfRBb1S0Ycl6X0Rj
         ELHtUZPosAVZA0mvitGwH+DXujQ7nVIrLRhaqKsUtxS8C0OFE9vDZh3Eyy+goa737RHn
         zoICzA1/MRKtc/kaKv2glP9OBJkr5rzrnbNpnFzp1Z4Ot2g5NqVtFfeVaaZn/frg0ZNF
         Jq8BdhOuh2oHZaadmdvbJkWWFMDi3aSlPqgbSH5spLmvSjUFi+SR+xfQSbgBTA8Bvign
         vBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0bQwq9+fWC4pQuN+D8QOE/ntondfVbGkexQoq1N7Yk=;
        b=VFFR2HpNLFsR1/8hT9R7HpjlVzSJOxy4MAVkhFQg+9v68HNeBjw1qGItr/k6PFatAT
         8MEss6JFSKaN2iOxQGRcS8AkSTiQ5e1Jz6aPjpfqkmyQdK4k+jCY5F9L12If8tM79wax
         WQIaY+qFaBZqRVfnvZs+q8k/KQqyWugpXw4TIchKdUwQs8E2C43kIRXODVvoFLrM5iS0
         8XBDNZPWOTyVNhIdA253fpGf7wIJ8um90V/c+b10iRolw9QZvM/NmBhk/bh3MX9kcJFr
         S2G83UVYln23TljhWFEqsz2OyckAdeSsgK/T/uMSeEyZ2Inw4LbWj8/QQ9ARqjPHH2if
         Cd0g==
X-Gm-Message-State: AOAM533j4NeBXwNGlmNdgJvhAKARtLq6tUuFmcnPU72OiYvSf5KWh6Fe
        VzexMxAr5+El9t9jFo5UNdvvbQ==
X-Google-Smtp-Source: ABdhPJx8Wu9Z1HK4Wwe+PIh9B9xFttlHndKGTBwTa4mqUPx4URFuOJdiob/TNuqFx43bLuwIbSzF2Q==
X-Received: by 2002:a05:600c:1548:b0:38c:ef05:4cdd with SMTP id f8-20020a05600c154800b0038cef054cddmr8360497wmg.71.1648809895471;
        Fri, 01 Apr 2022 03:44:55 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm1538956wmq.36.2022.04.01.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:44:54 -0700 (PDT)
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
Date:   Fri,  1 Apr 2022 11:44:51 +0100
Message-Id: <20220401104451.1951544-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
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

