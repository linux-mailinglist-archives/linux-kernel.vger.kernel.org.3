Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A65A32D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiHZXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiHZXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F861DBF;
        Fri, 26 Aug 2022 16:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A97961BD6;
        Fri, 26 Aug 2022 23:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E78C433C1;
        Fri, 26 Aug 2022 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661558152;
        bh=XX57P/MTCtZkCrNzIPCjYslur0UOJAp7ux5igGP8TC4=;
        h=From:To:Cc:Subject:Date:From;
        b=XwnTUgcIQqZkwTiSuIUBpv3lK+bfamIVSO7W0LE2Q5sC/NxHrveipp8qyjIO41qqw
         2gnPzXoZS3W5D3rhQVewyEPsxizT9v0z2bAZy0dp8i99b3tq2IB2yFFKyrP5CQL0tx
         D2o3b0PujQW3kjaDmAIUo77FZ8XR1MTtGudex+QAMRQDOQiAnBmTjtIXRmkl90qsHB
         Q2DB+4ZA9MGqFlrOhY54HGgJ00hQk1tPT9MuKjn68GAlwwHgtJhRTKTTvcZcGBA2kQ
         UrUeiuejGZsFKE/rz4oubkUrs7oJ5NBPfk3o57PkggPKsV4D13IZBW0FJXyW2VvJuH
         T/wEyw3QxzNBA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH RFC] s390: Fix nospec table alignments
Date:   Fri, 26 Aug 2022 16:55:44 -0700
Message-Id: <8719bf1ce4a72ebdeb575200290094e9ce047bcc.1661557333.git.jpoimboe@kernel.org>
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

Add proper alignment for .nospec_call_table and .nospec_return_table in
vmlinux.

Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
This is RFC because I don't know anything about s390 behavior for
unaligned data accesses, but this seemed to fix an issue for me.

While working on another s390 issue, I was getting intermittent boot
failures in __nospec_revert() when it tried to access 'instr[0]'.  I
noticed the __nospec_call_start address ended in 'ff'.  This patch
seemed to fix it.  I have no idea why it was (only sometimes) failing in
the first place.

The intermittent part of it is probably at least partially explained by
CONFIG_RANDOMIZE_BASE.  Except now I can no longer recreate it :-/

Regardless, this patch seems correct.  I just can't explain what I saw.
Any ideas?

 arch/s390/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 2e526f11b91e..5ea3830af0cc 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -131,6 +131,7 @@ SECTIONS
 	/*
 	 * Table with the patch locations to undo expolines
 	*/
+	. = ALIGN(4);
 	.nospec_call_table : {
 		__nospec_call_start = . ;
 		*(.s390_indirect*)
-- 
2.37.2

