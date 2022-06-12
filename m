Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830FF547AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiFLQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFLQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:13:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA04A3D0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:12:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so4461116wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6qupUetHLQqhezVhUKvPbR6n4KY1jcWxKelwznf1ww=;
        b=kxr19WDGBFfWNpHhE2e6u07EqdHog+2JA9ok+pRs9H42utwqqSIywW9yvdSkwkC/S+
         Wzo3N+UYE4Ym1Ky3uBHJNFb9E8SKbWGS3QqVGrlQzWrr+mXPJVY9vJRLxSveA/Z6Kqqh
         4eRBFooIEjH5Cn/ESGzRVC8bC4ovWzFTEutXOA+2FkWjEs17hQdB8L7OZjVeHUd4oEnq
         9aS3T3nzA2YMjvSY5Lr4zrwl/pz630MBviSOcud/L75VivL4TC7vBYLIr4Lga/edvElx
         jHEnpFBUKCS5e1ueklLZbgAx53kjnKs3buplNwR54A9SyxC7aUPApp0Uem6pNhrinPl6
         8auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6qupUetHLQqhezVhUKvPbR6n4KY1jcWxKelwznf1ww=;
        b=tApszV+WUa60KXPulTe7z8NVHOBKVwU0PTRpW8+FlZlONbmLOrRJ/+WQz12W+oet62
         VJl6ZT/2P1lIFXh0V3iqFcV6yIFaDh6prkCslft1uG/U9CU/xnhwTy+Ye5JpdngRZMLT
         vMmBHoQ0D/ba3t4rE2T4YrSX5JC94y91VdlP+3+Te5RNd5O/tditqFj8H1KvFy6vUUH+
         zB7FUr4IdD+9LGvpCyE3A+lVYSYZ495v+pFB0VT8p1cbzDdli4WIKaucLQyQXFI+whMz
         MoOH5x21hb9Yi3EnXYnvl0hcBrICKbbdFatu/j+LlYDKV4PKCU+3o4WIBo/xYoGxegao
         ABsA==
X-Gm-Message-State: AOAM5324shrLVT96wW3BM5Cz/KMdJkor+F926i4eD1uFJX5JlMN0lYju
        5TkzvCK8LR9etOOAZodJXak=
X-Google-Smtp-Source: ABdhPJxX1mft8P2RX7TPxZKoUa9mrJWuY00IutpNyOHZB7pwgN5RdKw5WQNPr0z3O5nkgteim0KHlg==
X-Received: by 2002:adf:d4c7:0:b0:213:ba6b:b017 with SMTP id w7-20020adfd4c7000000b00213ba6bb017mr49751881wrk.652.1655050377610;
        Sun, 12 Jun 2022 09:12:57 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d6208000000b0020d0f111241sm6015925wru.24.2022.06.12.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 09:12:57 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/3] KUnit tests for drm_format_helper
Date:   Sun, 12 Jun 2022 18:12:45 +0200
Message-Id: <20220612161248.271590-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hello everyone,

Here is the v2 of the series, including the documentation, previously
sent as a standalone patch [1], and changes suggested during review.

Thanks a lot,
José Expósito

RFC -> v1: https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89@gmail.com/T/

 - Add .kunitconfig (Maxime Ripard)
 - Fix memory leak (Daniel Latypov)
 - Make config option generic (Javier Martinez Canillas):
   DRM_FORMAR_HELPER_TEST -> DRM_KUNIT_TEST
 - Remove DISABLE_STRUCTLEAK_PLUGIN (Daniel Latypov)

v1 -> v2: https://lore.kernel.org/dri-devel/20220606095516.938934-1-jose.exposito89@gmail.com/T/

 Thomas Zimmermann:
 - Add DRM_RECT_INIT() macro
 - Move tests to drivers/gpu/drm/kunit
 - Improve test documentation

[1] https://lore.kernel.org/dri-devel/20220606180940.43371-1-jose.exposito89@gmail.com/T/

José Expósito (3):
  drm/rect: Add DRM_RECT_INIT() macro
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
  drm/doc: Add KUnit documentation

 Documentation/gpu/drm-internals.rst           |  32 ++++
 drivers/gpu/drm/Kconfig                       |  16 ++
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/kunit/.kunitconfig            |   3 +
 drivers/gpu/drm/kunit/Makefile                |   3 +
 .../gpu/drm/kunit/drm_format_helper_test.c    | 169 ++++++++++++++++++
 include/drm/drm_rect.h                        |  12 ++
 7 files changed, 236 insertions(+)
 create mode 100644 drivers/gpu/drm/kunit/.kunitconfig
 create mode 100644 drivers/gpu/drm/kunit/Makefile
 create mode 100644 drivers/gpu/drm/kunit/drm_format_helper_test.c

-- 
2.25.1

