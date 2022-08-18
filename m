Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020A45988CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbiHRQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbiHRQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:27:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898439BA2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 924AEB82218
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07D5C433D7;
        Thu, 18 Aug 2022 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660840022;
        bh=gphIi9ifMou2veCd5EsfoGNNCSHXINfos6wGCQQ+QW4=;
        h=From:To:Cc:Subject:Date:From;
        b=uTXdPVBcY0D1CpGvMDGfhlvxdNdKSMWj/qciRcreJftytwUOl8BEJXvBByR1rmq36
         JKm5Ub1bQ5CUdENHiIw9hrd6WXvE3lKGsz1Vf0L66lKxgTRFdzKDZGjo/abeOK0P+T
         232vtAn763i1zcibay7fpxf53Idm7SM/UwSR1ztJaOeb1EnL+52tLsJRQ+nwKvVGvC
         RF4VngIw5JfCNZuU69fdlvdzPhAjHvyyXftzi7ovnqRMc4vYzqfb46wGJ8fXO7qF6z
         mdjRY32zMo4U+LJ4yeHJQ+q422HXqS0ckMZAFEwTXe3oQVB1Ed7gD7yqakFTxyhXGy
         s79xH5RB8ghoA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] objtool: Remove "ANNOTATE_NOENDBR on ENDBR" warning
Date:   Thu, 18 Aug 2022 09:26:57 -0700
Message-Id: <142341a5dafdfc788e4c95b9e226a6eefc9b626e.1660839773.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning isn't very useful: why would you put ANNOTATE_NOENDBR on
ENDBR, and if you did, what's the harm?

And thus far it's only found one non-bug, where the
'__end_entry_SYSENTER_compat' label happens to land on the ENDBR from
entry_SYSCALL_compat:

  vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0: ANNOTATE_NOENDBR on ENDBR

.. which is fine.  Just remove the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..b0c65241651a 100644
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
 
-- 
2.37.2

