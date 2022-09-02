Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F865AB7DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiIBR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiIBR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:59:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAB2CDFD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jDC7BqYo1R92jQlcphXp72QFerhqQBqx/36u1nEWo8I=; b=Pn7d4Cl4P8/i9GBaN50WiffbYK
        TKDYFY8U3yBtZN+zJ+3zSxzCAtxn/lkMvLobXg5x1mq4iN4hxADhMn7S5tEXeirHu2uW70ML6Xh2n
        uQnAcUbaaebbkJ/wa9yjIAz37GOKdKxhWvXubVPc/dFY96cc0QSVBUgEikDzSNGhat3o3gqAgCmjA
        jhdRluR1HqbYhXX2Ov0jDcgZpVAfa5ZyFLZ12uTpr6GRpl3ZUil2SJ9SjjkYy5uXb9AOSIT4bIaC+
        4BQ99DEmyac5wgNxcTIktHmEt3+RODZ83fsAgJCxECMOqKSFbuMsowsT9sH04pA0dCheJ5EzREgWB
        LynoUUFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oUAx7-00BPZr-1h;
        Fri, 02 Sep 2022 17:59:37 +0000
Date:   Fri, 2 Sep 2022 18:59:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix a nasty sigreturn bug...
Message-ID: <YxJEiSq/CGaL6Gm9@ZenIV>
References: <YU0wDzeS/jXwkAca@zeniv-ca.linux.org.uk>
 <20220902092245.ande6fvievnbn35h@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902092245.ande6fvievnbn35h@kamzik>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:22:45AM +0200, Andrew Jones wrote:

> So, for riscv, where in do_signal and handle_signal syscall restarting
> is avoided when regs->cause != EXC_SYSCALL and it's common to set cause
> to -1 to avoid it, then it makes sense to set regs->cause != EXEC_SYSCALL
> in rt_sigreturn or in restore_sigcontext, which rt_sigreturn calls, as
> well.
> 
> So the only question I have is whether or not the cause assignment
> is better in restore_sigcontext() like other architectures? At least,
> since rt_sigreturn is the only caller of restore_sigcontext, it can't
> break anything putting it there atm...

	The only reason for doing that in restore_sigcontext() is that for
old architectures there'd been separate sigreturn(2) and rt_sigreturn(2).
Doing that in the helper shared by both avoided duplication; since
there's no such thing on riscv...

	Matter of taste, really - I have a slight preference for doing that
closer to the syscall surface, but it's no more than that.
