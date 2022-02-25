Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4074C44BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiBYMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiBYMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:42:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83216949E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:42:00 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EEFEE3F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792918;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FOvyzcUt7DvbL9/Vgde1Q4k4ZUGno96zyoj/3oJR1kJOj8jn1RpTHAInOTot2DEY3
         rAmnZVWebB7uEZ2xX0QsRNnw7egvOM+kxs1VpIexclZGnbmGjOD/2A0XlXvg/LtQVX
         tOFcriMXwbAtesIrhXwi3LoMkSg7yYdfPTIhqE63b7i7z5XExeBMbEkhKKTXYVW/mx
         FPqGRPrusbYPRvWRx3tP/z0+Ie069tZDV4fBbkDS1T//CwgtKj0x/SlhY+hfgITDKO
         FRbWo2uo0jqM3UAGyWz6qwirA+sAyGRINivzHE+sTjY1Ii3p2yc0ELfxD7AhfGsCCY
         T7DKlRGyYyOyQ==
Received: by mail-wm1-f72.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so1510302wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        b=tYJR5+wUKJlfsg3qAym1hWP1ffmwcMrBr5u8lSbhY6vODYhNU2A8B9eoX5XFpBpFab
         O+gsbqr+gxqpL8lkYIfJAfOT+C/sHvSJYpXDNkwNPB5pw3oV7G2TaFeZySjSGkW8UeVr
         FyfDFWgAUUlnI+qHEQ5EqFPZ1NvqcJSbpo3WiwmJfO1Da8fnW9wU1hNVqbi03qMV3UBB
         ebjcVhAFI3lqcupUF0ds+bOPlpYJTaVlbnkP0SXxbwSW87o/VbduGQMUd57PHZSDTRgy
         7EJoCX/JJR62qpssIdRcMAA95vHjOxr1eGRaFNoW4JXJmFYRoF3GsWUMR5/tfydpRt1t
         8Xvw==
X-Gm-Message-State: AOAM531sCTUL/yVsPgZCdD6tcunbf7yIzvD4RyTtOJ2/v4SOrFHXAmQR
        VWzi6aYErlWzZuwVEn/sT99i9veWlgINNMzp/+vtyvvP3kbG8GsxHtcTnkEitHHeylZIna3ueJG
        6dIW42SPcYIvVnRY6al/w4p2TQ+rgsi2lMlujkcP7cw==
X-Received: by 2002:adf:80c2:0:b0:1e3:3b9e:ab6d with SMTP id 60-20020adf80c2000000b001e33b9eab6dmr6234414wrl.253.1645792918685;
        Fri, 25 Feb 2022 04:41:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx83iJoyNT5BQRvq3mMRYqD931oXS9YXkhhT249/SBb5EDJpj7lWu/6JE6+IOyTRBie/j9F6Q==
X-Received: by 2002:adf:80c2:0:b0:1e3:3b9e:ab6d with SMTP id 60-20020adf80c2000000b001e33b9eab6dmr6234407wrl.253.1645792918458;
        Fri, 25 Feb 2022 04:41:58 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm2234860wrg.62.2022.02.25.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:41:58 -0800 (PST)
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
Subject: [PATCH -fixes v3 2/6] riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
Date:   Fri, 25 Feb 2022 13:39:49 +0100
Message-Id: <20220225123953.3251327-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the pfn of a struct page* when sparsemem is enabled
without vmemmap, the mem_section structures need to be initialized which
happens in sparse_init.

But kasan_early_init calls pfn_to_page way before sparse_init is called,
which then tries to dereference a null mem_section pointer.

Fix this by removing the usage of this function in kasan_early_init.

Fixes: 8ad8b72721d0 ("riscv: Add KASAN support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f61f7ca6fe0f..85e849318389 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -202,8 +202,7 @@ asmlinkage void __init kasan_early_init(void)
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
-			mk_pte(virt_to_page(kasan_early_shadow_page),
-			       PAGE_KERNEL));
+			pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
-- 
2.32.0

