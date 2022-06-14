Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E154BDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbiFNW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiFNW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:27:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2815712;
        Tue, 14 Jun 2022 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJr/fmSdEUSj6RNS8UsQWtv/38YJNaYwQGOi8xjnmhk=; b=csmfMYpeqiFH61nyMnTC1wjmny
        4PoLkBeX5DASAjEJOMgudvSheddDCYi/tRmIXsLGe2pqXWBea9nc91IauraULMBMz58B2WzN+otQu
        YV6GGJit+9Td+Zf96TVE8ermReBzP/tn5wQvjP+hY4UQwhJSO+AUNzehkeoLredjE0U6+pWVnfKxt
        M8+j9dGLmObynPegX+ZbCRRPKuLWFn+ekkkwyRavaOicWmAkbX4797DzrSQx5QbdVab08LmnUfNFZ
        MCNim1faGLMm66QvBjvc9H3+X6al2k8bbD+3a65OlDsfjqsO2S93tDn8NkuZ7stvndGFhNAm4fjjD
        lvK+A2Zw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1F0K-007xuf-1X; Tue, 14 Jun 2022 22:27:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 160E030008D;
        Wed, 15 Jun 2022 00:27:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01CFC26642EEC; Wed, 15 Jun 2022 00:27:17 +0200 (CEST)
Date:   Wed, 15 Jun 2022 00:27:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
Message-ID: <YqkLRSBaeb6U1ngW@hirez.programming.kicks-ass.net>
References: <20220614144853.3693273-1-glider@google.com>
 <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAKwvOd=SotrVcZshzGzsMprkORkVXFwYc-3mREkJSDCQ1nvbFw@mail.gmail.com>
 <CAHk-=wgmezfDP_b93_Hw090vUd-TKb-odZNPhB9L_2vL5pn6kQ@mail.gmail.com>
 <CAKwvOd=C1GC09zobqLK0higE3xPpghWBbB4xujyC8-QDyd_DTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=C1GC09zobqLK0higE3xPpghWBbB4xujyC8-QDyd_DTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:08:33AM -0700, Nick Desaulniers wrote:

> One thing I'm curious about; if you have an aggregate in C (struct or
> array) and don't fully initialize the whole object, just
> members/sub-objects, but only use those I assume that's not UB? (Which
> is what my maybe_init example does).  I think that's fine.

Perf does something like that. We only explicitly initialize the first
cacheline of a structure because that's *always* used. Any other field
will only be initialized on request.

At the time (and i've not benchmarked this in a good few years) that was
a significant performance win.
