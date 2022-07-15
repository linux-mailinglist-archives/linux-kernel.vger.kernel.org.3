Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C557A57691D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiGOVmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiGOVl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:41:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1087215;
        Fri, 15 Jul 2022 14:41:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so5511748pgb.4;
        Fri, 15 Jul 2022 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIiYiWzakzO24+cDORxNrgX7+oa/5spW02PWcOTwqvE=;
        b=nu/3FV1r4nno4gVxAosYSPpfuOa1Dm+EyCQIPwhEMDhDS16G8dh1xExupPl/jsUAHh
         s97M9acFO0GAww4OsVoC5Rzf2LfQNuezTqaQHWhPZjNB11IvurqsbE8liK+FTanI25QP
         BheZkm53vwQ2GMWFl/49uaFX9rxjKAnb9IktO6EaiubGSY7HEeVoQpbJZ0L7d7XudxIc
         lhn5x8m4A+xggTWoxgsaWV7aiIvjT/mHE4C97vKuB9uW2lBh7HuInDPx1wy0sMnoNjLC
         cTegxL9fRtiazB/PGUP+zCuLynSJVF3RpDdFMLRq5+hn1+cfbXi2P5Vp7CGWVCe7GnLV
         eIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIiYiWzakzO24+cDORxNrgX7+oa/5spW02PWcOTwqvE=;
        b=zoSBLGbGU4Hvv1FWuvsLZ1dXV/6xJ/gxdd/DpVXmH4DahAb2+91d85hNIT3lG2PwU+
         tWkX/OW18TVfmi3GAq3LKQGRzPaPsg1xCZpE6/J/67W7w1y0/g5gPl+jeY9LemqTFeWG
         lr9QahbFQpZDvF12jVHJ8QPLWtZgKwkH9HEyVuW0T1gCZabek+Et6YV4PvMvyzXkRweC
         YuOH0r63je9DBA7fqyr/uKeeHl+X/D3K1SpGNxNJWb7BPkha3LoJVzVH0c7EhRE33xl5
         qalJkIjUlLOdQKntEuc85GuTZ0vHOLZkfvfsTsbtpmn8V0zaux75IH5y6BX5YeWohmZK
         Pa1A==
X-Gm-Message-State: AJIora+HwH2C2vgBaojZKW4qw8cJOPnMVVoXVwiLFHcduMlSDuDUBfxr
        yDIsgbp45Z35U4lNvKdWQgognl6G7KU=
X-Google-Smtp-Source: AGRyM1suK/xq1SmYD+axwbklZ78+J5rctMth7TowkFHYq+uCO2pCGk3knnetvgGYndsr3UGa+4AK9g==
X-Received: by 2002:a63:8441:0:b0:415:d595:a7d6 with SMTP id k62-20020a638441000000b00415d595a7d6mr13784608pgd.441.1657921317259;
        Fri, 15 Jul 2022 14:41:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9-20020aa797a9000000b0052add461d2esm4289975pfq.103.2022.07.15.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:41:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] MIPS: CFE: Add cfe_die()
Date:   Fri, 15 Jul 2022 14:37:46 -0700
Message-Id: <20220715213747.111321-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715213747.111321-1-f.fainelli@gmail.com>
References: <20220715213747.111321-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a cfe_die() implementation which is useful when the kernel does an
early panic and no console is registered. This allows us to print
useful diagnostics such as an invalid DTB having been
configured/selected.

Since the BMIPS_GENERIC kernel can be built with support for multiple
processors, we need to do a runtime determination of the type of CPU
that we are executing on to perform the appropriate XKS01 disabling.

Since cfe_init() + cfe_die() could be conceivably called at very early
stages of the kernel boot, before cpu_probe(), we do not rely on the
structure(s) populated by cpu_probe().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/fw/cfe/cfe_api.c             | 68 +++++++++++++++++++++++++-
 arch/mips/include/asm/fw/cfe/cfe_api.h |  2 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/mips/fw/cfe/cfe_api.c b/arch/mips/fw/cfe/cfe_api.c
