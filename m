Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4477B56ADFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiGGVzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:55:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382A237C8;
        Thu,  7 Jul 2022 14:55:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d10so8147419pfd.9;
        Thu, 07 Jul 2022 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93ZpPgLJyecFvQZe9Ciq+tRk6eMsICLuhmWHFr9gFUg=;
        b=GAnWHQqJETVvqsV+eO/iRlXpA4gq+UO2T+uCUmjDTIjzIs8thcups8CeCbAkdQiSUd
         jPWOtQZG9DPoPYt1qTfBA1eppI1sQ8w8SHVRSPgp2vdsY8xE2Tu3AnuMk0ClU7n+FcQa
         a+LxkfwvIehuQRjHuGW0Mq8o3Smw/05570BmEN+V+7ejRIbQL9ZS1YiZrfBcaZ78TOl/
         elfsp0NWm6MKZIxUrqEF4gZ4KJhsglGGqI58xUqN8Sw87DUKuf8ofD+cpLJcDoQTfwJc
         lf24t1q4/V57Eb8yeh8QlCAZReoR9G+JXMdEz1BgZa8KIjRff6puyhUUvRHopR0M+yUr
         4VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93ZpPgLJyecFvQZe9Ciq+tRk6eMsICLuhmWHFr9gFUg=;
        b=TDacTkzez/4YPSOHAJq8MqDiBS6bkNSfcOeZyRhHxktFkwWSzhPBn1W1UsX/go66JD
         o1835nLWGTpVIXh6z3pyp+/3G9fgGB/+9GYiPDvnYw8LWlWB2sWZKaxVD1WaYwWvCDjx
         1g0uFAZr6S7SK9zjcXgcEAl70gXCESDqwvAfHlWIJV73n/DI82zjyZqipa6Ksmr3sUbA
         8muZxFV4Evs5XhtPH7yPoPb5sKpgGxO/qRMWSiIblNFRJv9D+b5q5bYnoGYx+3VjYjlx
         HFgpritOd96JHteet2nlMWevhHHNxPLFxGD2Cup9Xo6zrdGRjm9VMoYm+7fboRW/d6ml
         nzmg==
X-Gm-Message-State: AJIora8CGllhHvvMykdtqd0UjpV6VUs3mOKyWzkD3QJaWZ0F83zNculp
        qcsbMfd+JdRDpMPTJQ4t4Bh0NMKSYoA=
X-Google-Smtp-Source: AGRyM1tOiuIKopk+gbACZ96iTnvfbEAGXkXjE0d4OQIXpfAx3NzMvLRe5cA42MCnWxNPN0Bb7D/ttA==
X-Received: by 2002:a63:1f66:0:b0:412:2f72:ec19 with SMTP id q38-20020a631f66000000b004122f72ec19mr213370pgm.282.1657230904195;
        Thu, 07 Jul 2022 14:55:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm2542576pgb.39.2022.07.07.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:55:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     gerg@kernel.org, fancer.lancer@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Date:   Thu,  7 Jul 2022 14:52:36 -0700
Message-Id: <20220707215237.1730283-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is permissible for kernel code to call virt_to_phys() against virtual
addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
types. Add a final condition that ensures that the virtual address is
below KSEG2.

Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/physaddr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
index a1ced5e44951..a82f8f57a652 100644
--- a/arch/mips/mm/physaddr.c
+++ b/arch/mips/mm/physaddr.c
@@ -5,6 +5,7 @@
 #include <linux/mmdebug.h>
 #include <linux/mm.h>
 
+#include <asm/addrspace.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
 	if (x == MAX_DMA_ADDRESS)
 		return true;
 
-	return false;
+	return KSEGX(x) < KSEG2;
 }
 
 phys_addr_t __virt_to_phys(volatile const void *x)
-- 
2.25.1

