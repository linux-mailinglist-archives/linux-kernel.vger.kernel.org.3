Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8ED52E2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbiETCsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiETCr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:47:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4E14675B;
        Thu, 19 May 2022 19:47:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so10329964pjr.1;
        Thu, 19 May 2022 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=DjIc+Wo49kCqJg/FkuRXmC89Ony0yoizgWJPv5dNXvlZiERI1Kfwf6/BUwC/D+UIX9
         Ma4XWnlvhiT6md7t1eFGmZwL2LY5l/hA9UyW1gf2W8ACgCFVE+ZNgz5yGutCEaA4N2vf
         cKqVUDCdXfauT0j8JHgMWm3cUfHHjBJT4vq34LZ3TAqN3PcIu5z9yEoukk0zxY9sBKtZ
         Uw0cenW3JdipOtG859J8F4+5i4hjDKZebQVTGU+e8jn7BVUIYDv+IkmYljKKfvC4in5D
         ID6+IlF5lle1qQuAK6g51MWIe1fCnM55Go99RkquctSrPpzoyT1MpF3afNVXLdli9Cwl
         ckLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=AlIfE7QupJsCVouS2GALTMAqNjrQ74LVxhQZhgnu9fSd2z51GOijLoOfFVfOib8Hbr
         Vlc0wCgCHQz8Xi1AMsmNveYyNFCstXPLdfy6Z8YrJ7uUb2BlnS4uMvUp53IRWQXQhhrQ
         sAsf0J6FlvIq3/amNA1ppSA7h342ZHdhU2H0TZYOy6octS84VbmetCpUSxkKO8c7QSpS
         gqgW7umBfTTAoEc9yPto1cT9/B6bCk8SU7Z8fIS+AiQrDGOsKnfBOLCgfYMjhujCCPWN
         9eUiTAvUr5OpelNWKRQPyxRu07zwmExo7lH8WN3YETTvY9eRhA+oOc3FY0FvaYLSbwou
         4KJg==
X-Gm-Message-State: AOAM530+P3oesFjcWPa7ivuiuNZN03mHGFDRRklfpsGdwTzvAeXj8H9S
        xN6vROdWg87bKQAy/RYBAoc=
X-Google-Smtp-Source: ABdhPJy2uFtFFtN9rWyLz0yS4jZov005QUyAqUS2Ux+p8b3SBjFXKYwDlWCJ5OAifMB6G0FHkzSZoQ==
X-Received: by 2002:a17:902:8c92:b0:161:e861:861f with SMTP id t18-20020a1709028c9200b00161e861861fmr3477531plo.33.1653014876607;
        Thu, 19 May 2022 19:47:56 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm379406pfe.218.2022.05.19.19.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:47:56 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v3 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Fri, 20 May 2022 10:47:39 +0800
Message-Id: <20220520024744.25655-1-milkfafa@gmail.com>
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

