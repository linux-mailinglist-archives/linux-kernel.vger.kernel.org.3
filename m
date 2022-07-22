Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8757E6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiGVSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGVSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:41:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CD80F64;
        Fri, 22 Jul 2022 11:41:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id go3so5122975pjb.0;
        Fri, 22 Jul 2022 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3F+3beTVyq4ZE5Rzvt206g2hbCA+k/uqI3STZYdYGQI=;
        b=jyPs+8tPYzDpgdc5JpOmvjAPGXGFwiXc40Rt3zS0WyKaBIBWH4TB9TIOoecsAHDHnj
         cC6+3Hj5nZY9Sd9VTlJ8BNFegBdY/TSPkN75QgCpruTSGMe1midiOW14olLhmeCud3+J
         5gjI/lFI8as3ZfYFKlYH9Wqeo5u4AlNXKJF8b76KvM3AK0E10vOOI3IsIB1H1/NtYRT5
         RjFCXlTRZiaMqvFfgaW0C2desHKlW9ksoVQh9/nY5PS3IZREzrmXA96gOri23nG0u4ON
         piEU8/Ay4evsRvCqKzepKjlVTa9t+FsjVZeCeD2LM75EyPC40CNQNuqyGsP3h0DV4o/n
         0DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3F+3beTVyq4ZE5Rzvt206g2hbCA+k/uqI3STZYdYGQI=;
        b=5wUueGQXm+Eian6gRy5ZNjKdGHET0DgPcNKXbBNFFAmx8evNAg47UGbdbCy3mJKtR3
         nJybKyXlAusWuBFP0RjLH5gCk+fVCcEJbhuvYGEKizePjmxPeSXAU3SYEk/eWY9aQZ+f
         SX818OVSuYKN8LFN2L8y+4U3VUXlEeRFEdXVeqP4Xphd1WsVvlp4B7v2hLWPTpM3kTzQ
         /KLvFhRofMxl7ycyH6QOTfFJkAYPQ6waAiX8ws3uDjVBJ5letLyhbLJbfHPwKrjg/rXv
         ebySSdn7vrhCZdNxGLLdI1M7pq8RDHLxxt77oipdPMy4ASC0EQemDwqEzb6zbK1Y+kex
         kLBg==
X-Gm-Message-State: AJIora8QQw6XnVBg5Rf3G2+qYvgsabss2FSWJfH3Ya6wGoc95L3c3OhV
        aDx08XIkCVVZJMJ2tnz4lkPgSuhkIiw=
X-Google-Smtp-Source: AGRyM1tvuaHnD39derlvitnaqzi1EctzVvYDSioOlGmiWU76tcCoIre9bBMzrbYihQ0gt+qHuCtewA==
X-Received: by 2002:a17:903:185:b0:16c:3af7:dbc8 with SMTP id z5-20020a170903018500b0016c3af7dbc8mr1124664plg.147.1658515301954;
        Fri, 22 Jul 2022 11:41:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016c9e5f291bsm675976plg.111.2022.07.22.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:41:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/3] Add Broadcom STB memory controller driver
Date:   Fri, 22 Jul 2022 11:41:35 -0700
Message-Id: <20220722184138.2666241-1-f.fainelli@gmail.com>
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

Thans!

Florian Fainelli (3):
  dt-bindings: memory-controller: Document Broadcom STB MEMC
  dt-bindings: arm: bcm: Refer to the YAML binding for MEMC
  memory: Add Broadcom STB memory controller driver

 .../bindings/arm/bcm/brcm,brcmstb.txt         |  11 +-
 .../memory-controllers/brcm,memc.yaml         |  49 +++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/brcmstb_memc.c                 | 304 ++++++++++++++++++
 5 files changed, 365 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c

-- 
2.25.1

