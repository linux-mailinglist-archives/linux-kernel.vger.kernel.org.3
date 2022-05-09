Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85151FFD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiEIOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiEIOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:30:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B831CFD1;
        Mon,  9 May 2022 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652106406; x=1683642406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCdSIoiGs6J+p/OfruwdFMvCF2xJa6k7Z24v4z1d0G4=;
  b=ieimuAF2XOeLfLl6Nao7HUhSrUP4lBHs55NGo2iCcXnxS09wQoh50S1C
   gvNEoNnU2+2Dwux0Z06MI2TLZT7KWjSBHQPWEbtjHPolVx26qfGP6HxJ9
   VUfAx/8uH+XX1h5sZ4lkAbkuOUsDOl72cw27Vh8B4sXA9006DW7invIWQ
   YZwGfKTbCf4V7355Vrx0hnWg/4jjzKp2Xc7beBPc91R6dR62Xlt5VVZWD
   4nWqPhd9sAuaI4WAMW2hAtVI9fZusYgzDTPi0SmIGtoDWlE9PdhRpMKPh
   kxTczioilSe19yy6Jw9Vf6HL17pJ/cH6N9b8rI5VdrOOoF8VGP1wJc4qY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="162858666"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 07:26:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 07:26:44 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 07:26:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 00/10] PolarFire SoC dt for 5.19
Date:   Mon, 9 May 2022 15:26:01 +0100
Message-ID: <20220509142610.128590-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
Got a few PolarFire SoC device tree related changes here for 5.19.

Firstly, patches 1 & 2 of this series supersede [0] & are unchanged
compared to that submission, figured it would just be easier to keep
all the changes in one series.

As discussed on irc, patch 3 removes the duplicated "microchip" from
the device tree files so that they follow a soc-board.dts & a
soc{,-fabric}.dtsi format.

Patch 5 makes the fabric dtsi board specific by renaming the file to
mpfs-icicle-kit-fabric.dtsi & including it in the dts rather than
mpfs.dtsi. Additionally this will allow other boards to define their
own reference fabric design. A revision specific compatible, added in
patch 4, is added to the dt also.

The remainder of the series adds a bare minimum devicetree for the
Sundance Polarberry.

Thanks,
Conor.

Changes since v4:
- Whitespace and status ordering changes in the polarberry dt pointed
  out by Heiko
- A new patch for same whitspace and status order changes, but applied
  to the icicle dt
- A reordering of the icicle dt alphabetically to match the formatting
  of the polarberry dt

Changes since v3:
- remove an extra line of wshitespace added to dt-binding
- remove unneeded "okay" status & sort status to node end
- sort polarberry dts entries in ~alphabetical order
- add a comment explaining why the second mac (mac0) is disabled on
  polarberry

Changes since v2:
- make ,icicle-reference compatible with ,mpfs & put it inside the enum

Changes since v1:
- fixed whitespace problems in the polarberry dts
- disabled mac0 for the polarberry as its port is on the optional
  carrier board

Conor Dooley (10):
  riscv: dts: microchip: remove icicle memory clocks
  riscv: dts: microchip: move sysctrlr out of soc bus
  riscv: dts: microchip: remove soc vendor from filenames
  dt-bindings: riscv: microchip: document icicle reference design
  riscv: dts: microchip: make the fabric dtsi board specific
  dt-bindings: vendor-prefixes: add Sundance DSP
  dt-bindings: riscv: microchip: add polarberry compatible string
  riscv: dts: microchip: add the sundance polarberry
  riscv: microchip: icicle: readability fixes
  riscv: dts: icicle: sort nodes alphabetically

 .../devicetree/bindings/riscv/microchip.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/riscv/boot/dts/microchip/Makefile        |   3 +-
 ...abric.dtsi => mpfs-icicle-kit-fabric.dtsi} |   2 +
 ...pfs-icicle-kit.dts => mpfs-icicle-kit.dts} | 105 +++++++++---------
 .../dts/microchip/mpfs-polarberry-fabric.dtsi |  16 +++
 .../boot/dts/microchip/mpfs-polarberry.dts    |  99 +++++++++++++++++
 .../{microchip-mpfs.dtsi => mpfs.dtsi}        |  11 +-
 8 files changed, 181 insertions(+), 59 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (91%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (95%)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (98%)

-- 
2.35.2

