Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA854C1FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiBWXia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiBWXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:23 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF425A0A9;
        Wed, 23 Feb 2022 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659475; x=1677195475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NbdLTpNQ3jh8gkc2GZROWVng6uHNoRVJJzbDZHL59Lo=;
  b=BOCmol2+RLRXA/59WL8Kv7QSlRcteHi1q8H66cVYLwMbyiL+EMlnSpll
   aYmpHkzmwA35j8OL2fC157MS0qnwgIqDow1jPoNEWzKYihuwbuPuOoSS/
   pHvaPi1JYWJ14i47vSHQnXLQcl70n3bpvkBS9HD89Flkr5b3Is3oQi1ja
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 15:37:54 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:54 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:53 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 00/11] Gunyah Hypervisor drivers
Date:   Wed, 23 Feb 2022 15:37:18 -0800
Message-ID: <20220223233729.1571114-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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
 .../bindings/gunyah/message-queue.yml         | 100 +++
 .../bindings/gunyah/qcom,hypervisor.yml       | 122 ++++
 Documentation/virt/gunyah/index.rst           |  99 +++
 Documentation/virt/gunyah/message-queue.rst   |  52 ++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  12 +
 arch/arm64/include/asm/gunyah/hypercall.h     | 199 ++++++
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  27 +
 drivers/virt/gunyah/Makefile                  |   8 +
 drivers/virt/gunyah/device.c                  | 108 +++
 drivers/virt/gunyah/gunyah_private.h          |  18 +
 drivers/virt/gunyah/msgq.c                    | 295 ++++++++
 drivers/virt/gunyah/rsc_mgr.c                 | 632 ++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                 |  53 ++
 drivers/virt/gunyah/rsc_mgr_console.c         | 410 ++++++++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c             | 129 ++++
 drivers/virt/gunyah/sysfs.c                   | 152 +++++
 include/linux/gunyah.h                        | 138 ++++
 include/linux/gunyah_rsc_mgr.h                |  44 ++
 22 files changed, 2639 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
 create mode 100644 Documentation/devicetree/bindings/gunyah/message-queue.yml
 create mode 100644 Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst
 create mode 100644 arch/arm64/include/asm/gunyah/hypercall.h
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

