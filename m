Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB9525A28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376791AbiEMDfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiEMDfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:35:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E128C9FF;
        Thu, 12 May 2022 20:35:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so9656633pju.2;
        Thu, 12 May 2022 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xB3Nks/3PZ8n8YE9KWGnAkbqCqvpCjSbkXuUmVufMJE=;
        b=e5KSV/frgL0y90h9WqaG4FkFK9FPt3hC1zgca8AjROj+zUJka/k48R426iC/Z+T8rl
         HbMLuv5luVQb/LxqPQmj7ZvmAoK6HYQQJ8LfGaa0BJLx92RQNiNkUJrfWjUbGzMblwfI
         ps5AidIQnesJSyVuioiiMJ0JHhfQVH1NTuyWkqIKUPq4nqHb/wgyHxX67+kOhB9FYD/M
         +VyCgOIZSz9Eqj61XIWVtZIDMjybh0KHHh+rbrvKfw9IPBLDEurn+RN2m9s/xJL8ANNf
         l+qv0p6f/QCX9cAHVspG7kbz0rIf/aWK+6MNsxX1mJROEgq/R7tn8SsGV77s+1ANri/Y
         bmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xB3Nks/3PZ8n8YE9KWGnAkbqCqvpCjSbkXuUmVufMJE=;
        b=KFxk+WLxHXG40SpX9PbCCEato4bCFFOE+3Keai+2UgINO7mchzQf+skjC6VAZcoel9
         cp4mESGGBzpH+71ua6iKk0cJRRCkemxQp6c1i4PW2rdAnW3WlYpFfAze5xSQwCPM101U
         aZw31sG6uI6mqudlGQui+DnBQx7x2CyACAqxzIjP061S7vccQZdDxCw1u8/lh7R3jkpx
         pNYqEdz/S4CGF/bz18nI/MWfWObfNdc7SVOO+ZWgKwKbvB5Q0LW/Dkst7cnYgiloTwkY
         bC/y2DF3XcvDv7VWZoI30N+h+rpSheuCtu/jM7Gq5vWbrCQGbWmFrI5+mzLoIbjhh1x3
         hY4w==
X-Gm-Message-State: AOAM531gKTOfvDMCiXlST5arq4m2VZS1H77hintcHzQaSwsS8QLCYwLK
        hOmLePrjF5iKrtEreafPMFqSyHv3O7DQng==
X-Google-Smtp-Source: ABdhPJzCPONrWkNJJNUxQjkZmdNVGTHsJlRIZRaZyXHsGPITgnOoKbCbu4Csf4TCy9A96bwXauu3xA==
X-Received: by 2002:a17:902:eb88:b0:15e:967b:f934 with SMTP id q8-20020a170902eb8800b0015e967bf934mr2859768plg.67.1652412927312;
        Thu, 12 May 2022 20:35:27 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb1c7sm685133plm.17.2022.05.12.20.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:35:16 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v2 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Fri, 13 May 2022 11:34:45 +0800
Message-Id: <20220513033450.7038-1-kflin@nuvoton.com>
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

Changes in v2: Add Hextile document and locate with vendor formats.

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
 .../media/v4l/pixfmt-reserved.rst             |    7 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   19 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   12 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-video.c   | 2074 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/videodev2.h                |    1 +
 11 files changed, 2246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c

-- 
2.17.1

