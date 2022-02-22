Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4C4BFBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBVPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiBVPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:11:09 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A810EC4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:10:43 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE615FF814;
        Tue, 22 Feb 2022 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645542642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pOM4wfrMDqeY9Bjg00fwOoESa/b377YpBh4HMF9LC7U=;
        b=PBZW3zUOBneAa37PdtDkkBmmlqzZ+F0sMBsOq35Il849SxHeOBi/jjgF6/2sRa/gLqrpUy
        3GuF1geQaadYfXv0CvaRHUl2za8rZHUYX8zYIReuSk5biUaNIsUaRsuOtKteOdrdcDWMSz
        UvuwJeRTsjtTpWtCbkUSVQRyi6p/lVVllIIbUj0EgZPkSczDbavW59zso+0pu5VfXLBbVo
        lC7+MWXeXRl6Y0XCuDguvId07/4tgHCq/bOw1Oq+xD2n6OU8BHqJaMRKmogPKEvA9M88J7
        jfnXccbc3u7/IObuKhhn6h7h/yv+ImW7GjjGPP2fAxL1omJkd5PqD8LmPfcOUQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 0/4] ARM: at91: add support for secure suspend on sama5d2
Date:   Tue, 22 Feb 2022 16:08:42 +0100
Message-Id: <20220222150846.255307-1-clement.leger@bootlin.com>
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

Now that OP-TEE support for sama5d2 is more complete, add support to
execute SMC calls and to set suspend mode. This series adds new files
to be able to execute SMC calls targeting OP-TEE secure monitor and
secure suspend support uses it.

Clément Léger (4):
  ARM: at91: add code to handle secure calls
  ARM: at91: pm: move "atmel.pm_modes" parsing into a common file
  ARM: at91: pm: add support for sama5d2 secure suspend
  ARM: at91: pm: fix defines to select *_pm_init functions

 arch/arm/mach-at91/Kconfig          | 14 ++++++-
 arch/arm/mach-at91/Makefile         |  5 ++-
 arch/arm/mach-at91/generic.h        |  2 +-
 arch/arm/mach-at91/pm.c             | 31 +-------------
 arch/arm/mach-at91/pm.h             |  7 ++++
 arch/arm/mach-at91/pm_common.c      | 39 ++++++++++++++++++
 arch/arm/mach-at91/pm_secure.c      | 64 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.c     | 46 +++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h     | 18 ++++++++
 arch/arm/mach-at91/sama5.c          |  2 +
 include/linux/platform_data/atmel.h |  2 +-
 11 files changed, 195 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_common.c
 create mode 100644 arch/arm/mach-at91/pm_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.h

-- 
2.34.1

