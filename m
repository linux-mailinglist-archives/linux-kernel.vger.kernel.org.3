Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B823C564033
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiGBNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 09:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 09:11:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852EA452
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 06:11:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i126so7124786oih.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RupxMxCxKs9ErkkcGW/g6QAr9lKKxyugyfH5KsoLAkQ=;
        b=IogenoFZrlCEGX85ncuCjvqVU1u0Fj4d4/MbLm3RpiqFZNLPRoOjHAiVNAua+Q8Udc
         gHwCPe1N+7FT+4StSnKWdaRCzPy3dJRdV5enB9cvAH3NaqvTVTPj5yZj9TFVLXjufd97
         /4Vkh2ayCDR4nwNlqqvuxqsiyEPyMX8lB3I+7YaxmCwD+MRo6jXM2gdx07ntlhShxVfh
         q/kZmmYLRL7PFCVvb0K356GuAY60lNdICKC1QuFzPbEz03NVU7Gp5SaIkCIPc6v+tF58
         q58wf2hJGJSQpr8TD/TylsuddpGxMzi0sj/El5FLjFMSYj7sHnZMzAPWqjbpJ3EioU+D
         JZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RupxMxCxKs9ErkkcGW/g6QAr9lKKxyugyfH5KsoLAkQ=;
        b=Gx0x+9ohXJzgrVzZKG6Esl4d6gRX2Y6h7O8bSfxIU0MTDQF/SfSLVeE0J9ITKIgPrS
         zFF7CihLs2VRT/PNTuYdTEN7rrRqlg9wrmW4ddJd202j7WhlbScxdJyw5/melBNE4Mba
         CtjNvrgwtgKn8tiW3iJHt5hNJtMNAFcyKsjOGrI+YQWS5kY+ZIXk38mNAVfWORi6wWOv
         kk5cEs8M27IrHsPyZog0jL5wadIbJbYLeQeSJB0/prA2bqE+y3fb5BGj+ZhcGcx2AxZd
         1ZxB/2Kf7oQZqzpYpDGQ/ypVESLTi0aq6topdU6/a5lH8HuH/EDcK44X9CGqQixekMh1
         vn0Q==
X-Gm-Message-State: AJIora+bPN9MNFA+rpCC80PR+lbqI/+r68ERW+e/sgJAEfYzpnVq2Ytz
        GQQ+jv9vq6hEE9vne5xH6AYPDg==
X-Google-Smtp-Source: AGRyM1tlyNe8G0Vo+08JZOL72QUUSFmbe/f1fpCqn3lJWPQRdcy+LNEFvE3a4BduMm+VMxbvLkKzlA==
X-Received: by 2002:a05:6808:f94:b0:32f:6378:d8b5 with SMTP id o20-20020a0568080f9400b0032f6378d8b5mr11634868oiw.171.1656767500386;
        Sat, 02 Jul 2022 06:11:40 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d718d000000b00616afb1f1e2sm12643206otj.19.2022.07.02.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 06:11:39 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH v4 0/9] drm: selftest: Convert to KUnit
Date:   Sat,  2 Jul 2022 10:11:07 -0300
Message-Id: <20220702131116.457444-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Here is the v4 of the conversion of selftests to KUnit. Since the v3, there
have been minor fixes, asked by Javier. Basically, fixes on the SoB chain and
addition of Copywrites.

Thanks for your attention and any feedback is welcomed!

Best Regards,
- Maíra Canal

v1 -> v2: https://lore.kernel.org/dri-devel/20220615135824.15522-1-maira.canal@usp.br/T/

- The suites not longer end in _tests (David Gow).
- Remove the TODO entry involving the conversion of selftests to KUnit (Javier
Martinez Canillas).
- Change the filenames to match the documentation: use *_test.c (Javier
Martinez Canillas).
- Add MODULE_LICENSE to all tests (kernel test robot).
- Make use of a generic symbol to group all tests - DRM_KUNIT_TEST (Javier
Martinez Canillas).
- Add .kunitconfig on the first patch (it was on the second patch of the series).
- Straightforward conversion of the drm_cmdline_parser tests without functional
changes (Shuah Khan)
- Add David's Tested-by tags.

v2 -> v3: https://lore.kernel.org/dri-devel/20220621200926.257002-1-maira.canal@usp.br/

