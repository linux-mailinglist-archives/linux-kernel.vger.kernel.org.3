Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BC4FA218
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiDIDrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDIDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:47:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6F381B7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:44:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h63so12763746iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 20:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfFIR4LIjgd7Hrv5Hb1FuWlpDVZNI07W8ZVr7E+HPdE=;
        b=nixiBKa3+naz/RL5CyYGZhPRUztCEy7P/2+6O8TJ4BNVxMwof6mtBdwOwBfprF0mOD
         /yu/N9CchENjDFTsNvtxuGTn9jvG9VH3ssfyrbuntTQizz7wGq1JFxurD2rmP5dF8JXM
         qbm8+CQPR2jnUWsFMmqPd+bF+I/UPk+WmJXN9p7z3LCPaVhDJkjM3k5P9dkfXlUG1QJq
         Z7as/tz73RRyeF393QlhyOjCqWWf2WPgjb0MZtWiwVZerR1BWIzfp8DpthHQ0QXi1ZF4
         zbJPbAO0QCctnXOy4sAoFbhiUTsNNiLOR+OQCKPHptLN49uZUC/db0sGvr5rw3Kuxx+U
         e9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfFIR4LIjgd7Hrv5Hb1FuWlpDVZNI07W8ZVr7E+HPdE=;
        b=08W6ylPGQJlUIV/racFSh2W24j8VHimQPL6KICdVZ2XCURr/s/gRsT5FGfzdjvspVw
         8pLrPg17cumCchdfKNqLwlrKHUcFkNzdRUSV0IidS/O3JWYhOaGgXpXENIY/wbS/mpTH
         4RXd7RBRogFvykHAXWPRGQ8WWZulKMHQIMRfxzH/OQ7PnSfr5auSsm2KYY2ZCEhKKi5y
         amD6M4Nk+bGPt3hfocCtQZrduirEo8uXk+ZfKgA0zhbCgZoZIW2lH3brFZwuPooS4cla
         AJYGFxaYT4deIn+Mqtde9VIXHSZh+kpRQZYrs4WPYcP4F/P55FkOtufcorZpzELH7Yr6
         r4DQ==
X-Gm-Message-State: AOAM533Or4SiVI9EJh73osKbw3y8OZDR3n+jVQAGurScODbzqwuSm2m2
        2vcdWIZNqbB9L7LQlAPDw0S7jCu8OeWQrw==
X-Google-Smtp-Source: ABdhPJzNYBn/4Y962o5/8C1Ipa96l+ZsMaVG4WbC6ThYiMKpm3cCIf+2t4P045nwzvnjUm7LZgT8iw==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr10727409jat.289.1649475899076;
        Fri, 08 Apr 2022 20:44:59 -0700 (PDT)
Received: from james-x399.localdomain (71-218-122-133.hlrn.qwest.net. [71.218.122.133])
        by smtp.gmail.com with ESMTPSA id e4-20020a056e020b2400b002ca9ffbb8fesm71785ilu.72.2022.04.08.20.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:44:58 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gma500: depend on framebuffer
Date:   Fri,  8 Apr 2022 21:44:17 -0600
Message-Id: <20220409034418.3182706-1-james.hilliard1@gmail.com>
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
Changes v1 -> v2:
  - use depends instead of select
---
 drivers/gpu/drm/gma500/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index 0cff20265f97..8ea87bfa95f5 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -2,6 +2,8 @@
 config DRM_GMA500
 	tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
 	depends on DRM && PCI && X86 && MMU
+	depends on FB
+	depends on FB_EFI || !EFI
 	select DRM_KMS_HELPER
 	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
 	select ACPI_VIDEO if ACPI
-- 
2.25.1

