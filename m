Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8E4F9D92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiDHTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiDHTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:16:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11042BCB8;
        Fri,  8 Apr 2022 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i7yMGdudCtk4V5KXA9i8QId3yMTCmugDvZV+rOd5YTs=; b=POu619hCd/gRvJXecmp9CKGG40
        bqxiQQ3Ci2VVQJw/A6gOLapVC5iqEJdJ+Kq/onNY0HIrAIxBNlmJE1gzySPSbTz/DWKEA6vulyC1v
        u9+3FqjjC6h6rPRxqvFZRMsSbjxYA2HrRQdYx258C/04fStqiwU2C0pdfDtOaEOveStdQNT7vGuW4
        aBILc578cB8e0eTK+j/T1CHo7nKCIQhhhxbEE+KQkiLGaiw4PZY69EbBtb9YqIrid8UpnqrP7CKy5
        Z3EWDRd7HJLhY+w7KoLRZsN8+EC8kaPMdD1fnwAdAGsjq4oAPYt343ikgDTbGENV67Aez3zUmkl3Q
        gCeCLdAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncu45-00A5Vf-01; Fri, 08 Apr 2022 19:14:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E587D300130;
        Fri,  8 Apr 2022 21:14:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A70EF2B5A5C49; Fri,  8 Apr 2022 21:14:35 +0200 (CEST)
Date:   Fri, 8 Apr 2022 21:14:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net>
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 03:29:21AM +0900, Masahiro Yamada wrote:
> Is [2] caused by dead code that was not optimized out
> due to the unusual inlining decisions by the compiler ?

The complaint is due to SMAP validation; objtool will scream if there's
a CALL in between STAC/CLAC. The thinking is that since they open a
security window, we want tight code between them. We also very much
don't want tracing and other funnies to happen there. As such, any CALL
is dis-allowed.

This weird option is having us upgrade quite a few 'inline' to
'__always_inline'.
