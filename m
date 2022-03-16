Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEF4DB422
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356974AbiCPPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiCPPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:09:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794F5F25A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kUS0FWNIs0yIrLd/heSSebOcpR0j5wgqXueWxMkun0U=; b=KpXoIMpuXiIMakySaOTnply9Lg
        WcNmHVQqcXmOtBgabCvy1LAaoAnNdAimF/ltq7aJf6nWteuWbb3hdisBcWo3lNZ0XqDK3LNjHeTo/
        q//jezltTOXhyV23gyThc6WsWwVCLrA9rqY53lF3/f+Pa1MzhwE0ThrwXBXBxm0DVJzKjfvZUsuSo
        vEjwfq6J6V6Wf1ocCcfw32HwMvKfT6doidWHp54vQ8GALRUC7hF1Q8y3LorX1M1Qawy7eWdgZKcd6
        N72oJ+4IZuWIiDXoaGACv1YViLreJaXUmIiSP0U7sBv0/URNJBOkShrsFwzeuDGSVv9CJxnnHj1tf
        kdC9CkIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUVFL-001ZfU-QU; Wed, 16 Mar 2022 15:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 615D130007E;
        Wed, 16 Mar 2022 16:07:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B1BB2C47F84C; Wed, 16 Mar 2022 16:07:31 +0100 (CET)
Date:   Wed, 16 Mar 2022 16:07:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V3 4/7] x86/entry: move PUSH_AND_CLEAR_REGS out of
 error_entry
Message-ID: <YjH9M3MBn+j/MwPJ@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-5-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:46PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
> functionality.
> 
> It makes error_entry() do not fiddle with the stack.
> 
> It will enlarge the size:
> 
> size arch/x86/entry/entry_64.o.before:
>    text	   data	    bss	    dec	    hex	filename
>   17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o
> 
> size --format=SysV arch/x86/entry/entry_64.o.before:
> .entry.text                      5528      0
> .orc_unwind                      6456      0
> .orc_unwind_ip                   4304      0
> 
> size arch/x86/entry/entry_64.o.after:
>    text	   data	    bss	    dec	    hex	filename
>   26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o
> 
> size --format=SysV arch/x86/entry/entry_64.o.after:
> .entry.text                      8200      0
> .orc_unwind                     10224      0
> .orc_unwind_ip                   6816      0
> 
> But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
> enlarge the final text size.

So I don't much care about the orc data, that's only used when
unwinding, a relatively rare occasion, anyway. But the text increase
does bother me a little, this can blow up I$ misses on syscall heavy
workloads.
