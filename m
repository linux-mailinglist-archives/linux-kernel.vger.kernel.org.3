Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082654C901C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiCAQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiCAQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:16:19 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F160954A3;
        Tue,  1 Mar 2022 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VGbStSHHARqJktrOgniVFQ6u0YwBTQjRQ0LEmnlIFkk=; b=IGDQmo+alZXTaMgomNyLpt9hOp
        RpRfQKGalr145FjoQqtQsOfL0gL723d/LvXjlKaftAggH2uEPmGCY8o1ZgSQDSlcd/oO8f9ouw8rl
        e64D/b+z1RNubnT4aeNXTRH/kfN4GJ0voe5AkBq58ziumHy5WTyWnReXt5IwjGhoyn5o+gSYYZ1Ya
        Jp9nIN17ohV73LcDbtqdW2jIf9x8w+yQhCxKbQmNSx0px19iOqreuBfln8TeGuPjV+DvejSaeeyqU
        9ooN3s3wnAQ2qpLtJOMkLeyWf+8dG8dxtYVQLY5ub3XtuzaatMqVW8fy6m0hi11EMGTmX6rolKY8f
        JBQ21oJA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nP59q-0003Z8-EU; Tue, 01 Mar 2022 18:15:26 +0200
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 0/9] Host1x context isolation support
Date:   Tue,  1 Mar 2022 18:14:46 +0200
Message-Id: <20220301161455.4037062-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

***
New in v4:

Addressed review comments. See individual patches.
***

***
New in v3:

Added device tree bindings for new property.
***

***
New in v2:

Added support for Tegra194
Use standard iommu-map property instead of custom mechanism
***

This series adds support for Host1x 'context isolation'. Since
when programming engines through Host1x, userspace can program in
any addresses it wants, we need some way to isolate the engines'
memory spaces. Traditionally this has either been done imperfectly
with a single shared IOMMU domain, or by copying and verifying the
programming command stream at submit time (Host1x firewall).

Since Tegra186 there is a privileged (only usable by kernel)
Host1x opcode that allows setting the stream ID sent by the engine
to the SMMU. So, by allocating a number of context banks and stream
IDs for this purpose, and using this opcode at the beginning of
each job, we can implement isolation. Due to the limited number of
context banks only each process gets its own context, and not
each channel.

This feature also allows sharing engines among multiple VMs when
used with Host1x's hardware virtualization support - up to 8 VMs
can be configured with a subset of allowed stream IDs, enforced
at hardware level.

To implement this, this series adds a new host1x context bus, which
will contain the 'struct device's corresponding to each context
bank / stream ID, changes to device tree and SMMU code to allow
registering the devices and using the bus, as well as the Host1x
stream ID programming code and support in TegraDRM.

-------------
Merging notes
-------------

The changes to DT bindings should be applied on top of Thierry's patch
'dt-bindings: display: tegra: Convert to json-schema'.

Thanks,
Mikko

Mikko Perttunen (9):
  dt-bindings: host1x: Add iommu-map property
  gpu: host1x: Add context bus
  gpu: host1x: Add context device management code
  gpu: host1x: Program context stream ID on submission
  iommu/arm-smmu: Attach to host1x context device bus
  arm64: tegra: Add Host1x context stream IDs on Tegra186+
  drm/tegra: falcon: Set DMACTX field on DMA transactions
  drm/tegra: Support context isolation
  drm/tegra: vic: Implement get_streamid_offset

 .../display/tegra/nvidia,tegra20-host1x.yaml  |   5 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  11 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  11 ++
 drivers/gpu/Makefile                          |   3 +-
 drivers/gpu/drm/tegra/drm.h                   |   2 +
 drivers/gpu/drm/tegra/falcon.c                |   8 +
 drivers/gpu/drm/tegra/falcon.h                |   1 +
 drivers/gpu/drm/tegra/submit.c                |  21 ++-
 drivers/gpu/drm/tegra/uapi.c                  |  45 ++++-
 drivers/gpu/drm/tegra/vic.c                   |  68 +++++++-
 drivers/gpu/host1x/Kconfig                    |   5 +
 drivers/gpu/host1x/Makefile                   |   2 +
 drivers/gpu/host1x/context.c                  | 160 ++++++++++++++++++
 drivers/gpu/host1x/context.h                  |  27 +++
 drivers/gpu/host1x/context_bus.c              |  31 ++++
 drivers/gpu/host1x/dev.c                      |  12 +-
 drivers/gpu/host1x/dev.h                      |   2 +
 drivers/gpu/host1x/hw/channel_hw.c            |  52 +++++-
 drivers/gpu/host1x/hw/host1x06_hardware.h     |  10 ++
 drivers/gpu/host1x/hw/host1x07_hardware.h     |  10 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 ++
 include/linux/host1x.h                        |  22 +++
 include/linux/host1x_context_bus.h            |  15 ++
 23 files changed, 518 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/host1x/context.c
 create mode 100644 drivers/gpu/host1x/context.h
 create mode 100644 drivers/gpu/host1x/context_bus.c
 create mode 100644 include/linux/host1x_context_bus.h

-- 
2.35.0

