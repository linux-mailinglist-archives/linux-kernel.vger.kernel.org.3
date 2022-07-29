Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D483584F59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiG2LH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiG2LHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:07:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3A39B84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:07:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e1so4547420pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dg0qE236j75IPYm3gyWWoQDxRHaWsFT0nXvPkft/ED8=;
        b=ilJK0XZe2/X1mmOKGXUe7ww8k5aJC6BxG3gXRHNND8F9mB8+Kjx0cnfWcbP8b4RiAT
         FkwHtfg+0/u3L2aUSr9sjPsbwa04Ub7LAT02BB151HyxlDC2bL+z68H4SwxIl6U4S17G
         1x2LjCsYwmFl56sS3FCrBsK4e7K6iLoWClhOWazEUfls0CnI00erWFu8a9/mFfdU8mG7
         gPKlckyLVb3daPgBDIJsAM4JCkdPNwbkgaCCW1RhS8AUpXEb69wwnUec+JURsmQrW7ja
         fNyDQuOGSOezjnw4fkqvgQPnVXxk5mB0+KibcEdJ9pnSMzGsDMHg0ka+hZ1eLo3tSLPH
         c/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dg0qE236j75IPYm3gyWWoQDxRHaWsFT0nXvPkft/ED8=;
        b=q2EkO69CmOiE+wePUD8wtE2LqX0m28DZioq1fk74ZSH162KnL9K7kGhE8yRD5Ac9FU
         iTYI/8gg7PJF4Sjk0sQY8WlcWlEV+MNlo745z37vcHgAcnBCek6BSfGRRkAuMOcZ7VXs
         ZXQrk2SMbyyMkZ+1xSr7PqQ/zOtKtokuuJvUvMspjrO4CErBc9qgoPD5vdh56xrb8NQp
         LRenr4T3WFNHSGs1HZtjrJNQo6hJH6GMbrJrHSWsCGQMqHQybcnLNQJyJbKmtMQz45ub
         tUgieLXwGyAiOH2KYjgAqIjdhzbpVa7TX7nAJZVO1OGJwIQqCHBoBPT+9peTHqVJBpfk
         7L0g==
X-Gm-Message-State: ACgBeo1YnrdScfLMtVllAykdxrU4OkkK9rmQWDktlF+zbXbWy4K4V96e
        Pm5CKCDVCuO9LmdX1+Uc+MWGNpwvndM=
X-Google-Smtp-Source: AA6agR7K0DVPsqc7kshSFFkVsCLalRuyPMUBZgOkbFEOCB/w9q23UDpCLSXXq6fl+CpHWKhDOs+3nA==
X-Received: by 2002:a17:903:40c4:b0:16d:d2a9:43ae with SMTP id t4-20020a17090340c400b0016dd2a943aemr2322406pld.57.1659092871617;
        Fri, 29 Jul 2022 04:07:51 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090abf8b00b001efa332d365sm2719340pjs.33.2022.07.29.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:07:51 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: io: Define iounmap argument as volatile
Date:   Fri, 29 Jul 2022 20:07:25 +0900
Message-Id: <20220729110726.3635262-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
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

When OpenRISC enables PCI it allows for more drivers to be compiled
resulting in exposing the following with -Werror.

    drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
    drivers/video/fbdev/riva/fbdev.c:2062:42: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

    drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
    drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

    drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
    drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

Most architectures define the iounmap argument to be volatile.  To fix this
issue we do the same for OpenRISC.  This patch must go before PCI is enabled on
OpenRISC to avoid any compile failures.

Link: https://lore.kernel.org/lkml/20220729033728.GA2195022@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/io.h | 2 +-
 arch/openrisc/mm/ioremap.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 625ac6ad1205..ee6043a03173 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -31,7 +31,7 @@
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 
 #define iounmap iounmap
-extern void iounmap(void __iomem *addr);
+extern void iounmap(volatile void __iomem *addr);
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a76743..8ec0dafecf25 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
-- 
2.37.1

