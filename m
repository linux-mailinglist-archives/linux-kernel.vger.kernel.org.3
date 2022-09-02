Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5705AB3B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiIBOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiIBOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:30:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABDD20F4B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Mk4gyPud12Euk/9XIHAPXis5fefrr9FnQg5Sg88vnL0=; b=X7Th3/a7wdt17ojxWrABzi5Ae8
        oaJGENC29iMmbnDD3sh8vciSWHTDv2S3CaixkPjaGmC8OFjWx8NmpOqDVD0tbLjtH12mbRFODkxng
        PQo1KpOw1+NUHQnIopLOq87lu91khcWU0khwjLFicn4aOgFEtgBlxPbOp4uBsrXdnYLS39sfc+8dS
        OtT7nzeilsw5T/nJ2Ip42YCzEUjMrYtHimjs0zmUx0pgSsVeMP/JHZQpxjuwxSa9uMNQ1ZyGwiYVK
        lsebNDTOjDbP7PMGbrg1grISQc38zNKmCNsaCIvRRlR0HUz85NIXbBtvAaGEMXJEmS8wyE3fE6Qe5
        nwaLhoXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77P-008g8l-Jq; Fri, 02 Sep 2022 13:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 451CC302DA9;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A654D2B8EFB60; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130951.853460809@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 53/59] kallsyms: Take callthunks into account
References: <20220902130625.217071627@infradead.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Since the pre-symbol function padding is an integral part of the
symbol make kallsyms report it as part of the symbol by reporting it
as sym-x instead of prev_sym+y.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kallsyms.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -292,6 +292,12 @@ static unsigned long get_symbol_pos(unsi
 	return low;
 }
 
+#ifdef CONFIG_FUNCTION_PADDING_BYTES
+#define PADDING_BYTES	CONFIG_FUNCTION_PADDING_BYTES
+#else
+#define PADDING_BYTES	0
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -299,13 +305,25 @@ int kallsyms_lookup_size_offset(unsigned
 				unsigned long *offset)
 {
 	char namebuf[KSYM_NAME_LEN];
+	int ret;
+
+	addr += PADDING_BYTES;
 
 	if (is_ksym_addr(addr)) {
 		get_symbol_pos(addr, symbolsize, offset);
-		return 1;
+		ret = 1;
+		goto found;
 	}
-	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
-	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
+
+	ret = !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf);
+	if (!ret) {
+		ret = !!__bpf_address_lookup(addr, symbolsize,
+					     offset, namebuf);
+	}
+found:
+	if (ret && offset)
+		*offset -= PADDING_BYTES;
+	return ret;
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
@@ -318,6 +336,8 @@ static const char *kallsyms_lookup_build
 	namebuf[KSYM_NAME_LEN - 1] = 0;
 	namebuf[0] = 0;
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -347,6 +367,8 @@ static const char *kallsyms_lookup_build
 
 found:
 	cleanup_symbol_name(namebuf);
+	if (ret && offset)
+		*offset -= PADDING_BYTES;
 	return ret;
 }
 
@@ -373,6 +395,8 @@ int lookup_symbol_name(unsigned long add
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -400,6 +424,8 @@ int lookup_symbol_attrs(unsigned long ad
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -416,6 +442,8 @@ int lookup_symbol_attrs(unsigned long ad
 		return res;
 
 found:
+	if (offset)
+		*offset -= PADDING_BYTES;
 	cleanup_symbol_name(name);
 	return 0;
 }
@@ -441,8 +469,15 @@ static int __sprint_symbol(char *buffer,
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
-	if (add_offset)
-		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
+	if (add_offset) {
+		char s = '+';
+
+		if ((long)offset < 0) {
+			s = '-';
+			offset = 0UL - offset;
+		}
+		len += sprintf(buffer + len, "%c%#lx/%#lx", s, offset, size);
+	}
 
 	if (modname) {
 		len += sprintf(buffer + len, " [%s", modname);


