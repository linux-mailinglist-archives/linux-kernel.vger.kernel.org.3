Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B410C4EE486
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiCaXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCaXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF811176E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D0961678
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A808C340F0;
        Thu, 31 Mar 2022 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648768240;
        bh=NFb+yNIhAxcRdBorraIvjMJj3Pb3rD3DRavPneZciXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpAoQc5tibdSPze61eO+ml/nhHrCu7L/Zg0WX7RePjr1D8i8XGzYKWY3sY8MCmZYA
         Bc5TpEcH2UU/sLbnu0eU9AdfAXm5vNwuEkeVcuxfNkRV8j4P+pb7XPdaYqJZQMrDgj
         db/uCXp9mbc4kijnsqmFfPgJKeyCF1AO9s6YqVLQ=
Date:   Thu, 31 Mar 2022 16:10:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [hnaz-mm:master 29/122] arch/arm64/kernel/stacktrace.c:289:13:
 error: implicit declaration of function 'task_scs' is invalid in C99
Message-Id: <20220331161039.7ea889841228fa36e8387b93@linux-foundation.org>
In-Reply-To: <202203312049.zLjHyetm-lkp@intel.com>
References: <202203312049.zLjHyetm-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 20:59:49 +0800 kernel test robot <lkp@intel.com> wrote:

> >> arch/arm64/kernel/stacktrace.c:289:13: error: implicit declaration of function 'task_scs' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>            scs_base = task_scs(current);
>                       ^

Thanks.   Presumably this:

--- a/arch/arm64/kernel/stacktrace.c~arm64-implement-stack_trace_save_shadow-fix
+++ a/arch/arm64/kernel/stacktrace.c
@@ -213,6 +213,7 @@ noinline notrace void arch_stack_walk(st
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
 
+#ifdef CONFIG_SHADOW_CALL_STACK
 static const struct {
 	unsigned long ** __percpu saved;
 	unsigned long ** __percpu base;
@@ -293,3 +294,4 @@ out:
 	preempt_enable();
 	return len;
 }
+#endif		/* CONFIG_SHADOW_CALL_STACK */
_

