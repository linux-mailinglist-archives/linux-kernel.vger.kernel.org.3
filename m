Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974D549D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbiFMTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348621AbiFMTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E79B1FA5D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r187-20020a1c44c4000000b0039c76434147so4933450wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pND07IjUi7Nx4XC5+/AEJ436yBfHgMDn/iUw0DqnEmg=;
        b=UsJF7TH60A7l1RZn8ij0aH+0Cb9cxMAvucUlaQ7stS5YRrsZem6rXXWIGD1eH/eQOq
         xSIZ864+UWhpOVq2PXc7etly3451uxTOdQ2VuqRCG2OBDDnknPr1w4bwFG/GEZtMQ5NA
         8IkL4zi6qxZ5d0mTaBkNbu9rWt+sQZrnHVoofGR9tqPbPe7azOZgwbF33AicgX3OiZRG
         IuJv3QYQhSBxeDxEk7Qjsgm4HvLucFuMydOI/0ryZ6hiFz4G9bINup2eF1kqlTC8QMB+
         nG6UCqFdZnienPgdZfEBo99xHwrv0BowjhYq15uGdvznL4PCxwlY/hWn8DTCoc1zeWhD
         aDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pND07IjUi7Nx4XC5+/AEJ436yBfHgMDn/iUw0DqnEmg=;
        b=ASa8EyMDPm7xzgI4T46C+hUtYyiTuP5+zZSLY3xEKe0JRFc6yt5XidHmrMVFNIq8fr
         WgPLc5W/POG4lHUoX5lXIup3MTtX0LckzdcPVDv1hVtmDZiPyP2HpOPFWg9O4XlwUJwm
         ED7ImNApRsstk6QvyQ8FsaAH2oQND65mAiyTPcasTU3qrTUK/v4WOb/ctNf9HnyL1ciz
         14AkFz5OhVfM59maEgcOl4vWXoHLEd93lNswzoVKcna43DzHENSg59yUzZWjRRb0X798
         25Ag43XoTs7oyik1tSmTKA93ZymkTd0N0XrGB08jzCuf07iTR8vcXKoGn+nLAlddZjWE
         Puyw==
X-Gm-Message-State: AOAM5311SVxjXk1Too7gbviFiXnpPnBrBM8gGqJHHIPt0MLz9ueSSYND
        N6eZlOLagXPjBXye24MGaW8=
X-Google-Smtp-Source: ABdhPJwaZorMRFk5irMBRXjwuJdiDDebX+XtYnqXQ1rbRV3iYvd5x2d9LtUgLlPVFhDdoC0ehIxIIw==
X-Received: by 2002:a05:600c:1e2a:b0:39c:51f8:80d4 with SMTP id ay42-20020a05600c1e2a00b0039c51f880d4mr550978wmb.192.1655140666586;
        Mon, 13 Jun 2022 10:17:46 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000100a00b0020d106c0386sm9016129wrx.89.2022.06.13.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:17:45 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/3] KUnit tests for drm_format_helper
Date:   Mon, 13 Jun 2022 19:17:35 +0200
Message-Id: <20220613171738.111013-1-jose.exposito89@gmail.com>
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

Here is the v3 of the series, including the documentation, previously
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

v2 -> v3: https://lore.kernel.org/dri-devel/20220612161248.271590-1-jose.exposito89@gmail.com/T/

 - Use designated initializer in DRM_RECT_INIT (Jani Nikula)
 - Simplify the "conversion_buf_size" helper

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
 .../gpu/drm/kunit/drm_format_helper_test.c    | 160 ++++++++++++++++++
 include/drm/drm_rect.h                        |  16 ++
 7 files changed, 231 insertions(+)
 create mode 100644 drivers/gpu/drm/kunit/.kunitconfig
 create mode 100644 drivers/gpu/drm/kunit/Makefile
 create mode 100644 drivers/gpu/drm/kunit/drm_format_helper_test.c

-- 
2.25.1

