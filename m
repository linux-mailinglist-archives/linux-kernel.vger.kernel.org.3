Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FA508B33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379798AbiDTOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379785AbiDTOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:54:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A11ADAA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuRk25kCvRN6z3hBOfbf63wUVxhzveyy6WkzcVzferc=; b=KdjNoW1VU33lyQIOlL7UpUlkce
        KQhsMGUSJG/W5+ZEgUse3mr1fbbVL2VHbUXNBgku14LpLnMhX6btqb3TJ7cuscblRhCJfyz4KVMbB
        ncCa+bMfhTs9XP4hFwCuRjis20N3GuUA9Xp6l0TKS38b96B83vcOcecDQ/iz/J0pgd4hifbG4B2+H
        fnQGzhl0tMYLLvUUazAPvwJeD2fW8RyqjZcIRYjsQsANPZ2acGcxEqZfjpoiWi6fI3nRo4KLxzB5E
        7YVJA26AHgmCJK/WxpZzysRX37ljlU0q80cGC5ENxZo45RrGiVTsR1+i2obE3zymW6nBLgobiZxOM
        4ourAixQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhBgB-0078x5-Nk; Wed, 20 Apr 2022 14:51:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6230F9861A4; Wed, 20 Apr 2022 16:51:37 +0200 (CEST)
Date:   Wed, 20 Apr 2022 16:51:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220420145137.GG2731@worktop.programming.kicks-ass.net>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.339242797@infradead.org>
 <ed167304-0d43-42fb-9da1-1358dded3a2f@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed167304-0d43-42fb-9da1-1358dded3a2f@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:26:54AM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Apr 19, 2022, at 1:41 PM, Peter Zijlstra wrote:
> > Since the upper regs don't exist for ia32 code, preserving them
> > doesn't hurt and it simplifies the code.
> 
> They exist for compat code, though, and should be preserved for ABI
> purposes. Programs that do int $0x80 in 64-bit code do exist.

So this patch preserves semantics for int80, it changes things for
sysenter/syscall, those currently clear the high registers, whereas
after this patch they behave identical to int80.

So the earlier patch:

  https://lkml.kernel.org/r/20220408223827.GR2731@worktop.programming.kicks-ass.net

preserves semantics across the board but is slightly more complicated.

And as argued elsewhere in thie thread; if preserving instead of
clearing the high regs is a valid attach surface, then int80 already
provides it, so I don't see how doing the same to sys* is any worse.

