Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D857E815
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiGVULq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiGVULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:11:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74EA895F;
        Fri, 22 Jul 2022 13:11:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y15so5417501plp.10;
        Fri, 22 Jul 2022 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/sHqz52JCjZtTGGz1e4gK9EfsKCCo6NBQFJa9haPXs=;
        b=No6XYV/cF1q7/4YwMikQsOmP4nHdGsUYQF89/RNENnOywLKSM+0sKtK6Y8f2qqpbAk
         ZqqQMup4pfMtW5g2QC5DzwYuCxCxPSz/ZRBYSvQTG3VY8Ws/1k7QCZKwzwZZa29svKkR
         1CULsa8fGnZANIU04WsOqOEGgVgm92ahA+9eWHtVy0agppeuFloVj1BR7dE1IZCDESMz
         g1YsBZawHl+jprt+D48Hh368lh5w7vfKXMpYchJ9vVyAkjsLTWs0XXD5nucAxiEOUe6S
         DayhNBZr67gzo2bJ/+C5i2VqIs+S0oP/60pM3TacsXQ9P1IqBgtnEEiiotkOBSFQnVCW
         hk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/sHqz52JCjZtTGGz1e4gK9EfsKCCo6NBQFJa9haPXs=;
        b=RRr+NwloVpg1g1MS+w2BgtFTaoZUsoyFnry1PuXeCj3gjC0XA7o7F86bpDhXP9sJul
         odZ0DH5K4wqtpa4HiZjV0zlD/5NrLCE46TVro0J7gYP60OMtptzXLwCqgepL2SQ0PoAx
         CCCBWK0f5WbRVohblt5WDrzSdgsf/2cXk4hu2mOGcwtCQ0rcwrmcGfqqifhjeIeXAKgo
         MIbc2npxXHYxciQFTMYAspNCJS+erTDJoF0VthFIGNDmH25R9pTF20NvFzJe2NncUfbc
         cNBVUseCWFNLaFOVtJKlJyCqEdu4v0yU0zHdKNuqvOmUuOVRu+VACn3Pb5sZkzbikm9V
         2wMg==
X-Gm-Message-State: AJIora8SVCw/sgTwrwtgHEaYwd3sZFht62K6/AymxxMXU09kigEhmq6t
        ufODi+4Qy2kWq+I26ZHOjDqkCJg+JGU=
X-Google-Smtp-Source: AGRyM1tmntwkrguuJAICv9NXR4l1waxYHsCW+lA8zubnRJ8OSeVcVzxqCCIofQHq9BybvqvbBCkFhA==
X-Received: by 2002:a17:90b:4a83:b0:1ef:de4c:65f0 with SMTP id lp3-20020a17090b4a8300b001efde4c65f0mr19248669pjb.149.1658520703099;
        Fri, 22 Jul 2022 13:11:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b0016c0eb202a5sm4098604pll.225.2022.07.22.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:11:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add Broadcom STB memory controller driver
Date:   Fri, 22 Jul 2022 13:10:40 -0700
Message-Id: <20220722201043.2731570-1-f.fainelli@gmail.com>
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
 .../brcm,brcmstb-memc-ddr.yaml                |  53 +++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/brcmstb_memc.c                 | 302 ++++++++++++++++++
 6 files changed, 382 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c

-- 
2.25.1

