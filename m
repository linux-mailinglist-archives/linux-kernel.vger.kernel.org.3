Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE264991BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349894AbiAXUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiAXTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:53:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC76C06118F;
        Mon, 24 Jan 2022 11:26:59 -0800 (PST)
Date:   Mon, 24 Jan 2022 19:26:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643052416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uc4CcyNeBy6pq/UPib+XtFLrqtsV8lin+EF3qDe9Xm4=;
        b=L3+YLmiz1vcHCRmEVpY6owP6iftTzIaIeaGvoLb+BoXxODX1fKOyjebD8W4pTrCLmj6eQw
        UrRz6FH8qnY8eOR/3vFXYdRSwlZiQ3IYPdLgnxCp9qk+02wbd9sGFsqLq3SxLaFHTlp3lA
        rIGQ+GNNz4capz5SrJkROzbBh6u3aUoqy2MWgRkfLyj01IsA+48ZvFe+0rnw73w17MeJIl
        0d2xks+Stngumz9J/zCFK2mBhtbl9CbLmjUwov4BX3kodKcV/JT79hmHg1nV/rgCQ60XWB
        D3YUL7jOIfNfH/3dwlkwE73U0zGr4Hm+ZY3ixcPpXIoGKh9X9sbDdBMhwuIYxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643052416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uc4CcyNeBy6pq/UPib+XtFLrqtsV8lin+EF3qDe9Xm4=;
        b=6s27vJdI13QJ7ZdwPmM9YNHs4Jmn7lQhYcFtJ/+t6dQ5K95+iyBfyTj6zY2hFcz8OvODua
        HFT8BQ/xWk9gc6Dw==
From:   "tip-bot2 for Jan Beulich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Use %rip-relative addressing in hook calls
Cc:     Jan Beulich <jbeulich@suse.com>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
MIME-Version: 1.0
Message-ID: <164305241532.16921.6031632679880039280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e
Gitweb:        https://git.kernel.org/tip/2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e
Author:        Jan Beulich <jbeulich@suse.com>
AuthorDate:    Thu, 30 Sep 2021 14:40:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Jan 2022 20:21:19 +01:00

x86/paravirt: Use %rip-relative addressing in hook calls

While using a plain (constant) address works, its use needlessly invokes
a SIB addressing mode, making every call site one byte larger than
necessary:

  ff 14 25 98 89 42 82    call   *0xffffffff82428998

Instead of using an "i" constraint with address-of operator and a 'c'
operand modifier, simply use an ordinary "m" constraint, which the
64-bit compiler will translate to %rip-relative addressing:

  ff 15 62 fb d2 00       call   *0xd2fb62(%rip)	# ffffffff82428998 <pv_ops+0x18>

This way the compiler is also told the truth about operand usage - the
memory location gets actually read, after all.

32-bit code generation is unaffected by the change.

  [ bp: Remove "we", add examples. ]

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com
---
 arch/x86/include/asm/paravirt_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index a69012e..e159146 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -279,7 +279,7 @@ extern void (*paravirt_iret)(void);
 
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] "m" (pv_ops.op)
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -316,7 +316,7 @@ int paravirt_disable_iospace(void);
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+	"call *%[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
