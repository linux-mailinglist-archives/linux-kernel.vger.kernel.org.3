Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FF49FA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiA1NRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbiA1NRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:17:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7427BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:17:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z19so11635397lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYl20x8f64eY3Q6M51ieJFRc3attF791Qq3pPAooZU0=;
        b=cLb3S0ykwzyVoc8708XHRRYPgYryU5bGWXLkbayh8hQ+Un/CO5sfcMm3146Kk16CAx
         pHgU4SayyKOs+aagwTRyJTNcVzBZmRdx8bUfxUTjOy6Mm5C7QTVQb+FFKm73ykHWqwTo
         KxiiB/x5ZJ/i1jLRnvShGi37yl1tKPAtIH54w19tg7LbMVty6y9NceGKve3GxZV6oN97
         fEEWbewRQC2Og7Y1JzJu8CNuxaTzaeaDln6H1U+u9W1M//EYsAQxRd06ccuk0Sy0OR+L
         wVKeTQUtotZs/kL7WO7a8kLIld8P6g+1/YwN//75AxYd0UNZNhiFWaSyqzD0KXyuGv9k
         Hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYl20x8f64eY3Q6M51ieJFRc3attF791Qq3pPAooZU0=;
        b=h8wuihr2+GIAEfwZXy7K6m+CesFwyLamyHqslzmC/jUIZe1mrS1uA9jsA5dm6PGaao
         ihWgOfJCskYqayXfevawQZomCmO6ze3qQ6CGZQfXRnhoPyGstqYIB4TRIbjimpS3Xaxj
         epq2N5jauRWG6u8uHmyILQ6y3PdehadpyiVbMP7bkkHyHTue5nirZsNec5D1fDGqIyf9
         GstbSNPfr7P5YEhiEuAG7o+UIl6bREpo8gGBHHnaETd5kvI7CXTTKyYDD9LrRjdOGmtP
         cOAT5teCkHoEpUW8Bvj2O40pXnFuCe9FzDG1YLIqaeqNfhhBRvG9pCsP8gEml5CbPKvk
         Klvw==
X-Gm-Message-State: AOAM5323++i/qYlZrQsJIgophqK8y2E68SDG+7CfHs6ajYNHoiuM2I2n
        Z3eO0XDoEEv992JSbfJ9Bgu9UZ7dVy2A2w==
X-Google-Smtp-Source: ABdhPJwAZ2Q1WGxi7/NXG6VtAjneijeqYVZkjzKgZBOzUxzKZ4f5lAR7n+3sy+lC9puoYXvODnO40w==
X-Received: by 2002:a05:6512:3256:: with SMTP id c22mr6175723lfr.574.1643375847828;
        Fri, 28 Jan 2022 05:17:27 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id f8sm705480ljn.16.2022.01.28.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 05:17:27 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     nathan@kernel.org, ndesaulniers@google.com, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, christophe.leroy@csgroup.eu,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv3] powerpc: mm: radix_tlb: rearrange the if-else block
Date:   Fri, 28 Jan 2022 14:17:13 +0100
Message-Id: <20220128131713.299198-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
                                __tlbiel_va_range(hstart, hend, pid,
                                                  ^~~~~~
arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
                unsigned long hstart, hend;
                                    ^
                                     = 0
arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
                                __tlbiel_va_range(hstart, hend, pid,
                                                          ^~~~
arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
                unsigned long hstart, hend;
                                          ^
                                           = 0
2 errors generated.

Rework the 'if (IS_ENABLE(CONFIG_TRANSPARENT_HUGEPAGE))' so hstart/hend
always gets initialized, this will silence the warnings. That will also
simplify the 'else' path. Clang is getting confused with these warnings,
but the warnings is a false-positive.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..5172d5cec2c0 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1171,15 +1171,12 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
 			}
 		}
 	} else {
-		bool hflush = false;
+		bool hflush;
 		unsigned long hstart, hend;
 
-		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
-			hend = end & PMD_MASK;
-			if (hstart < hend)
-				hflush = true;
-		}
+		hstart = (start + PMD_SIZE - 1) & PMD_MASK;
+		hend = end & PMD_MASK;
+		hflush = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hstart < hend;
 
 		if (type == FLUSH_TYPE_LOCAL) {
 			asm volatile("ptesync": : :"memory");
-- 
2.34.1

