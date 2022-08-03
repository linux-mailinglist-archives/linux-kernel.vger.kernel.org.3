Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6923F589237
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiHCSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:24:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEF1A38B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:24:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e15so17564436lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=FVLEwCo6wxH6UqQ/rgVg/jkY1RdcrYbsKsmzA+SVqRM=;
        b=LU1swnTijzeZZHDu0s9wSa9WU5gb5v2Gito5N8j4LrA1Lw+WiFszXSofRJVsyE051X
         FpxVAyVV6DgsUD/iHB03RL2Hqw6XA5ZFm9bd4kxt/c7/J6f/2awu1WIDydmr7kEsD8Fy
         /V/BRMK0ime3RJhroiEaGVlCjEMrmhMQJGzz3Lvc7oDf8pVG804AtiHy47qOrqT/GS71
         EW38btSgTAsIMt2lqiUdCZKB1aQ716nYBRko3UsnwgoP+dh/UOkF31RQ74cZdypOvbBf
         GA9TqqO0DEAPxsKcsloFtdV7pffPsWcFOPQdmX9MSzyULZ7c6TCH0UtA5Q7myhY305sL
         r9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FVLEwCo6wxH6UqQ/rgVg/jkY1RdcrYbsKsmzA+SVqRM=;
        b=gSukrw3myCNMIXpq3QjhVLhor/ov6pSinI5miu4Bvp/4V8qSeh3l5ELjMU5YCXu/VU
         3TVNHwHN1WilrFLthltWbEBBIzCj+AS6Av2Wy7U+rCpvNr3AiHP8SJMU1nYdSZbVce7B
         PtMv7osHRO4Uxh5EsmJfNfL3cX+5wsdHWKe3D+jZyd4/bKf1kM66BEzHGcECrsipkT4w
         uZXB3KYDMvquy40aocxcW70mq/o9tbp2KBuh004LW4ogRc2Q0Sn3fMpNv4p4b3wQWn1m
         UrXcGf9nwOA0/DD0l3h3njFeT5trNHdys4LoPg7pWRfGynQuznY1LIjKGlAkOIWfcYT+
         +5/Q==
X-Gm-Message-State: ACgBeo31GQguDUh+481yyIjqv0T0GwZQHohonH2T2Q5YxJNC6dRT/TVH
        iLEKB3yvDMNHeEWG3p14ejc=
X-Google-Smtp-Source: AA6agR6sr8zJyhjOEd9u8ffumf8oYnOnI2d0WKHOSZv6kXvRl24BTaFUgSjQk+9avxwkktN42YcSmg==
X-Received: by 2002:a05:6512:70b:b0:48b:1d93:d31a with SMTP id b11-20020a056512070b00b0048b1d93d31amr1535068lfs.522.1659551061796;
        Wed, 03 Aug 2022 11:24:21 -0700 (PDT)
Received: from localhost.localdomain (83.24.233.119.ipv4.supernova.orange.pl. [83.24.233.119])
        by smtp.gmail.com with ESMTPSA id s3-20020a056512202300b0048af79884fesm1290967lfs.101.2022.08.03.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:24:21 -0700 (PDT)
From:   Maccraft123 <maccraft123mc@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Anbernic Win600
Date:   Wed,  3 Aug 2022 20:24:03 +0200
Message-Id: <20220803182402.1217293-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.37.1
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

From: Maya Matuszczyk <maccraft123mc@gmail.com>

This device is another x86 gaming handheld, and as (hopefully) there is
only one set of DMI IDs it's using DMI_EXACT_MATCH

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d4e0f2e85548..a8681610ede7 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -128,6 +128,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Anbernic Win600 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Anbernic"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* Asus T100HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.37.1

