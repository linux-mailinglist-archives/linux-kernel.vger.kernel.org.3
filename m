Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C524C10DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiBWK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiBWK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:58:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F786E4F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kHFNhk1pBpKd7mT4cZ4aG/QUwR4o59X1YOhqUE0TXP4=; b=d2whqwYNPQ3WQhrSAXPPSbYwZe
        AoU2lkSyg7Aa41HnWyaUFHfgwHr7Jhz4jDPopqZKLbx1nln/hq5iiYoGAbSz68XzkC6fdJA4tkCSZ
        76FczXcCUsamFnbnTgm8zN1gQD0z80/hSpy9bwvfK7cvFh9zxyWHpe2t/i836nIysRNv+AJiQWWb1
        eCQ2enlIvDxASZcHOoHBts54dC7GPJmI58nbWGupPKmrLHJTh6MuQV9Ln5GVmgkGXtME5hFG6xrNh
        FL2OoL1TRmDsc1gUWfvWq3WfsraXVqQQid2bgR2aUj573rajQzm73e7vvGgSAWxPdRYgqkOyOykTb
        wZZEi0KQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMpKp-00CElA-Lz; Wed, 23 Feb 2022 10:57:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4171A300454;
        Wed, 23 Feb 2022 11:57:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22B6C2B5208F0; Wed, 23 Feb 2022 11:57:26 +0100 (CET)
Date:   Wed, 23 Feb 2022 11:57:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
 <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:09:44AM +0100, Peter Zijlstra wrote:
> Yes.. so yesterday, when making function-graph tracing not explode, I
> ran into a similar issue. Steve suggested something along the lines of
> .... this.
> 
> (modified from his actual suggestion to also cover this case)
> 
> Let me go try this...

This one actually works...

---
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1578,7 +1578,23 @@ unsigned long ftrace_location_range(unsi
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		rec = lookup_rec(ip - offset, (ip - offset) + size);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -5110,11 +5126,16 @@ int register_ftrace_direct(unsigned long
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5222,6 +5243,10 @@ int unregister_ftrace_direct(unsigned lo
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
