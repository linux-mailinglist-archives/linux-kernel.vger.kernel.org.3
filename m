Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB54DB8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348099AbiCPTcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiCPTcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:32:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84B41612
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:31:06 -0700 (PDT)
Received: from zn.tnic (p200300ea971561ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EA831EC0528;
        Wed, 16 Mar 2022 20:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647459061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tp0yKmZCrFJl4RE8oYyyD3xIega8TfGKX84RCmIK9Tc=;
        b=Ep2qvssYh7SQ3YUBSjlRlP4GRK/cYaJkd1dzV+KKLiLpjQIknu2Y8bzzU62kpoc19MHptx
        EiUuNkU8bpAE2/6TIQlkurkOa3G7EzB6r+jyRUj8ONIf8IN1GuIrXfXmngBub7+PueyPWR
        Rr1VE0uLfUKHeORRocpn6drBhDAk3uM=
Date:   Wed, 16 Mar 2022 20:31:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jamie Heilman <jamie@audible.transient.net>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjI69aUseN/IuzTj@zn.tnic>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
 <YjHYh3XRbHwrlLbR@zn.tnic>
 <YjIwRR5UsTd3W4Bj@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjIwRR5UsTd3W4Bj@audible.transient.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:45:25PM +0000, Jamie Heilman wrote:
> Yep that worked, here's output, you can see the network get set up and
> then boom:

Thx, that was very useful. Does this below fix it, per chance:

---
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index f667bd8df533..e88ce4171c4a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -430,8 +430,11 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	FOP_END
 
 /* Special case for SETcc - 1 instruction per cc */
+
+#define SETCC_ALIGN 8
+
 #define FOP_SETCC(op) \
-	".align 4 \n\t" \
+	".align " __stringify(SETCC_ALIGN) " \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
 	ASM_ENDBR \
@@ -1049,7 +1052,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 {
 	u8 rc;
-	void (*fop)(void) = (void *)em_setcc + 4 * (condition & 0xf);
+	void (*fop)(void) = (void *)em_setcc + SETCC_ALIGN * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
