Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661157F1CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiGWVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiGWVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:45:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42331DFFE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t7so5848957qvz.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOV2niHKO7PtVMQqwHmkefwvvV5KsW69pLHmCgIHVEs=;
        b=JC3nAoMTVQvMQDRTMWOnWiytHG6OpszfZ4JQQrRPLIGuJpq4TguV9NhcxQFSTn7dWV
         HxMgtOMRWGlVxr22qPPO+AJLWE2xkgFolvdcPFh9IPbk6yEw8hal86GpH0LA9fCyQf1n
         i4QUmivVhWxelD9ZVZSnGmVg4zyzVTjWp4Qwdaa73uGvSznM20cAjqypqnas3QJxiH8v
         8qMCKoJGDPWDKtZD2WPtDsN3pqn63sB0YCgRFRPaQqNU+ltLzCQgCn5unw77RP4G8KUH
         ERaQHoiQiJbfxWdNtvFdGqxOHZTtXtOXXd6MkeJoxGsq7wWiAA4SktoGC6aR477DaaE8
         G+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOV2niHKO7PtVMQqwHmkefwvvV5KsW69pLHmCgIHVEs=;
        b=2mWt9ChdBuI0bGKM1Pjj6+bBiolDb/FEm8VlTEXGqcci2N2aANAMdrhHm1GWRT45sV
         dFTz77iM90e7UAZoR5tzR/bNvXqxsGqkJiWhnghBkGlrVKcxxEIPFqlMscbVyuKjvtiA
         UGCnd4EU/KuxaY91bXdkvLMQS2ybSk4nfSFLnSc3Jyx9pJVchWhSJvPIJoVl7KT7JCHc
         zhywv8gcRkQRnHfJEfqiMG5vxRCVFBXyO4jq03vEUMRVhM+jloJy0FjytUqB7SVf3QeA
         lQmpRZq5pin/twvcIedNSCBFnDBuqov0Um7QTmacBpvN0/aOEFO+4xhm0Z1hXuzkoKgI
         gs6Q==
X-Gm-Message-State: AJIora+rCGxCfVzzBcjx5VL+CaG8YpGEs3phdVXVmdFvKzLJ/AitBSES
        nrjmLNzLgDjvIU59UnLr3lMp3iQmDnY=
X-Google-Smtp-Source: AGRyM1tWJtYmpPAC6pDD2r1ggEtIQghnJsNEc6XwBU5AEZoOA4HkiFaN+EK8a/VXa4gscI8VFXC9yA==
X-Received: by 2002:a0c:800d:0:b0:474:19c:f0af with SMTP id 13-20020a0c800d000000b00474019cf0afmr5070727qva.74.1658612741164;
        Sat, 23 Jul 2022 14:45:41 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:6235:40e3:a1d2:6281])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84716000000b0031ed590433bsm4903219qtp.78.2022.07.23.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 14:45:40 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in archrandom.h
Date:   Sat, 23 Jul 2022 14:45:36 -0700
Message-Id: <20220723214537.2054208-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220723214537.2054208-1-yury.norov@gmail.com>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
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

archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
circular header dependency, if generic nodemask.h  includes random.h:

In file included from include/linux/cred.h:16,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
 1203 |         nodemask_t                      mems_allowed;
      |         ^~~~~~~~~~

Fix it by removing <asm/machdep.h> dependency from archrandom.h

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/include/asm/archrandom.h |  9 +--------
 arch/powerpc/kernel/setup-common.c    | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9a53e29680f4..21def59ef1a6 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_ARCH_RANDOM
 
-#include <asm/machdep.h>
+bool __must_check arch_get_random_seed_long(unsigned long *v);
 
 static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
@@ -16,13 +16,6 @@ static inline bool __must_check arch_get_random_int(unsigned int *v)
 	return false;
 }
 
-static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
-{
-	if (ppc_md.get_random_seed)
-		return ppc_md.get_random_seed(v);
-
-	return false;
-}
 
 static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index eb0077b302e2..18c5fa5918bf 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -171,6 +171,17 @@ EXPORT_SYMBOL_GPL(machine_power_off);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
+#ifdef CONFIG_ARCH_RANDOM
+bool __must_check arch_get_random_seed_long(unsigned long *v)
+{
+	if (ppc_md.get_random_seed)
+		return ppc_md.get_random_seed(v);
+
+	return false;
+}
+EXPORT_SYMBOL(arch_get_random_seed_long);
+#endif
+
 void machine_halt(void)
 {
 	machine_shutdown();
-- 
2.34.1

