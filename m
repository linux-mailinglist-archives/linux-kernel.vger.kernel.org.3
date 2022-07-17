Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D995776BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiGQOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiGQOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8EFD0B;
        Sun, 17 Jul 2022 07:43:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so3538605wmi.1;
        Sun, 17 Jul 2022 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nXzr6RXTjmwManVEd/M1NzDTHAv1xLQeADv/g9hsBw=;
        b=Wh0Uk6J8JtbDSh+iS+CJvs962lJuYfDS91VIX4Y7C73tRWP743GDoiXSX+R0pTtCUE
         BU3sZWunf0zQXKdHrYZVpC4F3IoOyJhagbgIaoCl9tApAdBdS+zCuAIcPrNOTHmEADTl
         CdykEFAqgpFFYnklw61niymytzjHrbQQbb8N3OoVd9fNKVRft0boAWC/+LeIrpmGnPdU
         jt3hb/aG65/vSuUDciIynxzbLBmXo3Q66SmwwwBcQzDx8et0GoBZ2Wo+A4tRtkyB/SsX
         5I3cnN3MRg3/RxtGCWjyKsDMVEKp//lGWgbGdgc/1/uYpv0Vvm9BZ2bjcf5R5gBEzN32
         c4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nXzr6RXTjmwManVEd/M1NzDTHAv1xLQeADv/g9hsBw=;
        b=BoM340WEP2k0nhKJHq/r6g6Ou8YlXyN4uSVcv7QDqaVG828TpAxeDvaJ6jXWQ/NUij
         K9BbR6psfldQkyFoAaEnc1caXt+tKxqLZowSQbX3VOUHQlbN72U3D5wA4T2oFiLWNItY
         Hv+b4ctclS2bW1H7V+nhZ4GiDo1ode9vTf5HF7EWCLgDvCfk5G3A8osjga7PXR5cOxM6
         nOvoV9Q/D/i4Aun3OQiANz7Dwx/qxVaDrimt/BbLLZZXUA71cZNmIBR1qWGND3zgeHWf
         PIm1Q+u5jsCo3/jWjLsjD/YLlfRtk1JcurnJhqEa4tvfw+F40IFAvIcn/h/QcZ5tWQCh
         Fwqg==
X-Gm-Message-State: AJIora/CGY+HrwbuIyKri7lPTVoQKxHzcHXT6JmW/nm3yGpDbajdFqzL
        A6e/I6YaUIB8HvsGwQDPajU=
X-Google-Smtp-Source: AGRyM1sivoj/mvrgjyl34nlF+tobq79sQiOhJIaZqIuygzddoBuAAg+kOklPQkoaks7ufrGA3FjzRg==
X-Received: by 2002:a05:600c:a0b:b0:39e:22ef:1a0 with SMTP id z11-20020a05600c0a0b00b0039e22ef01a0mr22787319wmp.46.1658069017156;
        Sun, 17 Jul 2022 07:43:37 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm8432001wrp.25.2022.07.17.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:43:36 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/7] XP-PEN Deco Pro S support (for-5.20/uclogic)
Date:   Sun, 17 Jul 2022 16:43:26 +0200
Message-Id: <20220717144333.251190-1-jose.exposito89@gmail.com>
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

This patchset adds support for the XP-PEN Deco Pro S.

Like the Deco L (for-5.20/uclogic) this tablet is a UGEE v2 tablet.

The first patch is not related to this tablet. It fixes some naming
conventions on the KUnit tests.

Patches 2 and 3 just move code to functions and add more unit tests.

Patch 4 parses the tablet string descriptor to get its frame type. The
values discovered so far are: only buttons, buttons + dial or
buttons + dial + mouse.

Patches 5 and 6 add the descriptors for the new frame types.

The last patch uses all of this to add support for the tablet.

I don't have access to the tablet. Credit for testing the patches and
providing the required recordings goes to Jouke Witteveen.
This fixes an issue reported in libinput:
https://gitlab.freedesktop.org/libinput/libinput/-/issues/738

Best wishes,
José Expósito

v1 -> v2:

 - First patch acked-by Daniel Latypov

José Expósito (7):
  HID: uclogic: KUnit best practices and naming conventions
  HID: uclogic: Refactor UGEE v2 string descriptor parsing
  HID: uclogic: Refactor UGEE v2 frame initialization
  HID: uclogic: Parse the UGEE v2 frame type
  HID: uclogic: Add support for UGEE v2 dial frames
  HID: uclogic: Add support for UGEE v2 mouse frames
  HID: uclogic: Add support for XP-PEN Deco Pro S

 drivers/hid/Kconfig                   |   2 +-
 drivers/hid/Makefile                  |   4 +-
 drivers/hid/hid-ids.h                 |   1 +
 drivers/hid/hid-uclogic-core.c        |   2 +
 drivers/hid/hid-uclogic-params-test.c | 192 ++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.c      | 225 ++++++++++++++++++++++----
 drivers/hid/hid-uclogic-params.h      |  10 ++
 drivers/hid/hid-uclogic-rdesc-test.c  |  22 +--
 drivers/hid/hid-uclogic-rdesc.c       |  74 +++++++++
 drivers/hid/hid-uclogic-rdesc.h       |   8 +
 10 files changed, 494 insertions(+), 46 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-params-test.c


base-commit: 0cb1fc0988e32bda84c2b7218e0c761af1430baf
-- 
2.25.1

