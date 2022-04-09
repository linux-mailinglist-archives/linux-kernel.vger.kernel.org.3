Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3B4FA27F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiDIEZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiDIEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:25:37 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6CB10CF34
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:23:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 14so7755873ily.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJypOpOA9aIF7A07tGX4soaaBLyBuWYyjxJ7q0m7th0=;
        b=NPEqzwWw0cB7k1ALFugu0+c2isySmZUAJchwKU9c8auBivUs+EHCCrcmT/NvOvtXZA
         l0T7McZG8qNrO25el8VQcNND1MWmlkX+p8q1h3+E/mUgFMa0wgup2AJ7MkIjBguHS/x4
         UqCuRhRXePhAN/9IGhExY7IUwGj2J29JvefULPBsv3QTybO45tikhIpCj+Vi4MAuNjRz
         bL/Z7yHlADVHboa8Qt/gQKaqH5APKeuPSQOWezK+mRJz9LyaZWbCWvIq/WcG+7s6YnFj
         9u04BgzxodGacaWU/vig6sn/9Y9sjc0/fNPjedKBwpoNzTX+y2mXftaya9rVMLcDAsJ4
         2duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJypOpOA9aIF7A07tGX4soaaBLyBuWYyjxJ7q0m7th0=;
        b=7WF37vGvFp3M6TdRwtP9YXLydZAHXv5b/6bIykIoeVlnmkcmEop/le4oPq0f/sbJHI
         fU8jBGDGGZEa+MyOAV5Wxc2ajHBUgaPDGsbiRjx4ctQpVo+FCInY8b1i6P9r3RZFyyJ2
         oDiag7ESNC0RltVh+AcN5wB/viu6ZMVXIXAvL/O6hxTXuqYrQohCY6x1IACVHB4ZZp1Z
         Ak0/fG8x8jVcq8mDv59XGok4s9QyX3zmFWeUKAsKfIDtwxTixh18L4vIOfSSC5bpJY8S
         kiObqnwo/wQm8wyLxNKyemFxV8fWasn1JOviwMcGt9mE5o6xJVTO6nZOCOX1ktAhQ09R
         qunw==
X-Gm-Message-State: AOAM532r9YXls2WvwTSgP0fWpRtkC9J5UIqrU+nry/WreYJLE42xa0ek
        fFbw2JAsVE2f9IGB3f+mvBw=
X-Google-Smtp-Source: ABdhPJzPxk4qY6Q6zL03Wzq9wKditxBAobGL6/CMo2XFZXDH58+NCffkqUpLV6nfgehKIxDxhJ4QTw==
X-Received: by 2002:a05:6e02:216f:b0:2ca:85f4:1473 with SMTP id s15-20020a056e02216f00b002ca85f41473mr2671059ilv.17.1649478209896;
        Fri, 08 Apr 2022 21:23:29 -0700 (PDT)
Received: from james-x399.localdomain (71-218-122-133.hlrn.qwest.net. [71.218.122.133])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm16131051iog.24.2022.04.08.21.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 21:23:29 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/gma500: depend on framebuffer
Date:   Fri,  8 Apr 2022 22:23:21 -0600
Message-Id: <20220409042321.3184493-1-james.hilliard1@gmail.com>
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

Select the efi framebuffer if efi is enabled.

This appears to be needed for video output to function correctly.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - select EFI_FB instead of depending on it
Changes v1 -> v2:
  - use depends instead of select
---
 drivers/gpu/drm/gma500/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index 0cff20265f97..a422fa84d53b 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -2,11 +2,13 @@
 config DRM_GMA500
 	tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
 	depends on DRM && PCI && X86 && MMU
+	depends on FB
 	select DRM_KMS_HELPER
 	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
 	select ACPI_VIDEO if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
+	select FB_EFI if EFI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
 	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
-- 
2.25.1

