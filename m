Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7A581955
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiGZSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiGZSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:06:37 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F00822A714;
        Tue, 26 Jul 2022 11:06:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,194,1654527600"; 
   d="scan'208";a="129202667"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jul 2022 03:06:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0573D40C58A7;
        Wed, 27 Jul 2022 03:06:30 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/6] Add support for Renesas RZ/Five SoC
Date:   Tue, 26 Jul 2022 19:06:17 +0100
Message-Id: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
[0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/
rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-
andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet

[1] http://www.andestech.com/en/products-solutions/andescore-processors/
riscv-ax45mp/

Patch series depends on:
-----------------------
[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[1] https://patchwork.kernel.org/project/linux-renesas-soc/
cover/20220630100241.35233-1-samuel@sholland.org/

[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[3] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

[4] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Below are the logs from Renesas RZ/Five SMARC EVK:
-------------------------------------------------

/ # cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdc
mmu             : sv39
uarch           : andestech,ax45mp
mvendorid       : 0x31e
marchid         : 0x8000000000008a45
mimpid          : 0x500

/ # cat /proc/meminfo
MemTotal:         884132 kB
MemFree:          863292 kB
MemAvailable:     860880 kB
Buffers:               0 kB
Cached:             1796 kB
SwapCached:            0 kB
Active:             1412 kB
Inactive:            456 kB
Active(anon):       1412 kB
Inactive(anon):      456 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           108 kB
Mapped:             1136 kB
Shmem:              1796 kB
KReclaimable:       6424 kB
Slab:              12548 kB
SReclaimable:       6424 kB
SUnreclaim:         6124 kB
KernelStack:         844 kB
PageTables:           32 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      442064 kB
Committed_AS:       2388 kB
VmallocTotal:   67108864 kB
VmallocUsed:         860 kB
VmallocChunk:          0 kB
Percpu:               84 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
/ # 
/ # cat /proc/interrupts 
           CPU0       
  1:          0  SiFive PLIC 412 Level     1004b800.serial:rx err
  2:          1  SiFive PLIC 414 Level     1004b800.serial:rx full
  3:         72  SiFive PLIC 415 Level     1004b800.serial:tx empty
  4:          0  SiFive PLIC 413 Level     1004b800.serial:break
  5:      10193  RISC-V INTC   5 Edge      riscv-timer
  6:         14  SiFive PLIC 416 Level     1004b800.serial:rx ready
IPI0:         0  Rescheduling interrupts
IPI1:         0  Function call interrupts
IPI2:         0  CPU stop interrupts
IPI3:         0  IRQ work interrupts
IPI4:         0  Timer broadcast interrupts
/ # 
/ # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
soc0/$i; done
machine: Renesas SMARC EVK based on r9a07g043
family: RZ/Five
soc_id: r9a07g043
revision: 0
/ # 

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: arm: renesas: Ignore the schema for RISC-V arch
  dt-bindings: riscv: Sort the CPU core list alphabetically
  dt-bindings: riscv: Add Andes AX45MP core to the list
  dt-bindings: riscv: Add DT binding documentation for Renesas RZ/Five
    SoC and SMARC EVK
  RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig option
  riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC

 .../devicetree/bindings/arm/renesas.yaml      |   9 ++
 .../devicetree/bindings/riscv/cpus.yaml       |  11 +-
 .../devicetree/bindings/riscv/renesas.yaml    |  49 +++++++
 arch/riscv/Kconfig.socs                       |  14 ++
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi    | 121 ++++++++++++++++++
 6 files changed, 200 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/renesas.yaml
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi

-- 
2.17.1

