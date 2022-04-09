Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8F4FA1E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiDIDCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiDIDCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:02:18 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1FD33A0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:00:12 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b17so680717ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 20:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RUgxB5lUnMf0m/8cJBKRpGrEmDxJAR3LLco6CCvSoQ=;
        b=XOXBEPeFHHNN7CMBaD7IyFVzbQgjm8LkaxzYx1ftFJNSXV6gS4JkUd3UW9t/qvpKhZ
         3YqwXfBtp1ZwgTxM8bHyhRab4zRiuVR5U+P86722emmM0Z+rkuRzVSFGXbMwxf2YJvKl
         +5dSv5E54VhyCQS6z4Uh87JCJvbgeNU+ztiegdXow7rIUt5CJjZoj06jKgDKGpMWuWnb
         n/KBhqUHRdJDauCFwQJvFZFx2l2LR25EQ9ZFShh+AOVFcx7jcsznU5rQXBoxfpgyU55e
         s9nDMzZP93lBA1F/g2jfVaETN4k5Hdh3hrL9THd1tFNTPAMlkAfqw/kwODL0inMrukXH
         RsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RUgxB5lUnMf0m/8cJBKRpGrEmDxJAR3LLco6CCvSoQ=;
        b=EbU6+ab9py2Atgw0OScLwJARQlRSm4jnQUhBDs4x+drb6utf5keKoLsWOoyD/5E2yQ
         LG2Z1FhcCyAPxp5R8uBDUskPhLx/UDzJ3DKgiDXizDK6fWkQAA86PxdrG6S/ickJtt3w
         d026MEVUPecsWZ78ZzS/mVZbYvDzyF8ndkO9nyRHEaK6dYK76XBi6tmruQeqz660M+QZ
         whVi2kgaMIzak7L/ALVr+emLjO9niwxUmQulwoFWXmXpgN8ChuK+/U8rzNG60ZOpnicx
         EcyuwIQxzirH17TpAxMI75YTSXs4ykYWIRkMAzpi4WeUoFGVV/arNKz9Musn/N30S8Zw
         X0Yw==
X-Gm-Message-State: AOAM530jxXGb8We0Il/SB+avBHiXP1AmX6K0OX+XO7rYYx584vl1w3f+
        x1he/lmhB4+/YHANEjEFd5rPDNsNL8NwQQ==
X-Google-Smtp-Source: ABdhPJwrhxj/LWZYAEPg4H8QbXHQjFpoQ8f4XNumCm8a/VGKhnV20+mtj6vY1XGvloXnr8hnu3nTqQ==
X-Received: by 2002:a05:6e02:1c41:b0:2ca:8a04:ad8d with SMTP id d1-20020a056e021c4100b002ca8a04ad8dmr2527592ilg.195.1649473211662;
        Fri, 08 Apr 2022 20:00:11 -0700 (PDT)
Received: from james-x399.localdomain (71-218-122-133.hlrn.qwest.net. [71.218.122.133])
        by smtp.gmail.com with ESMTPSA id y8-20020a920908000000b002ca38acaa60sm10314731ilg.81.2022.04.08.20.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:00:11 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: select framebuffer dependency
Date:   Fri,  8 Apr 2022 20:59:48 -0600
Message-Id: <20220409025948.3179636-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be needed for video output to function correctly.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/gpu/drm/gma500/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index 0cff20265f97..ff8c7b6e87f5 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -7,6 +7,8 @@ config DRM_GMA500
 	select ACPI_VIDEO if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
+	select FB
+	select FB_EFI if EFI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
 	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
-- 
2.25.1

