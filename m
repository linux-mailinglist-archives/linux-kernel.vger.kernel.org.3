Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173CF4C2F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiBXPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390D1451D0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f2j15bsQD/C+5tFPrTD411e+UBud04gHP0NJgiNY2mY=; b=nt5wXi1zK/yLMKlsZD4Y9pCfsh
        7gp336t+MufqzKBBViu6BebxpMDX3n3MqhKbLxzUTqoxTcYKhMuFVxZSZdmSAYmm+58HcYxi+zhu7
        jZCpCnUHCujM/10cpa9+oBmViQEvFwV9l3Y8PYLEYaowRJI7i7B3R5qQ7QI9XmQsirhqxHb5VLyUO
        a7iWfBlzNdPQ8T1F2NxuNOm+ji2eDuST3JUHSAjl1CUqA9L+ESQXKNuHoJDie5peuEniA82n5ARwz
        fd9dkLhn5xh/ku9CpWaLIN6HIV1o37wR2N2VUUYET5lHPXUq2STBv1vIXG3HkHhOJY9H+LPQ8b2Ke
        bAwo6P+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeLf-8q; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36C88301232;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 50A892B354781; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.776015583@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 13/39] x86/livepatch: Validate __fentry__ location
References: <20220224145138.952963315@infradead.org>
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

Currently livepatch assumes __fentry__ lives at func+0, which is most
likely untrue with IBT on. Instead make it use ftrace_location() by
default which both validates and finds the actual ip if there is any
in the same symbol.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/livepatch.h |    9 +++++++++
 kernel/livepatch/patch.c         |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -133,7 +133,7 @@ static void notrace klp_ftrace_handler(u
 #ifndef klp_get_ftrace_location
 static unsigned long klp_get_ftrace_location(unsigned long faddr)
 {
-	return faddr;
+	return ftrace_location(faddr);
 }
 #endif
 


