Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E124EBC25
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiC3HyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiC3Hxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:53:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8022183F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:51:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so27974455wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6A0P5Nugt3q0KDLO33UJFcQEQx63LX/0cNUolmrKWM=;
        b=V16MaX+hkN/U1Y39xaECqqNIGuGZn7Y8hPlKTULdPk5qbq8anVYXQfHLRMtoe1Ig4W
         Sfd9WfI81jqiAeEtYcjI3kq1h+xMrU+O962hOtF5wLxBZEbUplHfPcBRr7uInR1VP9y/
         vmIvR7iBpaVxm1QUh9I1DP/61+Rhw27+n56Y5uUCXPNRcpSdnFxtjCkkaOuK4/JaStkT
         /ubjCpgaQlbFjnc7q1EtTVNvWkQWBAIJhpwAGuE1GIEGXCVXsvyf52ldTRLZR64dq7zG
         bgfrrho0pUtuloTOPd/nwjX/hw2HDqccsiayW8zaeySMZv2hrMSTybaa3I5hxTbB/B7j
         bkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6A0P5Nugt3q0KDLO33UJFcQEQx63LX/0cNUolmrKWM=;
        b=TLSj4l6rv3MDLIoK8bIYnUkIfn/EDjkecxtTtyESnFor6Yhl7AAdQuW6z3el/70XRN
         NsJ0qTcasFEBkxs5UV5S/bvGlFZHERhU2GvbwdSJbj965vl5ndzsas2Z55x+jptvOl9N
         iuIdaVG9/NBzbMJ+GMXq6Tqk6OC96VfHt2Jq732zF2MiMs/MGvWn8lY16KDD7+R5pHYn
         2pvLCESDBSVK7ABrwxsdg2lJAsPT7WSxI3aUF6b+M81cYI2OWn+OQcpw/yDdmVlSnZs4
         N7vgQ6nqLavqQu4iQvLYmEQIUUIIfWTmxr3g+SlMB8w4WVUzEeWwkRPaYO5QNinHRHhX
         eEvw==
X-Gm-Message-State: AOAM5327b6nm28FP96YtoZ7ylJp9t3L9K73pmRHrs7jlYHFnaSG+ceal
        3zG1BAqrVSjoumQzHjhjJy5xqQ==
X-Google-Smtp-Source: ABdhPJxVO1y8gkkfGyd8mfh/5laRpzQ0HsRKTWtp+wjJsFvotvbjrSiCHWCtvhWYEIWbz9CGdaq9Tw==
X-Received: by 2002:a5d:64a3:0:b0:203:d7e5:67ff with SMTP id m3-20020a5d64a3000000b00203d7e567ffmr35060091wrp.617.1648626711521;
        Wed, 30 Mar 2022 00:51:51 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm16447335wru.75.2022.03.30.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 00:51:51 -0700 (PDT)
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
Subject: [PATCH 1/1] drm/amdkfd: Create file descriptor after client is added to smi_clients list
Date:   Wed, 30 Mar 2022 08:51:15 +0100
Message-Id: <20220330075115.426035-1-lee.jones@linaro.org>
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index e4beebb1c80a2..c5d5398d45cbf 100644
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
@@ -265,5 +256,14 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	list_add_rcu(&client->list, &dev->smi_clients);
 	spin_unlock(&dev->smi_lock);
 
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
+			       O_RDWR);
+	if (ret < 0) {
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