index 0c9c97ab291e..dcdfd962dbde 100644
--- a/arch/mips/fw/cfe/cfe_api.c
+++ b/arch/mips/fw/cfe/cfe_api.c
@@ -13,10 +13,15 @@
  *
  * Authors:  Mitch Lichtenberg, Chris Demetriou
  */
-
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <asm/mipsregs.h>
 #include <asm/fw/cfe/cfe_api.h>
 #include "cfe_api_int.h"
 
+unsigned long __initdata cfe_seal;
+
 /* Cast from a native pointer to a cfe_xptr_t and back.	 */
 #define XPTR_FROM_NATIVE(n)	((cfe_xptr_t) (intptr_t) (n))
 #define NATIVE_FROM_XPTR(x)	((void *) (intptr_t) (x))
@@ -412,3 +417,64 @@ int cfe_writeblk(int handle, s64 offset, const char *buffer, int length)
 		return xiocb.xiocb_status;
 	return xiocb.plist.xiocb_buffer.buf_retlen;
 }
+
+void __init cfe_die(char *fmt, ...)
+{
+	unsigned int prid, __maybe_unused rev;
+	char msg[128];
+	va_list ap;
+	int handle;
+	unsigned int count;
+
+	va_start(ap, fmt);
+	vsprintf(msg, fmt, ap);
+	strcat(msg, "\r\n");
+
+	if (cfe_seal != CFE_EPTSEAL)
+		goto no_cfe;
+
+	prid = read_c0_prid();
+	if ((prid & PRID_COMP_MASK) != PRID_COMP_BROADCOM)
+		goto no_cfe;
+
+	rev = prid & PRID_REV_MASK;
+
+	/* disable XKS01 so that CFE can access the registers */
+	switch (prid & PRID_IMP_MASK) {
+#ifdef CONFIG_CPU_BMIPS4380
+	case PRID_IMP_BMIPS43XX:
+		if (rev >= PRID_REV_BMIPS4380_LO &&
+		    rev <= PRID_REV_BMIPS4380_HI)
+			__write_32bit_c0_register($22, 3,
+				__read_32bit_c0_register($22, 3) & ~BIT(12));
+		break;
+#endif
+#ifdef CONFIG_CPU_BMIPS5000
+	case PRID_IMP_BMIPS5000:
+	case PRID_IMP_BMIPS5200:
+		__write_32bit_c0_register($22, 5,
+			__read_32bit_c0_register($22, 5) & ~BIT(8));
+		break;
+#endif
+	default:
+		break;
+	}
+
+	handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
+	if (handle < 0)
+		goto no_cfe;
+
+	cfe_write(handle, msg, strlen(msg));
+
+	for (count = 0; count < 0x7fffffff; count++)
+		mb();
+	cfe_exit(0, 1);
+	while (1)
+		;
+
+no_cfe:
+	/* probably won't print anywhere useful */
+	panic("%s", msg);
+
+	va_end(ap);
+}
diff --git a/arch/mips/include/asm/fw/cfe/cfe_api.h b/arch/mips/include/asm/fw/cfe/cfe_api.h
index 6457f36897a2..25df2f4deb31 100644
--- a/arch/mips/include/asm/fw/cfe/cfe_api.h
+++ b/arch/mips/include/asm/fw/cfe/cfe_api.h
@@ -105,5 +105,7 @@ int cfe_setenv(char *name, char *val);
 int cfe_write(int handle, const char *buffer, int length);
 int cfe_writeblk(int handle, int64_t offset, const char *buffer,
 		 int length);
+extern unsigned long cfe_seal;
+__printf(1, 2) void cfe_die(char *fmt, ...);
 
 #endif				/* CFE_API_H */
-- 
2.25.1

