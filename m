Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5091524FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355249AbiELOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351101AbiELOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:24:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BCD24FD9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YrWjE8pxTZS4ai7lrBpjOGo4601LIK1+MZr7SV8ukAo=; b=sqDm4UsITF7vwCZCR+zqU6VG0I
        IV5VKLdd6Q4R7A6B+TVsGcYVieV9cD8g5+DbOkEJ4Unto2Sm9i2eqlkx1pmbRTVJ70Le/iJsWViJy
        SOhI60WRkF/ZFD0s3E6sRbKAqIvHYWBPjtQASM8NTukifoR4AogyHNQVuYrPKgBlpxc5PWwzywwg+
        g8X7LTM6eKkBx3oRBgt2WsU4dr0iLxjzoFtZetEK2uIzUTV36DQKlahm8X2H2OY7hyl6uOmKeKcZj
        KsmT/2t+4/XzE2feu41R3W+NkTcNUwN7HvozI0mxAtBBUwn/JVP+GTpiSxxj724+bgoDdzFHVgW/d
        Y86CY9NQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np9jP-006T4R-F4; Thu, 12 May 2022 14:23:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 979E03001DD;
        Thu, 12 May 2022 16:23:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84837201E235D; Thu, 12 May 2022 16:23:48 +0200 (CEST)
Date:   Thu, 12 May 2022 16:23:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
Message-ID: <Yn0YdPNG/Q3lf+4G@hirez.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
 <87a6bmx5lt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6bmx5lt.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:06:38PM +0200, Thomas Gleixner wrote:

> #define untagged_addr(addr)	({			\
> 	u64 __addr = (__force u64)(addr);		\
> 							\
> 	__addr &= current->thread.lam_untag_mask;	\
> 	(__force __typeof__(addr))__addr;		\
> })
> 
> No conditionals, fast _and_ correct. Setting this untag mask up once
> when LAM is enabled is not rocket science.

But that goes wrong if someone ever wants to untag a kernel address and
not use the result for access_ok().

I'd feel better about something like:

	s64 __addr = (addr);
	s64 __sign = __addr;

	__sign >>= 63;
	__sign &= lam_untag_mask;
	__addr &= lam_untag_mask;
	__addr |= __sign;

	__addr;

Which simply extends bit 63 downwards -- although possibly there's an
easier way to do that, this is pretty gross.
