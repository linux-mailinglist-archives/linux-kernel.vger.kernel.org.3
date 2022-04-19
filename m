Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A212507ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357574AbiDSULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356926AbiDSULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605723B017;
        Tue, 19 Apr 2022 13:08:39 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGixIIVK11UN71F9hsjipeVRAdDqQ6PbGBA5GynwXF0=;
        b=QF7ONBLk6nCHTCgpcArUDjj+8G7kv3pN75z0+FQ0NDIUM0j3inQNAUCuqTqO0sd2R6RoOX
        HMEiTbQ1WFggsSRvfSJpz0Krj4wd/QbEfy3705tpCKTFE2jnK+CNwT1nOcOsEDRVMmsPCI
        L8Jy3kd+DW9C0yGr6DJVHTIp5zMZcGKypvY+NyiIpWPhTA5ZpMdBfobwQ0A2Q3xoBmJ8b7
        XmGRsGQLAWBf0fkEdxoGxXb3NvTWCqq4eB6Di0N4pYP+JRc+5VvtKAJPOPQVbyHBTOPG31
        FARM90Hj9KMtT3hgiF4wkye+BYxvcVIi3HmzQxEZdAJNoziMpYWajo1kei5KGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGixIIVK11UN71F9hsjipeVRAdDqQ6PbGBA5GynwXF0=;
        b=qfxQ8/aeYhEAbJ+Q658fC3jy2i7Fv5p3oVZVy1gOMMXb7OSmPBwttadD6+Vkqda9/QtDNo
        +TjBqT3vRBlnpKAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
References: <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891679.4207.9559148503286018502.tip-bot2@tip-bot2>
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

Commit-ID:     1ab80a0da4c4a4dd496fc14faabbc8bde61a605c
Gitweb:        https://git.kernel.org/tip/1ab80a0da4c4a4dd496fc14faabbc8bde61a605c
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:49 +02:00

x86/xen: Add ANNOTATE_NOENDBR to startup_xen()

The startup_xen() kernel entry point is referenced by the ".note.Xen"
section, and is the real entry point of the VM. Control transfer is
through IRET, which *could* set NEED_ENDBR, however Xen currently does
no such thing.

Add ANNOTATE_NOENDBR to silence future objtool warnings.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lkml.kernel.org/r/a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com
---
 arch/x86/xen/xen-head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ac17196..3a2cd93 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -45,6 +45,7 @@ SYM_CODE_END(hypercall_page)
 	__INIT
 SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	cld
 
 	/* Clear .bss */
