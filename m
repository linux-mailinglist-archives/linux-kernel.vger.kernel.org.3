Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DF5026BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351414AbiDOIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351402AbiDOIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:37:02 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7CC02;
        Fri, 15 Apr 2022 01:34:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KfqPW5TlSz9sTc;
        Fri, 15 Apr 2022 10:34:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ErDqpMPfQOSA; Fri, 15 Apr 2022 10:34:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KfqPV68s5z9sTX;
        Fri, 15 Apr 2022 10:34:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFF4F8B778;
        Fri, 15 Apr 2022 10:34:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id V3Rr1nEre8pL; Fri, 15 Apr 2022 10:34:22 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AAF718B764;
        Fri, 15 Apr 2022 10:34:22 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 23F8YDv21534506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 10:34:13 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 23F8YC1M1534505;
        Fri, 15 Apr 2022 10:34:12 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: Prepare cleanup of powerpc's asm/prom.h
Date:   Fri, 15 Apr 2022 10:34:12 +0200
Message-Id: <295e87a3094a92784657f7060fb0927e762a2e3c.1650011506.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1650011651; l=1660; s=20211009; h=from:subject:message-id; bh=w17H8EXX8pzEMlNgwq1J3aHFe2hBhP9gSqoRGzwu21A=; b=NqNdCw1WJInGzdBSlek4u+GsfjaFl4vZYZFhkWUjDYJSCNUin1asdBn069jzIm1SVsrNFtQ5X81q 9KsojUt+BMX57aDhaBFH/d3aYY/gG73ByXss6UgW4ELTn54LiDIi
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

In order to clean it up in a further step, first clean all
files that include asm/prom.h

Some files don't need asm/prom.h at all. For those ones,
just remove inclusion of asm/prom.h

Some files don't need any of the items provided by asm/prom.h,
but need some of the headers included by asm/prom.h. For those
ones, add the needed headers that are brought by asm/prom.h at
the moment, then remove asm/prom.h

Some files really need asm/prom.h but also need some of the
headers included by asm/prom.h. For those one, leave asm/prom.h
but also add the needed headers so that they can be removed
from asm/prom.h in a later step.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: More detailed commit description
---
 drivers/usb/core/hcd-pci.c     | 1 -
 drivers/usb/host/ohci-ppc-of.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 8176bc81a635..f192925f74f7 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -15,7 +15,6 @@
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
-#include <asm/prom.h>
 #endif
 
 #include "usb.h"
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 45f7cceb6df3..1960b8dfdba5 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -19,9 +19,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <asm/prom.h>
-
-
 static int
 ohci_ppc_of_start(struct usb_hcd *hcd)
 {
-- 
2.35.1

