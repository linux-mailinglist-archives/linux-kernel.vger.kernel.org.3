Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0574EA13D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiC1UQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiC1UQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:16:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F34275D1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZitBryn1WWy4JC7Ax6HzXQemEGIW1dW2lNZC6FYpefM=; b=h9J6gWtLbizs6hZuyeiUFCZt9S
        M7+uGk9gFt1AUqZ+rZr6C50cqtp71mwK1jLFnu/x/ZSRFilHkJ9F8Q+K2fTa0/wThEgGwa2zizyOn
        n5uih2fP9/k0FZqcH3T1E/cQUMYidFqRAuaY/pfcwn8UMc544S7ODH108we8ti0HhGXm/nfkwnCnY
        vZ5n9HPQV4tgSe4jTE6eC54JwuakFMJ6kNpDNJERz4/xAZhdrjmjEnxXTVEncoGCamVAjCgIf2cuc
        tKHPR11SOnEK20xSqAsguvwtFqo9cvS9H5DqX7HdYDND/RgjFER3lVwGshCYP/GU64CKlhz9WrOyR
        ocVsy/Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYvlC-00HENY-2D; Mon, 28 Mar 2022 20:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0997B3000E6;
        Mon, 28 Mar 2022 22:14:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEBCE203E586A; Mon, 28 Mar 2022 22:14:38 +0200 (CEST)
Date:   Mon, 28 Mar 2022 22:14:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <YkIXLnAxtPuSDcOW@hirez.programming.kicks-ass.net>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328195920.dqlfra3lcardko6r@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:59:20PM -0700, Josh Poimboeuf wrote:

> I'm not making any major changes to the code, just shuffling things
> around to make the interface more modular.  I hope to have something
> soon (this week).  Peter recently added a big feature (Intel IBT) which
> is already in -next.

Hit Linus' tree yesterday :-)

> Some years ago Kamalesh Babulal had a prototype of objtool for ppc64le
> which did the full stack validation.  I'm not sure what ever became of
> that.

I've also heard chatter about s390.

> FWIW, there have been some objtool patches for arm64 stack validation,
> but the arm64 maintainers have been hesitant to get on board with
> objtool, as it brings a certain maintenance burden.  Especially for the
> full stack validation and ORC unwinder.  But if you only want inline
> static calls and/or mcount then it'd probably be much easier to
> maintain.

IIRC the major stumbling block for arm64 is the whole jump-table thing.
Either they need to rely on compiler plugins to provide objtool that
data (yuck, since we support at least 2 different compilers), disable
jump-tables (yuck, for that limits code-gen just to please a tool) or
use DWARF (yuck, because build times).

There was a little talk about an impromptu 'abi' to communicate
jump-table details to objtool without going full on DWARF, but that
seems to have hit a dead end again.
