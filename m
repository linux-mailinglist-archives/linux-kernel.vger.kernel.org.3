Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349A554A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352451AbiFVNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352144AbiFVNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:10:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC41146A;
        Wed, 22 Jun 2022 06:10:53 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 94A62FF80E;
        Wed, 22 Jun 2022 13:10:41 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org
Subject: [PATCH v2 00/12] powerpc: Nintendo Wii U support
Date:   Wed, 22 Jun 2022 23:10:25 +1000
Message-Id: <20220622131037.57604-1-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add basic support for the Nintendo Wii U video
game console, a PowerPC system somewhat similar to the GameCube and
Wii.

This includes:
- devicetree source
- bootwrapper support
- udbg console to bootloader
- early udbg console
- interrupt controllers
- platform support
- recognition of the Espresso processor
- workaround for the discontiguous RAM blocks

This is enough to boot on hardware. dmesg pics (with a small hack to
udbg-immortal, not included):
Link: https://wiki.linux-wiiu.org/images/7/7e/Mainline-initial-dmesg1.png
Link: https://wiki.linux-wiiu.org/images/9/91/Mainline-initial-dmesg2.png

For those who have hardware and would like to try these patches, some
modification is required to the stock OS to allow Linux. For info:
https://wiki.linux-wiiu.org/wiki/AdvancedSetup

Some of the design choices (new platform > embedded6xx) were discussed
previously:
Link: https://lore.kernel.org/lkml/0020d47c-0e23-822c-33f5-ccb7ea4c1072@heyquark.com/T/

Turns out even less changes were needed than previously anticipated for
discontiguous memory, and KUAP is yet to give trouble. Thanks to those
who helped and discussed this.

Changes since v1:
 - Style and formatting tweaks to the devicetree, thanks Rob Herring for
   the review.

Ash Logan (12):
  dt-bindings: wiiu: Document the Nintendo Wii U devicetree
  powerpc: wiiu: device tree
  powerpc: wiiu: bootwrapper support
  powerpc: wiiu: introduce wiiu platform
  powerpc: wiiu: declare as non-coherent
  powerpc: wiiu: udbg support for latteipc
  powerpc: wiiu: espresso interrupt controller support
  powerpc: wiiu: latte interrupt controller support
  powerpc: espresso processor support
  powerpc: wiiu: platform support
  powerpc: wiiu: don't enforce flat memory
  powerpc: wiiu: Add minimal default config

 .../bindings/powerpc/nintendo/wiiu.yaml       |  28 ++
 .../powerpc/nintendo/wiiu/espresso-pic.yaml   |  42 +++
 .../bindings/powerpc/nintendo/wiiu/gpu7.yaml  |  41 +++
 .../powerpc/nintendo/wiiu/latte-ahci.yaml     |  43 +++
 .../powerpc/nintendo/wiiu/latte-dsp.yaml      |  35 ++
 .../powerpc/nintendo/wiiu/latte-pic.yaml      |  46 +++
 .../powerpc/nintendo/wiiu/latte-sdhci.yaml    |  40 +++
 .../bindings/powerpc/nintendo/wiiu/latte.yaml |  25 ++
 arch/powerpc/Kconfig.debug                    |   9 +
 arch/powerpc/boot/Makefile                    |   4 +
 arch/powerpc/boot/dts/wiiu.dts                | 322 ++++++++++++++++++
 arch/powerpc/boot/wiiu-head.S                 | 103 ++++++
 arch/powerpc/boot/wiiu.c                      |  73 ++++
 arch/powerpc/boot/wrapper                     |   4 +
 arch/powerpc/configs/wiiu_defconfig           |   7 +
 arch/powerpc/include/asm/udbg.h               |   1 +
 arch/powerpc/kernel/cputable.c                |  16 +
 arch/powerpc/kernel/head_book3s_32.S          |  20 ++
 arch/powerpc/kernel/udbg.c                    |   3 +
 arch/powerpc/mm/init_32.c                     |   4 +-
 arch/powerpc/platforms/Kconfig                |   1 +
 arch/powerpc/platforms/Kconfig.cputype        |   2 +-
 arch/powerpc/platforms/Makefile               |   1 +
 arch/powerpc/platforms/wiiu/Kconfig           |  19 ++
 arch/powerpc/platforms/wiiu/Makefile          |   4 +
 arch/powerpc/platforms/wiiu/espresso-pic.c    | 183 ++++++++++
 arch/powerpc/platforms/wiiu/espresso-pic.h    |  59 ++++
 arch/powerpc/platforms/wiiu/latte-pic.c       | 259 ++++++++++++++
 arch/powerpc/platforms/wiiu/latte-pic.h       |  23 ++
 arch/powerpc/platforms/wiiu/setup.c           |  67 ++++
 arch/powerpc/platforms/wiiu/udbg_latteipc.c   | 122 +++++++
 arch/powerpc/platforms/wiiu/udbg_latteipc.h   |  27 ++
 32 files changed, 1630 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
 create mode 100644 arch/powerpc/boot/dts/wiiu.dts
 create mode 100644 arch/powerpc/boot/wiiu-head.S
 create mode 100644 arch/powerpc/boot/wiiu.c
 create mode 100644 arch/powerpc/configs/wiiu_defconfig
 create mode 100644 arch/powerpc/platforms/wiiu/Kconfig
 create mode 100644 arch/powerpc/platforms/wiiu/Makefile
 create mode 100644 arch/powerpc/platforms/wiiu/espresso-pic.c
 create mode 100644 arch/powerpc/platforms/wiiu/espresso-pic.h
 create mode 100644 arch/powerpc/platforms/wiiu/latte-pic.c
 create mode 100644 arch/powerpc/platforms/wiiu/latte-pic.h
 create mode 100644 arch/powerpc/platforms/wiiu/setup.c
 create mode 100644 arch/powerpc/platforms/wiiu/udbg_latteipc.c
 create mode 100644 arch/powerpc/platforms/wiiu/udbg_latteipc.h


base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

