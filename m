Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F64C44C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiBYMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiBYMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:43:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F731199D5F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:43:02 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 515963F1A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792980;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pM0+kpRWb7dd7Tsz6ltx3TxX3tylo7zrS6pHacHj8ytb2VwP5mPPsCY/p0I+3/z5J
         39PHlTTSu50mUO0v9aOJ/lQc+/TPcz7gE4bLQdLEW3oyZqNTw9Nrj1A+EjgRY0a+Pw
         cfi01C3Bxv57tQsmKwjHhHa3v+zMSD74I+0aB9wtBsNgifhxqwR6X9aypde3GuEMhN
         3GxpytXM90YuqhKusGb5eujXEhbWlhS4A8eJ1qG/PmT/Cf22g14XZkqfC7yyMfl0DB
         qNy9bKeZV36OyyNDclIcVgVPoWk9VD5iWxdmtkTPjEnJPQ0KOHMObLUdAoDNdEdTuQ
         1GQxUvOgp6tfA==
Received: by mail-wm1-f71.google.com with SMTP id m21-20020a7bcf35000000b00380e364b5d2so1276990wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        b=KZqyi+X9vrBztFgEKBuMmr/qaZ4xqCXT7MFC/s0+oF2Vb5asmFpH86rBfV8UltSQc7
         Q5cCtHHpbzJNm0p4o4ZTXnyAnhVjXQ+5Zm/Xl6AQSmAfYyqSyCkqQA61vobJNdjIfGWO
         0zxuDXPXN1xpPAfciS/DAY+ib9E1M4jl5KLE2j05ZKC+3yZcMpz628jSqt2eNweQe5yu
         iZm6vMpZ1L9DfcQPAkzkHUceJaqBvW2D5lxFZ1ejBMcOTiYYfZnKsmS5HWid1y7dekzV
         JUJ6Hi0eshZ/jDlYkMv7xe4qYKTnRNE0S0MZCVJr09CpB8gJc7UgFXBA3U+hmYEmMVw0
         zJgw==
X-Gm-Message-State: AOAM533mIibBQe+yjnZlB2Flso21NJbf+pHBOv+WbeaR9umM+fHIBEjj
        z/SkQ7r0pwd24HUyfvkFO+i2GSsXT27ZImB3e3S1xJpiHJaJP4QN2Kn4UWHsgxzTmdjbhOryatT
        S/CiAyhPMflszQXo/8+smlmmmpU84e8hN999E6lj6tg==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr2577992wmq.20.1645792979759;
        Fri, 25 Feb 2022 04:42:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcRpOmBxAvnb9C8VWTL3Q+pIs+JnIpbWsXck+OsKjusYuwlpFrwhhbzMfm7RYXdb8ihagxtg==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr2577978wmq.20.1645792979554;
        Fri, 25 Feb 2022 04:42:59 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b001e2628b6490sm2248342wrv.17.2022.02.25.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:42:59 -0800 (PST)
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
Subject: [PATCH -fixes v3 3/6] riscv: Fix DEBUG_VIRTUAL false warnings
Date:   Fri, 25 Feb 2022 13:39:50 +0100
Message-Id: <20220225123953.3251327-4-alexandre.ghiti@canonical.com>
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

