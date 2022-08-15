Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858D593177
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiHOPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHOPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:15:58 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DA03EE3D;
        Mon, 15 Aug 2022 08:15:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="131484119"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 00:15:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3E4FF403965B;
        Tue, 16 Aug 2022 00:15:50 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/8] Add support for Renesas RZ/Five SoC
Date:   Mon, 15 Aug 2022 16:14:43 +0100
Message-Id: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
entry-class social infrastructure gateway control and industrial gateway
control.

This patch series adds initial SoC DTSi support for Renesas RZ/Five
(R9A07G043) SoC and updates the bindings for the same. Below is the list
of IP blocks added in the initial SoC DTSI which can be used to boot via
initramfs on RZ/Five SMARC EVK:
- AX45MP CPU
- CPG
- PINCTRL
- PLIC
- SCIF0
- SYSC

Useful links:
-------------
[0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
[1] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/

Patch series depends on:
-----------------------
[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[4] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Below are the logs from RZ/Five SMARC EVK:
------------------------------------------
/ # uname -ra
Linux (none) 5.19.0-next-20220815-00072-ge2dccecbe54f #256 SMP Mon Aug 15 15:12:03 BST 2022 riscv64 GNU/Linux
/ #
/ # cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdc
mmu             : sv39
uarch           : andestech,ax45mp
mvendorid       : 0x31e
marchid         : 0x8000000000008a45
mimpid          : 0x500

/ # cat /proc/interrupts
           CPU0
  1:          0  SiFive PLIC 412 Level     1004b800.serial:rx err
  2:          1  SiFive PLIC 414 Level     1004b800.serial:rx full
  3:        181  SiFive PLIC 415 Level     1004b800.serial:tx empty
  4:          0  SiFive PLIC 413 Level     1004b800.serial:break
  5:       2435  RISC-V INTC   5 Edge      riscv-timer
  6:         38  SiFive PLIC 416 Level     1004b800.serial:rx ready
IPI0:         0  Rescheduling interrupts
IPI1:         0  Function call interrupts
IPI2:         0  CPU stop interrupts
IPI3:         0  IRQ work interrupts
IPI4:         0  Timer broadcast interrupts
/ # cat /proc/meminfo
MemTotal:         882356 kB
MemFree:          861996 kB
MemAvailable:     859744 kB
Buffers:               0 kB
Cached:             1796 kB
SwapCached:            0 kB
Active:                0 kB
Inactive:             80 kB
Active(anon):          0 kB
Inactive(anon):       80 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:        1796 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           116 kB
Mapped:             1136 kB
Shmem:                 0 kB
KReclaimable:       6732 kB
Slab:              11904 kB
SReclaimable:       6732 kB
SUnreclaim:         5172 kB
KernelStack:         556 kB
PageTables:           32 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      441176 kB
Committed_AS:        592 kB
VmallocTotal:   67108864 kB
VmallocUsed:         716 kB
VmallocChunk:          0 kB
Percpu:               84 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
/ #
/ # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
soc0/$i; done
machine: Renesas SMARC EVK based on r9a07g043f01
family: RZ/Five
soc_id: r9a07g043
revision: 0
/ #

Lad Prabhakar (8):
  dt-bindings: riscv: Sort the CPU core list alphabetically
  dt-bindings: riscv: Add Andes AX45MP core to the list
  dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five SoC
  RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig option
  riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
  riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
  MAINTAINERS: Add entry for Renesas RISC-V architecture
  RISC-V: configs: defconfig: Enable Renesas RZ/Five SoC

 .../devicetree/bindings/arm/renesas.yaml      |   3 +-
 .../devicetree/bindings/riscv/cpus.yaml       |  11 +-
 MAINTAINERS                                   |  10 ++
 arch/riscv/Kconfig.socs                       |  14 ++
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/renesas/Makefile          |   2 +
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi    | 121 ++++++++++++++++++
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  16 +++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  22 ++++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |  32 +++++
 arch/riscv/configs/defconfig                  |   2 +
 11 files changed, 228 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/boot/dts/renesas/Makefile
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi

-- 
2.25.1

