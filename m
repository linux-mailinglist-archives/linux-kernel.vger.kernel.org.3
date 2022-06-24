Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9511D55A145
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiFXShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiFXShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD9781258;
        Fri, 24 Jun 2022 11:37:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id cw10so6427434ejb.3;
        Fri, 24 Jun 2022 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6qkeHUNFH4QmeQBj0bNc7f9zKmHQ5igPCiK5zgxrT8=;
        b=h/hkqjcnhoGz0vbAHb9p1jUooWrA/hO0BNtoz3If5Rt0ojAia+aSiYGe0hxG47PM+l
         72N29VmdrpdyZSxecqBMnU8W5lGIIJzF+L8cGn+CeWJhkp8yBvK7Vct4ng+Tf2tBPT7l
         5LiS0DZDOHYsHwiRtT2XwIuoiD9ei8KX92AvHpUjOhVoc3ovPb5H6cREBNtSN36ve3GN
         CLrBUdB8LPY8wJPD7mdue26qit7n6Td4WQesrtbMV9Jbb9mP6VqK9ke/uZm37lOSHZnW
         GhHTJMmk3aPH8+SivXBNQv37bEpyGOSWib8ExYci6huH6xN5j1teaBKe1reKOyfa4J3i
         Q6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6qkeHUNFH4QmeQBj0bNc7f9zKmHQ5igPCiK5zgxrT8=;
        b=U+yNBNfQ1jIX9yMdp24bQYFVx2097ymCIGjcUsqo3tVd3tKJATtPh1JT9osNd3KD5h
         M6t+uNFRFLLxWa5TWAgj2W8+DoBy9tLNyAaGhlYyZJZpuDzAnJz40Zp6RlCm9YXjllsh
         adtBtFEnoaes5VKFFnIyzjkrSjYJWD6ObA51BTIiUpVIS7dSSfOxZXhhbHOaQv/vol2Y
         ccUPjoeu0A/qaEJ1QYJOcVtvMuzblh5wmSpNLTPLvpp/2SZyKOyLlks2Pe8l/Oe/I8CV
         1ppiEjcrKef6MI85vLM3soGS+LziD+WUxknLXwQdxjjsH+niZkOiyHmr6jcXvclHaWn8
         tE2A==
X-Gm-Message-State: AJIora/SlZV89F3OkwH69PKPVy1ufovfZvJ0JbmsIrxtmOJJcefsQHDQ
        f5wOjTzNBaAFFtKcJ19GmVY=
X-Google-Smtp-Source: AGRyM1tVgWUkN1tNjUIpIuEVVhmLL12YLP8dLIREXKumlgpSMkOWKDAOyqyr5d22YIuSfKM9EX6WNg==
X-Received: by 2002:a17:907:da7:b0:711:6c6d:c6d with SMTP id go39-20020a1709070da700b007116c6d0c6dmr399275ejc.276.1656095825905;
        Fri, 24 Jun 2022 11:37:05 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm1493822ejb.208.2022.06.24.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:37:05 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/4] platform/surface: aggregator_registry: Add support for tablet mode switch on Surface Pro 8
Date:   Fri, 24 Jun 2022 20:36:41 +0200
Message-Id: <20220624183642.910893-4-luzmaximilian@gmail.com>
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

Add a KIP subsystem tablet-mode switch device for the Surface Pro 8.
The respective driver for this device provides SW_TABLET_MODE input
events for user-space based on the state of the keyboard cover (e.g.
detached, folded-back, normal/laptop mode).

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index bf3303f1aa71..8f249df673a4 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -77,6 +77,12 @@ static const struct software_node ssam_node_tmp_pprof = {
 	.parent = &ssam_node_root,
 };
 
+/* Tablet-mode switch via KIP subsystem. */
+static const struct software_node ssam_node_kip_tablet_switch = {
+	.name = "ssam:01:0e:01:00:01",
+	.parent = &ssam_node_root,
+};
+
 /* DTX / detachment-system device (Surface Book 3). */
 static const struct software_node ssam_node_bas_dtx = {
 	.name = "ssam:01:11:01:00:00",
@@ -264,11 +270,11 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_kip_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
 	&ssam_node_hid_kip_touchpad,
 	&ssam_node_hid_kip_iid5,
-	/* TODO: Add support for tablet mode switch. */
 	NULL,
 };
 
-- 
2.36.1

