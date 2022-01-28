Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B169949F6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiA1KIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiA1KIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:08:25 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCBC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:08:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x11so10776783lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPIs9YPGDV7k07cd7jFYYkWNGuS5b4mzeWo4flha5rw=;
        b=b56girLI15IIsF4oK/Hs939t9s4O1/gcc0gOszxgrp+bUH0aFjNsQfRUDBc6B9OzDP
         F3Li62qBgvSbyeCOA3SlwWxvfsFKm3vzvyTxJbhduyYBCyLgv2CNuYX0oeRgCps7KqKY
         c0+k5HzbbT2RYg1kmKNmlf4BBtetBbDEDhLAIvh/+KeA1CqtgTiOrjVgu8nH1VWM4ekk
         ZkpR07ArNRdSlIjnVlQl8rdf+d1gxMrkRN36sXO+pjTpxL/0jcUad7FTM/TuYzHssyW3
         d+MiBjcMQ5pUdfnBWel/+FSS37EcK7l2mg9tlxiPQA3C+P8L7wjdQaX0yLlJ8oR9YPoG
         hT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPIs9YPGDV7k07cd7jFYYkWNGuS5b4mzeWo4flha5rw=;
        b=PgkxZLRn1/k57snbKWslFlca4+fO7ruNfcuV1xCMPOf886O1zQUqOq9QbUXi6TJxm1
         tJhK4D16O/6cOgmKluKiOzJARvQEIy2SX3qFNve7AibPQMcZJ+oXiFZ0nThRPiboOKRF
         kW91+3UT4/5wBgmdJhpQJNbgdC66wBRKVHgpa/BU1wC/xrM8JpFM8GTQemr9zNdBsniQ
         Meb5FeaOpRRtSdczcCiARzHkhw7Zlvw3KYIPQeA90/WbSZzCCKzp6abVVFLpI+uEv8BU
         OgCFnvnbfOBTXccryqVNS8LH2AMFo0lt10nfCQQWjAusPyGP8pk8i1+dzOhXtrTKhVS9
         vzzw==
X-Gm-Message-State: AOAM530dJXMMXn8Xy4GYtjlr5VkIKjX+7z4hQcLyDKmHzLvie96nAW+d
        AvSt4AEuBy6g0a94YPySbjWIBw==
X-Google-Smtp-Source: ABdhPJy2ZzvAQ/MsCmkNEnqNIXI59+XYp+TYTg3rqECD18OxWTFLitIFA8t4wVyFa2K8FcrCX8pQHA==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr5560555lfk.534.1643364502961;
        Fri, 28 Jan 2022 02:08:22 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id w13sm1830172lfk.148.2022.01.28.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 02:08:22 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     nathan@kernel.org, ndesaulniers@google.com, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, christophe.leroy@csgroup.eu,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2] powerpc: mm: radix_tlb: rearrange the if-else block
Date:   Fri, 28 Jan 2022 11:08:15 +0100
Message-Id: <20220128100815.3231551-1-anders.roxell@linaro.org>
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
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..7d65965a0688 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1174,12 +1174,9 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
 		bool hflush = false;
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

