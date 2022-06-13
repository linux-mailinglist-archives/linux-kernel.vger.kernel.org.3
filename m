Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0008C549D76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiFMTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348629AbiFMTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ADC1FA61
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso4396271wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTgKLvjLuTzO7UM/mQsy+9BhRmEEwbTxiHwdzXn+Bis=;
        b=GCqt0jHDbbSAEtN+nQobnMYuspNmhWO31Jlw3BkNbBf4JuoBPhaTz0IqkCqndu0yTD
         XEwFvO18vMq2x/zYuP5VPzM6C0GXCH1I+T7FuwfX+Xm/eS0o66cQKMSnc9vGmcbtS3qn
         kVUxCXGnNvfc20nSneMcBtPI3GxeM/pWq5php6GklT52+D+OYf4wSJ0j8sFvUd0b46UK
         TB2d/JBO3OhcD1A0VMlyA89+trntVh6ygLkNqYmxKlw3kzPSlyfyry7hzFAm7Z6D7oGF
         inGWMPjHahuf5WdtUGZsdgXaytjRrsEafpH3TYIMSbmAWjV4EudB7pPINesAvIhvdcth
         rzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTgKLvjLuTzO7UM/mQsy+9BhRmEEwbTxiHwdzXn+Bis=;
        b=T7MhDy2vySL52Zt29K+XGJTKWPlEcp5MmUtg0AZLl9zzkY7tVwk+Ae4PDQJ3GKoPXC
         dlszmrtEK826Rpv82yWhjWmJeLs9th152IUEnEgoUPVNH7fWYfiHxEwomGd3BNXq8UVW
         TMVwjpNS9uac7zgoex4tZdJ0E3N40AD85+I85N7LpuZt36gm8fLds6HVGvVD3lig/p4/
         SP24xRiTs+hwlzjPEu2qk4Wbot6ang37vEmubVH5t+exmPd7NEh0KB9l7mcG2WjrC4e8
         ghW0qPCYUyG+WDOA3ClMjxxnuYCJvvkFEI86Mo2NNTWOFsPXqTbdzeTiLlIzyy3K34h8
         I/mQ==
X-Gm-Message-State: AOAM532k2ofkcpLme72cMUl+OmoT9Uk/dJfMkvfm6PaTmaAgaDjgxsnY
        Dn9o0lXMWHTfjiQDA43VL4Y=
X-Google-Smtp-Source: ABdhPJzigC+Zu4VdUjf/vJ/zZ+ckaaLhD1Hmrd5dgKce1PLsqWQFWFA/i0izU2+UeTXMvSspFJJtgQ==
X-Received: by 2002:a1c:7901:0:b0:39c:4252:d7f1 with SMTP id l1-20020a1c7901000000b0039c4252d7f1mr537938wme.178.1655140667601;
        Mon, 13 Jun 2022 10:17:47 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000100a00b0020d106c0386sm9016129wrx.89.2022.06.13.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:17:47 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 1/3] drm/rect: Add DRM_RECT_INIT() macro
Date:   Mon, 13 Jun 2022 19:17:36 +0200
Message-Id: <20220613171738.111013-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613171738.111013-1-jose.exposito89@gmail.com>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a helper macro to initialize a rectangle from x, y, width and
height information.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 include/drm/drm_rect.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 6f6e19bd4dac..e8d94fca2703 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -47,6 +47,22 @@ struct drm_rect {
 	int x1, y1, x2, y2;
 };
 
+/**
+ * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
+ * @x: x coordinate
+ * @y: y coordinate
+ * @w: width
+ * @h: height
+ *
+ * RETURNS:
+ * A new rectangle of the specified size.
+ */
+#define DRM_RECT_INIT(x, y, w, h) ((struct drm_rect){ \
+		.x1 = (x), \
+		.y1 = (y), \
+		.x2 = (x) + (w), \
+		.y2 = (y) + (h) })
+
 /**
  * DRM_RECT_FMT - printf string for &struct drm_rect
  */
-- 
2.25.1

