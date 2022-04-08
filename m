Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197024F9233
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiDHJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiDHJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:49:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6553B7C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HcbEHtQfU+y0zKzAgOWDf8z7QQbUgeOzE9rx4KsC4T8=; b=SOAuvH914GmZGCcg9L5In6zEM+
        N+z3d1F6twAK9PzIogLZ8qV5g1b/yXgjljw0+EoZFcJP1NZ7b+vxGZl0xEc56duJsdEVuEYl5hxSZ
        CAT82aCziFSOsw71mJlkKOkyyhULT5gwDu4hQt8YJbXuWmLJuoaW3EQJczRUGkHezjaGO6pWB8U9e
        yd9VYfjb8Up6XKHRHGvagkuwEN2bqrOD4Y9Bdf45azM03fMPvt1GHf+K6Svn9VrWbqK1WTcMgTqLG
        W2dmbqAtLpj0f8o65dgxMjUOHR457mIF0g2f5vA1aSMd5++ACuzhRREOyMnhCuxmG4RaOhgsoNxQH
        4+Uzs2tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nclDW-009h0l-G3; Fri, 08 Apr 2022 09:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E5E2300859;
        Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ACD0226718E96; Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Message-ID: <20220408094552.432447640@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Apr 2022 11:45:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, jpoimboe@redhat.com
Subject: [PATCH 0/4] objtool: Fixes
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various objtool whinges:

  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x33: call to do_strnlen_user() with UACCESS enabled
  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33: call to do_strncpy_from_user() with UACCESS enabled

  vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable
  vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
  vmlinux.o: warning: objtool: asm_exc_xen_unknown_trap()+0x16: unreachable instruction

