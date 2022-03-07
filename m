Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC54CFC1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiCGK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiCGK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:34 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E3655A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:17:22 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 799CC100002;
        Mon,  7 Mar 2022 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646648240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tutWd4trGKBphGeeWfYnezhoEF7V9uU5s6qavtK4MLY=;
        b=H4XtxXy/yXX4RbE1L0JLmDp2sJfxQkbW87TLMhNqKpZzBaUPtKR830LOUgdaWDuHbw0HWN
        +wGy7aeJoZCPLD9RNGZE4lT4Ag0f7chnoA2M/0E5D6IkAA/t8iyNePAQ4tlAynCrpgL4kB
        1eHduvg9iPb16RgSLAfC3IluRk4ZLdleYP6Qy8/kWrNqJsfnL+Mi5btx6G1i4x6JpIFeVM
        /2pYGE9Y2wHtKQ+OI7hK9dHVMRfOsV35HHRhtjOjYvM6H3D9i2dG5mmJY6B5eg8EGw4vjX
        wzfYRBVPzxsagkDJJ5FN440Dtk/7H9wCylzzJXU4qCcy9rYVlpul7P+ejFeRVA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/2] ARM: at91: add support for secure suspend on sama5d2
Date:   Mon,  7 Mar 2022 11:15:48 +0100
Message-Id: <20220307101550.95538-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that OP-TEE support for sama5d2 is more complete, add support to
execute SMC calls and to set suspend mode. This series adds new files
to be able to execute SMC calls targeting OP-TEE secure monitor and
secure suspend support uses it.

---

Changes V2:
 - Add suspend mode SMC in already existing secure support

Clément Léger (2):
  ARM: at91: add code to handle secure calls
  ARM: at91: pm: add support for sama5d2 secure suspend

 arch/arm/mach-at91/Kconfig      | 12 ++++++++-
 arch/arm/mach-at91/Makefile     |  2 +-
 arch/arm/mach-at91/pm.c         | 38 +++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.c | 46 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h | 18 +++++++++++++
 arch/arm/mach-at91/sama5.c      |  2 ++
 6 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.h

-- 
2.34.1

