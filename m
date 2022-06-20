Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E75521DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiFTQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFTQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:06:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FED2019D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so8886210wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg3ipiFQfydsWyAiWbeBt+zNJSN4+YJgCL2RNA61+gA=;
        b=gid0i80f9EvBzSgeZqk4RJxFFKLu1jA+LglKxOnYvBD82Q20hpZ8eRlhP0pv4Md/bg
         pseQrJxdoYJ4aikuzaDclk6NEt7B9j8EXka0anuCG5I0PrwhRFUE//bu/ijEtJmXZ7Wy
         ncEwL+a/0RkFqAgO5tEQo0v7dJLUC5+40KaCW6t7bPmzQjcInldQYDmMF5yLNLaFuaOu
         +4ev3iHQSdVelpHl1/MtpcQGFt79MR1qxCrwSgbvZ/Q7QmTYroqqka/zgh3Ry2hWcFFA
         0dJaaig2x4IJImS7QIChXxiHaOXw0sqErBVoi0IgOtFcsIQCri73lEpHmr5xK1QzJh0c
         tk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg3ipiFQfydsWyAiWbeBt+zNJSN4+YJgCL2RNA61+gA=;
        b=B7ztND2VqJfN5cBpc6jyVpDYmYetum4mARuKM0ODUhyraxyj7BfmSxhxJUqskV96qA
         qtOymFB6MMmebRESXz5BCoJclK2zN2KTMJ9yMyLFvlC38P/2AMSee1eysO6E8+sZIdq+
         Pxil7+Bn0SmLhwp6xvL/mOUBlBFPsgr8L52xrUkhIvvZny4yFrG3j8ydG4lQGzXF3ZPA
         cE/kOtx7WflKVW2jlyDv5OhlsyznqUp+IHiDxJPcAKltTcpeeedq/C90Ew1aWyNym14g
         fytXM9yYY/TQTAM+RE6aIe1dRmTPJhHjxyqsbBRdhE124gedWx19ysMVEm8ebMENqaQj
         wsZQ==
X-Gm-Message-State: AJIora8gG/aAZDzo8QgcGyg0fvdQ7ejAlAfDf1g1SnG/tzSGqa7jk/0m
        yHKq2ouQ50B7elc4FbZIkJA=
X-Google-Smtp-Source: AGRyM1tzn+SF6ChwEcxH3JHDBmTgOCpsJFCyvsaq1Ad8QH684/qCuoBFyH3Ljhl2le4AnKJSmHlduA==
X-Received: by 2002:a5d:4243:0:b0:21b:8483:31d with SMTP id s3-20020a5d4243000000b0021b8483031dmr13943734wrr.691.1655741204157;
        Mon, 20 Jun 2022 09:06:44 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b0021b90cc66a1sm2986096wrq.2.2022.06.20.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:06:43 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 0/3] KUnit tests for drm_format_helper
Date:   Mon, 20 Jun 2022 18:06:37 +0200
Message-Id: <20220620160640.3790-1-jose.exposito89@gmail.com>
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

Following the style used in the selftest to KUnit series [1] and the AMD
series [2], the tests were moved to the "tests" folder.
In addition, to be consistent naming functions, I renamed the
kunit_suite and the test cases to use underscores as suggested in [3].

It is not clear yet whether we want to have one or multiple Kconfig
symbols and select which test should be built. However, refactoring from
one approach to the other is quite simple, so I think we should be fine
choosing the simpler option now and refactoring if required.

Thanks a lot,
José Expósito

[1] https://lore.kernel.org/dri-devel/20220615135824.15522-1-maira.canal@usp.br/T/
[2] https://lore.kernel.org/dri-devel/20220608010709.272962-1-maira.canal@usp.br/
[3] https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html

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

v3 -> v4: https://lore.kernel.org/dri-devel/20220616183852.GA12343@elementary/T/

 - Move the source to the "tests" folder
 - Use "_" in kunit_suite and cases:
   https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html
 - Reviewed-by and Acked-by tags

José Expósito (3):
  drm/rect: Add DRM_RECT_INIT() macro
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
  drm/doc: Add KUnit documentation

 Documentation/gpu/drm-internals.rst           |  32 ++++
 drivers/gpu/drm/Kconfig                       |  16 ++
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/tests/.kunitconfig            |   3 +
 drivers/gpu/drm/tests/Makefile                |   3 +
 .../gpu/drm/tests/drm_format_helper_test.c    | 161 ++++++++++++++++++
 include/drm/drm_rect.h                        |  16 ++
 7 files changed, 232 insertions(+)
 create mode 100644 drivers/gpu/drm/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/tests/Makefile
 create mode 100644 drivers/gpu/drm/tests/drm_format_helper_test.c

-- 
2.25.1

