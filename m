Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D817B4F9235
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiDHJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiDHJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:49:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C3DF2E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YIg/+qqt+u27aRNl54+3kJ7k7fwga7cKeKGXafWjcTM=; b=cg6ALBDo2ZDh7sEV059V+1eoQi
        +3FT64Y8Mpah+mFJkACcK/Lc3DH789z18+STalV1DOCr6PMq6HRsvQuwq1zvYcpOtHLmlWw9twfhK
        jeVbsZMKXhFcH4QJIHjo5d3aQlEACFlBo2s+XVtJxuq3OWcePnlhUvrXYTaf9iWGMQzGK2y2xWquh
        XLvq2D0ugv+T0/yjKm+XCX6DLOSd1JANP2kYx0BVs7dIxrBYnFutiRx4IQSouSWJ7l8Zx0Ba3jAtN
        QNT0Ze1jB06laaNPEIT/zzK3CRwalwx2IuUhXTjVUdsECktUqYsYP86qgTD7dPgmjbaWH5RFe15we
        xfOi77ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nclDW-009h0k-Fr; Fri, 08 Apr 2022 09:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0832130031E;
        Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B46582B38B6C7; Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Message-ID: <20220408094718.321246297@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Apr 2022 11:45:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, jpoimboe@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] x86,xen,objtool: Add UNWIND hint
References: <20220408094552.432447640@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYM_CODE_START*() doesn't get auto-validated and needs an UNWIND hint
to get checked, add one.

  vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/platform/pvh/head.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -50,6 +50,7 @@
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
 SYM_CODE_START_LOCAL(pvh_start_xen)
+	UNWIND_HINT_EMPTY
 	cld
 
 	lgdt (_pa(gdt))


