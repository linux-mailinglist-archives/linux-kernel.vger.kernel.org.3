Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9257337F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiGMJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiGMJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:50:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCBEF6837
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:50:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D185B33AB2;
        Wed, 13 Jul 2022 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657705850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cLqF9b/idfjjmBVHpl66HKFXX47ckAo/g2nKjU6yJY=;
        b=EBbFm7h3uKOXK69EOLNZqpXjpToKxOCRB6kQduEM5m8GB2NJx7PV8hTqiLNO41OeBGbb+U
        WOmDRxbcv4Wm+h/MAh4aZE+nLTl+3i7j+pvsP19ZRvN057HZW5Y98/uKxGg43YwyDeaaLm
        nZWqb3mVj3MB6xSjyqUDrdArvC6E6AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657705850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cLqF9b/idfjjmBVHpl66HKFXX47ckAo/g2nKjU6yJY=;
        b=6piFxlNhqABKztsI4IU7WR+vUxnCL6LEavG0Kdc1l4Y5tX2Jowk9qkyVkq2a7L6NvV1Opv
        1bvMecZTmQpp9IBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FBD42C141;
        Wed, 13 Jul 2022 09:50:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] x86/asm/32: fix ANNOTATE_UNRET_SAFE use on 32bit
Date:   Wed, 13 Jul 2022 11:50:46 +0200
Message-Id: <20220713095046.26737-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <Ys6OiDQCuP072GCX@nazgul.tnic>
References: <Ys6OiDQCuP072GCX@nazgul.tnic>
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

The build on x86_32 currently fails after commit 9bb2ec608a20 (objtool:
Update Retpoline validation) with:
arch/x86/kernel/../../x86/xen/xen-head.S:35: Error: no such instruction: `annotate_unret_safe'

ANNOTATE_UNRET_SAFE is defined in nospec-branch.h. And head_32.S is
missing this include. Fix this.

Fixes: 9bb2ec608a20 (objtool: Update Retpoline validation)
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/kernel/head_32.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index eb8656bac99b..9b7acc9c7874 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -23,6 +23,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/percpu.h>
 #include <asm/nops.h>
+#include <asm/nospec-branch.h>
 #include <asm/bootparam.h>
 #include <asm/export.h>
 #include <asm/pgtable_32.h>
-- 
2.37.0

