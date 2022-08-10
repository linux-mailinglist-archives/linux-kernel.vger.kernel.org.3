Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242558EB70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiHJLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiHJLnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:43:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610677571
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:43:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s9so15818939ljs.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KRr7duS52TODFaYDFxdheo3ZE1Z29DCImBOABo5du1w=;
        b=L5bSi9j5tjzNYxKY/Yjve3HQTu5putRB3hOcGDpbo8kEHFySaD8u2jNqhyhgxw5PSY
         ilAiLUNa/T5OFqIpIF/cwUJPb6RBzELpPa4RGLQmxCLAh+dKYfLiMrnrm5PntvEpG/4o
         rWyJe0i4PARwDTKX25pa6Pl3gXMtgxi4kx4nO0hQHQQVLPDNwu4bMCHROeTUqd+RX9GD
         xE21kcgTC6gSjguLlKzyylBIPTA1YL6t1Ir61sGELzAf8s7aXeCNobk/V6ftThHsHzC8
         m9hUj4f98RIUuIKIw1083ZqM9pO+DXYb2Vcq60xnMYchNP5yM/s0uBpTY+gEiHE9EBnK
         WhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KRr7duS52TODFaYDFxdheo3ZE1Z29DCImBOABo5du1w=;
        b=lBJW3H/bQOUFvd4NphH9CPNdtbl239nGWBDeOenjPwmd/HhDZ8kSPrqImmHHBan/YQ
         W8wrqU7nZGsHGF96aTUH1uh2AharCwT9cYGPDMtf4MRZwQ6JIAcEKrWn6yeWjdu2ovJ+
         UmosKWW7w+b50tWzw9c584OUwopuiXa1Ybdxu9Fwuyk+rsHXbYwmYtekkmN7ukm01z6C
         XfSku/nVMXT+b9fx8pyoIRPN9jMM5onMzbfh3Nun2vimk4iLEfgyXReylm7K/Ob/UXzL
         XBGuUqrVlYyIpO6XWwhSh2ek29C/XHwspae4ISpBWcYj8WghCELf4twe5f0CE/tFVeD4
         Gssw==
X-Gm-Message-State: ACgBeo1BvsU9Zi+IJTkk5sEhM/CfFwTK/sXGer/25hvAQMrxhqTqp5w9
        dvpuXb+PM8iU/1YuDSee4kHhBw==
X-Google-Smtp-Source: AA6agR58RoUom5V9F0K5f8O7nc43sAMKbqRT2vJAmqcRE8MN5wQHYZN/H6+z2EXmE7lIKsqk6gh2zA==
X-Received: by 2002:a2e:391d:0:b0:25e:7237:13ef with SMTP id g29-20020a2e391d000000b0025e723713efmr9176026lja.350.1660131801071;
        Wed, 10 Aug 2022 04:43:21 -0700 (PDT)
Received: from localhost (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512375100b0048b969ac5cdsm319863lfs.5.2022.08.10.04.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:43:20 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     nathan@kernel.org, ndesaulniers@google.com, mpe@ellerman.id.au
Cc:     llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCHv3, resend] powerpc: mm: radix_tlb: rearrange the if-else block
Date:   Wed, 10 Aug 2022 13:43:18 +0200
Message-Id: <20220810114318.3220630-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 4e29b619578c..6d7a1ef723e6 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1179,15 +1179,12 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
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
2.35.1

