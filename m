Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4049E598
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiA0PQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:16:58 -0500
Received: from out28-148.mail.aliyun.com ([115.124.28.148]:43275 "EHLO
        out28-148.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiA0PQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:16:57 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4309704|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0724481-0.000318653-0.927233;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85OyW_1643296608;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85OyW_1643296608)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:16:53 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 00/12] Initial support for Nuclei DemoSoC w/ UX600
Date:   Thu, 27 Jan 2022 23:16:35 +0800
Message-Id: <20220127151647.2375449-1-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Nuclei DemoSoC (which is an evaluation
platform made with Nuclei CPU cores and mainly peripherals in original
Hummingbird E203 project, running on FPGA) with UX600 CPU cores.

Most patches are for DT bindings, the remaining ones are adding a
Kconfig option and some DTS/DTSI files. The last one is a workaround for
a severe bug in currently released versions of UX600, which is found
in 5.17 kernel, in which Sv48 support is added to Linux.

Two non-technical patches are in this patchset too, for MAINTAINERS
and .mailmap items.

Icenowy Zheng (12):
  dt-bindings: vendor-prefixes: add Nuclei
  RISC-V: add Nuclei SoC Kconfig option
  dt-bindings: riscv: add compatible strings for Nuclei UX600 series
  dt-bindings: timer: add compatible for Nuclei UX600 CLINT-compat timer
  dt-bindings: interrupt-controller: add compatible string for UX600
    PLIC
  dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
  dt-bindings: spi: add compatible string for Nuclei DemoSoC SPI
  dt-bindings: riscv: add binding for Nuclei platform boards
  riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
  RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
  MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
  mailmap: add Icenowy Zheng's Nuclei mail addresses

 .mailmap                                      |  1 +
 .../sifive,plic-1.0.0.yaml                    |  1 +
 .../devicetree/bindings/riscv/cpus.yaml       |  7 ++
 .../devicetree/bindings/riscv/nuclei.yaml     | 27 ++++++++
 .../bindings/serial/sifive-serial.yaml        |  1 +
 .../devicetree/bindings/spi/spi-sifive.yaml   |  1 +
 .../bindings/timer/sifive,clint.yaml          |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  7 ++
 arch/riscv/Kconfig.socs                       |  6 ++
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/nuclei/Makefile           |  2 +
 .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
 .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
 .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
 .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67 +++++++++++++++++++
 arch/riscv/include/asm/vendorid_list.h        |  1 +
 arch/riscv/mm/init.c                          | 17 +++++
 18 files changed, 245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/nuclei.yaml
 create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ddr200t.dtsi
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-ddr200t.dts
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600.dtsi
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi

-- 
2.30.2

