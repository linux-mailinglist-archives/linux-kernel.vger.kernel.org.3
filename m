Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDED5A71D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiH3Xcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiH3XcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D272EFA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc888dc62so190486597b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=9LSUCUqEmRpIK5FTeLqrINe//PWWlcjxscTw9SglyBU=;
        b=Su8/MiPy6GrNyCZfLWSzM0QU1dzSiDI0SliUWOKUODrw/Zg/7o59CaOtL6G5L0jYgM
         X/nIqegMyA+Kh3i5o6gz/yFE72IRB/oYvcAo8B4Ou65zdTIZjxFkikPuDGdBb1bm5xv/
         MkQSCWKHffAiHPaPg2AGsKSnliAJQUm2xtplYZb0b6I/YUiwy4GlqRa2GenrNFTV1dfC
         ORdhrBnHz00KdnQtOJmuoxpAMGLAy6YF4CuwKBafGYerSmoW9wEz5roZcGDBWthhjt0r
         Wut1FEVu2171ad+NOt4gzsl/aDqaQaEmAQ4TMKeMKbdDJYkJo1/+ghW7G8iMx/Murjyy
         wsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=9LSUCUqEmRpIK5FTeLqrINe//PWWlcjxscTw9SglyBU=;
        b=F66ksvPcKimyyvxT9Az1pDKV0CTuLDyKuUNRi6zvh17fHPt3Tm6b5SzlkdW2ut+9kJ
         jpjyrWzZvkdrZX0uTUfKSXjoZ8nzJCRojBUF1qdT8X8Eq3cSqPS9HRn4voMTIPY4aHZV
         ov4YnN9/irhWPjA4d62WudljEeLPz4BN59Fog4vkdUnobQSF1q6m7rEIX11ZwT+ABOh8
         SSb9yUy48WqwBpqcVv52rbApcO2Sljn7SVSdQWxbbJ1My75PTPclxMTZTWec78gATq5E
         WHyBvTSnczX+mMHDwW532GF72kglyiwsI2ml7m7qINGiVn48VrqXUZeXcI7t2qf5LEcO
         wdQg==
X-Gm-Message-State: ACgBeo01PsE1XMGjOmI2wyB3EvjMieMwwh8xyNdtsxbr41oQTHCtoIWL
        Ag73Kuxib53Ed0xpiR87VQEFhKylsqoghkvmyNUKu3Hdtiaq/f3ccXLq2KHCsLAmBiVX427DGLO
        eCA+XOWv6GWnr5b9x5D0rjH6DCjxCzpS2Q/D5r9jvXjqI3TzyQj8gUbjo8yuDgK9L/o893QrD3s
        7surRly4Oyyg==
X-Google-Smtp-Source: AA6agR68BGQFfoXet7uT17W5HOi349FKHJvCytSwwlUunuycgf/3w6VheODjwTRdH054IFoEZZevvqkxZQsPtf/8osU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:1c4b:0:b0:340:972f:abb0 with SMTP
 id c72-20020a811c4b000000b00340972fabb0mr16059486ywc.489.1661902314803; Tue,
 30 Aug 2022 16:31:54 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:16 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=samitolvanen@google.com;
 h=from:subject; bh=dCgTAVpHmh6ue+qIjFQmdwGO+wJHDxTFzsMUhw9fLMU=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3NvhTqxF6HKWPsUGSSA+N2dkmpL8jOb0ZK7Jx1
 pV8vgQyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzQAKCRBMtfaEi7xW7kFoC/
 9rUzKXMDXQKoSguu/A2Rv2ATA5t4yfg6zrdjYpiicpnCS+TbGGK2lUdzlcslHdS1IDP2ecHOWcdDcl
 Fe0QHSu2ujICLA210WhZwuUleMLIwtCzQDdoDj1VPjBfrJ3m8Bvw8UoVtabPRz2Up91t3EszVWpke7
 cOKRhf1TZUreP9c5HzmehuN6xPi6PfCsXekOiqqKS5bveLFNH1izxbSyDg4MB/Nf67NMlQonGdnxzl
 vhT5ncb1Xb0rn50pB1LcJRz/YZ8D3+Y3Vc5j3XBWHUj6N3RIJOxyEXC5ypoF774b2i+O7fvWy20CPQ
 hFIEux/rXEdv28MYbGssuPw+fLT/IhlbUoI1f+MxSCobNzG5kQcxThpkupoA9NFbFWxmBatG+FcPc8
 WTSgP0bNGyxHqO6BkyENMKnpUsvQbWes5XHGgvDop67nvldrkisGMHpuaEXqz3dQ99BgFp035sdyOc
 zEqaAajdW2W/J6ScBKCLnWsAcMP9axCky8DTM7nWY/lBE=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 08/21] psci: Fix the function type for psci_initcall_t
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions called through a psci_initcall_t pointer all have
non-const arguments. Fix the type definition to avoid tripping
indirect call checks with CFI_CLANG.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/psci/psci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..75ef784a3789 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -274,7 +274,7 @@ static void set_conduit(enum arm_smccc_conduit conduit)
 	psci_conduit = conduit;
 }
 
-static int get_set_conduit_method(struct device_node *np)
+static int get_set_conduit_method(const struct device_node *np)
 {
 	const char *method;
 
@@ -528,7 +528,7 @@ typedef int (*psci_initcall_t)(const struct device_node *);
  *
  * Probe based on PSCI PSCI_VERSION function
  */
-static int __init psci_0_2_init(struct device_node *np)
+static int __init psci_0_2_init(const struct device_node *np)
 {
 	int err;
 
@@ -549,7 +549,7 @@ static int __init psci_0_2_init(struct device_node *np)
 /*
  * PSCI < v0.2 get PSCI Function IDs via DT.
  */
-static int __init psci_0_1_init(struct device_node *np)
+static int __init psci_0_1_init(const struct device_node *np)
 {
 	u32 id;
 	int err;
@@ -585,7 +585,7 @@ static int __init psci_0_1_init(struct device_node *np)
 	return 0;
 }
 
-static int __init psci_1_0_init(struct device_node *np)
+static int __init psci_1_0_init(const struct device_node *np)
 {
 	int err;
 
-- 
2.37.2.672.g94769d06f0-goog

