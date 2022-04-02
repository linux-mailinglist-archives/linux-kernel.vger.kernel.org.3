Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1917A4F006D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351300AbiDBKVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiDBKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:21:01 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50C12629
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:19:09 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVtLN4g91z9sSZ;
        Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7QbbWbzQsQ4; Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVtLN3qx2z9sSY;
        Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7162A8B76D;
        Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SZjgNuEO6j77; Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 325398B768;
        Sat,  2 Apr 2022 12:19:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 232AIvQ2685097
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 2 Apr 2022 12:18:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 232AIu7B685096;
        Sat, 2 Apr 2022 12:18:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tty: hvc: Prepare cleanup of powerpc's asm/prom.h
Date:   Sat,  2 Apr 2022 12:18:55 +0200
Message-Id: <8b3dbd25bbeb7949e1b0a2170fee7b9cc5a6f806.1648833418.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648894734; l=1944; s=20211009; h=from:subject:message-id; bh=d4LUWHLQYB2RBspoMFrYGp7sUPtfQOfZFFYlzBwjZ18=; b=BiONXo4uG0mji8rDUYDSSVtILJOt/5u6tTHNB7KtyrLARFgmQXCZKYViu1UctfBdC3xXB07nas8K CRNGLeYXAi1pENCITDmhjrchHk5Avf0ouiYheeH58S9RAZaYdO8l
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
 drivers/tty/hvc/hvc_opal.c | 2 +-
 drivers/tty/hvc/hvc_vio.c  | 2 +-
 drivers/tty/hvc/hvsi.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 056ae21a5121..84776bc641e6 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -13,12 +13,12 @@
 #include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 
 #include <asm/hvconsole.h>
-#include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/hvsi.h>
 #include <asm/udbg.h>
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 72b11aa7e0a6..736b230f5ec0 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -28,10 +28,10 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/console.h>
+#include <linux/of.h>
 
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
-#include <asm/prom.h>
 #include <asm/hvsi.h>
 #include <asm/udbg.h>
 #include <asm/machdep.h>
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index aa81f4835fef..a200d01eceed 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -26,13 +26,13 @@
 #include <linux/module.h>
 #include <linux/major.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <asm/hvcall.h>
 #include <asm/hvconsole.h>
-#include <asm/prom.h>
 #include <linux/uaccess.h>
 #include <asm/vio.h>
 #include <asm/param.h>
-- 
2.35.1

