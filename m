Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFE557830
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiFWKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiFWKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:52:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165474B428;
        Thu, 23 Jun 2022 03:51:58 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A0F02E0017;
        Thu, 23 Jun 2022 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655981516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U7RfSrcQuRamOWWjJI1BD1X5IJAeB9zPMHMT1huumAE=;
        b=daIUvP2fgkDg44Q7KttVzCGnVY2CC5+apqLBGn+WAZtC2QHkWgqJwJB7oP0289V0HCA88R
        FaUHdxpzCoZRUIlqI64KAvvP0uKfZoBLEqOPnYSnYPIR/sHoJN8EWXd0liboXaDV2d4551
        Uc+/zyVedUxNk4ojob4Bv4mbw/OhTXDoQKB8RXumMUDXpsRh+qO0m5gh8JLONluvsNNEkD
        LhagOIc0fZiAWOuKYGQZe7PJioJ6R6hwJmHOHr97hF/DshqSQAirFpNht4Hof8eKK/SQWN
        esItSdNHPVo1YGvTenMJAHdZbqOGW4xAT2DVisuJBdmozNmHN9odNF95borl1A==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 0/2] of: populate of_root node if not set
Date:   Thu, 23 Jun 2022 12:50:42 +0200
Message-Id: <20220623105044.152832-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to apply overlays or create new nodes under the root node, the
kernel expects of_root to be set. On some system were a device-tree us
not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
then we will end up with a null of_root. This series add support to
create this root node using a builtin dtb and remove the manual
creation of the root node done in unittests.c.

Clément Léger (2):
  of: base: populate of_root node if not set
  of: unittest: remove check for of_root

 drivers/of/Makefile       |  2 +-
 drivers/of/base.c         | 18 ++++++++++++++++--
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/unittest.c     | 10 ----------
 4 files changed, 23 insertions(+), 13 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

-- 
2.36.1

