Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172D47EE79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352534AbhLXLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:11:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33260
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhLXLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:11:30 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3F3DE3F1A9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640344289;
        bh=tffzkkxKa4YIdNV590tAX3Y9552dAe4ASNyCk+JJADI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JM+D9E6omlwqsxYAmsVikjVG5t/POxPurWfcpfMO8WxFcMMN9cii2c6IpK9cSES1h
         daMLDZndBAksx1aO5EuDkx0AN79uoazvv1xVEuiL4suLbTYJb8ar2iS6sL56s9rJcL
         G/QIstaDMmmEFmVwYKFhAlr5PW16shjH4uDn3UqX7JZDnw0o+2TLBJqkEhbhcWZ0DH
         pdr1TaNvT+1CQ3/FC42i2mj3CAMoGHWWdYe7mKFs6pyJHsHKjvOhx6SDCB9s69RkB+
         5gtw4Ja32tViMDiOta5K6KFCllYyL80/JvW6epF+SlM5wIZWkFY4B8bm1sV1mYmczs
         57ITON97my3QA==
Received: by mail-lf1-f69.google.com with SMTP id g2-20020a19e042000000b00425cfac0e67so2786376lfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tffzkkxKa4YIdNV590tAX3Y9552dAe4ASNyCk+JJADI=;
        b=yLZtDN9YOoaJYjmc2C1MIhZF9B/YSsHVx/Q0HVUV0UVFBYwRLuqVhC4JM6wQANHNIX
         nxAqxXRg4v6zdv33zrok7C9W2QGdcfRbwn7RKSQhqY1cOit+brG6y6U5nn0o0xtrjLy/
         +Kw8VM+DH7qyQo4AIU5fA8R5L71Trr9hacqWvjBvAa2eTm4Y+4egGtuxVtckLbuwIu2+
         bl4dM4v2m88HXq1rhCZlCferpACMUKQeFRA2o/G1ffQ/EAWrB6sFzCFpKOz6l6x1bVvW
         UKpZi0BSryV7b4Yhxz68yGnlvZeZaAKrwso6nr22vitB0mOhq9GVlu9w1wGcx3/I42aw
         D9dg==
X-Gm-Message-State: AOAM530BZtX3Qvh7mFcp2RQxRp76Cjoqt3p+aTKKDTzORiVoWjodZBpR
        nna/gVi6gyuUISRGqh3OXDG2Ih9zRNZLQ7DfWcjEclPoZbAZ2AIBwKNrEIXC0YfhyrGcPdArNOM
        HhTEbxCc6ptwgA7IziqZAnNco4lLmnfIRfGXoYtcA3g==
X-Received: by 2002:ac2:46d1:: with SMTP id p17mr5126112lfo.578.1640344287597;
        Fri, 24 Dec 2021 03:11:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlyHdSEopC8h5txg13zP15CN+pLoXyUsLHjPcX8vB6NbjpuzCeCZs1rIgCHJp1thoyKJd4tA==
X-Received: by 2002:ac2:46d1:: with SMTP id p17mr5126102lfo.578.1640344287341;
        Fri, 24 Dec 2021 03:11:27 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm773870lfa.75.2021.12.24.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 03:11:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] memory: drivers for v5.17
Date:   Fri, 24 Dec 2021 12:11:23 +0100
Message-Id: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.17

for you to fetch changes up to de369801658a9a54759ac011af770e8c01d9db7f:

  Merge branch 'for-v5.17/tegra-mc' into mem-ctrl-next (2021-12-22 12:59:03 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.17

1. Minor improvements: Mediatek SMI, Freescale/NXP IFC, Tegra20 and
   Tegra30.
2. Convert Freescale/NXP IFC bindings to dtschema.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX

Dmitry Osipenko (2):
      memory: tegra30-emc: Print additional memory info
      memory: tegra20-emc: Correct memory device mask

Jason Wang (1):
      memory: brcmstb_dpfe: fix typo in a comment

Krzysztof Kozlowski (1):
      Merge branch 'for-v5.17/tegra-mc' into mem-ctrl-next

Li Yang (2):
      dt-bindings: memory: fsl: convert ifc binding to yaml schema
      memory: fsl_ifc: populate child devices without relying on simple-bus

Rikard Falkeborn (1):
      memory: tegra: Constify struct thermal_cooling_device_ops

 .../bindings/memory-controllers/fsl/fsl,ifc.yaml   | 113 ++++++++++++++++++
 .../bindings/memory-controllers/fsl/ifc.txt        |  82 -------------
 drivers/memory/brcmstb_dpfe.c                      |   2 +-
 drivers/memory/fsl_ifc.c                           |   9 ++
 drivers/memory/mtk-smi.c                           |   3 +-
 drivers/memory/tegra/Kconfig                       |   1 +
 drivers/memory/tegra/tegra20-emc.c                 |   2 +-
 drivers/memory/tegra/tegra210-emc-core.c           |   2 +-
 drivers/memory/tegra/tegra30-emc.c                 | 131 +++++++++++++++++++--
 9 files changed, 248 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
