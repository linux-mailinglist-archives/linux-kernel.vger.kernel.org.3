Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CDE58DD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbiHIRg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245604AbiHIRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:36:47 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76E252AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:36:43 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 17A38308CE0;
        Tue,  9 Aug 2022 19:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660066601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whJ8JdfyDmkVHTS7IW0UaNVlONqZJHPYMWt03zZsZbY=;
        b=W1XMXk3a7QpeAH/rxCzm0kWh2//sPRluPe7v5CfdaSrXnrX+lMxZmRvAfLTR1eqfcyoV7T
        KTW+7fbe1/m+QeOTMQSxPkXcOuqS8UShCBKVt7zaNfsIpts3lxLx9LAbhRcPIDjxuj8Fyq
        dgalPf8VFX5WxDUaFpP4+SqlOLtgYSA4MX+Kmjo02wF+Cg67tcDfbu1xlSiolC/6EtGuk/
        7rMBmjsCR7CMXFCWQCE4oDdZIgTtYKt1VI6wIbx9Bcl2lXWYNr6iMtqQfBO1g0Psbvdwgc
        PGqxTiz++yUjtMMmWTbZdNV0+IGIDSnPgjOPg+2JpHnObbvTmQDnFax6G5gfnA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 2/3] lib/cpumask: add inline cpumask_next_wrap() for UP
Date:   Tue,  9 Aug 2022 19:36:34 +0200
Message-Id: <e2d40f6ab6758d11054c40272457d164f201d987.1660066581.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660066581.git.sander@svanheule.net>
References: <cover.1660066581.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the uniprocessor case, cpumask_next_wrap() can be simplified, as the
number of valid argument combinations is limited:
    - 'start' can only be 0
    - 'n' can only be -1 or 0

The only valid CPU that can then be returned, if any, will be the first
one set in the provided 'mask'.

For NR_CPUS == 1, include/linux/cpumask.h now provides an inline
definition of cpumask_next_wrap(), which will conflict with the one
provided by lib/cpumask.c.  Make building of lib/cpumask.o again depend
on CONFIG_SMP=y (i.e. NR_CPUS > 1) to avoid the re-definition.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/linux/cpumask.h | 19 +++++++++++++++++++
 lib/Makefile            |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d8c2a40f8beb..bd047864c7ac 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -262,7 +262,26 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
 		(cpu) < nr_cpu_ids;)
 
+#if NR_CPUS == 1
+static inline
+unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+{
+	cpumask_check(start);
+	if (n != -1)
+		cpumask_check(n);
+
+	/*
+	 * Return the first available CPU when wrapping, or when starting before cpu0,
+	 * since there is only one valid option.
+	 */
+	if (wrap && n >= 0)
+		return nr_cpumask_bits;
+
+	return cpumask_first(mask);
+}
+#else
 unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+#endif
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
diff --git a/lib/Makefile b/lib/Makefile
index c95212141928..5927d7fa0806 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,9 +34,10 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o cpumask.o
+	 buildid.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
+lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
-- 
2.37.1

