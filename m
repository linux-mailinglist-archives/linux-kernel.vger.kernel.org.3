Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D354BBA30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiBRNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:39:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiBRNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:39:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449A20193F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:38:45 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 970B23F32C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645191524;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tE6HaCikKClwBjWGiSeGA7qiserKIpPEwggp/sdiNqRJaZRiJuTNI6MHyrXteUBqO
         wUx98EqXBXXV4FJgmrIJKZmXy4vHJ90oPXBxg4/FGFUUCTBgetA7oR9HVOxifhNEwb
         QN39NE2GZgJn1MocUl2F7+/woBF9GtXy16dKRGrjtu6EAlIs+eZJfvnglJ9WllIn9M
         L9HlhEgSnAfKyzCwx2f2B5tvepTYwvMS+nC5gQwMR5lznks4epboN4ZYlJhjsAIr31
         rQL1odDTtklzBbzubKnVIjN6d6F/PfMqf8uXTwO/+aqff/8Hl6E17F0GvNE4w8kGSM
         BFCOdqFurZLyw==
Received: by mail-wm1-f69.google.com with SMTP id k36-20020a05600c1ca400b0037ddae32528so2857125wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        b=Fil+sHM9FRkTHtbG2BBfMhfyPrTtRU0nI4tsSA9Ldfvf22xq4Zas1C9ke9N8ibw4W3
         dEhvqrI+M0vbbQktxoRhzt4KkG4UPEpJDaKdie2cfumCTgD+u7kPw911uiTM9I+XCNey
         gcoZVXq6t5V9NfOFOQGuo6qmDrudjHz+h7InAHBctMTarVds8zrRB1slQbixwFJBtD/a
         C1/D/FoZeVpV5the7nAswz1UiYIn6eSn6JHWIltEmobBKogF7VVq2yHPYasqrai8U8/D
         Qs6GENyfZF+B4RCA5JVDG2qboZXill0ijdeYa+DmijI9VwVWF+x7MDHQHJl8egf7xsgt
         OCAQ==
X-Gm-Message-State: AOAM531NkeHuWRRPb+EGHn25q3LIMHWjzmGWlGgQZl65PQOSj1Kqb2EC
        9LtTPIBf6JAxRmirULcOw/wHqMeZ3sGitu/VxNwcR3yVmYHBXCfWYXJlcjazV/YWTkeWx6GL5+z
        PL6pqdOsaUu9YG49sevbU3mR/sBc7pHpjM8It88O4FQ==
X-Received: by 2002:a7b:cbc6:0:b0:37b:c56b:9eb9 with SMTP id n6-20020a7bcbc6000000b0037bc56b9eb9mr7250947wmi.17.1645191524258;
        Fri, 18 Feb 2022 05:38:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwdi9qCsRGOKRf5aFH1Q0xUVlWAkuAr/mtea9chk3ia4coprzZyLiP+xUhMh9Zer9nD237Mg==
X-Received: by 2002:a7b:cbc6:0:b0:37b:c56b:9eb9 with SMTP id n6-20020a7bcbc6000000b0037bc56b9eb9mr7250929wmi.17.1645191524072;
        Fri, 18 Feb 2022 05:38:44 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id g5sm4282472wmk.38.2022.02.18.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:38:43 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes 3/4] riscv: Fix DEBUG_VIRTUAL false warnings
Date:   Fri, 18 Feb 2022 14:35:12 +0100
Message-Id: <20220218133513.1762929-4-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
References: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KERN_VIRT_SIZE used to encompass the kernel mapping before it was
redefined when moving the kasan mapping next to the kernel mapping to only
match the maximum amount of physical memory.

Then, kernel mapping addresses that go through __virt_to_phys are now
declared as wrong which is not true, one can use __virt_to_phys on such
addresses.

Fix this by redefining the condition that matches wrong addresses.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/physaddr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index e7fd0c253c7b..19cf25a74ee2 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -8,12 +8,10 @@
 
 phys_addr_t __virt_to_phys(unsigned long x)
 {
-	phys_addr_t y = x - PAGE_OFFSET;
-
 	/*
 	 * Boundary checking aginst the kernel linear mapping space.
 	 */
-	WARN(y >= KERN_VIRT_SIZE,
+	WARN(!is_linear_mapping(x) && !is_kernel_mapping(x),
 	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
 	     (void *)x, (void *)x);
 
-- 
2.32.0

