Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46CD55A123
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiFXShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFXShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295B8126C;
        Fri, 24 Jun 2022 11:37:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ge10so6385469ejb.7;
        Fri, 24 Jun 2022 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk5pMy7Zd97VX3BKR5VEk1jaORfYL6tDVYZN+cZYFto=;
        b=RRMHywXN0k5cnqLRZ1tqLahM6ZdigXE5VNCurGhJPbwCK6VI0UaIwBPmznefCYqhUI
         GkTxDznIPnPaZq5Wf8w9ESY2dzStS/Kk/Gor9ZgXBYskw+YXz2KLDkWRvV9boTegcIFx
         gsm2maO/0TEmcjAlaRTBdJ201yVUMOovz0OlAJ8H5kwfo90kG7+FRlM6scCWk/EqGefI
         IwlC+aSQGOcOGXGh5T2BPNK6sMkgrrzCwMgiiQbIv+lzY0gWR2cM4gG3NM9wKg4yxQ/t
         K3jQTnI41UfKyefGLXg9vZmC8Bzo/Wjd8N0qdFrosEE4ZjXd2IrGrQrA/bPDVfyThXFI
         eIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk5pMy7Zd97VX3BKR5VEk1jaORfYL6tDVYZN+cZYFto=;
        b=m7dZK4TNgHP0dOpU0XVE9OhwH5TCqSLp4Jq34i2lfEex6lXolpJoXMktMrYCq/7qFT
         jqLLxR4KQorRv8KTCKJWR/dqI2C2o0qJEeG+0HhpKyLEg6tgL/8peHkEPGqFQiFTVYw9
         Jrb4C+a141qil631NxkqO27LguuR4q2h0cCcvilpbMSMV4U4nFfeokbZgezjWq6CvpE6
         V7+ChjoDnVLlZXBW1qFNUZa3IVbfWOHRZoxyREAlLxvvdDqLYW0v/IhZr0i3DDcs2O6V
         bsGmeA5jmmnfof7lbn5YH9oJ1h8BX2hvAbF1TFsbJ72MDA7pzMSr16xnYrWdWgikMMWp
         YqTg==
X-Gm-Message-State: AJIora/ipMq0I0kALdNX/lOpsc3vrREgeiXLs7h9/44RliZcfWVm3/3s
        NkhWEcC5wCar10QuMwnbqxg=
X-Google-Smtp-Source: AGRyM1tjEUoazywNMjLpdPgFsdSAat4CmmBmty2MepRR97HbIFsh643SXO+IoeJf0NpDI5i9snAF6g==
X-Received: by 2002:a17:907:6d0c:b0:726:32e5:1736 with SMTP id sa12-20020a1709076d0c00b0072632e51736mr370371ejc.596.1656095827578;
        Fri, 24 Jun 2022 11:37:07 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm1493822ejb.208.2022.06.24.11.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:37:07 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 4/4] platform/surface: aggregator_registry: Add support for tablet mode switch on Surface Laptop Studio
Date:   Fri, 24 Jun 2022 20:36:42 +0200
Message-Id: <20220624183642.910893-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624183642.910893-1-luzmaximilian@gmail.com>
References: <20220624183642.910893-1-luzmaximilian@gmail.com>
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

Add a POS subsystem tablet-mode switch device for the Surface Laptop
Studio. The respective driver for this device provides SW_TABLET_MODE
input events for user-space based on the posture of the screen.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 8f249df673a4..f1c5905f1c16 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -191,6 +191,12 @@ static const struct software_node ssam_node_hid_kip_iid5 = {
 	.parent = &ssam_node_hub_kip,
 };
 
+/* Tablet-mode switch via POS subsystem. */
+static const struct software_node ssam_node_pos_tablet_switch = {
+	.name = "ssam:01:26:01:00:01",
+	.parent = &ssam_node_root,
+};
+
 /*
  * Devices for 5th- and 6th-generations models:
  * - Surface Book 2,
@@ -237,6 +243,7 @@ static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_tid1_keyboard,
 	&ssam_node_hid_tid1_penstash,
 	&ssam_node_hid_tid1_touchpad,
-- 
2.36.1

