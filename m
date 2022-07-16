Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD3577262
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiGPXRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPXRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCB1AF22
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:14 -0700 (PDT)
Message-ID: <20220716230952.727288644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tOd2h+5X6DIVgo8cTm+A/eBNlNlb0gNOIgz+JPAUdSc=;
        b=oFTQVt3owFOV+oSY8U3WQnmJAYOcGBGoUCum40vbucF0emAfCPRDk/WMPsBNw3Pbg0+9UA
        3xzhsDToCRznVTj7pDE6Q7dkDR9R2lyA7PttQqNzgR5DT596wzcZQEBmiPcNcCWSg6iwdw
        v3qsaPiNkj51M9Sp/2TpxSBJECcOAlJy3SGTG3iGX8rjz0vDkeSBNCtvCYpa3zTzHYO9g0
        /YbPa1zGqc1i+6y0fjUi6m4bh1Z8YfxyOo7jsLQQglU4N7dUhrx4lq92DE9/VhbKUu/Ynf
        ytI2Q4TeqJX6ktZBVp2qcme8qXtZhsHnKr0RS1UFgwInOBVvH50FB8ptZv/kyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tOd2h+5X6DIVgo8cTm+A/eBNlNlb0gNOIgz+JPAUdSc=;
        b=WdxTxQ8jYG9/FPO6DHcYaOuRVxVDXZEdHmRUHwRBH8UoLxEWX1V7ki0XFm5lS5Op3j97tY
        ucBGzqzyO2tVyRAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 01/38] x86/paravirt: Ensure proper alignment
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entries in the .parainstr sections are 8 byte aligned and the
corresponding C struct makes the array offset 16 bytes.

Though the pushed entries are only using 12 bytes. .parainstr_end is
therefore 4 bytes short.

That works by chance because it's only used in a loop:

     for (p = start; p < end; p++)

But this falls flat when calculating the number of elements:

    n = end - start

That's obviously off by one.

Ensure that the gap is filled and the last entry is occupying 16 bytes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |    1 +
 arch/x86/include/asm/paravirt_types.h |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -743,6 +743,7 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
+	 _ASM_ALIGN;				\
 	.popsection
 
 
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -294,6 +294,7 @@ extern struct paravirt_patch_template pv
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
 	"  .short " clobber "\n"			\
+	_ASM_ALIGN "\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */

