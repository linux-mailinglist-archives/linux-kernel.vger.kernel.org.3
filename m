Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36904FA120
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiDIBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiDIBaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0610EDD6;
        Fri,  8 Apr 2022 18:27:35 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xf32lnrz/WwoOm86DK6KgwZxq+kehH2JYzD+BOgTO2o=;
        b=ITLsfZis23Ta4eDfLeYyn2M395vMBNHnlzMan3nMKjQJ8GW0GxIksJ4cZE1rpNVmBfQLh3
        SzLgOetcSk6JSIFsqDhbI04L+q7dZzGe/gtXxTwyMorLAIztNIymhJNFKgJTAG7YqL2/1K
        JLE2tEkrmLqYfhRNoXKETWcSHo9Wq4qhBYrQalgJU3crt1mh04jIcYbfz+QDVGcPZ/c8lw
        8rX0JTBoQM2TGjKo+A8ZDoijXUuOs2G3ew/o+UVnlDmOiQAOTD3RYr/1eNqog+sK5bPT5x
        fYwzmMhKsDJ07O2DXMQbywck9dR/6nrqR5V6wU+yFRTCklDUj5Er0GOwfuI/Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xf32lnrz/WwoOm86DK6KgwZxq+kehH2JYzD+BOgTO2o=;
        b=kfeAJOQrqTt7dQcbUoh1bzYzxymYJZ2ZTxVn/uhmSdv9tYsPTz+R+1GwyCwpOD7O7UZCxt
        yRVtqedjgaKwqvBw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86: Adjust types used in port I/O helpers
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-14-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765283.4207.12958160887364079238.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     15104de122a4f0258981b06ed94cf616a6eb03ef
Gitweb:        https://git.kernel.org/tip/15104de122a4f0258981b06ed94cf616a6eb03ef
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:22 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86: Adjust types used in port I/O helpers

Change port I/O helpers to use u8/u16/u32 instead of unsigned
char/short/int for values. Use u16 instead of int for port number.

It aligns the helpers with implementation in boot stub in preparation
for consolidation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-14-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/io.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6d91ec..638c1a2 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -258,37 +258,37 @@ static inline void slow_down_io(void)
 #endif
 
 #define BUILDIO(bwl, bw, type)						\
-static inline void out##bwl(unsigned type value, int port)		\
+static inline void out##bwl(type value, u16 port)			\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
 }									\
 									\
-static inline unsigned type in##bwl(int port)				\
+static inline type in##bwl(u16 port)					\
 {									\
-	unsigned type value;						\
+	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
 		     : "=a"(value) : "Nd"(port));			\
 	return value;							\
 }									\
 									\
-static inline void out##bwl##_p(unsigned type value, int port)		\
+static inline void out##bwl##_p(type value, u16 port)			\
 {									\
 	out##bwl(value, port);						\
 	slow_down_io();							\
 }									\
 									\
-static inline unsigned type in##bwl##_p(int port)			\
+static inline type in##bwl##_p(u16 port)				\
 {									\
-	unsigned type value = in##bwl(port);				\
+	type value = in##bwl(port);					\
 	slow_down_io();							\
 	return value;							\
 }									\
 									\
-static inline void outs##bwl(int port, const void *addr, unsigned long count) \
+static inline void outs##bwl(u16 port, const void *addr, unsigned long count) \
 {									\
 	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
+		type *value = (type *)addr;				\
 		while (count) {						\
 			out##bwl(*value, port);				\
 			value++;					\
@@ -301,10 +301,10 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 	}								\
 }									\
 									\
-static inline void ins##bwl(int port, void *addr, unsigned long count)	\
+static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 {									\
 	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
+		type *value = (type *)addr;				\
 		while (count) {						\
 			*value = in##bwl(port);				\
 			value++;					\
@@ -317,9 +317,9 @@ static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 	}								\
 }
 
-BUILDIO(b, b, char)
-BUILDIO(w, w, short)
-BUILDIO(l, , int)
+BUILDIO(b, b, u8)
+BUILDIO(w, w, u16)
+BUILDIO(l,  , u32)
 
 #define inb inb
 #define inw inw
