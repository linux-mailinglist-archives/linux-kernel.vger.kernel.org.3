Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19D254C570
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiFOKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiFOKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:06:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8E3BF8D;
        Wed, 15 Jun 2022 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4eey67g7t7O8BPfmN7/7q5QPXgKgTakp0SBwPI8Wwc=; b=A9gwmKAW+XiQ9/DOSyqS8RJYDi
        kLftzCd0j9LecehqiL/heefWcKRALCLCgCI6c1Tu5XFO6iOIW6t+mnQs40w8vhM6UYlb40E5XJBPF
        lKAnJla+8pJmZnFEzggotql2iqWkR6j9Zs2v1tzI0Tv7jH5KJkwPqo+cyU5aKyalw/pGa4Reo+XZv
        PEn0pc1fJcgZFYxVz0OgVmIKIZgY6CnfbUvLbCqdGhdjNewgT5wNDSwB5e7Lww1K+HxgKb148dm8C
        JROyYYP3CAoRJLlfsHBxkBl9Nzc8osG+72C0hwxIGsRVAhBUjT7MU4jDf1dnmODn0sh/dPc9+WyRn
        +zQOBI0Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Pv7-000xmS-0e; Wed, 15 Jun 2022 10:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C5433001C3;
        Wed, 15 Jun 2022 12:06:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A817201A4F6D; Wed, 15 Jun 2022 12:06:39 +0200 (CEST)
Date:   Wed, 15 Jun 2022 12:06:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] jump_label: make initial NOP patching the special
 case
Message-ID: <YqmvL2Biw3TnIl7a@hirez.programming.kicks-ass.net>
References: <20220608104512.1176209-1-ardb@kernel.org>
 <20220608104512.1176209-4-ardb@kernel.org>
 <Yqmr6fvu4OYkarCm@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqmr6fvu4OYkarCm@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:52:41AM +0100, Mark Rutland wrote:
> On Wed, Jun 08, 2022 at 12:45:12PM +0200, Ard Biesheuvel wrote:
> > Instead of defaulting to patching NOP opcodes at init time, and leaving
> > it to the architectures to override this if this is not needed, switch
> > to a model where doing nothing is the default. This is the common case
> > by far, as only MIPS requires NOP patching at init time. On all other
> > architectures, the correct encodings are emitted by the compiler and so
> > no initial patching is needed.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/staging/static-keys.rst |  3 ---
> >  arch/arc/kernel/jump_label.c          | 13 -------------
> >  arch/arm/kernel/jump_label.c          |  6 ------
> >  arch/arm64/kernel/jump_label.c        | 11 -----------
> >  arch/mips/include/asm/jump_label.h    |  2 ++
> >  arch/parisc/kernel/jump_label.c       | 11 -----------
> >  arch/riscv/kernel/jump_label.c        | 12 ------------
> >  arch/s390/kernel/jump_label.c         |  5 -----
> >  arch/x86/kernel/jump_label.c          | 13 -------------
> >  kernel/jump_label.c                   | 14 +++-----------
> >  10 files changed, 5 insertions(+), 85 deletions(-)
> 
> I have one minor comment below, but either way this is a nice cleanup (and I'm
> always happy to see __weak functions disappear), so FWIW:

(I've got a new found hatred for __weak after having had to fix so many
objtool issues with it, so yeah, that).

> 
>   Acked-by: Mark Rutland <mark.rutland@arm.com>

With the thing Mark pointed out fixed:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

(although, I'll probably be the one to eventually apply these I suppose,
unless they're needed in a different tree?)
