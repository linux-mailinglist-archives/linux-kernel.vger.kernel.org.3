Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D425D469174
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhLFIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:32:56 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3827 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhLFIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638779366; x=1670315366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sDxxks2ISanKCZutPVRC7KEeBXIXNr8hG9VHZXbESTI=;
  b=BWR2MDrDOV+cTlrJIABb2eo4Hy+d00eZ0+7O6v0J49Nbo1GP5XF8WyYK
   O/OPAY1tFXp/0ZN+L/EUc7gsVbfxwxIJaolCsPkePOmQqmJYeMwgk3qkl
   WEz9BXNRlA2tIwNAxvHs4DwzYIyzs62VPS8qj2nhrTCld6sZsI9jd42NK
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 00:29:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 00:29:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:09 -0800
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:05 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Marc Zyngier" <maz@kernel.org>
CC:     gregkh <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv5 0/4] tracing/rwmmio/arm64: Add support to trace register reads/writes
Date:   Mon, 6 Dec 2021 13:58:02 +0530
Message-ID: <cover.1638275062.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
are typically used to read/write from/to memory mapped registers
and can cause hangs or some undefined behaviour in following cases,

* If the access to the register space is unclocked, for example: if
  there is an access to multimedia(MM) block registers without MM
  clocks.

* If the register space is protected and not set to be accessible from
  non-secure world, for example: only EL3 (EL: Exception level) access
  is allowed and any EL2/EL1 access is forbidden.

* If xPU(memory/register protection units) is controlling access to
  certain memory/register space for specific clients.

and more...

Such cases usually results in instant reboot/SErrors/NOC or interconnect
hangs and tracing these register accesses can be very helpful to debug
such issues during initial development stages and also in later stages.

So use ftrace trace events to log such MMIO register accesses which
provides rich feature set such as early enablement of trace events,
filtering capability, dumping ftrace logs on console and many more.

Sample output:

rwmmio_read: gic_peek_irq+0xd0/0xd8 readl addr=0xffff800010040104
rwmmio_write: gic_poke_irq+0xe4/0xf0 writel addr=0xffff800010040184 
rwmmio_read: gic_do_wait_for_rwp+0x54/0x90 readl addr=0xffff800010040000
rwmmio_write: gic_set_affinity+0x1bc/0x1e8 writeq addr=0xffff800010046130

This series is a follow-up for the series [1] and a recent series [2] making use
of both.

[1] https://lore.kernel.org/lkml/cover.1536430404.git.saiprakash.ranjan@codeaurora.org/
[2] https://lore.kernel.org/lkml/1604631386-178312-1-git-send-email-psodagud@codeaurora.org/

Note in previous version, Arnd suggested to benchmark and compare size with callback
based implementation, please see [3] for more details on that with brief comparison below.


**Inline version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
$ size vmlinux
   text           data             bss     dec             hex         filename
 23884219        14284468         532568 38701255        24e88c7        vmlinux

**Callback version with CONFIG_FTRACE=y and CONFIG_TRACE_MMIO_ACCESS=y**
$ size vmlinux
    text          data             bss     dec             hex        filename
 24108179        14279596         532568 38920343        251e097       vmlinux

$ ./scripts/bloat-o-meter inline-vmlinux callback-vmlinux
add/remove: 8/3 grow/shrink: 4889/89 up/down: 242244/-11564 (230680)
Total: Before=25812612, After=26043292, chg +0.89%

[3] https://lore.kernel.org/lkml/466449a1-36da-aaa9-7e4f-477f36b52c9e@quicinc.com/

Changes in v5:
 * Move arm64 to use asm-generic provided high level MMIO accessors (Arnd).
 * Add inline logging for MMIO relaxed and non-relaxed accessors.
 * Move nVHE KVM comment to makefile (Marc).
 * Fix overflow warning due to switch to inline accessors instead of macro.
 * Modify trace event field to include caller and parent details for more detailed logs.

Changes in v4:
 * Drop dynamic debug based filter support since that will be developed later with
   the help from Steven (Ftrace maintainer).
 * Drop value passed to writel as it is causing hangs when tracing is enabled.
 * Code cleanup for trace event as suggested by Steven for earlier version.
 * Fixed some build errors reported by 0-day bot.

Changes in v3:
 * Create a generic mmio header for instrumented version (Earlier suggested in [1]
   by Will Deacon and recently [2] by Greg to have a generic version first).
 * Add dynamic debug support to filter out traces which can be very useful for targeted
   debugging specific to subsystems or drivers.
 * Few modifications to the rwmmio trace event fields to include the mmio width and print
   addresses in hex.
 * Rewrote commit msg to explain some more about usecases.

Prasad Sodagudi (1):
  tracing: Add register read/write tracing support

Sai Prakash Ranjan (3):
  arm64: io: Use asm-generic high level MMIO accessors
  irqchip/tegra: Fix overflow implicit truncation warnings
  asm-generic/io: Add logging support for MMIO accessors

 arch/arm64/include/asm/io.h      | 33 ++-------------
 arch/arm64/kvm/hyp/nvhe/Makefile |  7 +++-
 drivers/irqchip/irq-tegra.c      | 10 ++---
 include/asm-generic/io.h         | 49 +++++++++++++++++++++++
 include/trace/events/rwmmio.h    | 69 ++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig             |  7 ++++
 kernel/trace/Makefile            |  1 +
 kernel/trace/trace_readwrite.c   | 29 ++++++++++++++
 8 files changed, 170 insertions(+), 35 deletions(-)
 create mode 100644 include/trace/events/rwmmio.h
 create mode 100644 kernel/trace/trace_readwrite.c

-- 
2.33.1

