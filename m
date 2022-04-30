Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A91515C59
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382596AbiD3Kxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380278AbiD3Kxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:53:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F126308
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EdwU7zphlaqSH4Kaj3FCs5OTnA493vLfU5D6iYHz2BU=; b=KY0tl3qYFGMbWI8thn7qu5kgmw
        6plHoqFMPaMwppYzTVopOCK8lK2tC6bYZlIfzcIcRxUaZLHkBgtcudLRaRnjvP7tLHiBOHdSjMCVH
        /vVl6G0iwciXCsfouRIbBLzoDa57aSk/bzzUznB05fqrNTgcH5o9UGX/4H32L1RomKxAdzjQGAmAE
        F9fh8adPOEJwZi4LQhAUbKTCOtsmCe5/vGPWNKsg8FADGKQtI6ROlDc/eoGqjz6DGOdAPWCnsaUh4
        utsyIFfHIZKyeSaA3/o333+7e2UnfCGBXyMAe/pFVV/pSyZYuL6lEtIyzBzKN5WzwE7SMeHONLibZ
        k/+85sBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkkfs-009tdQ-Bk; Sat, 30 Apr 2022 10:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76B57300473;
        Sat, 30 Apr 2022 12:50:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 481752028EFE6; Sat, 30 Apr 2022 12:50:02 +0200 (CEST)
Date:   Sat, 30 Apr 2022 12:50:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix SLS checks
Message-ID: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the SLS validation; not having a next instruction is also a fail
when the next instruction should be INSN_TRAP.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f6785415894..3354101ffe34 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3380,7 +3380,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_RETURN:
 			if (sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
+			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
 				WARN_FUNC("missing int3 after ret",
 					  insn->sec, insn->offset);
 			}
@@ -3428,7 +3428,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_DYNAMIC:
 			if (sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
+			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
 				WARN_FUNC("missing int3 after indirect jump",
 					  insn->sec, insn->offset);
 			}
