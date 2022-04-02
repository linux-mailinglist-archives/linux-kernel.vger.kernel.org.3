Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59AC4F0037
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354203AbiDBJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354189AbiDBJwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:52:41 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE0657BE;
        Sat,  2 Apr 2022 02:50:48 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVsjd2M5Zz9sSQ;
        Sat,  2 Apr 2022 11:50:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z3MUvRq6RmtZ; Sat,  2 Apr 2022 11:50:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVsjd1DWVz9sSK;
        Sat,  2 Apr 2022 11:50:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 125F78B76D;
        Sat,  2 Apr 2022 11:50:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HCQ8W1xZ0UnK; Sat,  2 Apr 2022 11:50:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE5D98B768;
        Sat,  2 Apr 2022 11:50:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2329oSiI683640
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 2 Apr 2022 11:50:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2329oSfu683638;
        Sat, 2 Apr 2022 11:50:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: Prepare cleanup of powerpc's asm/prom.h
Date:   Sat,  2 Apr 2022 11:50:21 +0200
Message-Id: <5ed3298d8b5b1b5bf681d79584c61cb495852f4e.1648833423.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648893020; l=1125; s=20211009; h=from:subject:message-id; bh=AN5+sJJJcquHvC2UPmI8GuxRgyVnpRlVKbnl/IP79Gc=; b=Fie+6glCGNPKokhM39eJzMe0z6W7PURsdfNqy7vMjCl9usnHh1FN57C9J6/EsQWtuuSXk/GHvDEo 1NQvLrlZA4x0XpUmOOvZf/TtHls5JEQdfQz2h4EZEVNLA2LSrlii
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
 drivers/spi/spi-mpc52xx-psc.c | 1 +
 drivers/spi/spi-mpc52xx.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 21ef5d481faf..7654736c2c0e 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
 #include <linux/slab.h>
+#include <linux/of_irq.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 51041526546d..3ebdce804b90 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -19,6 +19,9 @@
 #include <linux/io.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
 
-- 
2.35.1

