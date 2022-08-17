Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2615979AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbiHQWb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiHQWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF2A262C;
        Wed, 17 Aug 2022 15:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80D3AB81F60;
        Wed, 17 Aug 2022 22:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C9DC433D6;
        Wed, 17 Aug 2022 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775481;
        bh=nryGnFZEUd3dfpXHPuSwf2Mu1tM2xpxmFFLQP+/wNsA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZV3FC5WHldtdiockLPE3TIpjeTtSFPuLzZ/VEImqMvVNMNWqEfXYAbDIM/xN+rCaL
         onNc+OZYQRYHIIYYjDnpbFsgvrYBXUhfO11XI4MimxAfvnZY5V7gO9cF0IIB77JtB3
         niE7tpP0ghfF3YJEz1YPyRkvxCyH66tZCH5eyNwTEHZRWIM/fjlHa0itRGlS+m7wR6
         G3SA57Di42t6N/IWu36T1Al00LBckOdEivaDtmIYRBTjuKhB5X+f4Bx3Pe4xhc4VWd
         KcgxnHBbQvmt7MGkQ9Hew69uNLNzVTcMj5Vmh4Mql0azOcPNxudWEnLivdfbKOyZ20
         pWjQn0OEXeFsg==
Received: by pali.im (Postfix)
        id EB83777A; Thu, 18 Aug 2022 00:31:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 0/6] ARM: dts: pci-mvebu: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:47 +0200
Message-Id: <20220817223053.31141-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per IEEE Std 1275-1994 bindings documentation (to which kernel DT
bindings refers), DT property assigned-addresses contains BDF address
of resource. Currently more PCIe Root Port nodes have BDF address in
assigned-addresses which points to different PCIe Root Port nodes. This
obviously does not make sense as the address resource specified in
assigned-addresses of every PCIe Root Port describes address range of
internal registers which are specific for corresponding Marvell PCIe
Root Port. Fix this issue and align all BDF addresses in
assigned-addresses DT property to specify correct BDF address of the
current PCIe Root Port.

Note that current version of pci-mvebu.c controller driver, which
registers Marvell PCIe Root Ports, ignores BDF value in DT property
assigned-addresses. It expects that Root Port's assigned-addresses
contains address range of that root port. That is why driver currently
works without any issue and nobody spotted it. But if driver or
something else would do device tree validation then this issue should be
spotted and throws error. Also device tree files may be used by other
projects where drivers may require correct values.

This patch series aligns BDF address of every Marvell PCIe Root Port in
node name, config space in reg property and mem in assigned-address
property of internal registers resource.

Pali Rohár (6):
  ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
  ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root Port
  ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Port
  ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root Port
  ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root Port
  ARM: dts: armada-39x: Fix assigned-addresses for every PCIe Root Port

 arch/arm/boot/dts/armada-370.dtsi        |  2 +-
 arch/arm/boot/dts/armada-375.dtsi        |  2 +-
 arch/arm/boot/dts/armada-380.dtsi        |  4 ++--
 arch/arm/boot/dts/armada-385.dtsi        |  6 +++---
 arch/arm/boot/dts/armada-39x.dtsi        |  6 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  8 ++++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/dove.dtsi              |  2 +-
 8 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.20.1

