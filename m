Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C25593438
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiHORyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiHORyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:54:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3528708;
        Mon, 15 Aug 2022 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXNuYNMsVlTl4n7W8GHGr1bQEFwqfgp2A0ExRIF23qk=; b=qXeNvC+T5gA3BMHrvTz7QklUoi
        zSJhfDsa/e/YFM28wZKpazCPqwXfUaLKWQmqKbkQ6uWUpHc2qXniG48txxPhRSLJg4OWt9sER60tV
        YrBPEmy07SDMpzT2YbwPSY3tcG/1esOvN5peb//b/TwWDUx6nRU3n8//5T3zm6hsnVMs3ZFp6VN6b
        Z6CoE4/2UE9Ehi8mz9zoq9uujaSDUSg0wmdapR/wgQmuzoVOcbgpJId3Z9B8OHpCMEKcnR3IHgQ07
        WA5NdTHPxSFHgeXkh9AG0ojwCik46XFa74EJ3B0q/MkNRS0ceKf38TLFEiNGR6UDUGpw050FKsrpH
        58N98aJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNeHm-002j9M-Mc; Mon, 15 Aug 2022 17:53:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DDF0980264; Mon, 15 Aug 2022 19:53:55 +0200 (CEST)
Date:   Mon, 15 Aug 2022 19:53:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Message-ID: <YvqIMyIDR334j3to@worktop.programming.kicks-ass.net>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
 <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:58:21AM -0700, Linus Torvalds wrote:

> The other question I had was actually the "return false" above - I
> decided that if the address of the fault does *not* match the expected
> "round %rdx up" address, we shouldn't do any fixup at all, and treat
> it as a regular kernel oops - as if the exception table hadn't been
> found at all.

Ah yes, I did see that and I agree, that seems like the right thing to do.
