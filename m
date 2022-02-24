Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCB4C27BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiBXJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBXJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:11:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9E1A02B5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8RvNia9Hw9E1ELsaDTDybH4NfpZAf2KyeUgPWqGrwNs=; b=BdQjU3TfxuEPwkn4tLPda20a8o
        +crCScUbqkGkQur4UWDLX20ob2jysVHJAS4toyI8tYpOLa6R+mMSDtXzIxgpJb2edPo1Ln0Mn+bsg
        yVRDCA39MOyANyUMTSGZD9mdRf8FSYHdJTHih2217/MWJfXecYuQ+pQDSwlTUC5fP+kDOolnyJQxY
        kUuQqLewa+02iynmP/C+3KaKRFXGz7PYjBE9x6yD3TUgkfUgwfZpAGqf+/KRCDrdSjfHG5PG8njrC
        /61wFNKhL+e9bLX8eavLjIOdK4FlW+S6gk+v/r1xncurasNeT8r5gCgSBu2tQJk2WxnQFb3JgzW8k
        2jYpwz8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNA8b-004cPW-Ei; Thu, 24 Feb 2022 09:10:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4418C300470;
        Thu, 24 Feb 2022 10:10:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 215EB2C7EA795; Thu, 24 Feb 2022 10:10:12 +0100 (CET)
Date:   Thu, 24 Feb 2022 10:10:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     x86@kernel.org, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 24/29] x86/text-patching: Make text_gen_insn() IBT aware
Message-ID: <YhdLdMiVgeYOGP/H@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.990016403@infradead.org>
 <5c77889ca6b988b0dff65136264bd1fb@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c77889ca6b988b0dff65136264bd1fb@overdrivepizza.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 05:18:04PM -0800, Joao Moreira wrote:
> > +#ifdef CONFIG_X86_IBT
> > +	if (is_endbr(dest))
> > +		dest += 4;
> > +#endif
> 
> Hi, FWIIW I saw this snippet trigger a bug in the jump_label infra where the
> target displacement would not fit in a JMP8 operand.

Bah, I was afraid of seening that :/

> For these cases perhaps we can verify if the displacement fits the operand
> and, if not, simply ignore and lose the decode cycle which may not be a huge
> problem and remains semantically correct. Seems more sensible than padding
> jump tables with nops. In the meantime I'll investigate clang's behavior and
> if it is really a bug, I'll work on a patch.

Urgh, trouble is, we're going to be re-writing a bunch of ENDBR to be
UD1 0x0(%eax),%eax, and you really don't want to try and execute those.