- Rebase it on top of the drm-misc-next with drm_format_helper KUnit tests.
- Change KUNIT_EXPECT_FALSE to KUNIT_EXPECT_EQ on drm_format_test (Daniel Latypov).
- Add Daniel's Acked-by tag.

v3 -> v4: https://lore.kernel.org/dri-devel/9185aadb-e459-00fe-70be-3675f6f3ef4c@redhat.com/T/

- Add blank line after #include <kunit/test.h>  (Javier Martinez Canillas).
- Make the order of the tags chronological  (Javier Martinez Canillas).
- Add Copywrite to the tests (Javier Martinez Canillas).
- Add Javier Martinez Canillas's Reviewed-by tag.

Arthur Grillo (1):
  drm: selftest: convert drm_mm selftest to KUnit

Maíra Canal (8):
  drm: selftest: convert drm_damage_helper selftest to KUnit
  drm: selftest: convert drm_cmdline_parser selftest to KUnit
  drm: selftest: convert drm_rect selftest to KUnit
  drm: selftest: convert drm_format selftest to KUnit
  drm: selftest: convert drm_plane_helper selftest to KUnit
  drm: selftest: convert drm_dp_mst_helper selftest to KUnit
  drm: selftest: convert drm_framebuffer selftest to KUnit
  drm: selftest: convert drm_buddy selftest to KUnit

 Documentation/gpu/todo.rst                    |   11 -
 drivers/gpu/drm/Kconfig                       |   20 +-
 drivers/gpu/drm/Makefile                      |    1 -
 drivers/gpu/drm/selftests/Makefile            |    8 -
 .../gpu/drm/selftests/drm_buddy_selftests.h   |   15 -
 .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
 drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
 .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
 drivers/gpu/drm/selftests/drm_selftest.c      |  109 --
 drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
 drivers/gpu/drm/selftests/test-drm_buddy.c    |  994 --------------
 .../drm/selftests/test-drm_cmdline_parser.c   | 1141 -----------------
 .../drm/selftests/test-drm_damage_helper.c    |  668 ----------
 drivers/gpu/drm/selftests/test-drm_format.c   |  280 ----
 .../drm/selftests/test-drm_modeset_common.c   |   32 -
 .../drm/selftests/test-drm_modeset_common.h   |   52 -
 drivers/gpu/drm/tests/Makefile                |    4 +-
 drivers/gpu/drm/tests/drm_buddy_test.c        |  750 +++++++++++
 .../gpu/drm/tests/drm_cmdline_parser_test.c   | 1080 ++++++++++++++++
 .../gpu/drm/tests/drm_damage_helper_test.c    |  637 +++++++++
 .../drm_dp_mst_helper_test.c}                 |   87 +-
 drivers/gpu/drm/tests/drm_format_test.c       |  287 +++++
 .../drm_framebuffer_test.c}                   |   26 +-
 .../test-drm_mm.c => tests/drm_mm_test.c}     | 1136 +++++++---------
 .../drm_plane_helper_test.c}                  |  104 +-
 .../test-drm_rect.c => tests/drm_rect_test.c} |  125 +-
 26 files changed, 3406 insertions(+), 4338 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/Makefile
 delete mode 100644 drivers/gpu/drm/selftests/drm_buddy_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_buddy.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
 create mode 100644 drivers/gpu/drm/tests/drm_buddy_test.c
 create mode 100644 drivers/gpu/drm/tests/drm_cmdline_parser_test.c
 create mode 100644 drivers/gpu/drm/tests/drm_damage_helper_test.c
 rename drivers/gpu/drm/{selftests/test-drm_dp_mst_helper.c => tests/drm_dp_mst_helper_test.c} (72%)
 create mode 100644 drivers/gpu/drm/tests/drm_format_test.c
 rename drivers/gpu/drm/{selftests/test-drm_framebuffer.c => tests/drm_framebuffer_test.c} (96%)
 rename drivers/gpu/drm/{selftests/test-drm_mm.c => tests/drm_mm_test.c} (58%)
 rename drivers/gpu/drm/{selftests/test-drm_plane_helper.c => tests/drm_plane_helper_test.c} (62%)
 rename drivers/gpu/drm/{selftests/test-drm_rect.c => tests/drm_rect_test.c} (53%)

-- 
2.36.1

