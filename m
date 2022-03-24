Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447004E64DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350905AbiCXOQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbiCXOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:16:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8EB23BC0;
        Thu, 24 Mar 2022 07:14:29 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B51E76000D;
        Thu, 24 Mar 2022 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648131267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Apb2CpKn69J/+/Fz8GwEO96e94X6qhRbKP77Fofh3Fc=;
        b=nMVNKOujS787Xgm2AbQvqwOlFpgsTKM6mRrHJCLuBynJTcSHu0PPm+L06IZobev8mDWT7J
        KqwHYixOvD8kVHutp/+WeAQm8UfGj44GHgrFiqsvB+ebK6t6GW/18qfrRrt4roUBtlFOgU
        /EPBQPLj3OkbGNLCNlw3xeWfZL9G0bZ4t/VqFWefVKT7TLIO3XYSPRyIdLgGW1xK61Qlrl
        WJC1tzyrcCE3zk8t9ErvU1wfpcQEYf4Tqx9CO9DOnNFI+mOyhXN4JD3eFYwT9KcPWr7y01
        ZhVDID4llGv8gUy0PTcJ/bwBSlfQ8nHuWt5g8f8uI16HS2f9Cl/AelaJnM/vHQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 0/3] add fwnode support to reset subsystem
Date:   Thu, 24 Mar 2022 15:12:34 +0100
Message-Id: <20220324141237.297207-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is part of a larger series which aims at adding fwnode
support in multiple subsystems [1]. The goal of this series was to
add support for software node in various subsystem but in a first
time only the fwnode support had gained consensus and will be added
to multiple subsystems.

For the moment ACPI node support is excluded from the fwnode support
to avoid creating an unspecified ACPI reset device description. With
these modifications, both driver that uses the fwnode_ API or the of_
API to register the reset controller will be usable by consumer
whatever the type of node that is used.

One question raised by this series is that I'm not sure if all reset
drivers should be modified to use the new fwnode support or keep the
existing device-tree support. Maintainer advice on that particular
question will be welcome.

This series was tested on a sparx5 board (pcb134).

[1] https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/

---

Changes in V2:
- Updated comment specifying that either one of fwnode_xlate or of_xlate
  should provided and add check to return EINVAL if both are set
- Use only fwnode node name in rcdev_name() which also works for of_node
- Remove of_node handling case in __reset_control_get()
- Handle new error values -EOVERFLOW and -ENOMEM (returned by swnode
  implementation) for fwnode_property_match_string()
- Add sparx5 driver fwnode conversion

Clément Léger (3):
  of: add function to convert fwnode_reference_args to of_phandle_args
  reset: add support for fwnode
  reset: mchp: sparx5: set fwnode field of reset controller

 drivers/reset/core.c                   | 100 ++++++++++++++++++-------
 drivers/reset/reset-microchip-sparx5.c |   3 +-
 include/linux/of.h                     |  18 +++++
 include/linux/reset-controller.h       |  20 ++++-
 include/linux/reset.h                  |  14 ++++
 5 files changed, 123 insertions(+), 32 deletions(-)

-- 
2.34.1

