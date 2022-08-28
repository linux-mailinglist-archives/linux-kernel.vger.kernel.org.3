Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A365A3E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH1Qpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiH1Qpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:45:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1919C3F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:45:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so4768165wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=c6/vSF9S8NKWJSMSnwvul76XPlLqVxRis9zbs5khOBw=;
        b=MuZVZknB4CIlYavTxchdpdvUYHKuMvZpbo5YGWw/pIWFRwWmNIP7CxvD39IduL/tF0
         QowctCeEEHPVQc+ik0j6t4umkdo/tjTzvXjbxJrHrOyguxBDftyUv81WM2GGIP4Ci/wQ
         mV9EX/6O2/lYwqxExYYRKkM/RXdqHGnBiyTI+hC3+HDp+x8kfh+4QmLTM5df86Lb26B+
         kp4oSSyOFDtjgjIEy01CbVkOHYfPbfx90Pb6e2f0v1APcZsbswHc48sK/dA91cgtRlVy
         29Ayx/2g5Q8232PDUUQzt586eUKI1gYeZHpFArlj9bVKxU7/7rkX5qVzIwUFZqyNn5ue
         HSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=c6/vSF9S8NKWJSMSnwvul76XPlLqVxRis9zbs5khOBw=;
        b=uhg1O/gGGEnMNsu7cX9B9uL068E2u218cw+FybadZLpwY2VmJUGZAxJx/KkawI/g5b
         Uo1NiWxqoDpJjlyuGG69YETAxoGgbz+Xrv/GGsyIxyFSsXVOhyJeP0oLvsk7YqseECEy
         YE0nlBdcrpW7q9zF8cn5ufUdVbKVBkeNHaX6mw7naQKwGk7cSslmmUs5Jp/ObVyFK/eQ
         IxqTA+bcZVIMNjXgcR2Rc9QFaNpmYjL0YRu3NwZyGgBMdHAj1+Tfleq8STEGWkVtqxjf
         sjdZGEh5Ze4DEtV9stajnvVu+JbNGTthSeRrcxEmoTFnoSOFnX+LWNALkaB+JxJgZq5W
         NPRQ==
X-Gm-Message-State: ACgBeo2aJCn/fNJ6bl8c9oosdfh0P4ZE3NEDurJZDdH9kO+DodPn7ll+
        MIn8XgbacyX0JU9UmgC3T0M=
X-Google-Smtp-Source: AA6agR5iLmJqY7oqKbuCwfjD+Umb9mpPns3Bz3rShsNhUlEaMupPw23l6e5Z+i7LuXXFu6NotxZhSw==
X-Received: by 2002:a5d:6d88:0:b0:222:c8e2:f5fb with SMTP id l8-20020a5d6d88000000b00222c8e2f5fbmr4609958wrs.35.1661705130349;
        Sun, 28 Aug 2022 09:45:30 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0021d6924b777sm399926wro.115.2022.08.28.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 09:45:29 -0700 (PDT)
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
Subject: [PATCH v3 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Date:   Sun, 28 Aug 2022 18:45:14 +0200
Message-Id: <20220828164517.185092-1-jose.exposito89@gmail.com>
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

v2 -> v3:

    Export symbol drm_fb_xrgb8888_to_xrgb2101010()

José Expósito (3):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
  drm/format-helper: Add KUnit tests for
    drm_fb_xrgb8888_to_xrgb2101010()
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()

 drivers/gpu/drm/drm_format_helper.c           |   1 +
 .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
 2 files changed, 191 insertions(+)


base-commit: 61a9fa154d217c13eea90aa5bc635bc4b1fcb66e
-- 
2.25.1

