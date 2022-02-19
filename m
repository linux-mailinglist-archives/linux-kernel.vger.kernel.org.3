Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C514BC8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiBSOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:46:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:46:16 -0500
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3B9AE68;
        Sat, 19 Feb 2022 06:45:56 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0903952|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0665288-8.09977e-05-0.93339;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.MsSaWGO_1645281943;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.MsSaWGO_1645281943)
          by smtp.aliyun-inc.com(33.37.75.142);
          Sat, 19 Feb 2022 22:45:52 +0800
Message-ID: <6ff70d9fbbfcde860823aa24f0ce58a0a96a1c91.camel@nucleisys.com>
Subject: Re: [PATCH 00/12] Initial support for Nuclei DemoSoC w/ UX600
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Date:   Sat, 19 Feb 2022 22:45:43 +0800
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-01-27星期四的 23:16 +0800，Icenowy Zheng写道：
> This patchset adds support for Nuclei DemoSoC (which is an evaluation
> platform made with Nuclei CPU cores and mainly peripherals in
> original
> Hummingbird E203 project, running on FPGA) with UX600 CPU cores.
> 
> Most patches are for DT bindings, the remaining ones are adding a
> Kconfig option and some DTS/DTSI files. The last one is a workaround
> for
> a severe bug in currently released versions of UX600, which is found
> in 5.17 kernel, in which Sv48 support is added to Linux.
> 
> Two non-technical patches are in this patchset too, for MAINTAINERS
> and .mailmap items.

Ping, could any RISC-V maintainers review these patches, especially the
SATP workaround one?

> 
> Icenowy Zheng (12):
>   dt-bindings: vendor-prefixes: add Nuclei
>   RISC-V: add Nuclei SoC Kconfig option
>   dt-bindings: riscv: add compatible strings for Nuclei UX600 series
>   dt-bindings: timer: add compatible for Nuclei UX600 CLINT-compat
> timer
>   dt-bindings: interrupt-controller: add compatible string for UX600
>     PLIC
>   dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
>   dt-bindings: spi: add compatible string for Nuclei DemoSoC SPI
>   dt-bindings: riscv: add binding for Nuclei platform boards
>   riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
>   RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
>   MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
>   mailmap: add Icenowy Zheng's Nuclei mail addresses
> 
>  .mailmap                                      |  1 +
>  .../sifive,plic-1.0.0.yaml                    |  1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |  7 ++
>  .../devicetree/bindings/riscv/nuclei.yaml     | 27 ++++++++
>  .../bindings/serial/sifive-serial.yaml        |  1 +
>  .../devicetree/bindings/spi/spi-sifive.yaml   |  1 +
>  .../bindings/timer/sifive,clint.yaml          |  1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  7 ++
>  arch/riscv/Kconfig.socs                       |  6 ++
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/nuclei/Makefile           |  2 +
>  .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
>  .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
>  .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
>  .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67
> +++++++++++++++++++
>  arch/riscv/include/asm/vendorid_list.h        |  1 +
>  arch/riscv/mm/init.c                          | 17 +++++
>  18 files changed, 245 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/riscv/nuclei.yaml
>  create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
> ddr200t.dtsi
>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-
> ddr200t.dts
>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
> ux600.dtsi
>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
> 


