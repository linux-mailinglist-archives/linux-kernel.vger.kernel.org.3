Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7B56B34D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiGHHUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C27B353
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1nMVtjbiz/Yr0AEPB448TuEkWvIWnr9bl4+XJj3PWUA=; b=XbPaMQfEK7hyBIb2ys5XBSSvis
        GrANZnvChoPdcGug7ovsXTWFQjDUP1LfWfTkQ6IJzOo64nT2gCVxaj/dza/3PDBxt1DKBohWixoaO
        rXGztRuYtoJH6KtF1EQvcjnChvWeFpst+dv2AjlxEDGMaLOaM22DCf7hWWHF+5FAgde8ijpwMvMZ6
        9ixlRQdej4IfvSszvy2AIag+yAZXJ0G5WBkOXAQbHa5BT5JsLg/T5+bdYduoxbuFdhynZdY0Jaw+q
        pAOUrrnixReggIuSaaYi4sEoRhZcsLPPBIG649nKVpSRBU+63Z5kYCyw+QNYMaTAuZ/qdyazhzRNm
        I2YC2IHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iHK-003Igs-12; Fri, 08 Jul 2022 07:19:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6FDA300E7E;
        Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FE48203C0435; Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Message-ID: <20220708071834.019084831@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Jul 2022 09:18:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: [PATCH 2/4] csky/tlb: Remove tlb_flush() define
References: <20220708071802.751003711@infradead.org>
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

The previous patch removed the tlb_flush_end() implementation which
used tlb_flush_range(). This means:

 - csky did double invalidates, a range invalidate per vma and a full
   invalidate at the end

 - csky actually has range invalidates and as such the generic
   tlb_flush implementation is more efficient for it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/include/asm/tlb.h |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/csky/include/asm/tlb.h
+++ b/arch/csky/include/asm/tlb.h
@@ -4,8 +4,6 @@
 #define __ASM_CSKY_TLB_H
 
 #include <asm/cacheflush.h>
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #endif /* __ASM_CSKY_TLB_H */


