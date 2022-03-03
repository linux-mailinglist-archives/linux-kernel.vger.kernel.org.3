Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66E4CBC9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiCCLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiCCLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89044DE2CD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JWR1Jvatd2wRq94EgF2FFUHDrJsSm4yXOI7jdL4Xcs4=; b=hJhEpavCPHNClNaTf6mDQbriuB
        JU5Oc0Kd8GpMqMPexa1jJDYxpkgq+LXmAWOnGuXfsufIF7YnmQ3UYeEeuJzEPjHTZq3b++1CZ69MF
        91nNsTgI4HgIy2RlbazkagdAQwj535bOVnXZZsD6SUlM2+28TyND5JG6u7aCQt9e4gQJlXZdhIUHN
        cJEJ8ZCLoyNupZyJ8MTihszNfFoGfEjfNdrHQ1ydPrpBZowovcL4Am3ZFUJTmkOctoQQaOBmixBb0
        HgCRY5T4KCBLM6iRcagjFLTOVeP2Z+kTIkdgJdR46BH6k9AHcYDMydkr4PJAiGVIqOQYRMkaZ1K4R
        oePOFf1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00Etpn-QZ; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E0E7302D8A;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9002A30126BED; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.787190196@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 30/39] x86/ibt: Ensure module init/exit points have references
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the references to the module init/exit points only have external
references, a module LTO run will consider them 'unused' and seal
them, leading to an immediate fail on module load.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cfi.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -34,8 +34,17 @@ static inline void cfi_module_remove(str
 
 #else /* !CONFIG_CFI_CLANG */
 
-#define __CFI_ADDRESSABLE(fn, __attr)
+#ifdef CONFIG_X86_KERNEL_IBT
+
+#define __CFI_ADDRESSABLE(fn, __attr) \
+	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
+
+#endif /* CONFIG_X86_KERNEL_IBT */
 
 #endif /* CONFIG_CFI_CLANG */
 
+#ifndef __CFI_ADDRESSABLE
+#define __CFI_ADDRESSABLE(fn, __attr)
+#endif
+
 #endif /* _LINUX_CFI_H */


