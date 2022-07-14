Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BFC5756FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiGNVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiGNVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF86EE89;
        Thu, 14 Jul 2022 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834206; x=1689370206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SEbxvGAHLc85YgJefDifK0QXI0LTg3QY4C+MJpGOR6g=;
  b=rkCQJ2+S8FUBo2WcF1CeuKElwMVXGdODf9CLrtk4LNhFRjXInFkizzbR
   D0Frq4vnXEpd27BrKH3yofzZkq6uyq/Vg13nmPPM3UhDzN1oftZglAPxr
   bz4Jr0g9WJv4DrTKQHw59MbTdlBudagb2maJu1kUY2kqGiyVJqvfWqu2z
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:04 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:04 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:03 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
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
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 01/11] docs: gunyah: Introduce Gunyah Hypervisor
Date:   Thu, 14 Jul 2022 14:29:30 -0700
Message-ID: <20220714212940.2988436-2-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714212940.2988436-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
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

Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
does not depend on any lower-privileged OS/kernel code for its core
functionality. This increases its security and can support a smaller
trusted computing based when compared to Type-2 hypervisors.

Add documentation describing the Gunyah hypervisor and the main
components of the Gunyah hypervisor which are of interest to Linux
virtualization development.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst         | 92 +++++++++++++++++++++
 Documentation/virt/gunyah/message-queue.rst | 52 ++++++++++++
 Documentation/virt/index.rst                |  1 +
 MAINTAINERS                                 |  7 ++
 4 files changed, 152 insertions(+)
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
new file mode 100644
index 000000000000..e7bb2b14543e
--- /dev/null
+++ b/Documentation/virt/gunyah/index.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Gunyah Hypervisor
+=================
+
+.. toctree::
+   :maxdepth: 1
+
+   message-queue
+
+Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
+a higher CPU privilege level. It does not depend on any lower-privileged operating system
+for its core functionality. This increases its security and can support a much smaller
+trusted computing base than a Type-2 hypervisor.
+
+Gunyah is an open source hypervisor. The source repo is available at
+https://github.com/quic/gunyah-hypervisor.
+
+Gunyah provides these following features.
+
+- Scheduling:
+  A scheduler for virtual CPUs (VCPUs) on physical CPUs and enables time-sharing
+  of the CPUs.
+- Memory Management:
+  APIs handling memory, abstracted as objects, limiting direct use of physical
+  addresses. Memory ownership and usage tracking of all memory under its control.
+  Memory partitioning between VMs is a fundamental security feature.
+- Interrupt Virtualization:
+  Uses CPU hardware interrupt virtualization capabilities. Interrupts are handled
+  in the hypervisor and routed to the assigned VM.
+- Inter-VM Communication:
+  There are several different mechanisms provided for communicating between VMs.
+- Virtual platform:
+  Architectural devices such as interrupt controllers and CPU timers are directly provided
+  by the hypervisor as well as core virtual platform devices and system APIs such as ARM PSCI.
+- Device Virtualization:
+  Para-virtualization of devices is supported using inter-VM communication.
+
+Architectures supported
+=======================
+AArch64 with a GIC
+
+Resources and Capabilities
+==========================
+
+Some services or resources provided by the Gunyah hypervisor are described by capability IDs.
+For instance, inter-VM communication is performed with doorbells and message queues. The specific
+instance of a doorbell is described by a capability ID. These devices are described in Linux as a
+struct gunyah_device.
+
+High level management of these resources is performed by the resource manager VM. RM informs a
+guest VM about resources it can access through either the device tree or via guest-initiated RPC.
+
+Resource Manager
+================
+
+The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
+It provides policy enforcement aspects of the virtualization system. The resource manager can
+be treated as an extension of the Hypervisor but is separated to its own partition to ensure
+that the hypervisor layer itself remains small and secure and to maintain a separation of policy
+and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to other virtual machines.
+
+Communication with the resource manager from each guest VM happens with message-queue.rst. Details
+about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
+
+::
+  +-------+   +--------+   +--------+
+  |  RM   |   |  VM_A  |   |  VM_B  |
+  +-.-.-.-+   +---.----+   +---.----+
+    | |           |            |
+  +-.-.-----------.------------.----+
+  | | \==========/             |    |
+  |  \========================/     |
+  |            Gunyah               |
+  +---------------------------------+
+
+The source for the resource manager is available at https://github.com/quic/gunyah-resource-manager.
+
+The resource manager provides the following features:
+
+- Generate device-tree overlay
+- VM creation and deletion
+- VM device-tree management
+- VM access control policy
+- Interrupt routing configuration
+
+When booting a virtual machine which uses a devicetree, resource manager overlays a
+/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
+how to communicate with resource manager, and basic description and capabilities of
+this VM. See Documentation/devicetree/bindings/gunyah/qcom,hypervisor.yml for a description
+of this node.
diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
new file mode 100644
index 000000000000..afd405f3a5e1
--- /dev/null
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Message Queues
+==============
+Message queue is a simple low-capacity IPC channel between two VMs. It is
+intended for sending small control and configuration messages. Each message
+queue object is unidirectional, so a full-duplex IPC channel requires a pair of
+objects.
+
+Messages can be up to 240 bytes in length. Longer messages require a further
+protocol on top of the message queue messages themselves. For instance, communication
+with the resource manager adds a header field for sending longer messages via multiple
+message fragments.
+
+The diagram below shows how message queue works. A typical configuration involves
+2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
+queue 2 allows VM_B to send messages to VM_A.
+
+1. VM_A sends a message of up to 240 bytes in length. It raises a hypercall
+   with the message to inform the hypervisor to add the message to
+   message queue 1's queue.
+2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
+   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
+   b. Explicility with gh_msgq_push command from VM_A.
+   c. Message queue has reached a threshold depth.
+3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
+
+For VM_B to send a message to VM_A, the process is identical, except that hypercalls
+reference message queue 2's capability ID.
+
+::
+
+      +---------------+         +-----------------+         +---------------+
+      |      VM_A     |         |Gunyah hypervisor|         |      VM_B     |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |   Tx    |                 |         |               |
+      |               |-------->|                 | Rx vIRQ |               |
+      |gh_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gh_msgq_recv() |
+      |               |<------- |                 |         |               |
+      |               |         |                 |         |               |
+      | Message Queue |         |                 |         | Message Queue |
+      | driver        |         |                 |         | driver        |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |         |                 |   Tx    |               |
+      |               | Rx vIRQ |                 |<--------|               |
+      |gh_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gh_msgq_send() |
+      |               |         |                 |-------->|               |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      +---------------+         +-----------------+         +---------------+
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 492f0920b988..dd4e8ef284eb 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -14,6 +14,7 @@ Linux Virtualization Support
    ne_overview
    acrn/index
    coco/sev-guest
+   gunyah/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..0a8ea7c28b23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8735,6 +8735,13 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GUNYAH HYPERVISOR DRIVER
+M:	Elliot Berman <quic_eberman@quicinc.com>
+M:	Murali Nalajala <quic_mnalajal@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/virt/gunyah/
+
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
 S:	Supported
-- 
2.25.1

