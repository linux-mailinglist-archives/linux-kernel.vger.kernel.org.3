Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620A84F9234
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiDHJuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiDHJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:50:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE57B7C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=igXgQD/ddH49n8ibNLb/Rwn22m/d6rBnJOm1sbgeJFw=; b=Yh9xUqoQDSWBBkHsAorJeHFvc6
        nx4mzvgu4+JghEVl2iTA+IupApBBY3bVFW8cPO3MKUXTGZrFPWN3toJ1CZrmt95wT1dwMaa/LEcI9
        +YlTpjax381NWlFw72ertYIrXtQnZcRpwcx7qWMq8EQCBQXb8LoBjYhcpj8N3FH08RceTzcemGp/J
        X7WD3tqnRR1gP2gk/uyrL/YQIVGubGQK1AiyfmBA53+98lSK9kcHBPxXgDVJNa7rNFWeNZj+MhemY
        jZE19IDSwYTymhnPW+YkjOuPZVHiCPSnWVHYl7yFWA4LMWafk+bRMzsJCLi/RBdQzYVhlWlSCm0Q/
        YYG2uwnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nclDW-002rgR-71; Fri, 08 Apr 2022 09:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A49D3005DD;
        Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B96D92B38B6CB; Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Message-ID: <20220408094718.383658532@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Apr 2022 11:45:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, jpoimboe@redhat.com
Subject: [PATCH 3/4] x86,objtool: Mark cpu_startup_entry() __noreturn
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

GCC-8 isn't clever enough to figure out that cpu_start_entry() is a
noreturn while objtool is. This results in code after the call in
start_secondary(). Give GCC a hand so that they all agree on things.

  vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -167,7 +167,7 @@ static inline int suspend_disable_second
 static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
-void cpu_startup_entry(enum cpuhp_state state);
+void __noreturn cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
 


