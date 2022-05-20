Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C152F304
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbiETSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352788AbiETSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2A1957B4;
        Fri, 20 May 2022 11:34:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so4779066wme.3;
        Fri, 20 May 2022 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhA5bjJ74Si/OSKu8X0VGNNeVIpBH5bvQj0ul7HoBqk=;
        b=Vjp8G0hcbakvlHhUqNtOi44R7xEsD0p1BVhAu+0UIh5WXPWnm6HgTnLR2cbQDzBjc/
         sWVE9FTkG89H5/rFbjGZlcB8acA1ozMHR+C8IIhMck1jYCsDfujKtit54Wsio/IsjAo9
         NR0zQOU9RnLXaHi63lO+iJtHhfh8rLuVUgvCFXGJcl0TAN6fswte+hrZfTuudy/zUG7e
         vMFH2ydkg+iQZKeEh7W7LfFNKeL5rkGl5HECV7w8A+K2Pv5iVK8R3dcwrxtAE0IHAa21
         tKtpe1pVh0H5vEg9rlkYG7XuusS7fGL9apM0w7TjM5xNmM4Bj9nIennV7jkzyUFfXE8w
         1+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhA5bjJ74Si/OSKu8X0VGNNeVIpBH5bvQj0ul7HoBqk=;
        b=KOAaRIL4Z/Xg+6bijswjblfhXVVgcM+4UJiS6bMrzR4NhrO+f/VSKRRzJzNVbIh59F
         hhUXJxxvmc6a6h+ebGZsx+2vBzXnnJnCoWVx5jfXF7ZJ+E2IJkp539UWqp2bwuDVEONz
         fzn2aMFaVzT64XsnQ0C0pFhAEn1y1DL+3g6bxGOVLFyDSRwvdX7EU5l83IdDL9yzED6R
         NavX7XLZaoqwvili8bPi1SqfDBF9RwSgtCLL3AET3VuaFgFcTwhpHsQcpXv9b6dhoTft
         Y6HGkRHtvaj2nuXGqtZW3eFvc2rb06iYHUAjsSs6b0rvcfFjX/lQr5UCoihAZr4so/As
         hLhQ==
X-Gm-Message-State: AOAM530VubxD5+Ytfg++RDDZ5sISwK69s+i9/UYC1oPd62w7DC14NfKZ
        OtZ8+ga8cdOAFD9ay6Dgwy6k7neA+AY=
X-Google-Smtp-Source: ABdhPJxgvCfQLlXqpvZ6bqJySXh503ppeq4UyWK+pS+F/rfopFlACrqxEpVOtJoe+n3A7eZ1t1JoAA==
X-Received: by 2002:a05:600c:354a:b0:394:8fa4:73bc with SMTP id i10-20020a05600c354a00b003948fa473bcmr9867233wmq.37.1653071691223;
        Fri, 20 May 2022 11:34:51 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:50 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] platform/surface: aggregator_registry: Add support for keyboard cover on Surface Pro 8
Date:   Fri, 20 May 2022 20:34:22 +0200
Message-Id: <20220520183422.7185-11-luzmaximilian@gmail.com>
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

Add support for the detachable keyboard cover on the Surface Pro 8.

The keyboard cover on the Surface Pro 8 is, unlike the keyboard covers
of earlier Surface Pro generations, handled via the Surface System
Aggregator Module (SSAM). The keyboard and touchpad (as well as other
HID input devices) of this cover are standard SSAM HID client devices
(just like keyboard and touchpad on e.g. the Surface Laptop 3 and 4),
however, some care needs to be taken as they can be physically detached
(similarly to the Surface Book 3). Specifically, the respective SSAM
client devices need to be removed when the keyboard cover has been
detached and (re-)initialized when the keyboard cover has been
(re-)attached.

On the Surface Pro 8, detachment of the keyboard cover (and by extension
its devices) is managed via the KIP subsystem. Therefore, said devices
need to be registered under the KIP device hub, which in turn will
remove and re-create/re-initialize those devices as needed.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 1e60435c7cce..ab69669316bd 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -47,6 +47,12 @@ static const struct software_node ssam_node_hub_base = {
 	.parent = &ssam_node_root,
 };
 
+/* KIP device hub (connects keyboard cover devices on Surface Pro 8). */
+static const struct software_node ssam_node_hub_kip = {
+	.name = "ssam:01:0e:01:00:00",
+	.parent = &ssam_node_root,
+};
+
 /* AC adapter. */
 static const struct software_node ssam_node_bat_ac = {
 	.name = "ssam:01:02:01:01:01",
@@ -155,6 +161,30 @@ static const struct software_node ssam_node_hid_base_iid6 = {
 	.parent = &ssam_node_hub_base,
 };
 
+/* HID keyboard (KIP hub). */
+static const struct software_node ssam_node_hid_kip_keyboard = {
+	.name = "ssam:01:15:02:01:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID pen stash (KIP hub; pen taken / stashed away evens). */
+static const struct software_node ssam_node_hid_kip_penstash = {
+	.name = "ssam:01:15:02:02:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID touchpad (KIP hub). */
+static const struct software_node ssam_node_hid_kip_touchpad = {
+	.name = "ssam:01:15:02:03:00",
+	.parent = &ssam_node_hub_kip,
+};
+
+/* HID device instance 5 (KIP hub, unknown HID device). */
+static const struct software_node ssam_node_hid_kip_iid5 = {
+	.name = "ssam:01:15:02:05:00",
+	.parent = &ssam_node_hub_kip,
+};
+
 /*
  * Devices for 5th- and 6th-generations models:
  * - Surface Book 2,
@@ -230,10 +260,15 @@ static const struct software_node *ssam_node_group_sp7[] = {
 
 static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_root,
+	&ssam_node_hub_kip,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
-	/* TODO: Add support for keyboard cover. */
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_iid5,
+	/* TODO: Add support for tablet mode switch. */
 	NULL,
 };
 
-- 
2.36.1

