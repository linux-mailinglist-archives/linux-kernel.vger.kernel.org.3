Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93954514653
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357255AbiD2KNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357250AbiD2KN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:13:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1210CD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yhQeU9VIFEFkgSl23emOh2lTCYr2keWcApdqCY7h5yg=; b=u+73zBFLEP0IND+vnIO7v4WkC1
        4wkHv5HLcdkgr4RJlmWg1sWR6c5eduuKRqhyoCp5dXwNFZeIlmx72MiBtXgkgHGDMIt3A2oarN3f4
        +c2XZqZ500MsxEnpozEvuVUmWSGWXRz2idTH3MlNB/0ZUCB5OIrmWyB3aWD5KJA1F44wuqeglCNdg
        xDTxD3SalzW1ijpvB7a4XMuVDyQr7lFFGxJpUz0wkjUGG0KK77HLEy7wqarJg0x/BcDl1G5JdHbAV
        Vi+pxS+oq0oX0Ll3qTMH+6YixuMxl2VhQggnwf+dQOO0O0ixyaoAovHKNzxw8H4Z/ZQ04ZBHm28GP
        08oJvJsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkNZd-00CIrZ-Ty; Fri, 29 Apr 2022 10:10:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C23C03002B1;
        Fri, 29 Apr 2022 12:10:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD4F720295B05; Fri, 29 Apr 2022 12:10:03 +0200 (CEST)
Date:   Fri, 29 Apr 2022 12:10:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Simplify RESERVE_BRK()
Message-ID: <Ymu5e24d3JRWJdHb@hirez.programming.kicks-ass.net>
References: <0e001c79794c46d619714d122c262147ed83f658.1651176151.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e001c79794c46d619714d122c262147ed83f658.1651176151.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:04:25PM -0700, Josh Poimboeuf wrote:
> RESERVE_BRK() reserves data in the .brk_reservation section.  The data
> is initialized to zero, like BSS, so the macro specifies 'nobits' to
> prevent the data from taking up space in the vmlinux binary.  The only
> way to get the compiler to do that (without putting the variable in .bss
> proper) is to use inline asm.
> 
> The macro also has a hack which encloses the inline asm in a discarded
> function, which allows the size to be passed (global inline asm doesn't
> allow inputs).
> 
> Remove the need for the discarded function hack by just stringifying the
> size rather than supplying it as an input to the inline asm.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
