Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00534501A36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbiDNRnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343569AbiDNRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:43 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E8FC6829;
        Thu, 14 Apr 2022 10:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649957979; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VjFBGdfplW0RwARYZ29skO53UAinybUpUvoqGP39DrTGoR+Z6DhBf2UrbuAIdWPjgc0KLLcFayn4gQ2x1igDeHIeQiZrtF3UiXKyCom9sspnqF5hI8pHUQjg4YFc9WRhhRnuhjghX76mt8tgvzwhBpv+K0ZuoaPCwd3FYk/zLp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649957979; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6l8Xi4rdLQ5Rv6v5LQWdj/sRsB5lC1bpiknsCtq45ho=; 
        b=m7cz0GKqm6eKi369qmxGKD0yfyuNIeLM05KC4mdhqEy9Ch/1QMS9rhkP9zo6T6VvRehBUH10jRbqe6fX18s+/MT7XeY8C3ZqNpoAXXVwt8PTkTIN4vjJKSW2nSP36JCJvWuygvgpUlhWxgojTf3FNmnEcjXUth7wfxmA4X/skaw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649957979;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=6l8Xi4rdLQ5Rv6v5LQWdj/sRsB5lC1bpiknsCtq45ho=;
        b=MhHRYtIBgQo2xR3glDY1nO3t9BbgtSIKd+lywl+3+r6e4KQBSWdQvZ6BMAOGWlpE
        DWJTMjxGwqKlzNyZTawdsIgc5W1lrGgR4AmSa2Y9iFUa/k3lzxnmiy7ucSQYdpwzrUu
        7fdG857j7V9pVycXYvMatIUNw/trdOSI4nQE+ASY=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649957978514971.8112186343374; Thu, 14 Apr 2022 10:39:38 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 00/14] Refactor Ralink Pinctrl and Add Documentation
Date:   Thu, 14 Apr 2022 20:39:02 +0300
Message-Id: <20220414173916.5552-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone.

This patch series brings complete refactoring to the Ralink pinctrl driver
and its subdrivers.

The mt7620 pinctrl subdriver supports MT7628 and MT7688 SoCs along with
MT7620. These two share the same pin layout. The code used for MT7628 and
MT7688 is renamed from MT7628/mt7628an to MT76X8.

Ralink pinctrl driver is called rt2880 which is the name of the Ralink
RT2880 SoC. A subdriver for the Ralink RT2880 SoC is called rt288x. Rename
rt2880 to ralink.

Rename code from pinmux to pinctrl for where the operation is not about the
muxing of pins.

Rename rt288x pinctrl subdriver for the RT2880 SoC to rt2880.

Variables for functions include "grp" on the Ralink MT7620 and MT7621
subdrivers. Rename them to "func" instead as they define the functions for
the pin groups. This is already the case for the other 3 subdrivers;
RT2880, RT305x, RT3883.

Fix Kconfig to call the subdrivers, well, subdrivers.

Add new compatible strings for each subdriver and update DT binding
accordingly.

Add Ralink pinctrl driver to MAINTAINERS and add me and Sergio as the
maintainers.

Finally, fix the current rt2880 documentation and add binding for all of
the subdrivers.

I have the patches here should anyone prefer to read them there:
https://github.com/arinc9/linux/commits/ralink-pinctrl-refactor

Ralink pinctrl driver and the subdrivers were compile tested.
MT7621 pinctrl subdriver was tested on a private mt7621 board.
YAML bindings checked with:
ARCH=mips CROSS_COMPILE=mips-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/ -j$(nproc)

v2:
- Add Sergio’s Reviewed-by: tag to where it's given.
- Properly explain the addition of the new compatible strings.
- Remove asterisk on MAINTAINERS commit.
- Properly explain the compatible string change for the rt2880 binding.
- Mention adding myself as a maintainer to rt2880 binding.
- Fix typo "indiviual" on YAML bindings. Limit lines to 80 characters.

Arınç ÜNAL (14):
  pinctrl: ralink: rename MT7628(an) functions to MT76X8
  pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink
  pinctrl: ralink: rename pinmux functions to pinctrl
  pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
  pinctrl: ralink: rename variable names for functions on MT7620 and MT7621
  pinctrl: ralink: rename driver names to subdrivers
  pinctrl: ralink: add new compatible strings for each pinctrl subdriver
  MAINTAINERS: add Ralink pinctrl driver
  mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
  dt-bindings: pinctrl: rt2880: fix binding name, pin groups and functions
  dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
  dt-bindings: pinctrl: add binding for Ralink MT7621 pinctrl
  dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
  dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl

 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml            |  91 +++++++++
 .../bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,mt7621-pinctrl.yaml}  |  27 +--
 Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml            |  68 +++++++
 Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml            |  92 +++++++++
 Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml            |  71 +++++++
 MAINTAINERS                                                                     |   7 +
 arch/mips/boot/dts/ralink/mt7621.dtsi                                           |   2 +-
 drivers/pinctrl/ralink/Kconfig                                                  |  28 ++-
 drivers/pinctrl/ralink/Makefile                                                 |   4 +-
 drivers/pinctrl/ralink/pinctrl-mt7620.c                                         | 302 +++++++++++++++---------------
 drivers/pinctrl/ralink/pinctrl-mt7621.c                                         |  76 ++++----
 drivers/pinctrl/ralink/pinctrl-ralink.c                                         | 349 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/ralink/{pinmux.h => pinctrl-ralink.h}                           |  16 +-
 drivers/pinctrl/ralink/pinctrl-rt2880.c                                         | 381 +++++---------------------------------
 drivers/pinctrl/ralink/pinctrl-rt288x.c                                         |  60 ------
 drivers/pinctrl/ralink/pinctrl-rt305x.c                                         |  66 +++----
 drivers/pinctrl/ralink/pinctrl-rt3883.c                                         |  50 ++---
 17 files changed, 1009 insertions(+), 681 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,mt7621-pinctrl.yaml} (63%)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
 create mode 100644 drivers/pinctrl/ralink/pinctrl-ralink.c
 rename drivers/pinctrl/ralink/{pinmux.h => pinctrl-ralink.h} (75%)
 delete mode 100644 drivers/pinctrl/ralink/pinctrl-rt288x.c


