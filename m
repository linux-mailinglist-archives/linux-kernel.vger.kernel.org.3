Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCFE517270
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiEBP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbiEBP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:27:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51D13CFD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:23:38 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4E787240003;
        Mon,  2 May 2022 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651505017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NRx/sFS6cK8F7vvtOq0bTd/fTq+8EgoXR5ZO4+0mp4M=;
        b=ALeOSdj5ocd2k5c4fb5khkuTBhanikviBNZHYLqLmdt3zMCQjZpWlsr/kx2yG6RDGpgvPD
        im4ovTbh8lFCESsevh3NSZOi9grBSrnCtJb4tQi6Y4ehGWnFo4i3RMgbZrfRl3slvOg9rV
        v3UON/nnTsGiKXYFlNrZJ3Oxq5WIDqdMwN5o/RP8JRjtSZUdDiwM6Wq9YHrnG7hPiHrM+w
        N81slnI9vWp/gPmgTn+JTQkILYupuVYmBMmC4HAxIvBiKVuA9C13vlrPnVCVuFKDGbBiUF
        pAAHzhoaV5KqTefgeRmhxkSXVPJ97A03y9ziWx6R9S5/7KjZ+PWRh3dvF2FdAQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/2] ARM: at91: add support for secure suspend on sama5d2
Date:   Mon,  2 May 2022 17:22:17 +0200
Message-Id: <20220502152219.216758-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
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

Now that OP-TEE support for sama5d2 is more complete, add support to
execute SMC calls and to set suspend mode. This series adds new files
to be able to execute SMC calls targeting OP-TEE secure monitor. Then
secure suspend support is added and uses these new functions.

---
Changes in v3:
 - Move warning for standby in sama5d2_pm_init()
 - Remove missleading message in ATMEL_SECURE_PM help

Changes in v2:
 - Add suspend mode SMC in already existing secure support

Clément Léger (2):
  ARM: at91: add code to handle secure calls
  ARM: at91: pm: add support for sama5d2 secure suspend

 arch/arm/mach-at91/Kconfig      | 11 +++++++-
 arch/arm/mach-at91/Makefile     |  2 +-
 arch/arm/mach-at91/pm.c         | 36 ++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.c | 46 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h | 18 +++++++++++++
 arch/arm/mach-at91/sama5.c      |  2 ++
 6 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.h

-- 
2.34.1

