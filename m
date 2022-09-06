Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24B25AE0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiIFHLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiIFHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:11:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0D15A2A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:11:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF2561F941;
        Tue,  6 Sep 2022 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662448284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nsa+Xk7ccNocnMo8ZzvArXUWJOMS6sKd/z3w63CgUwQ=;
        b=CNP8t/2cBeTANtQkWg5Fi8aBZRXpZpJqQm/crunaBgTestXpryd/Hj/FZ/Z97A2b3R49zG
        wQq3y7e7TafGgwbjSJAL+iH5nvVB9nDQ1A14HAirkaWxyVkxV1R3e+92PrWgpQyv/f3mHz
        DTJFUitbpoiVcswVHFCENDMQMDzqFek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662448284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nsa+Xk7ccNocnMo8ZzvArXUWJOMS6sKd/z3w63CgUwQ=;
        b=O9I7f8BKrZOy41ZO1ANOl0kVJ10L0ZDdxey7U7vO/jcEKDtZ7/BySlx1qeHXtqPs3aG6ri
        9hMEbfjNAtgGL5Ag==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A6242C141;
        Tue,  6 Sep 2022 07:11:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@suse.de
Cc:     tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Mossberg <mark.mossberg@gmail.com>
Subject: [PATCH] x86/dumpstack: Don't mention RIP in "Code:"
Date:   Tue,  6 Sep 2022 09:11:23 +0200
Message-Id: <20220906071123.558-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
References: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 238c91115cd0 ("x86/dumpstack: Fix misleading instruction pointer
error message") changed the "Code:" line in bug reports when RIP is an
invalid pointer. In particular, the report currently says (for example):

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  RIP: 0010:0x0
  Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.

That "Unable to access opcode bytes at RIP 0xffffffffffffffd6." is
quite confusing as RIP value is 0, not -42. That -42 comes from
"regs->ip - PROLOGUE_SIZE", because Code is dumped with some prologue
(and epilogue).

So do not mention "RIP" on this line in this context.

Cc: Mark Mossberg <mark.mossberg@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afae4dd77495..b3dba35f466e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -128,7 +128,7 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 		/* No access to the user space stack of other tasks. Ignore. */
 		break;
 	default:
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		printk("%sCode: Unable to access opcode bytes at 0x%lx.\n",
 		       loglvl, prologue);
 		break;
 	}
-- 
2.37.3

