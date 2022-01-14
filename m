Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBA48E91E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiANLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiANLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:24:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF157C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:24:54 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4757A1EC01CE;
        Fri, 14 Jan 2022 12:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642159488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M50s0kMU4Nt9S/bloOlFHSxe6yLWJ7aCdGmY9JND95A=;
        b=l3g9m+GgzqAY0U1odi9aQp+M/3L00a3WVnkIxxFkhz0RchINJB3NxdOU5d0C3MbP01mkgV
        brSUsNJm0BHFOFQr4vGK8xVlgwRwq9xE6FfVYpu+grcV3VUGr7nnlhjQObWzrtRcxE2sKL
        UzO5QpCA6mLYQQP89Ry5yYVRe09pmQg=
Date:   Fri, 14 Jan 2022 12:24:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [PATCH] x86/entry_32: Fix segment exceptions
Message-ID: <YeFdeZsTWDt9WU8f@zn.tnic>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net>
 <Yd724f1Uv1GTZ+46@zn.tnic>
 <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
 <YeCDudla868Ipf++@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeCDudla868Ipf++@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:55:37PM +0100, Peter Zijlstra wrote:
> On IRC Andrew also noted that these EX_REG_* things should be __i386__
> only. Previosly when they lived as open-coded EX_DATA_REG() usage in
> entry_32.S that was implied, but now ...

I guess that then below.

amluto, I'd love it if we (and by that I mean you :-)) could document
the rules for GS on 32-bit so that it is clear what's going on there...

entry_32.S is only hinting at what's going on, we have comments here and
there but not all concentrated into a single location.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 14 Jan 2022 12:15:21 +0100
Subject: [PATCH] x86/entry_32: Remove GS from the pt_regs offsets and fixup
 regs

GS is special on 32-bit and segment exceptions fixup through it won't
work. Leave breadcrumbs for others not to walk into the same nasty.

Fixes: 9cdbeec40968 ("x86/entry_32: Fix segment exceptions")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/extable_fixup_types.h | 5 +++--
 arch/x86/lib/insn-eval.c                   | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 503622627400..0aa5f4d3234f 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -20,11 +20,12 @@
 #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
 #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
 
-/* segment regs */
+#ifdef CONFIG_X86_32
+/* segment regs, valid only for 32-bit code, see pt_regoff */
 #define EX_REG_DS			EX_DATA_REG(8)
 #define EX_REG_ES			EX_DATA_REG(9)
 #define EX_REG_FS			EX_DATA_REG(10)
-#define EX_REG_GS			EX_DATA_REG(11)
+#endif
 
 /* flags */
 #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index b781d324211b..34001eee7482 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -432,7 +432,10 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, ds),
 	offsetof(struct pt_regs, es),
 	offsetof(struct pt_regs, fs),
-	offsetof(struct pt_regs, gs),
+	/*
+	 * Can't use that one - it is special - see entry_32.S
+	 * offsetof(struct pt_regs, gs),
+	 */
 #endif
 };
 
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
