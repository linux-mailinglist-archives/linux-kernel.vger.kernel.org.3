Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746BB5246E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350970AbiELH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349921AbiELH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:27:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748812E325;
        Thu, 12 May 2022 00:27:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a191so3854437pge.2;
        Thu, 12 May 2022 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VgtuSspPJrZl0jLVEiIkQ6TuZqE9Z2iilbMNeSQTMxI=;
        b=P6pNllwbvdjsOPDvGlj6WiFYA2FBOGg18byFnZLrqjvxmqcGL1ouVMe5B7n0ld6Nxw
         lGvbjJju+fwxbZjeK2a9zYJHmJ+8VvJfF715SHWREAXvri5JWg4fZH3HxVKxAquLMjRz
         HI5JxydTEnbcggMP/2SsGwDpoooEUHrCuT73ZxcaFISGt5EHptHR+L074/8YLXPJxcEI
         VhgPQg8CCUmE8nonBDehT2mg3QTE+I+JkG1Br/N/Gs7DzH2lLMsiMHwk1wIsE8Bim5iJ
         U2s+4skU1/VRHJa21j3NKsvQxBQOvjYWzvqxHwHodoeUJXg7Ux5cNHXxd5dsntdvq32I
         Pm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VgtuSspPJrZl0jLVEiIkQ6TuZqE9Z2iilbMNeSQTMxI=;
        b=MGIkGVtZxlM5SD6jKKZwBuGi3Bj/atTUtI7TmKAlvohXS7Ndfz/grAQjDWVbLEEUTV
         msl//R+vJiGz+HMp8KFVSmihRSSsSQAzUS49tahjOA6jla3xk8NTYcKyxbzukJ8+baE0
         9Jwz2rZGcJhPV+Mxsv4e8+RemiCUgo76XmV759evHXKaVwY6yvEDplGQZTAxdlX3pVRs
         FfNACXb4qM/NR77RSJ+GUrglc91NgWqjY26pDO2IcY03tm4LL2CDrF0h3oQRESQrwBV4
         uMavJfQy22KWb+5cePwGv7wEPJXik/QGkUFDpFNd49GZKc3/bap+yB2kt7JYa90FB5BF
         fptw==
X-Gm-Message-State: AOAM5327xg3v8EZi4svNyACjv5S2fEM4z1QQMCFpTHaKpEVvMT+DHtQd
        D62rHCUcN5HwWHIPidgFx0c=
X-Google-Smtp-Source: ABdhPJxODcr5MqRHBIViamAPN40p1m+6snj1eKf+gSdwUTr2qMEIvN3b3sXB2xmnWCSOY52qHZIH7w==
X-Received: by 2002:a65:6aa3:0:b0:3ab:23fb:adae with SMTP id x3-20020a656aa3000000b003ab23fbadaemr23973962pgu.278.1652340456354;
        Thu, 12 May 2022 00:27:36 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79e49000000b0050dc762813csm3082779pfq.22.2022.05.12.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:27:35 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v1 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Thu, 12 May 2022 15:27:17 +0800
Message-Id: <20220512072722.25005-1-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add DTS node, dt-bindings document and drivers for Video
Capture/Differentiation Engine (VCD) and Encoding Compression Engine (ECE)
present on Nuvoton NPCM SoCs.

VCD can capture/differentiate video data from digital or analog sources,
then ECE will compress the data into HEXTILE format.

HEXTILE compressed format is defined in Remote Framebuffer Protocol (RFC
6143) and is used by VNC features, so we also add a patch to support it.

Marvin Lin (5):
  arm: dts: Add node for NPCM Video Capture/Encode Engine
  dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode
    Engine
  dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
  media: Add HEXTILE compressed format
  drivers: media: platform: Add NPCM Video Capture/Encode Engine driver

 .../bindings/arm/npcm/nuvoton,gfxi.yaml       |   41 +
 .../bindings/media/nuvoton,npcm-video.yaml    |   87 +
 MAINTAINERS                                   |    1 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   19 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   12 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-video.c   | 2074 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/videodev2.h                |    1 +
 11 files changed, 2240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c

-- 
2.17.1

