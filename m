Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8571A5767B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiGOTrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiGOTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:47:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE87D1D4;
        Fri, 15 Jul 2022 12:47:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e132so5290872pgc.5;
        Fri, 15 Jul 2022 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6X/3ckvYE0wtXVr72Gxp8WzPkv76c9FiTiUqFyjZ+VE=;
        b=BRAE06mGZu0NzBX5M4u+VU0kmaA9M/knffIrDU2eo2GZrxRnUzrGod+bBtrbVhFejh
         uT7HjZcvNuXkQNR+7EAWcpzb8IonVsadYPFpGG0agzoEFZpGbUqSxCnOjloWK5OjCo7E
         +oDD2AKoQA+FLW5CPNsBThULzNU4QvjiIkVM9NVjJohORhRKJjlpvwEen8uuWvr8ZpfE
         w6jK/cxavM+au1P3B2ekOOK1Amu9lPA4moVJADJNNmB/yoT+7HYoGJoUbleWk/wBmsNq
         VPx3bjWJg2Y6U7ijKrvxkAgJkFMgFuoaeDBgTPzxGWVmAEi7t+Wreftg7EyANJaGB27T
         yDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6X/3ckvYE0wtXVr72Gxp8WzPkv76c9FiTiUqFyjZ+VE=;
        b=itH8rttDsaTjU13X+A0XEytRascbpcQgFsVIK9sZa0erE6Uc93eLUmqJJpStDpz9KO
         MjK7I/v60LPs2aqE+dPdTjizG3efQQ2IioL2PRvb6X22+SoiVHzdHW5KX5lzUaenJgPl
         oC4h038jO99M421Y2NAALaCtBFR6Q2GVsbXSN4oHIM2b6ZUvi+k+swWMkgBEY9CiyVW1
         w9wWI1eruESMbmivJgkSd9eJRQwjbJ/pa4Rc4CZR62RfU9VrXCi8ZVTIybfjTcDceczv
         CBQMDhtO484KPw9+CvDk1rcb2kQe6nLFk7nxG8rziRGNkYydNVnEGioZtobx3JaxAK80
         pvCw==
X-Gm-Message-State: AJIora+Nme+HZo7OUEKZcTZ9qpeMJ+7/c/C31Y+1P9bNFrCwahEfF7ca
        0MKJwPsr3ZT1NKktBgtWN/EqbOm72fE=
X-Google-Smtp-Source: AGRyM1soCeC2BieeoCqcZb9v6ss5n7cE9l/4V+gEfZgYyBqWBSv4tFduJ0FVSzcv7X03Fv3tPFzD+g==
X-Received: by 2002:a63:190b:0:b0:416:10ee:3c7a with SMTP id z11-20020a63190b000000b0041610ee3c7amr13548170pgl.490.1657914461548;
        Fri, 15 Jul 2022 12:47:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d82-20020a621d55000000b0052ab6590290sm4247227pfd.88.2022.07.15.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:47:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] MIPS: CFE: Add cfe_die()
Date:   Fri, 15 Jul 2022 12:47:36 -0700
Message-Id: <20220715194737.4174717-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715194737.4174717-1-f.fainelli@gmail.com>
References: <20220715194737.4174717-1-f.fainelli@gmail.com>
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

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/fw/cfe/cfe_api.c             | 48 +++++++++++++++++++++++++-
 arch/mips/include/asm/fw/cfe/cfe_api.h |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/mips/fw/cfe/cfe_api.c b/arch/mips/fw/cfe/cfe_api.c
index 0c9c97ab291e..6e7883f1d47e 100644
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
@@ -412,3 +417,44 @@ int cfe_writeblk(int handle, s64 offset, const char *buffer, int length)
 		return xiocb.xiocb_status;
 	return xiocb.plist.xiocb_buffer.buf_retlen;
 }
+
+void __init cfe_die(char *fmt, ...)
+{
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
+	/* disable XKS01 so that CFE can access the registers */
+#if defined(CONFIG_CPU_BMIPS4380)
+	__write_32bit_c0_register($22, 3,
+		__read_32bit_c0_register($22, 3) & ~BIT(12));
+#elif defined(CONFIG_CPU_BMIPS5000)
+	__write_32bit_c0_register($22, 5,
+		__read_32bit_c0_register($22, 5) & ~BIT(8));
+#endif
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

