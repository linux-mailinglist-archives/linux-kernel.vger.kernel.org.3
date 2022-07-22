Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2957E931
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiGVVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiGVVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:50:52 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18BB8791;
        Fri, 22 Jul 2022 14:50:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c3so5476238pfb.13;
        Fri, 22 Jul 2022 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0dVPpSvAwJP2BMIET+fnHbE/tEy93/PQneHIgbhVWc=;
        b=IjlZU3xQuaKjM3/QyW1QCXqa/XRwTmoe649cVoWeVrnPkwG8k4lmlwbaOJp/UBWWMw
         Cqoja3ELRXsL95rDnHIuFpJ6wUjeR9j8XCG+hx4IcT7IjqziSgw714sc68Zac8yzMgE2
         /I1UwM+x7x9ZifIpIxhu6uaua0sk58QyZgpudb2Bm/NV4rTt7BtogIaO6mbBWeFkRXeo
         7bHc9CRp/aNJzVhahRqUVxsow4DhpHiCl0sRvmvnhz6s9HVCbtZY4gHEIrWbtyuhwR5U
         CMndihQBt3eVmLCkPN7DX1ohqcfwKElcBDLLcWSz7d/QNCAIlgqBFPkt4AnM18L1C7tC
         UcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0dVPpSvAwJP2BMIET+fnHbE/tEy93/PQneHIgbhVWc=;
        b=Tf8Mql/tk1/VREn2CpU7xIPOX1BeVRQNm0pcXbPWGTI+C+KiB3yCGwmXQlw9tXvOXZ
         5PPX6dgKbEfLOr2aUyfIU581VG8LahJM5wYbmhbhSRZKxS2fbPtYf6i3m0lqkh2r+GJE
         MQIaii11Yy7JNA9RwLVvhL4jz5GPn6Gkog+qFgtFmMtMVvia+q1r4jEFjtzawJWyT2im
         sCYOsowm0uSyzNMC2D3kVN1w+hgT9kKssqw6op/TA5CJiI8VpcylcGX6TYB8n0Uq1BJX
         bymXtGVlWc7uefgkhp38BlOmJVxsvn5si/3MkJV2pUmE/yJ3pGupd2+JcAJ8xdpwgBnT
         rM1w==
X-Gm-Message-State: AJIora8TiH6/ai5YrZva9rmqr4Rs5QXAjW65SUnH/AJFo1oXCKSrBYDr
        0fZ51eIDcjfbDtg05pA38JwAayhttDgzKQ==
X-Google-Smtp-Source: AGRyM1tBTsogo1gSmua6jGoxfDXPV151Hi56FK9PWJ6VailR/FPEgYquomVeVNtpgiU6imfNn7NvKA==
X-Received: by 2002:a05:6a00:2347:b0:52a:cf39:59a6 with SMTP id j7-20020a056a00234700b0052acf3959a6mr1956435pfj.34.1658526635660;
        Fri, 22 Jul 2022 14:50:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id w67-20020a626246000000b0052ac5e304ccsm4368142pfb.194.2022.07.22.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:50:35 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Morel <pmorel@linux.ibm.com>, linux-csky@vger.kernel.org
Subject: [PATCH v6 3/4] csky: PCI: Define ARCH_GENERIC_PCI_MMAP_RESOURCE
Date:   Sat, 23 Jul 2022 06:49:43 +0900
Message-Id: <20220722214944.831438-4-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722214944.831438-1-shorne@gmail.com>
References: <20220722214944.831438-1-shorne@gmail.com>
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

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
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

