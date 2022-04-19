Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51001506F65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbiDSNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352935AbiDSNts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:49:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44538BEF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:43:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650375782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIEjYwj2QAqx9py6IcEjJB2ia7qvYgpI4ylKTJuhGT4=;
        b=no4qYDUPmJaIjuNukg01OeTjgoV3wmfospQz7c9rfc/E+aZOvSGl1v7Y0fHEwVs7A9Kizl
        FQVyhnAmwXgaKdWtc6FAPLhcpm2FqSzcVRHv6nHtBjyBbomupKefZADIS0GKD3sNkqZWkw
        rfnmOevicwz8Q9iRQI6/LSOASEaEPcJEiXDo24PRQLs/EXKzAG/h+EhbMnQZ9Fc+S2LaAV
        1chjSJd9RaY3pI6BUZNAb80IwCTTSjaQ1arRsSdAwDk+Fc21JPlsk9T6zEcrnCNR9/fAXT
        AH+Nb27O9KswYsVAqV+aiZsOoQhzvG+mQjGLlLZMnKwsWCJwde/8aRX42c/8Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650375782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIEjYwj2QAqx9py6IcEjJB2ia7qvYgpI4ylKTJuhGT4=;
        b=yfFLli6BsXGlU2KHolkrs9DNcjU0iuLqfJXGBKLsjFGzIp5oLihJ8by2U9Z4mgVsbdcPzD
        T/5jRAMs6dnhp7CA==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
In-Reply-To: <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
 <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com>
Date:   Tue, 19 Apr 2022 15:43:01 +0200
Message-ID: <87ee1t9oka.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14 2022 at 10:24, Dave Hansen wrote:
> On 4/4/22 05:11, Thomas Gleixner wrote:
>> which is suboptimal. Prefetch works better when the access is linear. But
>> what's worse is that PKRU can be located in a different page which
>> obviously affects dTLB.
>
> The numbers don't lie, but I'm still surprised by this.  Was this in a
> VM that isn't backed with large pages?  task_struct.thread.fpu is
> kmem_cache_alloc()'d and is in the direct map, which should be 2M/1G
> pages almost all the time.

Hmm. Indeed, that's weird.

That was bare metal and I just checked that this was a production config
and not some weird debug muck which breaks large pages. I'll look deeper
into that.

Thanks,

        tglx



