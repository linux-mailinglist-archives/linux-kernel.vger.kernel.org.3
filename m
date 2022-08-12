Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0F5914D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiHLRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbiHLRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:31:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C9A6C09;
        Fri, 12 Aug 2022 10:31:33 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h4so1261400qtj.11;
        Fri, 12 Aug 2022 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oaUCbnaOaO/kjQKPb1GH5mFqVp7+u4EfhIP4oZeH2rc=;
        b=B0rNvBv6hqNrcuknu/vCYkIKosD0gYESAPCt88QuIfjZA+18svJX19VTMvOoxsW73U
         NROpiFTH+uCXZyFCY8gDvz0w9oBvsaSrSeSdfFQhmdfI6j0F8UqLn2ebqFE0HPyq2+Up
         dl3KD6xf3AYcecK1U6lBv5zzNAdToOTbdLGDnquE4rakysKmQbUzWUuYBpyYs7hHrVJy
         UEX+dcX2VcZd4DEqv6Kx6uC7axX4n1U61gnqNl6l2ekP6E/rYowW3fX+JIfxGYd2a+kO
         bfLdzS1nofFHUXJMQ4V0Cf+yspmM5FwHRvpNg2Er+kkkpzkj0Ekj3Kv2lMH8Nb+Z0W0h
         BK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oaUCbnaOaO/kjQKPb1GH5mFqVp7+u4EfhIP4oZeH2rc=;
        b=bLyEtC5FiicyvWjnF6Y07+ZmldjEf6LJtZ0DByp7S0zOQD0vvWGScHFHjHpLF7fvVU
         /olMuRy3qCJNDF3pcDgwDjA4sVGm4QU9nZEKcHSsum/r2KIy5DycHZSrGvYQ23zpV3Rf
         lbMm2qQ3P5qfmboDWGymQiCElmoDrB22wfNPQ5mtKs70x0CBaUeSIlu83k4dHlz1klgE
         ZimppbS4b5THmO1xM0Q0/oTOGUNmHgoVulr6n2O4yQVOhH0AWwHeA5R6pbgAkRG56vxf
         CsJ2nFGfP3hgcImW1jLkvAZpFeqHQQVV5KoDavJsMRMsPMZ6WcLlIHFt2eJm6338OXhy
         0HoA==
X-Gm-Message-State: ACgBeo1r3+x0r+Td0iST71DL8KRD4dY4VWwfAy2IZtaCqsjBbCC82smz
        Ev0hrzVghcQxDdxOVBS4nao0e3afaj0=
X-Google-Smtp-Source: AA6agR7a7RItEv6RiqJofk5V9VwUYBiQCFeU6ZbqJ9yF7/cvZy1OCN6eGtx51fFO07l7SpWaP4c3iA==
X-Received: by 2002:ac8:7fd5:0:b0:31e:f229:2bad with SMTP id b21-20020ac87fd5000000b0031ef2292badmr4451404qtk.528.1660325491703;
        Fri, 12 Aug 2022 10:31:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9b7879964sm2369300qke.28.2022.08.12.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:31:31 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add Broadcom STB memory controller driver
Date:   Fri, 12 Aug 2022 10:31:22 -0700
Message-Id: <20220812173125.2410536-1-f.fainelli@gmail.com>
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

