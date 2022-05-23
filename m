Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD05308B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiEWF0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354238AbiEWF0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:26:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADCE0F;
        Sun, 22 May 2022 22:26:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b135so959572pfb.12;
        Sun, 22 May 2022 22:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=PDO1ltwCxEDERQBIHyx4r4g1N3u1jliI2hd3dINmAuIcmWY1hRByK+vIHhWkSCOkS6
         3OcbZQtuCQhx5/HxTzceSahPqDktr8YZaJfdXLEw83cnlWTNWZSAGvNJnU6G/mT+Vhg6
         y/yD/meUpuhWca5rBY/jeKItZGSjzXH5Zj5at/pDUJV5Z5ExeFc0m+PW7+M4fpYUSdiZ
         P6Owbzrq+kuao0WwN/SIs+13qZ4o33Ml2IFjeq1eF8FZ4b+xtQPzfvgf62ERgboylu0s
         1JI7/yTxpRQ0ITxRduHgXBJ3rn6Ir3RZ5gomzT5zn1SEGgvCSAgKUq1Fc+SF4KUc0MYz
         nSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=8ATGp+JjR2UumGzNrNaST/C9JqdTwiBMGyfSBtoGCsKBEv6MEWPPZiykGcYr6Ig3AN
         ZqFciqyQzLEekWCyVgUqr2wq/ZCf/mtXoDfga4xJefoFkhAVYDBqZ6elsmvcn01x+J7l
         zm0wYh/WVoJ2qWwsB5AB1i4jo8SZ/bEiK/D1Ulg8uokuGFdnjx0uT5uj19taZ0O3vNg2
         XfT59s/sqYGbkmRULdYhRgs5Lc/hV8Y2TYkv4J5he/6rr6q/oOH+xkvOZz6w5TTMi0mI
         8b28cwPsvbHGz5K+nbQdKxLoDfCByLB1yt5AVMIFdpY5UKPPasJG1Cf0Jf2rXUrrM3sX
         Q3Fw==
X-Gm-Message-State: AOAM533b3ml+4+dntnuzKTdWwKoZVuNqjmwhlWog8GqJFNxFAEVVo3Yy
        Gso9QcMOePvz4RQUkKnwQ+s=
X-Google-Smtp-Source: ABdhPJxMEVyiGL0U4n+8vRcPFSHCqcgT+LNDVchrhOc2LvrfGLbmG6DNgad/j2Ve9slnTtiqf3szaw==
X-Received: by 2002:a05:6a00:14c8:b0:518:7789:d33b with SMTP id w8-20020a056a0014c800b005187789d33bmr12846585pfu.36.1653283564770;
        Sun, 22 May 2022 22:26:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a655285000000b003c14af50603sm3871523pgp.27.2022.05.22.22.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:26:03 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v4 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Mon, 23 May 2022 13:25:43 +0800
Message-Id: <20220523052548.28109-1-milkfafa@gmail.com>
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

Changes since v1:
  - Add Hextile document and locate with vendor formats.
  - Add video driver entry in MAINTAINERS
  - Change config name to CONFIG_VIDEO_NPCM_VCD_ECE
  - Reduce the waiting time after resetting the VCD/ECE module
  - Correct data types of some variables

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
 drivers/media/platform/nuvoton/npcm-video.c   | 2064 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/videodev2.h                |    1 +
 12 files changed, 2245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c

-- 
2.17.1

