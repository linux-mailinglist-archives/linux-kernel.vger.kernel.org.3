Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18C4D63F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiCKOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350322AbiCKOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:44:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6A141471
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l10so5272132wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DC5Lyo0u7Webj/mowBh6O4eTeZkl9naLEHKUm4TCwDA=;
        b=fIIGKec5DhH7F0ghCXPyZCkwex77X91zaslVC3Sc1TEvoJ4Bes/UzjErOJWjNuTDff
         9qj08Pls0ObfslAUvMrOqrEuVqtN4idDs6iIh09TJjeV2iGXnEWNM6Q9ILUmZoj9530R
         4vz81HPYCgDscgepPU9V1JpwS9PYhPIi6RsMwgoChYJaJXRSqiChSmATYJTYGHAqyj7u
         7mViLQKVnWrzAga3B7jQkXShvFMjYcbRTpSL9WWrH6DNepV3YJNLkd69KrXXkZGuHqH9
         tIjuPr2u7K56MtLiy6q6xGyttG3KdslZwUuS5NcBpfXxzBHMmEJKWpD1eqBN8JcqDHTx
         yBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DC5Lyo0u7Webj/mowBh6O4eTeZkl9naLEHKUm4TCwDA=;
        b=5dcLR3lIkT4lgV96YLqFtbEVgr7XQGdj6kFpkjsqXa5w+AhuIbj5Wjlr0rP0M1eQC4
         1W8XG9MfAk0m9LspFPfuJNOcB5Xale7U8cxnuRT4ktHPp3GpwA7/8coAl6oliUj9ODkE
         oD/LbcyuqRkCRAYXmOhbbmVQHg90u7cD/tQUWBoBo2jWLKHZr/zwdJshBQUOfBEj2GE2
         Dcgc1aj7JggMaeFh7tB/TJWRM7Oyr3D2Q8XkeC4KDmSLSfmzblqroM9wxCz2/Hzuz/Q5
         VQA80A+U1MY73BOqK1rqKwf1TtxWxiRW71wUVDMzIWkZDnZbjdJTbRPQkvFzleqJSJ2D
         gUbw==
X-Gm-Message-State: AOAM53043/QHUcNVE9XYExDEQsg6gd59fMvgSSkboKUtH46xYKdebPL1
        lhVTDtvqGM5eGj0DhiYIVESqUEFsrA==
X-Google-Smtp-Source: ABdhPJxxP8Lu/fGeHzfvA3fx0YR6fw65co8BUd9DGxv9qhHoMnPCM7TvaZ8gK6FZBw2SgNB8aMkcRw==
X-Received: by 2002:a05:600c:4c11:b0:383:fae4:41c2 with SMTP id d17-20020a05600c4c1100b00383fae441c2mr15947724wmp.104.1647009805909;
        Fri, 11 Mar 2022 06:43:25 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6877637wra.97.2022.03.11.06.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:43:25 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
Date:   Fri, 11 Mar 2022 17:43:08 +0300
Message-Id: <20220311144312.88466-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid zero length check with clever whitespace placement in the format
string.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---
 arch/x86/kernel/alternative.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5007c3ffe96f..6c9758ee6810 100644
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
-- 
2.34.1

