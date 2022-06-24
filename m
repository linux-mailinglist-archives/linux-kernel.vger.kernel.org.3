Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8EC55A10B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiFXShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFXShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516B80507;
        Fri, 24 Jun 2022 11:37:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g26so6391086ejb.5;
        Fri, 24 Jun 2022 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7x+93/bf/OFy0gtgD7o9zovjDkSW2Dr+HMDRLcG03E=;
        b=UBwZQNMdfo8T1yoq3GvmXbSulJCGmOEiLiJslZupN8Vsv1vKmyEAa8FpFSp5w8lDVt
         gD1+oEJ/u4JQa5z6mv2+rrUWaItISlPOp1Ni2ByexriZl1+UmYQ463CNS3B5QBIU/Wur
         /DM6EKKWLLtJdzxXqrCkH2/umepgecr9rOBlfidU9M73txE6LOwntNlezSTuhmbHMPdx
         4Qc6K17jBxKm6fp1HViA6J4ZJtzCmkAVMhhZiIxeHu9+Z4B9CJeM+4vwDgIOaYWE3lzT
         Tkcm+ADukm2KPWjmfsXI8lxcR2sM8SV7mNDkei9rC7hGIiMGZM9VZyIV+PJKelhr702n
         U6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7x+93/bf/OFy0gtgD7o9zovjDkSW2Dr+HMDRLcG03E=;
        b=1pz6H0JE0O8fxcJYUzEwzsZR7zcl+uSZRK6jlyAmEMwqt8eHwDC1rCgaCCIbz6quXw
         pEc6iMZc9Bg0eJEgon80J8tUOwlQYpc+SFuGNzWJuhXgfXxMsPrvC4gj+nPJGr4kp64S
         rHvyCI5AUWX7FRg/BpQwRbSFVOXRTeMnfeUooWbfhsFBl8vVL+aiTTq8iNZFZ40VxaZ8
         XHmdwWhWJ4JvUzt1t0HkrU/3YjpgwgBQm42Wx6fH3yata10yGgSB/Utcf7c5a+CS6801
         7e6HuNiO0WLR5F2BhILAzKSQWoY36o8wBZA4iN2p35ZCf/HyACcefC4IrcHhLblw5KZL
         A2ug==
X-Gm-Message-State: AJIora/kCtj7/lPN6jzLkX+T4pJttNG7sWn+aKe+l3fHz/7dvgbRYd/G
        3tCY8KnMsAZp7g9Ob0Fx1K+2bBgVsEo=
X-Google-Smtp-Source: AGRyM1uze8mxsLSfHcjqNG1xbj2n7dYFcrYO4BpMGtGidaD6HXzNi7n2yCadoGyUWWMSuXX1dReA8A==
X-Received: by 2002:a17:906:4f:b0:712:af2:29d9 with SMTP id 15-20020a170906004f00b007120af229d9mr320542ejg.751.1656095819920;
        Fri, 24 Jun 2022 11:36:59 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm1493822ejb.208.2022.06.24.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:36:59 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/4] platform/surface: Add support for tablet mode switch via Surface Aggregator Module
Date:   Fri, 24 Jun 2022 20:36:38 +0200
Message-Id: <20220624183642.910893-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds a driver providing a tablet mode switch on the Surface
Pro 8, Surface Pro X, and Surface Laptop Studio.

These devices provide posture information via subsystems of the Surface
Aggregator Module (SAM; embedded controller). While the specific
subsystems used for the Pro and Laptop models differ, large parts of the
respective subsystem drivers would be equal. Therefore, we essentially
provide a generic framework for tablet-mode switches via the Surface
Aggregator module and use that to implement specific support for the KIP
and POS subsystems used on the aforementioned devices.

In addition, this series first introduces some helper macros for
synchronous stack-allocated SAM requests used in the subsequent patches,
extending the already existing ones.

Further, this series adds the respective firmware nodes to the Surface
Aggregator Registry.

Maximilian Luz (4):
  platform/surface: aggregator: Add helper macros for requests with
    argument and return value
  platform/surface: Add KIP/POS tablet-mode switch driver
  platform/surface: aggregator_registry: Add support for tablet mode
    switch on Surface Pro 8
  platform/surface: aggregator_registry: Add support for tablet mode
    switch on Surface Laptop Studio

 .../sysfs-bus-surface_aggregator-tabletsw     |  57 ++
 MAINTAINERS                                   |   6 +
 drivers/platform/surface/Kconfig              |  23 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_registry.c     |  15 +-
 .../surface/surface_aggregator_tabletsw.c     | 533 ++++++++++++++++++
 include/linux/surface_aggregator/controller.h | 125 ++++
 include/linux/surface_aggregator/device.h     |  36 ++
 8 files changed, 795 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-surface_aggregator-tabletsw
 create mode 100644 drivers/platform/surface/surface_aggregator_tabletsw.c

-- 
2.36.1

