Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322DF5756EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbiGNVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiGNVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:06 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800D6EE90;
        Thu, 14 Jul 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834204; x=1689370204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ohTWDd1PCrHN5v0aqrbVJeHwH3BlN0RoL4tMpz77sGI=;
  b=EeWZ9+1MwOmrN1r/Ec8tq+XZjIwoMHyT6HqSB5Ia0p/nf8Q+uW10J3ew
   hbVD0ITkHwEw9bGbz/P0Wd7beqNwee0bzc9hNIlUk7xrkO97pUyQ1lA4U
   HHlSUwS2k/KH3FAJNN6BReBgPL6ySSeU5kcPW6APyr5qSy3gnGtTeKp9L
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:04 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:03 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:03 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 00/11] Gunyah Hypervisor drivers
Date:   Thu, 14 Jul 2022 14:29:29 -0700
Message-ID: <20220714212940.2988436-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gunyah is a Type-1 hypervisor independent of any
high-level OS kernel, and runs in a higher CPU privilege level. It does
not depend on any lower-privileged OS kernel/code for its core
functionality. This increases its security and can support a much smaller
trusted computing base than Type-2 hypervisors. This series adds the initial
support for Gunyah hypercalls, IPC via message queues, communication with the
Gunyah Resource Manager to enable Gunyah's paravirtualized console.

Gunyah is an open source hypervisor. The source repo is available at
https://github.com/quic/gunyah-hypervisor.

This series enables guest awareness of Gunyah and establishes the basic
architecture of Gunyah capabilities in the Linux kernel. As an end-to-end
use case, a TTY driver for the Gunyah-based console is added which can demonstrate
communication with the resource manager. In a future series, we intend to add
support for loading secondary VMs.

To self-test the console driver without other VMs, reads and writes to
/dev/ttyGH0 will be sent to /dev/ttyGH1 via the hypervisor. In a system with
multiple VMs, a secondary VM could use ttyGH0 as its boot console.
The primary VM would be able to access that secondary VM's console via a ttyGHx.

Changes in v2:
 - DT bindings clean up
 - Switch hypercalls to follow SMCCC

Elliot Berman (11):
  docs: gunyah: Introduce Gunyah Hypervisor
  dt-bindings: Add binding for gunyah hypervisor
  arm64: gunyah: Add Gunyah hypercalls ABI
  gunyah: Common types and error codes for Gunyah hypercalls
  virt: gunyah: Add sysfs nodes
  virt: gunyah: Add capabilities bus and devices
  gunyah: msgq: Add Gunyah message queues
  gunyah: rsc_mgr: Add resource manager RPC core
  gunyah: rsc_mgr: Add auxiliary devices for console
  gunyah: rsc_mgr: Add RPC for console services
  gunyah: Add tty console driver for RM Console Serivces

 .../ABI/testing/sysfs-hypervisor-gunyah       |  37 +
 .../bindings/firmware/gunyah-hypervisor.yaml  |  84 +++
 Documentation/virt/gunyah/index.rst           |  99 +++
 Documentation/virt/gunyah/message-queue.rst   |  52 ++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  12 +
 arch/arm64/include/asm/gunyah.h               | 142 ++++
 drivers/virt/Kconfig                          |   1 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  24 +
 drivers/virt/gunyah/Makefile                  |   8 +
 drivers/virt/gunyah/device.c                  | 108 +++
 drivers/virt/gunyah/gunyah_private.h          |  18 +
 drivers/virt/gunyah/msgq.c                    | 223 ++++++
 drivers/virt/gunyah/rsc_mgr.c                 | 682 ++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                 |  56 ++
 drivers/virt/gunyah/rsc_mgr_console.c         | 405 +++++++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c             | 151 ++++
 drivers/virt/gunyah/sysfs.c                   | 176 +++++
 include/linux/gunyah.h                        | 133 ++++
 include/linux/gunyah_rsc_mgr.h                |  45 ++
 21 files changed, 2458 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
 create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst
 create mode 100644 arch/arm64/include/asm/gunyah.h
 create mode 100644 drivers/virt/gunyah/Kconfig
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/device.c
 create mode 100644 drivers/virt/gunyah/gunyah_private.h
 create mode 100644 drivers/virt/gunyah/msgq.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 drivers/virt/gunyah/rsc_mgr_console.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
 create mode 100644 drivers/virt/gunyah/sysfs.c
 create mode 100644 include/linux/gunyah.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h

-- 
2.25.1

