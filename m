Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF657CC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiGUNue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGUNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19337BF54;
        Thu, 21 Jul 2022 06:50:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so5311262pjg.3;
        Thu, 21 Jul 2022 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4XvE54O1JXlU9U0HrAJmVaUcBzx7Lfp6tLdIlBo2lM=;
        b=hpOvU7/lmkQOOc03/AeOWcb06dOSTaHHxkq4h31lZ3BUFJHsmhIhNf52SBmT81yxlC
         TbUIR1hTTliUk8jCPT28w6ZmvvbUEndVx/5UjMEG+WryRDTSuUew/HsFrYwGzde7n/FL
         RRzr8gFR9Wa9ZcA/RTyw609krccYU/BKdAiNAz2O8E6+wexSsyo4SAlVKO+q8u4pZRyd
         CbpWgfQvyAy8aRVz3DiFJkVtj45GnQf/hcfERfEdKVYsC12G4hF5MH9ZrI71KAXlFzNV
         vLRhRxfhMs6EjuZ+iX38X5y5LGQBSxqwgA8pOVVTqui074F6DxcwaO1VKG9Q14mBDRnz
         gxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4XvE54O1JXlU9U0HrAJmVaUcBzx7Lfp6tLdIlBo2lM=;
        b=Xlu9slibUY41z7bllw36Q2ttpK0ZajECEFZS/cUxaoflKjQqEJifVpkZ5IzIyxDqQA
         8xTwBkrDZ7HXBU9p0nJ15UP/98KN+TCw45CK9WdUuG805Z9HcwoZjLn4+zvt1/AjJp5G
         S9PnSOOCc9Wfw4YQy8WxoXeSKx7L22+HNwCrt0a8yp4peFIoYSVEqF/FJ3tJMzPNSuI/
         vxg5TM0r9bpkZYxXzmRUeXwYR6ip1v6Z3d6MLDW5Zt3N9XYn/poDXPQ7+0kiaM9jsc8I
         s7EMqPSK1IJ0RHtvVblJ60STKEUWl4lhLmnwD992MEAzcOcEnWbVIWFNNvXXdl1bH/FB
         R4sg==
X-Gm-Message-State: AJIora998S4DH7oBIVa+AVcZQE9+rLOTyTvW5WYWOHsI0G22T2EVoMaY
        XJkRT+gOnehJ5ASMI28bvuwM5XrZ2HisuQ==
X-Google-Smtp-Source: AGRyM1vfmMhISa5KyerLXSwhlZLFl9DGIv5Z47+sl2DvdBwjrWHsoy51rNfytwFSdPsbhJOdkK9kFA==
X-Received: by 2002:a17:902:f551:b0:16c:505c:ebf8 with SMTP id h17-20020a170902f55100b0016c505cebf8mr43638617plf.70.1658411414256;
        Thu, 21 Jul 2022 06:50:14 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id v188-20020a6261c5000000b0051b9ecb53e6sm1789140pfb.105.2022.07.21.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:50:13 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-csky@vger.kernel.org
Subject: [PATCH v5 3/4] csky: PCI: Define ARCH_GENERIC_PCI_MMAP_RESOURCE
Date:   Thu, 21 Jul 2022 22:49:23 +0900
Message-Id: <20220721134924.596152-4-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721134924.596152-1-shorne@gmail.com>
References: <20220721134924.596152-1-shorne@gmail.com>
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

This looks to be something that was left out on accident on the csky
port.  Add the definition of ARCH_GENERIC_PCI_MMAP_RESOURCE to keep it
inline with other ports.  Adding ARCH_GENERIC_PCI_MMAP_RESOURCE enables
the definition of mordern pci_mmap_resource_range functions which is
generally what new ports should be using.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v4:
 - New patch.

 arch/csky/include/asm/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
index 5c02454ec724..875bc028f8f6 100644
--- a/arch/csky/include/asm/pci.h
+++ b/arch/csky/include/asm/pci.h
@@ -15,6 +15,8 @@
 /* C-SKY shim does not initialize PCI bus */
 #define pcibios_assign_all_busses() 1
 
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+
 #ifdef CONFIG_PCI
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
-- 
2.36.1

