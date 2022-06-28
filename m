Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9255CBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiF1DaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiF1D36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:29:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52BF21B;
        Mon, 27 Jun 2022 20:29:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w24so11260477pjg.5;
        Mon, 27 Jun 2022 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=EEueh/v7BkDbtKXAB/Ic2Nfainam+mEZY78i7SMnzTZOdOxMjcMOkUp/C7iosI05Zn
         76Ugras2AieqsBYb/nbsDS9hffP11cYLImGNPIZsrnf83L23VyATooTsBAAFbDtvjbis
         2il4qybGGIK78QxBJuRvpTN20JUXKAcqIbuzTHZvLq17KR/CMdEMaa6hiUeHhe1T1tYv
         0Xnp7P0c8T9veNPpQz/XvAZyTVum6Ncbfy5oujj5T8TwcYw+D4/KNyvXc216hL8/kBct
         6yzarR+F+LyB8VxlX6GMTo9vq0Hh/Rz9OB4tvmI/+5aJVw6fhAodDFdYrMjPuXVv/6EM
         Bouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1KbVuW7XSoJDS/I+9egOZ67761pOOMfzmK48C2Bte6s=;
        b=f+mB+e3PDMLMLd8u3gMKQikU2prUbFTyHmMB3o/KWIfFdZUmx8gEnu5E+jtDJdZemr
         rTvnBG6Ild4Sq2JPF0weLynspD5OlJYitB+6iAsjdOiDmc2O7YCt2/3E1LcUD3vKcpcj
         tb6ZVxqqEa8mx6IJAZhDdSkFR+h1N1qEQ3tlW+mz5dKKURRYkepXYBKRYQGo3Up1GDnJ
         N3vy31hZIW5Zs7pgwEVNzWhHEQk0UZfXy+pjIOV2zF5Y6TdXK1NpxuEUVxH+aCZyjTKN
         Lo6Z29Xq35ecGKpLTovpN+UeyeobP5UepaLuXNlU4Tfa0C/P0XiW95qYSSxgg33wku8q
         9EVg==
X-Gm-Message-State: AJIora/lSRNbiaMNuu9MpLFsQs9K823tNrt5JO07nmbzCddwTiFbp+7z
        n5CKht30G9r5v/Cw8JEH35o=
X-Google-Smtp-Source: AGRyM1tdp/7AgyD1MoZ6Lg/8L2v7IRhOFg80oiTRI3ibsnSdqFebZiSsob347DSyGp+vPNucqByneQ==
X-Received: by 2002:a17:90a:ac04:b0:1ec:81d2:732 with SMTP id o4-20020a17090aac0400b001ec81d20732mr19859152pjq.45.1656386997195;
        Mon, 27 Jun 2022 20:29:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0050dc762816dsm8091160pfi.71.2022.06.27.20.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:29:56 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [RESEND PATCH v4 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Tue, 28 Jun 2022 11:29:40 +0800
Message-Id: <20220628032945.15410-1-milkfafa@gmail.com>
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

