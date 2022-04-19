Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F65507AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiDSULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356897AbiDSULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020539172;
        Tue, 19 Apr 2022 13:08:38 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUsQRUynxwE6aIVskGFZYHhGJAmT1WprsF9+cnYba2M=;
        b=Aa4IOSb5QUUOiJm63N8W7YUdwcsDbVp9IFpXVT9QWP9B4GXR5BOKs1ubfBQgIisMwcJuVz
        cWWfIz+yw7GSpaMq2eAnxF+i9e4C6wQiOPYTIpbckiiJJ1JYNXsUYyHbQJeR/NLBkxSCFL
        e3cP13xBghv5JpvyH/aeDSRSfRP6eH2veykrjxZgrUkJoNTYrsZTLZs4edleVop9rHRpK2
        IKwd1SBvRvNeuGLUS3TBvIYlchb/kzYUg6jJzyoahANg4GFiaZkXAnAAKc/8oLab/9Yprn
        XwRyxwx+NVLhzFOO6IjmO6Z35gWNwNQXc43UTVOgLAOfSDvQtm2y8z8ftC2mXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUsQRUynxwE6aIVskGFZYHhGJAmT1WprsF9+cnYba2M=;
        b=RP65PgRA4EMKNNsEtl01Z1ClvBbFGpbMM60mt8l8zl04YhsZFfvZOzQsizJPfP/j5t36oM
        xhA9RMoNn8MZMPDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Print data address for "!ENDBR" data warnings
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <762e88d51300e8eaf0f933a5b0feae20ac033bea.1650300597.git.jpoimboe@redhat.com>
References: <762e88d51300e8eaf0f933a5b0feae20ac033bea.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891592.4207.1506577697956201551.tip-bot2@tip-bot2>
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

Commit-ID:     4baae989e638e9bf4b7d29bc5e36b581fddcca52
Gitweb:        https://git.kernel.org/tip/4baae989e638e9bf4b7d29bc5e36b581fddcca52
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:50 +02:00

objtool: Print data address for "!ENDBR" data warnings

When a "!ENDBR" warning is reported for a data section, objtool just
prints the text address of the relocation target twice, without giving
any clues about the location of the original data reference:

  vmlinux.o: warning: objtool: dcbnl_netdevice_event()+0x0: .text+0xb64680: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Instead, print the address of the data reference, in addition to the
address of the relocation target.

  vmlinux.o: warning: objtool: dcbnl_nb+0x0: .data..read_mostly+0xe260: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Fixes: 89bc853eae4a ("objtool: Find unused ENDBR instructions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/762e88d51300e8eaf0f933a5b0feae20ac033bea.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e3a675d..b822a6d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3817,11 +3817,8 @@ static int validate_ibt(struct objtool_file *file)
 			struct instruction *dest;
 
 			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr) {
-				warn_noendbr("data ", reloc->sym->sec,
-					     reloc->sym->offset + reloc->addend,
-					     dest);
-			}
+			if (is_data && dest && !dest->noendbr)
+				warn_noendbr("data ", sec, reloc->offset, dest);
 		}
 	}
 
