Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC904B5888
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357128AbiBNRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:31:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353641AbiBNRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:31:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD3652FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:30:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s10so14530471wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AGCFdqLSGMml/hB38dxa+9K7KXIhUPhr2p9KJH7yQOw=;
        b=fF5f304uLd8qG/ptoPc82cE0G9TEhr8c7bhbNMAbatpc4mpdLfO9SYrUbw0Z9Fa8BM
         NPH1wgKHgNg+Fy3kDqxUncJcxI8miMxR12aDOTVyPhLmT0bF3nfJWmnxZ+j9tccy97vO
         U1juckm/tf+RZcC91IBO6n/1soK8/j2P3TNTtnIZBuGsGXrUbe9hSVaS3jQ4n1o200/n
         YpTT2+mlnVKWt71Mj5aAjl1STUl3I+oaVT5XKCqsdFkIsQbBT3ywar0cFaqWlt+v6M+J
         NQpWNYoYanjEwWdc1L4+sVrPu5D6DUQpbSHPXxMInmDyHYa+VRDyEGM54O6eZO5VKJzG
         gFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AGCFdqLSGMml/hB38dxa+9K7KXIhUPhr2p9KJH7yQOw=;
        b=X2+8SH82unqZ3aILGDKXeI5GFkzjUg52uqqkIx+oBPJ0vqN0sW+5pmvZ0uHMwPM53/
         D3pNATOMBOipTQ911/Da9WxdmTeqqmCGev/h9GXzk/PaqTceFf6GEAZW/GRDFJ0JVhkx
         eRSmbf5dDc5zVrCk2g/IhL2QVPIQClMPOO34IEOM4gx7JRmTjyWP2rpzYuzBPzj9NfjB
         K6qgiLOSnpFFRVhFccRbMmKMQ6LrGsAy+1cEw27XzzUESsQYJIe//Ntk6mtRqIBziaPS
         Oy8+tHzpEKVYPIS88oSuY7+Rt4GGGO9RVntzYID88US+1NSINYTZSWePh9j0b87zHY1s
         hfrA==
X-Gm-Message-State: AOAM532JjOwKogXoylwledw64grrU0JZiU00Kj21R7Qzoeld7Bdn76gA
        zMhyX452A2rIyed9FmB2ig==
X-Google-Smtp-Source: ABdhPJxrmXqZeVPlzpv1HDwLQrpG8BXwagt0bWX/clYj9JqT0GpW+yaXkMzyr1sdYWNu7+UzRIYvCA==
X-Received: by 2002:a5d:6f11:: with SMTP id ay17mr29377wrb.581.1644859857075;
        Mon, 14 Feb 2022 09:30:57 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.86])
        by smtp.gmail.com with ESMTPSA id u14sm16733986wmq.41.2022.02.14.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:30:56 -0800 (PST)
Date:   Mon, 14 Feb 2022 20:30:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     bp@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH] x86, alternative: simplify DUMP_BYTES macro
Message-ID: <YgqRz4dYzaexFiUh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing buffers is simpler if space is put before the data.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---

 arch/x86/kernel/alternative.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -66,13 +66,10 @@ do {									\
 	if (unlikely(debug_alternative)) {				\
 		int j;							\
 									\
-		if (!(len))						\
-			break;						\
-									\
 		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
-		for (j = 0; j < (len) - 1; j++)				\
-			printk(KERN_CONT "%02hhx ", buf[j]);		\
-		printk(KERN_CONT "%02hhx\n", buf[j]);			\
+		for (j = 0; j < (len); j++)				\
+			printk(KERN_CONT " %02hhx", buf[j]);		\
+		printk(KERN_CONT "\n");					\
 	}								\
 } while (0)
 
@@ -214,7 +211,7 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
 	add_nops(instr + off, nnops);
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs: ", instr, off, i);
+	DUMP_BYTES(instr, instrlen, "%px: [%d:%d) optimized NOPs:", instr, off, i);
 
 	return nnops;
 }
@@ -303,8 +300,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn:", instr);
+		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn:", replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
@@ -328,7 +325,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn:", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
@@ -499,8 +496,8 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
-			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
-			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
+			DUMP_BYTES(((u8*)addr),  len, "%px: orig:", addr);
+			DUMP_BYTES(((u8*)bytes), len, "%px: repl:", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}
