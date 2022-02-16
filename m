Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4C4B7C91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbiBPBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:34:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbiBPBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EC73F70CE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644975278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TxaBIMaSmpGvEpUN6pnfgExDYJwGH+sDt4Nge7L+SbE=;
        b=RXFA4DKEAybAHrLPsmOEZ7wTfOpjVQxtLSl3Ww4vR5FXE45OaumCFfQJv79N9ySSry7Mi/
        ILT2Wp8yUQCHN0oxcllXkwtRqygCScHgEYrgue7qMV07pSwXgOvVNEaQ09OcfuGN3/uahO
        AKaH7/GmZV0kcFr3NimGeDq8kCDsans=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-Ffw9vDB2PD-WR-lmhMpCFA-1; Tue, 15 Feb 2022 20:34:37 -0500
X-MC-Unique: Ffw9vDB2PD-WR-lmhMpCFA-1
Received: by mail-oo1-f70.google.com with SMTP id t14-20020a4a96ce000000b00318605258dbso399217ooi.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxaBIMaSmpGvEpUN6pnfgExDYJwGH+sDt4Nge7L+SbE=;
        b=BrqdQdwS6atKREc12WA6twOJR8xnCpHDqG4pn2KgMxs0IY+hKZ5cW0rlk6nQdaC4+G
         1DC/XX5CWpCPpehCBzal4duO6b8cpElDxL4bRNfroEyaQukadvRmxkFYSh0AnFaBgGHc
         ZM4Nc945WV1ShCcdphaXdfZ+Td6BPk/Xb5IZH+KjQNdNOwzwytq1Tjw71LbuoP78tgsB
         cDTFYudSHBgoQ4DMYvF0j7JIMQi/pzfCNuXySBMJdoxC9b1FpfF2cDt+AX/lR7XMYt/O
         eVSsLkDyC4aM5GYYFMbyDRZOOPwD7EEdm7yb6YCI0+dOsVFqttsjLGgzDs/wLzu4n/+D
         5ayg==
X-Gm-Message-State: AOAM531/6jhMkqVMpAjoP0Rh9QffPE165NaYpkvOLyGmvYeYuRSBufsc
        SAwc6XmBSRdpK7hENFU5wey1KhARSz2aAPRBqzjlJC17OlNIuZqwPFP+Ycwb4tIUrCWC0YOCsYh
        5OX7Iow1YtA6HG/Y+AVyFvbcb
X-Received: by 2002:a05:6870:e749:b0:d3:4ada:380e with SMTP id t9-20020a056870e74900b000d34ada380emr244596oak.206.1644975276300;
        Tue, 15 Feb 2022 17:34:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIWFPq8WR/J0ftst2Qc1PQDGPtfYiYgOJVkBhQLwJvoEFneclhBD3/SN4zuCWYCBqLlE5zJw==
X-Received: by 2002:a05:6870:e749:b0:d3:4ada:380e with SMTP id t9-20020a056870e74900b000d34ada380emr244588oak.206.1644975276058;
        Tue, 15 Feb 2022 17:34:36 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 100sm14574391oth.75.2022.02.15.17.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:34:35 -0800 (PST)
From:   trix@redhat.com
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: cleanup comments
Date:   Tue, 15 Feb 2022 17:34:24 -0800
Message-Id: <20220216013424.3062140-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replacements:
SPDX--License-Identifier to SPDX-License-Identifier
incase to in case
Adaptor to Adapter
overruning to overrunning

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/drivers/dma/dma-sh.c           | 2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c | 2 +-
 arch/sh/drivers/pci/pci-dreamcast.c    | 2 +-
 arch/sh/drivers/pci/pci-sh7751.c       | 2 +-
 arch/sh/drivers/platform_early.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 96c626c2cd0a..38e2d62c330c 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -261,7 +261,7 @@ static inline int dmaor_reset(int no)
 {
 	unsigned long dmaor = dmaor_read_reg(no);
 
-	/* Try to clear the error flags first, incase they are set */
+	/* Try to clear the error flags first, in case they are set */
 	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
 	dmaor_write_reg(no, dmaor);
 
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index 41e4daee8f04..2e8a1e2233a3 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -9,7 +9,7 @@
  *
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
- *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
+ *	Dreamcast PCI: Supports SEGA Broadband Adapter only.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-dreamcast.c b/arch/sh/drivers/pci/pci-dreamcast.c
index 4cff2a8107bf..c48ae4576d24 100644
--- a/arch/sh/drivers/pci/pci-dreamcast.c
+++ b/arch/sh/drivers/pci/pci-dreamcast.c
@@ -7,7 +7,7 @@
  *
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
- *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
+ *	Dreamcast PCI: Supports SEGA Broadband Adapter only.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
index 11ed21c2e9bb..0324ab2564d8 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -170,7 +170,7 @@ static int __init sh7751_pci_init(void)
 	pci_fixup_pcic(chan);
 
 	/* SH7751 init done, set central function init complete */
-	/* use round robin mode to stop a device starving/overruning */
+	/* use round robin mode to stop a device starving/overrunning */
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
 	pci_write_reg(chan, word, SH4_PCICR);
 
diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206..1c2a571a8ab8 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -1,4 +1,4 @@
-// SPDX--License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
-- 
2.26.3

