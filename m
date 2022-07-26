Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5E581C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiGZXJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiGZXJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:09:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBC1AF1A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h8so22002867wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwFmvFCFnxG61X2FguLsSH/7rkf2ag01ypc985KcPmM=;
        b=WQsGl3Kr3A1qawTQ6Zz8L/BuT36RV9oznguzkv2sbKXOveo6XZdQIAItrn2m1d7zcm
         yACDU6OcXbJwZyN6HhH7crei0r/Wn/1+5uXU9FihvCG80QZf5Wosg82kTO0YYjQ8A/Av
         QywOfyEj0yq0JvtOADPC5TmMSrNQT9Q++ltI2+ZrK14y9lKUQCtIURTZY//IS/Yv22Nz
         dUVAYNAK0e16gwwdaz4tDSL5oQyz7+Xv9lzMeSRTBR2QqKxg1KcN8PufzpS7VBMKpm0p
         nsbJTJarlnfCchcCHodhaGU2dDD9zcMxqlqbr7dU4FFXYh4Wfcgqf0NdMlCaIpnuFXQC
         xCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwFmvFCFnxG61X2FguLsSH/7rkf2ag01ypc985KcPmM=;
        b=XtDRMG9BN3PK4OtnxATHpmd7PCTB7p3CeBVGazODG55utG/9Za7+7/Z11eFOzTrVI2
         LeHVY2/pA6D23GoYXiPc+6MNzuk3I3nJeyWnuz5t8yTHtQaDIL1TyUB7ThFBYNycKuE/
         OQ2/DKbm9Z+pJNNe8MhPM9nAcppQ3fJAqxxe0m6tolIrNzPBF2hLYJK4DLBl7/6wTVHT
         PhyL9PDoF1lpq1co+eNcgA3EJjIGu0upLUXmMFTMXhl13t48zB0FM4PVERBHAI5FA/d2
         Zd3OFuoPqqNesrkPo0y3MIfW6H8AAKrIQX6jeRXpU2YA8rHdelpywnYsmnT2NJbb80iW
         eeKQ==
X-Gm-Message-State: AJIora+aXuluzxpLURDbYZs3rdtle8+GPH6kwx6iuv4F9wnR9TBlNks+
        c+d3BkI2yxsAHnum3kCmv9/uTW2eVlSpHw==
X-Google-Smtp-Source: AGRyM1tdcxy2N25R+h1wWjdtYIjcptfq6mjGu52yVm2VcIkYmpygzKzkyRTjVyNH47JCA++3lfeAxQ==
X-Received: by 2002:a5d:4f09:0:b0:21e:cc31:50b6 with SMTP id c9-20020a5d4f09000000b0021ecc3150b6mr245687wru.124.1658876965270;
        Tue, 26 Jul 2022 16:09:25 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0021e86504736sm7278533wrb.16.2022.07.26.16.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:09:24 -0700 (PDT)
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
Subject: [PATCH v3 0/4] KUnit tests for RGB565 conversion
Date:   Wed, 27 Jul 2022 01:09:12 +0200
Message-Id: <20220726230916.390575-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This series is a follow up of the XRGB8888 to RGB332 conversion KUnit
tests.

As I mentioned in v2 [1] I suspected that the inconsistency handling
the endian might need to be fixed.
Fortunately, Geert Uytterhoeven fixed it in commit 4d9db10576ff
("drm/format-helper: Fix endianness in drm_fb_*_to_*() conversion
helpers"), so I updated the tests to reflect his change.

Changes since v1:

 - Fix a bug reported by David Gow in the XRGB8888 to RGB332 tests
 - Simplify the test structure as suggested by David Gow
 - Add Tested-by Tales L. Aparecida and Acked-by Thomas Zimmermann
 - Fix link in the last patch (Thomas Zimmermann)

Changes since v2:

 - Test endian as fixed in commit 4d9db10576ff ("drm/format-helper: Fix
   endianness in drm_fb_*_to_*() conversion helpers")
 - Fix Sparse warning reported by David Gow
 - Add Reviewed-by David Gow

[1] https://lore.kernel.org/dri-devel/20220709115837.560877-1-jose.exposito89@gmail.com/

José Expósito (4):
  drm/format-helper: Fix test on big endian architectures
  drm/format-helper: Rename test cases to make them more generic
  drm/format-helper: Support multiple target formats results
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()

 .../gpu/drm/tests/drm_format_helper_test.c    | 169 ++++++++++++++----
 1 file changed, 139 insertions(+), 30 deletions(-)

-- 
2.25.1

