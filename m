Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181AC4D7003
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiCLQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiCLQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:37:21 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B3574B1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:36:15 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 2F7CF12089B;
        Sat, 12 Mar 2022 16:36:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id BB5D634;
        Sat, 12 Mar 2022 16:36:12 +0000 (UTC)
Message-ID: <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Mar 2022 08:36:11 -0800
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: c6gs414ciqyugqo9h4ijd6e6zsennyq5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: BB5D634
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX194K3XRck3ArpoYUkfPKFo7/9WGxwsHxS8=
X-HE-Tag: 1647102972-289440
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 17:43 +0300, Alexey Dobriyan wrote:
> Avoid zero length check with clever whitespace placement in the format
> string.
[]
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
[]
> @@ -66,13 +66,10 @@ do {									\
>  	if (unlikely(debug_alternative)) {				\
>  		int j;							\
>  									\
> -		if (!(len))						\
> -			break;						\
> -									\
>  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
> -		for (j = 0; j < (len) - 1; j++)				\
> -			printk(KERN_CONT "%02hhx ", buf[j]);		\
> -		printk(KERN_CONT "%02hhx\n", buf[j]);			\
> +		for (j = 0; j < (len); j++)				\
> +			printk(KERN_CONT " %02hhx", buf[j]);		\
> +		printk(KERN_CONT "\n");					\
>  	}								\

This could also use %02x and not %02hhx

And MAX_PATCH_LEN is 255 but is that really possible?

Maybe if the actual patch length is always <= 64 this could use
	printk(KERN_CONT "%*ph\n", (int)len, buf);
instead and avoid all possible interleaving?

If so, maybe just remove DUMP_BYTES and use DPRINTK directly.

Perhaps:
---
 arch/x86/kernel/alternative.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 018b61febf0e7..74fa946093467 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -61,21 +61,6 @@ do {									\
 		printk(KERN_DEBUG pr_fmt(fmt) "\n", ##args);		\
 } while (0)
 
-#define DUMP_BYTES(buf, len, fmt, args...)				\
-do {									\
-	if (unlikely(debug_alternative)) {				\
-		int j;							\
-									\
-		if (!(len))						\
-			break;						\
-									\
-		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
-		for (j = 0; j < (len) - 1; j++)				\
-			printk(KERN_CONT "%02hhx ", buf[j]);		\
-		printk(KERN_CONT "%02hhx\n", buf[j]);			\
-	}								\
-} while (0)
-
 static const unsigned char x86nops[] =
 {
 	BYTES_NOP1,
@@ -214,7 +199,8 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
 	add_nops(instr + off, nnops);
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+	DPRINTK("%px: [%d:%d) optimized NOPs: %*ph",
+		instr, off, i, (int)instrlen, instr);
 
 	return nnops;
 }
@@ -303,8 +289,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+		DPRINTK("%px:   old_insn: %*ph",
+			instr, (int)a->instrlen, instr);
+		DPRINTK("%px:   rpl_insn: %*ph",
+			replacement, (int)a->replacementlen, replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
@@ -328,7 +316,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		DPRINTK("%px: final_insn: %*ph",
+			instr, (int)insn_buff_sz, insn_buff);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
@@ -499,8 +488,8 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
-			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
-			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
+			DPRINTK("%px: orig: %*ph", addr, (int)len, addr);
+			DPRINTK("%px: repl: %*ph", addr, (int)len, bytes);
 			text_poke_early(addr, bytes, len);
 		}
 	}


