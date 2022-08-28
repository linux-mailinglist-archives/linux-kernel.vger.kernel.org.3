Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05C5A3CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH1JBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 05:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1JBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 05:01:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE733ED69
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 02:01:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b5so6660329wrr.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UYtdFnOEZEqfm5HH9C3uJEi/4LXalt7UYf8sjQmdups=;
        b=Rka/8601O/3M/lTmK6mxsL1ycOH930+Nwe+C1Csu9h93acxtNYx+ptNRT0vV/7iKXQ
         oZxLKLBjyudJf9980oOzgjj1AeWm7H35lO2YkzaKv0biegzca6EHj8AjIimWVG7ypcIA
         R1asA/2R/LPK93R3z99s6JnGxtWD8SjisoS9JBAv0PA9wjnXh6tXDo1euvxKzqz5Jcuw
         wRo22xH9/VaWK5i6LYwtftxupna/lJfC6zBXwlrZL3Jhq/00hvmZYLqii0g8aPMJH9ZP
         Kr9Y6gpdEK/TGaeJGUq5G7EPnyMj/KOuKPx6xXBNIaLYFb/1uGqr8bpgc2ZYpgZBQoVP
         c+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UYtdFnOEZEqfm5HH9C3uJEi/4LXalt7UYf8sjQmdups=;
        b=Eniz5aWylFXMeDnirQvnS8txDy2y/gtr/cWCEJ7HqiNE23ain6RNESiivxjk/rbn29
         MKxDj8A7+ase6TCMwLfgp/AEuabv3RCriK2P/B9NwUNUbPbyX8hkOVjt9FhYIDvno89/
         3yvdxrUvFmvqiaIBJqtGKQk0P0XPdxtw1gebnGf5rfKTnt6IQD7qEKUF8jOvNQsdpnuB
         Tq6dzRyvsqyJJLEwnL5fn9bhrk9xHprcXSwuJyqJbXNMigqN8innluC5c8Z8RIqidR7q
         E8SYLX9oDSVXqzbNuEhGkhzVZw8J5FdLEqSyaPaDTU5m5lUZCQ7dbTs+H6fL1t4x3tFD
         1GlA==
X-Gm-Message-State: ACgBeo2KEBNfFuIws+IDxRm91I9/3IfFnGarehS2/vq5h5lX5jJa7tQE
        SdlzhqW61HKbstsuhKZvHDY=
X-Google-Smtp-Source: AA6agR49R+q2KE0LxufaglaOfe9+ERfnrV6hlh5+z1fBEcEClz/Q/lt+DmrYoVIDYG2AUbiZI2HNyA==
X-Received: by 2002:a05:6000:1a42:b0:225:8b5e:e0f8 with SMTP id t2-20020a0560001a4200b002258b5ee0f8mr3910608wry.710.1661677288034;
        Sun, 28 Aug 2022 02:01:28 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003a60ff7c082sm5733425wmq.15.2022.08.28.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 02:01:27 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Date:   Sun, 28 Aug 2022 11:01:18 +0200
Message-Id: <20220828090121.13243-1-jose.exposito89@gmail.com>
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

This series is a follow up on my work adding KUnit test to the XRGB8888
conversion functions. This time RGB888, XRGB2101010 and gray8 are added.

Best wishes,
Jose

v1 -> v2:

    Tested-by: Maíra Canal <mairacanal@riseup.net>
    Reviewed-by: David Gow <davidgow@google.com>

José Expósito (3):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
  drm/format-helper: Add KUnit tests for
    drm_fb_xrgb8888_to_xrgb2101010()
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()

 .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)


base-commit: 61a9fa154d217c13eea90aa5bc635bc4b1fcb66e
-- 
2.25.1

