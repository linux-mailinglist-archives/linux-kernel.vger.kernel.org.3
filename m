Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7204BDBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiBUKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:46:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355249AbiBUKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:45:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D77D69
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpBKsVZQGw9BH4QPev42eXnbVs5cNcqTAyBEyLsnM0U=; b=hqoT0z2W1y5VOYy+ndSdVNBa0b
        MCVpWQcRp4KkJzPLTOAToIaLhE72Vwncn4hGPwExWubQlKcNvpETWbX0FuY8ZksyVHfFEkGc4t/tE
        IT3Z7AGmlMprhRPVeNfh66BYJqnIQCqoAL7uSDgnzD82XbI3rgmmagg/8No3p4V6B48Aw7NXsAb/O
        /Y5/jxxRsn0A7Llejh9P9uhBc1hSJcu2WFFA8B14GB2FLiXq9Jdu1RCa1Tkg1/zjs4kUBDhzjiw2a
        WEimjO6TofBE2AILLdsIgdvl6XLnksVyt4nmNj4fG5JMny+DfUR+wBLvvBIvGNjDoKi6uQzx8nKBI
        kXDtL1ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM5aD-00BcH4-8Y; Mon, 21 Feb 2022 10:06:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B423A9857C7; Mon, 21 Feb 2022 11:06:15 +0100 (CET)
Date:   Mon, 21 Feb 2022 11:06:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 15/29] x86: Disable IBT around firmware
Message-ID: <20220221100615.GK23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.456054276@infradead.org>
 <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Could you trim replies so that I can actually find what you write?

On Mon, Feb 21, 2022 at 12:27:20AM -0800, Kees Cook wrote:

> >+#ifdef CONFIG_X86_IBT
> >+
> >+u64 ibt_save(void)
> >+{
> >+	u64 msr = 0;
> >+
> >+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
> >+		rdmsrl(MSR_IA32_S_CET, msr);
> >+		wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
> >+	}
> >+
> >+	return msr;
> >+}
> >+
> >+void ibt_restore(u64 save)
> 
> Please make these both __always_inline so there no risk of them ever gaining ENDBRs and being used by ROP to disable IBT...

Either that or mark them __noendbr. The below seems to work.

Do we have a preference?


--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -48,8 +48,8 @@ static inline bool is_endbr(const void *
 	return val == gen_endbr64();
 }
 
-extern u64 ibt_save(void);
-extern void ibt_restore(u64 save);
+extern __noendbr u64 ibt_save(void);
+extern __noendbr void ibt_restore(u64 save);
 
 #else /* __ASSEMBLY__ */
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -596,7 +596,7 @@ __setup("nopku", setup_disable_pku);
 
 #ifdef CONFIG_X86_IBT
 
-u64 ibt_save(void)
+__noendbr u64 ibt_save(void)
 {
 	u64 msr = 0;
 
@@ -608,7 +608,7 @@ u64 ibt_save(void)
 	return msr;
 }
 
-void ibt_restore(u64 save)
+__noendbr void ibt_restore(u64 save)
 {
 	u64 msr;
 
