Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E024BACDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBQWra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:47:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBQWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:47:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D53C0503
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:47:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w20so5684635plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzXd5FmHBKsOYS1jrgdrsv1P+ALINKkoa0HY5TnOhiM=;
        b=D1+XRZvD1K0LZKJELaNxk6yYE9Ow1k4PJ7Gxx8f444Faqn7lxwyD9RlgR+xMCZ/2ZR
         xcB9VDvolniqvt+h/UMdMqAvQZ+Rm27/OsPHopXXL2p2QHRBM4vJQLDl7sQZwVqXEE0d
         TEp0M83DXHUbX/FMc33F1HPqVSiGjsxE0DTCjyo/MnymOXDLbru9/mp4LltCbBZC8i2A
         PEqDoGJN51/dBC1LmrpX2yv45GyyFzw9C8jhPjb3sWIh5bDHDZzYS/X1OdEUKdz+bhKZ
         fmg1bU3wKps8INtBxpscVfE9ncdL1c+y3Cns0+gxkOg94kHHL0BVBCHUSJb44M+4cCTx
         OVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzXd5FmHBKsOYS1jrgdrsv1P+ALINKkoa0HY5TnOhiM=;
        b=7sFwjSEncssrn3f9CfU+q8mq25wz7FWUZtkY7cCTqoTGza4bRFyafnJVCoF4eAcABD
         Tg9LgRND2rrG44J+QAjJHF4pAsT/gDmoi+D6mp3meFqz+YH9BEbxjnT/HP34ZFI/wHCF
         aCxorLN6+gwLvk7rOaCLxCokh05nmWAYDUbrs5Irz+IXFxUO9z8eNLAsK+XNVTvaqv1y
         tWUTW45KCGZbLu9rD2BIqTAvW3pOAlPBqynGVzjvZL3TlnWGIMqn0R77KHgG7MND/y+P
         jRV6DwXjky0IoRDMLY7zw1ZBG0kU2je4JNqAWoZ2ypbe/PWkjFMjpUpsPk37cYPjnZnD
         9RAQ==
X-Gm-Message-State: AOAM531PC9q9SYdoyQvBCohYeqo+qOh8zM2FEJSWecnuH58/8MsVYH7P
        qZ5P06QYmx2qi8XajPtHinM=
X-Google-Smtp-Source: ABdhPJyIqa1tPshUf4vbYqEZvWiA4/3kxWrOCzXWSTyGQ/YFSi2cGPdgEJulRQj5tpZgLhu79B/oCg==
X-Received: by 2002:a17:902:904a:b0:149:b6f1:3c8b with SMTP id w10-20020a170902904a00b00149b6f13c8bmr4752821plz.83.1645138030298;
        Thu, 17 Feb 2022 14:47:10 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:84fa:54e7:f2a3:d608])
        by smtp.gmail.com with ESMTPSA id f30sm9263350pgf.7.2022.02.17.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:47:09 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux@armlinux.org.uk, arnd@arndb.de, ardb@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: iop32x: add prototype for iop_enable_cp6()
Date:   Fri, 18 Feb 2022 04:16:48 +0530
Message-Id: <20220217224648.113767-1-jrdr.linux@gmail.com>
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws warning ->
arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype
for function 'iop_enable_cp6' [-Wmissing-prototypes]

Adding prototype by including header.

Fixes: 	6f5d248d05db ("ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 arch/arm/mach-iop32x/cp6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-iop32x/cp6.c b/arch/arm/mach-iop32x/cp6.c
index 2882674a1c39..7135a0ac9949 100644
--- a/arch/arm/mach-iop32x/cp6.c
+++ b/arch/arm/mach-iop32x/cp6.c
@@ -7,6 +7,8 @@
 #include <asm/traps.h>
 #include <asm/ptrace.h>
 
+#include "iop3xx.h"
+
 void iop_enable_cp6(void)
 {
 	u32 temp;
-- 
2.25.1

