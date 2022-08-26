Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2335A1EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbiHZCmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiHZCl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:41:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8835533A12;
        Thu, 25 Aug 2022 19:41:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pm13so356598pjb.5;
        Thu, 25 Aug 2022 19:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=7xmFFYm+XcYvKh7z4do1m6bswn3gHfIMo5PCJ65CLMY=;
        b=djM1cSOi3W4T9puhAdrRPIIF8Du/zeee5X7KEGDTXTnPzNo+VEe0yGiweRfDBhQXSL
         auLCS+g8KvGJNnakSFss2N6vWJ2wxflfkLylwNpJTctjjHoC0vI1pCzkwH2u3Fl43v6w
         PHQwUf7glMQ73LFqQlpw+BTASrkurrzQzE0GiLLbQG+xxxVRH0tkyMBym5A43mqPEeAR
         oLTR4FTIFydN2HUlFtmYg2l/u083PbxK+iYFr9Avib/7/3opBiXSDebSIJWOQ3QfKTcX
         RBAu01sz05rlkG5OMY4oV+MiM+pu5Iy7B5iI10fXzuwKzRPuL2iRVhZhccRbohjfN/RT
         vNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7xmFFYm+XcYvKh7z4do1m6bswn3gHfIMo5PCJ65CLMY=;
        b=70C4p6Ktb8BcgDmDc7GbPZsT8Vd6HzDDNd+APuu4fK8ui9PyTvowjynJpFR2q5+zza
         qMFb3+MyJwWuhkDNMazKRNUBM47NbKwN7a0YPdiEtOYdh0NAvByTI1dLzChwAIlihhZs
         Mi7XKAGXtqqoYbPeOtw3gCGXRJaFgtZxtbxSB5U7WEKx+eavD5NS3mOtc8GjiJTpGDyq
         jll1K6Qp4QvOQMj6vbEj0SWKxzg8nDXWo2D8MLy9H4GScb3Pc5nfDG+0ZZ40ugx8I5Kl
         +GtVBAPJUnqQjkYjkLTL/5nwImOwHYUc5H1eJ3XavPQKvHN4AOVOtuOU66Ptcea/d7wJ
         xsGQ==
X-Gm-Message-State: ACgBeo0u7/BAns8UjasieHzAu6I6kReKyX8gp0H7CbuNe9qBu/c3g2Jn
        tHZLoAnW1kLceBIN5FN2DH4=
X-Google-Smtp-Source: AA6agR5x0IhdFPivC2pfQKnAkFj8iM7odo3NM+06iBY5Y1IaAVfJti6/b6yByKNrzSmIY9tg4aqH+w==
X-Received: by 2002:a17:90a:c78f:b0:1fa:e505:18e6 with SMTP id gn15-20020a17090ac78f00b001fae50518e6mr2047814pjb.23.1661481717811;
        Thu, 25 Aug 2022 19:41:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a69a500b001f021cdd73dsm444473pjj.10.2022.08.25.19.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:41:57 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v5 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Fri, 26 Aug 2022 10:41:19 +0800
Message-Id: <20220826024124.22747-1-milkfafa@gmail.com>
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
then the ECE will compress the data into HEXTILE format.

HEXTILE compressed format is defined in Remote Framebuffer Protocol (RFC
6143) and is used by VNC features, so we also add a patch to support it.

Changes in v5:
  - Simplify function prefix "nuvoton_" to "npcm_".
  - Increase VCD_BUSY_TIMEOUT_US and ECE_POLL_TIMEOUT_US to 300ms to
    prevent polling timeout when ECC is enabled or system is busy.

Changes in v4:
  - Fix compile warning reported by kernel test robot.

Changes in v3:
  - Add video driver entry in MAINTAINERS.
  - Change config name to CONFIG_VIDEO_NPCM_VCD_ECE.
  - Reduce the waiting time after resetting the VCD/ECE module.
  - Correct data types of some variables.

Changes in v2:
  - Add Hextile document and locate with vendor formats.

Marvin Lin (5):
  arm: dts: Add node for NPCM Video Capture/Encode Engine
  dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode
    Engine
  dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
  media: Add HEXTILE compressed format
  drivers: media: platform: Add NPCM Video Capture/Encode Engine driver

 .../bindings/arm/npcm/nuvoton,gfxi.yaml       |   41 +
 .../bindings/media/nuvoton,npcm-video.yaml    |   87 +
 .../media/v4l/pixfmt-reserved.rst             |    7 +
 MAINTAINERS                                   |    9 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   19 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   12 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-video.c   | 2056 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/videodev2.h                |    1 +
 12 files changed, 2237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c

-- 
2.17.1

