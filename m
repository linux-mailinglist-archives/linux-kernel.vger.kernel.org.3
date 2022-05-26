Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775E534DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbiEZLDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiEZLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC9CEBB1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ahCkEUxJhRK4hVH+4uEu4Zy1YkpDUahrDlA6QHnqYn8=; b=VBE83Hd4eytECO94kruW1UuKSc
        2WI3mvsU/TIWy8PuSiezJKbYSVu2vrql7iDaYT9vR22bxcXupaeD6bGmbN75ZXokikrHgKGVbFMrM
        FTWGjHlJDlRgS+q28NyFrsn5MDRRUn/Bcfb2+26JX2xQjr3/Zd3k+4AUDgBbFrLx1920YCNiBtlWj
        jmWb+ohJoYo8MAcRjGlsN691mXZgBGrzZK/OfrK5LqlqyPAb0vcp0TX0N55A7vLTD6JV1pgwEFbvO
        v/sgzlDvd21SIW56whktjMdaGO+qO3KdS+KYriZxBVboad6LrOgcSu0hl7UND/ORRyXZ7+c1NH3Jk
        T9JS6Fbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001Bjo-5l; Thu, 26 May 2022 11:02:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 932EE30031D;
        Thu, 26 May 2022 13:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6B11E202C3166; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105957.754830839@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: [PATCH 1/7] x86/entry: Anchor annotation
References: <20220526105252.440440893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64-allmodconfig gives:

  vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0: ANNOTATE_NOENDBR on ENDBR

This is due to:

	ANNOTATE_NOENDBR
SYM_CODE_END(entry_SYSENTER_compat)
SYM_CODE_START(entry_SYSCALL_compat)
	UNWIND_HINT_EMPTY
	ENDBR

And the hint then landing on the first instruction of the next symbol,
which happens to be ENDBR. Stick in an int3 to anchor the annotation
in the previous symbol.

Fixes: 3e3f06950434 ("x86/ibt: Annotate text references")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64_compat.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -124,6 +124,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR // is_sysenter_singlestep
+	int3
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*


