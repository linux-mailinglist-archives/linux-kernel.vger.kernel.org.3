Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D125559174F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiHLW0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiHLWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139712D0B;
        Fri, 12 Aug 2022 15:25:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id u24so1837140qku.2;
        Fri, 12 Aug 2022 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=22h/M/V860IplmghhOOIgt/faKZklILiFH5PQHaZGuQ=;
        b=bV9JUvVE2HdIowfvyhODwSprmEzqvEvIWJkWCX8mGzO6O6Mb1X9tyyTDSJkEV3J9kv
         kcqGPhbxTK5TKWHzG6ebBjnWGzzLcWZncl3zl3ODqWLTsFDspWHUzX06bIROnZ8g2lDS
         gDlBDvInrqAmpk6V+6S9n9WXvQeahiUbo+RB6ZxCY5WgaRydlEb/+VqaYbiHMb2IZB/1
         4tFvrZAA2ikeutY2/agaLhtNF3zHs+ah7eKPInVxsGcw6zPVj3Oeksz0icXkV3vGhktC
         cQ83UZrwaYGnilwnF4VaJhvGeRxBKN/8FnY5XPQnmMqGw+OzdV8Xgl1xLxsMlX3LCcgZ
         /jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=22h/M/V860IplmghhOOIgt/faKZklILiFH5PQHaZGuQ=;
        b=GZQ7Q1phPgLaMkawfdH+m99Z/wEkUYTtCbaUFYdPCbB8alJxz320bLwS+2gKOe24M7
         q5pzaLGzGrWyU+9dvb0grebTfShtmJadt7H7/926vd9dnuXOV6aCQ9At+Y8jejzK/mWl
         6hIgXPQ5e8uKkCyfc9jbZqYh+jZcdDIGD5tu81JxQcFfSpzakxgD+NVkR75PVhG19Xpr
         RncgleF+rZ7n7eUfStEOybkedZP3lbO/FZ/ol55PL0Z6N6Pcnl0M1JUeRixKaYOYwJzu
         GAqyBCSTpL9uTNSSYypPExj6mZJwaIE4ZAGznYaRLfFuNluDvdkk1FvPTxDRIgZEnATU
         MH2Q==
X-Gm-Message-State: ACgBeo3rIvEDLad7yg1CsAp5kPt7egfqgTt0EB2n3N78XYlWRj1VRYhp
        dzKE8zMUC2Rw9JD/Y+HNYeJkDbgBzlw=
X-Google-Smtp-Source: AA6agR4sfKig+81R21IHRCKMPg1+J43EyxVKJ0AjLE7V76UMtM0QABWO3kvjmalmekrTXtUjv3gzOQ==
X-Received: by 2002:a37:88c3:0:b0:6b9:53c7:75e4 with SMTP id k186-20020a3788c3000000b006b953c775e4mr4299661qkd.532.1660343136819;
        Fri, 12 Aug 2022 15:25:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a409100b006b942ae928bsm2788878qko.71.2022.08.12.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:25:36 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add Broadcom STB memory controller driver
Date:   Fri, 12 Aug 2022 15:25:30 -0700
Message-Id: <20220812222533.2428033-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v5:

- use DEFINE_SIMPLE_PM_OPS() to avoid keeping the __maybe_unused

Changes in v4:

- drop unnecessary owner assignment for the platform_driver
- use pm_ptr() as directed

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
 drivers/memory/brcmstb_memc.c                 | 301 ++++++++++++++++++
 6 files changed, 380 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c

-- 
2.25.1

