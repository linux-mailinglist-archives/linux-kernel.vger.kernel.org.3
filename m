Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0D4F0071
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354272AbiDBKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiDBKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:22:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58312629;
        Sat,  2 Apr 2022 03:20:32 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVtMz3DGqz9sSK;
        Sat,  2 Apr 2022 12:20:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xnPhM1sjivqw; Sat,  2 Apr 2022 12:20:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVtMz2NVhz9sQx;
        Sat,  2 Apr 2022 12:20:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 370848B76D;
        Sat,  2 Apr 2022 12:20:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N76mO51tVULW; Sat,  2 Apr 2022 12:20:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9FBA8B768;
        Sat,  2 Apr 2022 12:20:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 232AKK2x685186
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 2 Apr 2022 12:20:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 232AKJrg685185;
        Sat, 2 Apr 2022 12:20:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: Prepare cleanup of powerpc's asm/prom.h
Date:   Sat,  2 Apr 2022 12:20:19 +0200
Message-Id: <49fc0d4b6446da630b1e9f29c4bab38f8ed087bf.1648833419.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648894818; l=1666; s=20211009; h=from:subject:message-id; bh=OEjRDeZAfp+2QT3pAyv3SoV3GY3UmYAVBWs0TMUxvZk=; b=gpK/gwFq/JdRwA2dEZAy3dkq+jhAAP6bs68z/l7be45EW2seiobjWw7j79KO9+C/n55e0WTDpdlY psC3jgNUBm2sYm75W9rJK8EMKY0mVuyHTfRe6nECvrGSfYfBOLlU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc's asm/prom.h brings some headers that it doesn't
need itself.

In order to clean it up, first add missing headers in
users of asm/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 1 -
 drivers/tty/serial/mpc52xx_uart.c           | 2 ++
 drivers/tty/serial/pmac_zilog.c             | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 6a1cd03bfe39..108af254e8f3 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -25,7 +25,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/fs_pd.h>
-#include <asm/prom.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 8a6958377764..4ec785e4f9b1 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -38,6 +38,8 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 5d97c201ad88..c903085acb8d 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -51,7 +51,6 @@
 #include <asm/irq.h>
 
 #ifdef CONFIG_PPC_PMAC
-#include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
-- 
2.35.1

