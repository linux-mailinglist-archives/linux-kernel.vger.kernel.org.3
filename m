Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C3516AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383432AbiEBGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348929AbiEBGJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:09:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE624DF52
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:06:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j8so11702776pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb/AySZkWods5suv/xpDDz17y/16dyB8v+XlSpFQjug=;
        b=Xd0Ik3Z9Ytq+8JMLC57QirSPeQWHPMw6quuLsuvZK1t64rOGTmZ6ucnMIVio0g96gg
         oFO5k67SMkft6cGVoJYuZa0nmlnEAH09r6jSPuvE0irOPP4g7P1VKswDJFL3oZjynmG3
         wPL9rs1K+6foPq/o0+n309JmZOwSg+u6/5uDPSGG3z76vwdMDmbSiK0MrmoTSph6vqZu
         fFnRhsLl63+XWsh8aeVwgR5DRsmV2x/LjHbrW1RIIlqpvxYPystLoh8ntY3Vb1VeOVkQ
         RIl7BHZ20UvjL8yvmwqEJhGEbUTpb0z6jbJsr7v2hJaA0B3o4PhJmxM89ucowcKFy2GJ
         U5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb/AySZkWods5suv/xpDDz17y/16dyB8v+XlSpFQjug=;
        b=U8rcZWyOZiZLhCcsX0mtb4y1NcU0jM/D79X+fLEu/6+bvcoYqMOa5DUyA0IbvQZ36A
         bW4Padb6kP3mrhtumRpRRn+sqmvJ97wIci4bxK9sliWXUSg8T7AzrAbIO4dlNxy/ogga
         zU/61Ewbmivqu/zB/hQ8rzTAnlb/ZalzsVVaA1q6prFAO0or7jxuq3ZvERCpy0BVIiaP
         O0wF6iHJ9VWYu27azMBmMyFFo5omqkOl5cvydNuZxjbkmqaNDGDLAKuzYYhQVlPwDYjE
         m4367A+/+LHYTVc/x7XikA6krW+a43Cky3qnkCZ1sB/6eObuzFHez6FxdZLjLjg8v7/o
         7pBw==
X-Gm-Message-State: AOAM530NR2qQKIIy+pyy15iiPVrmsxsJJV/BoGIO8IGMsi32zdimfpCX
        m1yrzfoKNYN7cheNGuhpfteNOV530l1S
X-Google-Smtp-Source: ABdhPJzLu2WuDNByW0kzZXJFyRC8Sdimsbe5M7cV/nLnOnrNKkyutEUWOX/hJbhJRLAXGb/pGauVEg==
X-Received: by 2002:a17:90b:4b82:b0:1dc:673:1662 with SMTP id lr2-20020a17090b4b8200b001dc06731662mr15787595pjb.103.1651471582716;
        Sun, 01 May 2022 23:06:22 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/8] Add support for MHI Endpoint function driver
Date:   Mon,  2 May 2022 11:36:03 +0530
Message-Id: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for Modem Host Interface (MHI) Endpoint function
driver and few updates to the PCI endpoint core.

MHI
===

MHI is the communication protocol used by the host machines to control and
communicate with the Qualcomm modems/WLAN devices over any high speed physical
bus like PCIe. In Linux kernel, MHI is modeled as a bus driver [1] and there
are two instances of MHI used in a typical setup.

1. MHI host - MHI implementation for the host machines like x86/ARM64.
2. MHI Endpoint - MHI implementation for the endpoint devices like modems.

MHI EPF
=======

The MHI Endpoint function driver (MHI EPF) is used on the MHI endpoint devices
like modems. The MHI EPF driver sits in between the PCIe RC and MHI EP bus and
carries out all of the PCIe related activities like BAR config, PCIe Event
handling, MMIO read/write etc,... for the MHI EP bus.

Below is the simple representation of the setup:


                 +----------------------------------------------------+
                 |                  Endpoint CPU                      |                   
                 |                                                    |
+------------+   |   +------------+   +-----------+   +-----------+   |
|            |   |   |            |   |           |   |           |   |
|            |   |   |   MHI EP   |   |           |   |           |   | PCIe Bus
|  Modem DSP +---+---+    Bus     +---+  MHI EPF  +---+  PCIe RC  +---+---------
|            |   |   |            |   |           |   |           |   |
|            |   |   |            |   |           |   |           |   |
+------------+   |   +------------+   +-----------+   +-----------+   |
                 |                                                    |
                 |                                                    |
                 +----------------------------------------------------+


The data packets will be read from the Modem DSP by the MHI stack and will be
transmitted to the host machine over PCIe bus with the help of MHI EPF driver.

Test setup
==========

This series has been tested on Snapdragon X55 modem a.k.a SDX55 connected to
the ARM64 host machine.

Dependency
==========

This series has the build dependency with the recently merged MHI EP bus [2]
support for v5.19.

Thanks,
Mani

[1] https://www.kernel.org/doc/html/latest/mhi/mhi.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/bus/mhi/ep

Manivannan Sadhasivam (8):
  PCI: endpoint: Pass EPF device ID to the probe function
  PCI: endpoint: Warn and return if EPC is started/stopped multiple
    times
  PCI: endpoint: Add an API for unregistering the EPF notifier
  PCI: endpoint: Add linkdown notifier support
  PCI: endpoint: Add BME notifier support
  PCI: qcom-ep: Add support for Link down notification
  PCI: qcom-ep: Add support for BME notification
  PCI: endpoint: Add PCI Endpoint function driver for MHI bus

 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +
 drivers/pci/endpoint/functions/Kconfig        |  10 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 436 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |   3 +
 drivers/pci/endpoint/pci-epc-core.c           |  34 ++
 drivers/pci/endpoint/pci-epf-core.c           |   8 +-
 include/linux/pci-epc.h                       |   8 +
 include/linux/pci-epf.h                       |   6 +-
 11 files changed, 507 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c


base-commit: c268c0a8a33047cd957fecc1349d09a68eb6ad9e
prerequisite-patch-id: 1578725693279d018290ef496258dbe825785192
-- 
2.25.1

