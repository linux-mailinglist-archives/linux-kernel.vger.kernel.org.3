Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B4E4F2C83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354362AbiDEKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320B17040;
        Tue,  5 Apr 2022 01:29:03 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nxx2Wto6f2mz0XCSsSZ+6fkmOz447qGXO8hO/llqmMc=;
        b=W8wmjmRe6E62Nimh/DLGGw2Ucq2ff9vNzPPpH19jZCEEENA0PGEkGRmuvyVmeeleHsZLlg
        I/AzYHCJh0vlLc/OxrZ2KAyDpLrrPJlU56SZZ11+fkBcZLZbNLcbdNE/Gces9jsYUZQPx6
        62FBvVxkMFYAj1rTqNFhhW2aaNTB3x5rX3LIu6YM9lG3ZKZym0tSWZ2e9P3VhX85q68++M
        Yfi5/ZTcNqHONflTNFCTtWYAWeHMHVC9okHEEt7TIokdkKHYXZsrWP8/eE8bpROMTbmN7r
        RuFfGN5cyzsayLWkokRg+PugMb43hfkISBNylp5BgKeOmSDIdkRHlTMnkmwrGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nxx2Wto6f2mz0XCSsSZ+6fkmOz447qGXO8hO/llqmMc=;
        b=2mxeFg4e5XQkBiH+GhZ0zIBoqcvrPLYzoWNbfpEEqGh4gDBck+evAPHVKJbdl8NP3/Ge5b
        gvjAgNd0rCOcV7Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] x86,static_call: Fix __static_call_return0 for i386
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318204419.GT8939@worktop.programming.kicks-ass.net>
References: <20220318204419.GT8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164914734085.389.319468284703922010.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1cd5f059d956e6f614ba6666ecdbcf95db05d5f5
Gitweb:        https://git.kernel.org/tip/1cd5f059d956e6f614ba6666ecdbcf95db05d5f5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Mar 2022 21:24:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:37 +02:00

x86,static_call: Fix __static_call_return0 for i386

Paolo reported that the instruction sequence that is used to replace:

    call __static_call_return0

namely:

    66 66 48 31 c0	data16 data16 xor %rax,%rax

decodes to something else on i386, namely:

    66 66 48		data16 dec %ax
    31 c0		xor    %eax,%eax

Which is a nonsensical sequence that happens to have the same outcome.
*However* an important distinction is that it consists of 2
instructions which is a problem when the thing needs to be overwriten
with a regular call instruction again.

As such, replace the instruction with something that decodes the same
on both i386 and x86_64.

Fixes: 3f2a8fc4b15d ("static_call/x86: Add __static_call_return0()")
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220318204419.GT8939@worktop.programming.kicks-ass.net
---
 arch/x86/kernel/static_call.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 531fb4c..aa72cef 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -12,10 +12,9 @@ enum insn_type {
 };
 
 /*
- * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
- * The REX.W cancels the effect of any data16.
+ * cs cs cs xorl %eax, %eax - a single 5 byte instruction that clears %[er]ax
  */
-static const u8 xor5rax[] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
+static const u8 xor5rax[] = { 0x2e, 0x2e, 0x2e, 0x31, 0xc0 };
 
 static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
 
