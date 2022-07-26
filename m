Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3758178C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiGZQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGZQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E71B78A;
        Tue, 26 Jul 2022 09:39:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so8484416wmm.4;
        Tue, 26 Jul 2022 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29x0nCk/ur2KUdOZUnTIumuxDHZRb0pHCThFhm3QUnE=;
        b=eswxB9oFMd4BSNn6cVnnv4RNChTe8UtyetdfRbT1oXV5VAf6YcJUBTrPXZ0VQe+kNf
         +0/N6ga2xIWLlVVuGYPllkmQImEkJf0M87MZ6O24tB9ioBD3PxZ0BneI1ZbJpVXZu4DW
         ZmzFg652az62jrOfIqLi5605sk1LGg51MmHdsdI7fyZp82ha8Em5Mrf4KoslJAhjYLu9
         pKz231jd7R7sDsu3mebgW3JKbX0xD3b0lnNqkb4IlyAjzKFacnEqGyUpoyfqjXlBTMWz
         A65qYyxKXwL6DDaonfQDvqxyum0683VRl8OwFhBkxG/is83k6uYOJvDszhaf0/YWLLUV
         Rsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29x0nCk/ur2KUdOZUnTIumuxDHZRb0pHCThFhm3QUnE=;
        b=vDVdKRGWuyI/0XUQu2uyptE1sRqbL7iwNe3N+JbLSAeGoHHzyyWCZ5VCaBVeKSptNJ
         H9CdtolAvBNlu9WivuwPQ4QXYmkH7QqNQLk1Y62o1UQP8SxrMhdXLMAo9Bhov7/UiHvl
         xklcRIIHzxAaQG+8vX3gk8OwTJTB3Pc1z3CUC/hamrdCwDRPTDxkq93FoKEhsi6GsI2k
         mas8IkNIwxKIbWvrFRV1eNq2goS0VetlsELHLQwKGBn4w48HJgo0TBUzlkuIjTymuMcF
         30SIQw1Nl2nqqmZ3wYCFkxsDsoI7NCu3+U8a8W8vaBK/fIRaKH4uejSB/bhsbBB7cU6+
         DlJQ==
X-Gm-Message-State: AJIora9rWK0ZzCXUQbiCMcGdZovUc7VWFJel5OGuU4y4WEoD9wYihRJO
        VTSWQt5EcIS8efNW5a5fgQI=
X-Google-Smtp-Source: AGRyM1sQevuEo1/3d/ZSVQq2jLHlnNo7slsoom4acFCjIgpOnRwPtpOSFtw0+CEM9oqFtCqLBh05Yg==
X-Received: by 2002:a05:600c:1e83:b0:3a3:3ecb:52a0 with SMTP id be3-20020a05600c1e8300b003a33ecb52a0mr59570wmb.44.1658853570264;
        Tue, 26 Jul 2022 09:39:30 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:29 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 0/7] XP-PEN Deco Pro S support (for-5.20/uclogic)
Date:   Tue, 26 Jul 2022 18:39:19 +0200
Message-Id: <20220726163926.10549-1-jose.exposito89@gmail.com>
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

This is v3 of [1]. Check the description in the link for more
information, please.

v1 -> v2:

First patch acked-by Daniel Latypov

v2 -> v3:

Fix bug in "HID: uclogic: Add support for UGEE v2 mouse frames".
Reported-by: kernel test robot <lkp@intel.com>

I copy-pasted the wrong template size.
Thanks to Nathan Chancellor for looking into it. As he mentioned [2],
CONFIG_FORTIFY_SOURCE doesn't catch this error without LTO enabled.

[1] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/
[2] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/#m796ac6c8f7484b0bafc1f1ed80d3ead90ae5dbb7

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

