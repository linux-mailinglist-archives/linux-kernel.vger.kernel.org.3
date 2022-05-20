Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661252F2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352767AbiETSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352715AbiETSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200C17CE74;
        Fri, 20 May 2022 11:34:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so11478247wrb.11;
        Fri, 20 May 2022 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlapgyOF88xrJLl2wtICNi6HO+gUokT48PIEhhY3NfY=;
        b=JM2Wnbp9SfIpxNvAGnQrmPhgkPsKZ+3+Y6eNoCYiVB4VZoqFIQ1J98FmTwWFoceoGI
         Pf87wVBPexMFtr/ikVADo2rzwK6ldy9TPvC7HvahlDO0LNvMOporm1HwmWBnfJ8x4CEq
         5UqzpQlz6TDu4jT1lZcrEtZ6L8CA3hv+nfeBCLnRixpUiKIjVae5VzAmHxJ2GUIapoeo
         mrddCAafl3YzIrtLN1S7DiZ5HDklozaAOHgnW68tCXwDvmRKqoMwzW2BvB5zpc26JFjp
         pJ0BIPAkaBExr+d7TiveQ901Ssl+grOCApXtWjreKFfTPMfXZjF0qIZLFqVPAbWnzGKW
         CWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlapgyOF88xrJLl2wtICNi6HO+gUokT48PIEhhY3NfY=;
        b=D9rje75Ye4H9iwtH+At4Ghin/8pfzRHYms32+uSpPgdO+9p6PeYiBQxLY+vaAxXVwX
         FOYh0k9a3cQxhoShWlpYE8dOUjFjPg9AsdgW6xPk0j8CYyofuIcQinSzokoYwSvEdzMm
         mfW4pB47Wko2ufebNI9+W5IFVYA8LQKDMDDoZfMV7aqmCL7To8N2osiCIfSjZWjrXxCr
         8Xd21bmpptDhK0bdkv35Pd01QbXf/3JRtZI+wUdctgWnxVTadba9IHIPUOxxNhY0llUf
         tqQdvojPHSPipMVbs3QU0nUMBRygyFKILsafaZ/+pqemgfiNwsWBq5lGB/kLaETLLMY9
         CRkg==
X-Gm-Message-State: AOAM531N41VSqhb7p57/3KX7yqlxKuXpS36yQm2MQlRXE1JN1AtFNlfp
        bYj6RP5kFA2d6MiOu9NSjjE=
X-Google-Smtp-Source: ABdhPJwB2ERMu6onf9McvHGWGg5viiQmRedJNKDMhBHw99haLFVoXVyHNqdTnj8pERmfSYPEGWoYNA==
X-Received: by 2002:adf:dbce:0:b0:20c:f507:8ef9 with SMTP id e14-20020adfdbce000000b0020cf5078ef9mr9417713wrj.29.1653071684093;
        Fri, 20 May 2022 11:34:44 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:43 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] platform/surface: aggregator_registry: Use client device wrappers for notifier registration
Date:   Fri, 20 May 2022 20:34:15 +0200
Message-Id: <20220520183422.7185-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

Use newly introduced client device wrapper functions for notifier
registration and unregistration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index ce2bd88feeaa..9f630e890ff7 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -468,7 +468,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 
 	ssam_device_set_drvdata(sdev, hub);
 
-	status = ssam_notifier_register(sdev->ctrl, &hub->notif);
+	status = ssam_device_notifier_register(sdev, &hub->notif);
 	if (status)
 		return status;
 
@@ -480,7 +480,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 	return 0;
 
 err:
-	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_device_notifier_unregister(sdev, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
 	ssam_remove_clients(&sdev->dev);
 	return status;
@@ -492,7 +492,7 @@ static void ssam_base_hub_remove(struct ssam_device *sdev)
 
 	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
 
-	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
+	ssam_device_notifier_unregister(sdev, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
 	ssam_remove_clients(&sdev->dev);
 }
-- 
2.36.1

