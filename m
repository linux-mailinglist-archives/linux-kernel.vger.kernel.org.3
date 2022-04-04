Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C54F1F06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358731AbiDDV5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379674AbiDDRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:48:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075AF2E9E3;
        Mon,  4 Apr 2022 10:46:51 -0700 (PDT)
Date:   Mon, 04 Apr 2022 17:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649094409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3N+jev8SrzDa0Nmjae+hY+7VOcQ8L94Nkcq/fRv8hE4=;
        b=z7uy41kdBd0niNlzn2C0RFv0woCttoi1EHX1fgBM7qwIBGn9+4EA6hqUepZBcvdrLrKTkg
        7ZHruqs8H920XnO7sMFr3wFhWEsqP5CBgJPxseE506lXofhZHM244cbYAMQIG157ZrGKQy
        ndjbCFDl0/TYodYbu2QmbhZXicNuTLUlc7vMajvVWXeLUc8TwOr+gV82WJ953b+i0Xm4GJ
        RYG10BhkpZ2yuw4wG17/rQ4z8W3TOV4EybLdtUDbv1xONYK4FsiXP4CC5UZ0PVY9FNCp1A
        JMZDXVXIPTNkEacVdoO52nogucfsEcjLBHjPcbu9wbb/9SyXYgqBCWsZGdmORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649094409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3N+jev8SrzDa0Nmjae+hY+7VOcQ8L94Nkcq/fRv8hE4=;
        b=+iXnKMOetcgyuxYv8LhjjC2kXPJRmG8C5fF33zfFpR6DU7pasO9piQ6DQF1nyxx0eopCw+
        xYwTsKHdJ8aALYDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/mm: Force-inline __phys_addr_nodebug()
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220324183607.31717-4-bp@alien8.de>
References: <20220324183607.31717-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909440815.389.8658129440289890986.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ace1a98519270c586c0d4179419292df67441cd1
Gitweb:        https://git.kernel.org/tip/ace1a98519270c586c0d4179419292df67441cd1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 23 Mar 2022 23:24:12 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:13:25 +02:00

x86/mm: Force-inline __phys_addr_nodebug()

Fix:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x8b: call to __phys_addr_nodebug() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220324183607.31717-4-bp@alien8.de
---
 arch/x86/include/asm/page_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index e9c8629..baa7045 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -16,7 +16,7 @@ extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
 
-static inline unsigned long __phys_addr_nodebug(unsigned long x)
+static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
 	unsigned long y = x - __START_KERNEL_map;
 
