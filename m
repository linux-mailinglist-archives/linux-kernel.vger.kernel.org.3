Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695EE59BC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiHVJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiHVJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDAC13DC8;
        Mon, 22 Aug 2022 02:08:36 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:08:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661159315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ma56cxir0v02N0F6KOviPaOZXGv046jNuSJ4KvoXwgg=;
        b=AGk3VI8jVcWEnQlBJVojNR1W3GQew5r0XOE4pmXdZZLioqBBSwy3DIWD6ugslvHNqBmGGr
        KNEOWYBjz6zDu2RL7LGc+C8G/JgQ8pBawYEHGoWU9gPHWRsT9l9eOWfx+tBxpWeyWrz+PP
        DUVnaDmv1+rGBq2sZKAYuaGK+XilEYeOF4HjhwW2BNee3Fozqo6wjWNVoYtRo1sbq+MmPQ
        XX7kq5BwLE7oecRmvmtLsUJ3d0xpPKJahjnMWe1cxVxXoO05y1urRQFKvGX59bPANZ07WA
        j3jhCWNK1nYbz6A0wYRp/zAVrQW34FZtN4ErKx9tpeSNbEqW1wg8MSJivnABpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661159315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ma56cxir0v02N0F6KOviPaOZXGv046jNuSJ4KvoXwgg=;
        b=G4zwX+wGTo8fVZU0t5X+8K9pdlxtXqo8CdUeqLN8dScYPs3IvTYlnl3Ms3pHwrrFqrh1IG
        TVJQEFV3XjV/ZNDg==
From:   "tip-bot2 for Chen Zhongjin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use arch_jump_destination() in
 read_intra_function_calls()
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818014553.220261-1-chenzhongjin@huawei.com>
References: <20220818014553.220261-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Message-ID: <166115931419.401.6469534927439670416.tip-bot2@tip-bot2>
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

Commit-ID:     7b3e31869081771c63c3d006347ad06738f843b5
Gitweb:        https://git.kernel.org/tip/7b3e31869081771c63c3d006347ad06738f843b5
Author:        Chen Zhongjin <chenzhongjin@huawei.com>
AuthorDate:    Thu, 18 Aug 2022 09:45:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 19:47:56 +02:00

objtool: Use arch_jump_destination() in read_intra_function_calls()

Use arch_jump_destiation() instead of the open-coded 'offset + len +
immediate' that is x86 specific.

Avoids future trouble with other architectures.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220818014553.220261-1-chenzhongjin@huawei.com
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74d..b012d98 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2233,7 +2233,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 		 */
 		insn->type = INSN_JUMP_UNCONDITIONAL;
 
-		dest_off = insn->offset + insn->len + insn->immediate;
+		dest_off = arch_jump_destination(insn);
 		insn->jump_dest = find_insn(file, insn->sec, dest_off);
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find call dest at %s+0x%lx",
