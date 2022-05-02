Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918D516E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbiEBLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiEBLQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:16:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8626D1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IboLsRTGfsW5mAOfgWVbq8NTNwIsQlJU0nFRW/NtXfE=; b=U5qiIMSOIeVcTRivs/9mkXqVeO
        EorD5rMULKDErza5ssoI6BlhhuZrIs2tyXBh2ClHsEqYyhRDrTxFPz6h+zVW+wIaKk6cqoffQ2HOZ
        3iMy/z8Yu9RzcSmAPXDz+gjDJcKH8nwhUbFUj/u5bz2gNmMDs5Jk71Gsi0rWkMZ3lPFZq7oMNquek
        XG8qVSFuwWwR2So/JF2x+qx1aL8+mw8Ld6g8MXI0gr/5xKz6gfYsc6ZkOZV0dem5xjD3kQi0bp94L
        PcJ1gnUy/28e44sVh4v1DraANswz1A1X7DH5/i5bHLNDstPfI7cQtpyGYqiFKTcvDqqScZK0saRhH
        HPuuKfyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlTyn-00ElGQ-O4; Mon, 02 May 2022 11:12:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3876030047E;
        Mon,  2 May 2022 13:12:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E2ECF20288D0D; Mon,  2 May 2022 13:12:34 +0200 (CEST)
Message-ID: <20220502111216.350926848@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 02 May 2022 13:07:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
References: <20220502110741.951055904@infradead.org>
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

When building x86_64 with JUMP_LABEL=n it's possible for
instrumentation to sneak into noinstr:

vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/jump_label.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
-static inline int static_key_count(struct static_key *key)
+static __always_inline int static_key_count(struct static_key *key)
 {
-	return atomic_read(&key->enabled);
+	return READ_ONCE_NOCHECK(&key->enabled.count);
 }
 
 static __always_inline void jump_label_init(void)


