Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC758EEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiHJOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiHJOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:42:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51751A01;
        Wed, 10 Aug 2022 07:41:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k26so28136289ejx.5;
        Wed, 10 Aug 2022 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FikqBGBdu6x0dvHeaCyYGZeHuRdv4sBlsHEPXRgAZ58=;
        b=ffdypMKK/ep4+DITQK84DLW7WEK36T/ksk5u0KwrFGTYvPS9eaMwVyx7laY9CkW858
         R5DUAZJRBhoETpnMK9eX6PFWzAQPvwPkyJ5LJVkBNgkn9NyM4lnSQsJJ3YC+9OecsoZm
         uvjQzxVarpotbURJ474oTqo2bUcnuY+RXRIiJWpQ3WExUouXiTc2GFED9wuk5FbmblRO
         dQwBIA9d6vKAi76EJZDZ2XScvT9/VQxesGrwuUVf6krZSGDGI6HkyLT9ZCi94sZej/Nx
         ijX+xe2MIR3IRShMCa5LboY98JDqqvUk/0xQ5dYsGTQGVaVsRVFEVM6al6DG63DSbgEd
         zBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FikqBGBdu6x0dvHeaCyYGZeHuRdv4sBlsHEPXRgAZ58=;
        b=o5pnLAh/qDhxA4ZawQvbpzhu30LVvaluRmeGzOvRNlUoBZMWVLBj2MZ1uqkUNrajkP
         DezHmQ+nMKXx7zHSSkyl00zvtCc5BqigeoCqI0ZIwsMURUKb3DFglviushpa0cnIxtmd
         VsHAyMvJ8FJwvcvcX4EbSaDHzo2KkDxXntz4fCEuRSjtKfjWglLzSQ36SSZ4gsYmTzpQ
         HvdsRhpducn8O2NRyp7HiUjbZ9MkmAOVoGv5dUqlU8UhvEylugSbSBLpesjeYsxCaFVK
         NuHYLPQ3SvfBBtD55r26fRe79zjZli2Vg0vtmxiE7OmZWoNCcKLlc7f6HpqHybmXMRkP
         w20g==
X-Gm-Message-State: ACgBeo2xYGup1GE/e5C7Tgh9zl5n+X+T5NX4QhXYuvi5t4gFVfGMKN1k
        vpmlHKqs4GENATmTyC8rp4d4AyenBfk=
X-Google-Smtp-Source: AA6agR4d7csoW30nuv2zRdV3XRrHGwArOWcLEHh4+2IyLT/pgV06qrIkqzxIZr34Q4QYFBzPrijgJw==
X-Received: by 2002:a17:907:7284:b0:731:82a3:16e3 with SMTP id dt4-20020a170907728400b0073182a316e3mr7710834ejc.30.1660142500924;
        Wed, 10 Aug 2022 07:41:40 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b0043cedad30a5sm7778049edr.21.2022.08.10.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:41:40 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/3] platform/surface: aggregator_registry: Rename HID device nodes based on their function
Date:   Wed, 10 Aug 2022 16:41:15 +0200
Message-Id: <20220810144117.493710-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810144117.493710-1-luzmaximilian@gmail.com>
References: <20220810144117.493710-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename HID device nodes based on their function. In particular, these
are nodes for firmware updates via the CFU mechanism (component firmware
update), HID based sensors, and a USB-C UCSI client.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index d5655f6a4a41..c1ee8af7996d 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -104,14 +104,14 @@ static const struct software_node ssam_node_hid_tid1_touchpad = {
 	.parent = &ssam_node_root,
 };
 
-/* HID device instance 6 (TID1, unknown HID device). */
-static const struct software_node ssam_node_hid_tid1_iid6 = {
+/* HID device instance 6 (TID1, HID sensor collection). */
+static const struct software_node ssam_node_hid_tid1_sensors = {
 	.name = "ssam:01:15:01:06:00",
 	.parent = &ssam_node_root,
 };
 
-/* HID device instance 7 (TID1, unknown HID device). */
-static const struct software_node ssam_node_hid_tid1_iid7 = {
+/* HID device instance 7 (TID1, UCM UCSI HID client). */
+static const struct software_node ssam_node_hid_tid1_ucm_ucsi = {
 	.name = "ssam:01:15:01:07:00",
 	.parent = &ssam_node_root,
 };
@@ -182,8 +182,8 @@ static const struct software_node ssam_node_hid_kip_touchpad = {
 	.parent = &ssam_node_hub_kip,
 };
 
-/* HID device instance 5 (KIP hub, unknown HID device). */
-static const struct software_node ssam_node_hid_kip_iid5 = {
+/* HID device instance 5 (KIP hub, type-cover firmware update). */
+static const struct software_node ssam_node_hid_kip_fwupd = {
 	.name = "ssam:01:15:02:05:00",
 	.parent = &ssam_node_hub_kip,
 };
@@ -244,8 +244,8 @@ static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_hid_tid1_keyboard,
 	&ssam_node_hid_tid1_penstash,
 	&ssam_node_hid_tid1_touchpad,
-	&ssam_node_hid_tid1_iid6,
-	&ssam_node_hid_tid1_iid7,
+	&ssam_node_hid_tid1_sensors,
+	&ssam_node_hid_tid1_ucm_ucsi,
 	&ssam_node_hid_tid1_sysctrl,
 	NULL,
 };
@@ -278,7 +278,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
 	&ssam_node_hid_kip_touchpad,
-	&ssam_node_hid_kip_iid5,
+	&ssam_node_hid_kip_fwupd,
 	NULL,
 };
 
-- 
2.37.1

