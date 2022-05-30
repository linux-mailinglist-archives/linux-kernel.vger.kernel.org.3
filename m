Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40379537938
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiE3KjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiE3Kiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB86B664;
        Mon, 30 May 2022 03:38:53 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIYI9r1xg9SEjXONgAPSijJ/633c70XiaGGltpvKbQk=;
        b=MG3LaSIwkIXNnPuYg2VWxfqSJbFYPz1B1WGUlHPiq39YpjypuD6lrIit7Tm/aGvcnB0o1P
        eH7nByOsS9eKHK5URKtsdtzdG9iBQ92KpAJRtRf1g4iMdYdJ768PMcCVXp0f/6UEINqvA4
        zlVLVY/OJYPIkDkHeXkA0qbBd9TaHkByKQiofwlJUGw5E2a0EBE4bYSeAkiimVnhahaYSC
        YTjOumPBwGPEWsHMcHk2lltCK1cc54qcC+UEx/BYzrOu5ZRviSYkDRgJILVzTIuHYYyrv3
        gbkKi5f6GbedoEKaR3ymn7q11zUPM0CpQVUAaZcedgdcN0fVAuo78vUbCEMPLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIYI9r1xg9SEjXONgAPSijJ/633c70XiaGGltpvKbQk=;
        b=/Kc/KiE14HQCmDfn0tJQeHW14H1w2GhANKHgHmLIT934XHOPYdtE0m4M+qu+NV63ifV97k
        Wmmxjl7D3UmvheDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Mark
 __ubsan_handle_builtin_unreachable() as noreturn
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220502091514.GB479834@worktop.programming.kicks-ass.net>
References: <20220502091514.GB479834@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165390713152.4207.14750134351387268996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     385bd430c011a8cb8278e61c32d602d11e06f414
Gitweb:        https://git.kernel.org/tip/385bd430c011a8cb8278e61c32d602d11e06f414
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 May 2022 11:15:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:43 +02:00

objtool: Mark __ubsan_handle_builtin_unreachable() as noreturn

  fs/ntfs3/ntfs3.prelink.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr.cold()

That is in fact:

000000000000124a <ni_read_frame.cold>:
    124a:       44 89 e0                mov    %r12d,%eax
    124d:       0f b6 55 98             movzbl -0x68(%rbp),%edx
    1251:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1254: R_X86_64_32S      .data+0x1380
    1258:       48 89 c6                mov    %rax,%rsi
    125b:       e8 00 00 00 00          call   1260 <ni_read_frame.cold+0x16>   125c: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1260:       48 8d 7d cc             lea    -0x34(%rbp),%rdi
    1264:       e8 00 00 00 00          call   1269 <ni_read_frame.cold+0x1f>   1265: R_X86_64_PLT32    __tsan_read4-0x4
    1269:       8b 45 cc                mov    -0x34(%rbp),%eax
    126c:       e9 00 00 00 00          jmp    1271 <ni_read_frame.cold+0x27>   126d: R_X86_64_PC32     .text+0x19109
    1271:       48 8b 75 a0             mov    -0x60(%rbp),%rsi
    1275:       48 63 d0                movslq %eax,%rdx
    1278:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        127b: R_X86_64_32S      .data+0x13a0
    127f:       89 45 88                mov    %eax,-0x78(%rbp)
    1282:       e8 00 00 00 00          call   1287 <ni_read_frame.cold+0x3d>   1283: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1287:       8b 45 88                mov    -0x78(%rbp),%eax
    128a:       e9 00 00 00 00          jmp    128f <ni_read_frame.cold+0x45>   128b: R_X86_64_PC32     .text+0x19098
    128f:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1292: R_X86_64_32S      .data+0x11f0
    1296:       e8 00 00 00 00          call   129b <ni_readpage_cmpr.cold>     1297: R_X86_64_PLT32    __ubsan_handle_builtin_unreachable-0x4

000000000000129b <ni_readpage_cmpr.cold>:

Tell objtool that __ubsan_handle_builtin_unreachable() is a noreturn.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220502091514.GB479834@worktop.programming.kicks-ass.net
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 190b2f6..7a187da 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -185,7 +185,8 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_group_exit",
 		"stop_this_cpu",
 		"__invalid_creds",
-               "cpu_startup_entry",
+		"cpu_startup_entry",
+		"__ubsan_handle_builtin_unreachable",
 	};
 
 	if (!func)
