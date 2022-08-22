Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1259BC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiHVJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiHVJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40C120A7;
        Mon, 22 Aug 2022 02:08:35 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661159314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LjJUmQhs8JWWfXs/XFLie47/93a2JV46oxDFL6VxnU=;
        b=n5kwvX6gwsRKoxFv8mKYG66190dsLW5G0mbPkDXBW19XAMzndFcE3SnP+piIaP/kf64y/M
        cgIL0sUhzDI77Ao+4zDQ1lUXHCDmEUQby4ZnM9vDe/5qyOMd9PvULQ2C37EVcL/wbiTr40
        uhB2GEtZ5MJ3zYOViGeL+Cxqc6SCPiOLZCZep2AhS8cDlrJcE5zfuKUlgK1V2WaYOEnO0t
        wKlmFq4ReelY2bOaTzZQTpPwk4jxx3MeKJPm3gXNRzO9JgUuQaC9MzMwSH3mwX82uShDbB
        EqSafbBP/BVXKyXxwi19PnePxKIktSSGuGxyriTS0ehbzrdcwy9/luV5xWSWvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661159314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LjJUmQhs8JWWfXs/XFLie47/93a2JV46oxDFL6VxnU=;
        b=D2K7eURP+A0a0Q3o8guFviXj6LdgFfGMt+StguwZOuhDkCsYHg3n/vHyRIKmPOivlm9kFO
        lWn5Ym/Lff2upVBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove "ANNOTATE_NOENDBR on ENDBR" warning
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <142341a5dafdfc788e4c95b9e226a6eefc9b626e.1660839773.git.jpoimboe@kernel.org>
References: <142341a5dafdfc788e4c95b9e226a6eefc9b626e.1660839773.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <166115931303.401.10570900112002921632.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3c6f3900808c483b0bbb2c351f995c7b880dae14
Gitweb:        https://git.kernel.org/tip/3c6f3900808c483b0bbb2c351f995c7b880dae14
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 18 Aug 2022 09:26:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 19:47:57 +02:00

objtool: Remove "ANNOTATE_NOENDBR on ENDBR" warning

This warning isn't very useful: why would you put ANNOTATE_NOENDBR on
ENDBR, and if you did, what's the harm?

And thus far it's only found one non-bug, where the
'__end_entry_SYSENTER_compat' label happens to land on the ENDBR from
entry_SYSCALL_compat:

  vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0: ANNOTATE_NOENDBR on ENDBR

.. which is fine.  Just remove the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/142341a5dafdfc788e4c95b9e226a6eefc9b626e.1660839773.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b012d98..8b8c8f7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2102,9 +2102,6 @@ static int read_noendbr_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		if (insn->type == INSN_ENDBR)
-			WARN_FUNC("ANNOTATE_NOENDBR on ENDBR", insn->sec, insn->offset);
-
 		insn->noendbr = 1;
 	}
 
