Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5918E52DAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiESRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiESRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:00:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE2B66
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g7xCp6J3k4L2dkaSWosqH9kge3uPbogCKlir9eF0rGw=; b=LOxGwIJzeEdNh9RKyGjDZiEa13
        fjaut1Kx6s93BK2A5wahP5RHOCuE21Ssz0OSKDFxlv8SWwpH84C3n1eijyHSbqfl7i0iNBNaJDV3C
        YZVmsZeWeY08AQ802UELHYM6uanc4kdLT9uTB1yWgmh8qMFY1qIS0qZo2Vuhxxwd9Sc2Gvdub0dQR
        oe36axBUTmpUIwt0ygeFxkdJHR1UKr0n7lDlQnGyBKPkNI6PgAR+0T1mAyjmwTEXqMiXkrTSyUhNP
        i60D2Aq8z2KP865EWMEZf/XfxZTWgZjFW2NeWEU9fL1JF/aMKC1gqn15DMP7vIgXOXG1WqhpK2d7S
        0wyKDnRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrjVT-0025Ro-Mk; Thu, 19 May 2022 17:00:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DB3C980E7F; Thu, 19 May 2022 19:00:10 +0200 (CEST)
Date:   Thu, 19 May 2022 19:00:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220519170009.GL2578@worktop.programming.kicks-ass.net>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519162411.GA4095576@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:24:11AM -0700, Guenter Roeck wrote:
> On Fri, May 06, 2022 at 02:14:34PM +0200, Peter Zijlstra wrote:
> > Since the upper regs don't exist for ia32 code, preserving them
> > doesn't hurt and it simplifies the code.
> > 
> > This doesn't add any attack surface that would not already be
> > available through INT80.
> > 
> > Notably:
> > 
> >  - 32bit SYSENTER: didn't clear si, dx, cx.
> > 
> >  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
> >    take a second argument.
> > 
> >  - 64bit: didn't clear si since the C functions take a second
> >    argument; except the error_entry path might have only one argument,
> >    so clearing si was missing here.
> > 
> > 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> > and selftests pass.
> > 
> > Unconditionally clear rsi since it simplifies code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> linux-next (next-20220519) crashes due to this patch when booting
> q35:EPYC-Rome in qemu.

Could you try backing out each of the hunks one at a time? They're all
more or less independent.

My bet with this being a #PF on an AMD machine, it's either the SI clear
or the SYSCALL change.
