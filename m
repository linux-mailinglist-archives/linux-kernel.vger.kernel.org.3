Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AA507ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357594AbiDSULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357148AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4D3C731;
        Tue, 19 Apr 2022 13:08:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPA42ChuTlOaSKtgc0k0MGM0iE9m59AeUtQErq5CWog=;
        b=44KlVQjV1OpCfNtY+ngn85ulPCc7pmGigVEuRC6YLl4bbhTFBwXsAbDJPLD8K4Wvm89Hu8
        l3ce3+SL4vSmxBtMUbebz+CFvUUdfy+MraSRGIJb2zT+nkMw1sIRUWv4x8GAcvNLgZFmr7
        gPfZRAkbUhlfli17sZx5zl6c3F4dgozkr8A2OzuYnJta/r+4Y84L3RG+Ev6RAEofTc3vJ4
        Uzbc60w4aHVlQMxAhLTVzteW2RslZCZGEoI7BFg3cQ8A6jgfVTdt1FPGuNObEzyLrPbsxa
        Wvc54tqwIq0eGcWLOB4QGoyJPgg802RsJ0F8Z9wmfiRkqkvbKYMi9w7xyqRKsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPA42ChuTlOaSKtgc0k0MGM0iE9m59AeUtQErq5CWog=;
        b=m79/fhyIKk8kxiI0RssEwnET3SbzdhcPvXw0TapoKbyC4iQVR+qGtuxlIzhgla/exAQURZ
        StVa9yV0aQY476CA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,objtool: Explicitly mark idtentry_body()s tail
 REACHABLE
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408094718.441854969@infradead.org>
References: <20220408094718.441854969@infradead.org>
MIME-Version: 1.0
Message-ID: <165039892139.4207.18081241946662720260.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d66e9d50ea5cd76b2c4875c758efad665283d7ad
Gitweb:        https://git.kernel.org/tip/d66e9d50ea5cd76b2c4875c758efad665283d7ad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Apr 2022 11:45:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:48 +02:00

x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE

Objtool can figure out that some \cfunc()s are noreturn and then
complains about certain instances having unreachable tails:

  vmlinux.o: warning: objtool: asm_exc_xen_unknown_trap()+0x16: unreachable instruction

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220408094718.441854969@infradead.org
---
 arch/x86/entry/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48..73d9585 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -337,6 +337,9 @@ SYM_CODE_END(ret_from_fork)
 
 	call	\cfunc
 
+	/* For some configurations \cfunc ends up being a noreturn. */
+	REACHABLE
+
 	jmp	error_return
 .endm
 
