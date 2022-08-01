Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0A5873BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiHAWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAWJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:09:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D523DF7D;
        Mon,  1 Aug 2022 15:09:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso6536546pjf.5;
        Mon, 01 Aug 2022 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9Z8J3irksMZXis7Ie9brihlp5V92bNnWK5MaHlycXJo=;
        b=PiL+wNbeYjYPPXoxsUcMIi1LeUIRuIw6u9OiR1j3/5sio2e+qGd88Cbri1RfgBKSUo
         XJ+yWyVyTtbsBzo0HX61BtxEn+Sm1t2U8+ooX4EdtP/Z72p6pTTYFdweoliDLdFeZwmb
         PDiQhMStGlAVpcC4S5TLlY8sfLc/cYcMgi1uQw8VnEYfb+TGI64IvluEeXH8i383FyDz
         fGcTvKVeJczaw2DaTMPa5MroHev6cVgl0lrOo+tukNhtgoqs6+2emyLJ8NzWJkKWYuE/
         +FdJfTjDducUqsRzq8AMtqfn8gfxchW5vUfGbeOgUW1nDI0xFgUaE9FpEqyFGhEhWIQP
         Ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9Z8J3irksMZXis7Ie9brihlp5V92bNnWK5MaHlycXJo=;
        b=YsRIntJ0ic4w6jrcQfKTb2JjsxyBSeywKW8jwYDb+cb7CMhTNy6+ZVFlGJsLXmZcGG
         p4cUsuyge4XlLNVfLwt05+ywOMxAHOCg6+04yDbdCKERZinl5ftKezfnSOxEVhbsPKMA
         epJNogZHdtQYGPeoGhUegmYU+Je/YRZuR8GOHcp1jkMUQd2M2lX6DETnFgNqxFA3kDrD
         q9nNvV3ogVW5ZVk4CEoRL6lv32TRPZzWmeUUAqP0mKoqZPZwuUW8BeIcRjUgDoe8laGL
         TJUZBmuIQUx7a7zLFXlQYh3+XDgDGHu+nqPVbF+AExz3mHji/FYKSz2fnDswWvtZK1zZ
         M1Iw==
X-Gm-Message-State: ACgBeo29I3Xn2I+PG/xlEb2UbtIDPXWLPE3lq6945bDo34IyM80Zszdt
        eUz83cpepROdS47x4ESeq0vBjlSh5YA=
X-Google-Smtp-Source: AA6agR7iWd0Wn7UJ43mQfrjRZalF3kIoRd7+rxXZ8UFJ5UhnkR77njj5iyB/cVMOwmt2qJP+K0VZWw==
X-Received: by 2002:a17:902:cec4:b0:16d:7d8c:4be with SMTP id d4-20020a170902cec400b0016d7d8c04bemr17802366plg.139.1659391774294;
        Mon, 01 Aug 2022 15:09:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001637529493esm10136969plq.66.2022.08.01.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:09:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 0/3] Add Broadcom STB memory controller driver
Date:   Mon,  1 Aug 2022 15:09:28 -0700
Message-Id: <20220801220931.181531-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

This small patch series adds basic support for controlling self-refresh
power down on Broadcom STB memory controllers. We might be able to
contribute more features to the memory controller driver in the future
like accurate reporting of the memory type, timings, and possibly some
performance counters.

Changes in v3:

- made 'frequency' property optional to avoid introducing warnings for
  existing BMIPS and BCM7445 DTS files
- updated sysfs document to use a shorter and universal path

Changes in v2:

- merged the v1 first two patches
- added a sysfs document describing attributes exposed
- addressed feedback from Krzysztof regarding style and API usage


Florian Fainelli (3):
  dt-bindings: memory-controller: Document Broadcom STB MEMC
  Documentation: sysfs: Document Broadcom STB memc sysfs knobs
  memory: Add Broadcom STB memory controller driver

 .../ABI/testing/sysfs-platform-brcmstb-memc   |  15 +
 .../bindings/arm/bcm/brcm,brcmstb.txt         |  11 +-
 .../brcm,brcmstb-memc-ddr.yaml                |  52 +++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/brcmstb_memc.c                 | 302 ++++++++++++++++++
 6 files changed, 381 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c

-- 
2.25.1

