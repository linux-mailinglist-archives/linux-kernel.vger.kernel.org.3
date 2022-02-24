Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D949D4C2F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiBXPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiBXPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C698144F50
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JWR1Jvatd2wRq94EgF2FFUHDrJsSm4yXOI7jdL4Xcs4=; b=h4QDH/Gv96wd3eVPV61DyLB68+
        t8jRD2oT1kQAdAHgy8Mztir6XZCLuZIBG1ZLpDhzAR8ObMy5QP37KpXMmCLOktSFSGuoQGy3KTuE2
        9vclMYuuBtMTYxgUzgpGUIOQsR4rihCZYupCrzIepI4xIyBMVZVPGpCvgAAWRyPnKY72I5wQhA4rg
        PoQtrnuKUjPiUyXWDRJhvckIB00KSpRdvjuigiqn40+WItp9iXmwSVnA3TUvVq4LR+eQqdWooBbHr
        yxTn6Gjxco/LIoO+EhR1tnLB3yaoDkR3yozmHQGmTzxU6ciIA+DJtngIeKyni4l9pHCo7JIUY8Yzw
        gPSyE2ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-004s2N-Du; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5339B302DB9;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B7E842B3547B3; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.256729197@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 38/39] x86/ibt: Ensure module init/exit points have references
References: <20220224145138.952963315@infradead.org>
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


