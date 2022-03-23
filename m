Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6134E4FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbiCWJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCWJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:53:19 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555B40A1E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:51:49 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CD2451C0010;
        Wed, 23 Mar 2022 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648029107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6wzTq/iLtaua/nCNsjBznYuZy+E+HLp3ClQUbK0xQdc=;
        b=GtjrWOFZUnUfsPInHz9xnq3hqc8FbLAFDMoe+vG3J2HO54gN36DwXFuhDE4n3A7a8o2Y2A
        64xa8wzIASffXh+q5FJLzZlbXgvBCn2uEPMwillvJpbFmoLR890LA5jDUe0SJJGrjyNkmU
        Ypd315pL21B0eaBVKw7Kewetlu/G3gnvLjyiFOxT8s0tqum7BSLMIBZo47qaltD3JzmSzA
        fQ047wMJ/fzohk6vhr51aH385jwyrZnDwmUkuXvDgdeOX3ijzHrWcG+AG9llL1uxNdqh4D
        5sPCUDafvFaixOluANWilFqjeXBCYk3f5aYHguTZ4ixci9hkcuu5WZoa6Gz9BA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 0/2] add fwnode support to reset subsystem
Date:   Wed, 23 Mar 2022 10:50:20 +0100
Message-Id: <20220323095022.453708-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/

Clément Léger (2):
  of: add function to convert fwnode_reference_args to of_phandle_args
  reset: add support for fwnode

 drivers/reset/core.c             | 91 ++++++++++++++++++++++++--------
 include/linux/of.h               | 18 +++++++
 include/linux/reset-controller.h | 14 ++++-
 include/linux/reset.h            | 14 +++++
 4 files changed, 114 insertions(+), 23 deletions(-)

-- 
2.34.1

