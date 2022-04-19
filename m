Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F5507ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357578AbiDSULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356895AbiDSULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A433915B;
        Tue, 19 Apr 2022 13:08:37 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSzpPAtevF2FdGrZBozZZn3Y/G/z3LHQd+B4A9qveaU=;
        b=y1trgAHXYQCTIJl5rgPZyRYjlHnHHABqCayk95nZwsodvxotPMBunUt1s4WpttgeusRYRB
        82RPkEztkJhOetCLkcFJ2Tm+vR03VcPKb/eRyaRobgr/deqwEs/d5bTudr8FJY/x+Grhzy
        4LksJU30ZK6CDBzom1LYXkooUuIqDx7GRiTpuZkZV6XQFk4sFoA00VHHE6XWCxIUzidyWl
        b64dX0vNMrotzN1nOK2bXU+QRNLfqtQn3tRL6tU9KArTRFqGP9kWFY00fTakxwIzKUBU3c
        VOWhqmyRpe14TL6R+hizG9/Mthui1gTp9HeR6e94w2J1lVGdATwF2sT9JozdYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSzpPAtevF2FdGrZBozZZn3Y/G/z3LHQd+B4A9qveaU=;
        b=Qc9aJGpazNPbiHRCKCX8yOawh+MfXcqrjzIKnP2sjFuLcPX31135LzTTWRaLX9haIImRJU
        1Qjw8WpEAhiyqpCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Use offstr() to print address of missing ENDBR
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <95d12e800c736a3f7d08d61dabb760b2d5251a8e.1650300597.git.jpoimboe@redhat.com>
References: <95d12e800c736a3f7d08d61dabb760b2d5251a8e.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891504.4207.6288189756775964296.tip-bot2@tip-bot2>
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

Commit-ID:     1d08b92fa2c41c43e4efe9787413e9ac9a434f83
Gitweb:        https://git.kernel.org/tip/1d08b92fa2c41c43e4efe9787413e9ac9a434f83
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:50 +02:00

objtool: Use offstr() to print address of missing ENDBR

Fixes: 89bc853eae4a ("objtool: Find unused ENDBR instructions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/95d12e800c736a3f7d08d61dabb760b2d5251a8e.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b822a6d..5285edd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3211,9 +3211,8 @@ validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
 static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
 			 struct instruction *dest)
 {
-	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
-		  dest->func ? dest->func->name : dest->sec->name,
-		  dest->func ? dest->offset - dest->func->offset : dest->offset);
+	WARN_FUNC("%srelocation to !ENDBR: %s", sec, offset, msg,
+		  offstr(dest->sec, dest->offset));
 }
 
 static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
