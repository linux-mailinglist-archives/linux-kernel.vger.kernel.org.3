Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C0846DBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhLHTXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLHTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:23:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E48C061A32
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYBzVAP+UUBZVvFCBmINHOMm+kDlK+2C2HI2mk48OWc=; b=aN/hUxArDyhJh1awEX43rhQMgl
        dMEsSfpvZrXZb6frPmTdoxPaL8NnCwC4nch2AzI8pdkuf4zaC+W6NSaBVYfSrcVizcKdJR8c59eUM
        XBUQRQH1bLeUebM8rQARC75MO5sIz7/rOflI8Ls1V7TOPMX3Ie0d8677G0UzwyY3wa7NCnccnoCyN
        R8ydvf6eSDSu92bTBBQpjdXX+IbTQHK+PcMX+MUwXvvt7UtGx3sO9rkob3NnhQDrjximboKa13B1q
        +QlrEMI2PXmFLOwNJGsJ+z9KzKIvCGtK/Za+TvMT2xXoahXfYCyW9/wy6afPT4F9PegPNijCsBdNv
        gNZ105Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv2TY-008hlq-0e; Wed, 08 Dec 2021 19:19:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14A3B3000E6;
        Wed,  8 Dec 2021 20:19:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7CC2205C969D; Wed,  8 Dec 2021 20:19:35 +0100 (CET)
Date:   Wed, 8 Dec 2021 20:19:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 2/5] refcount: Use atomic_*_ofl()
Message-ID: <YbEFR9LVCkf0GQ0s@hirez.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.468934357@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208183906.468934357@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:36:57PM +0100, Peter Zijlstra wrote:
> Use the shiny new atomic_*_ofl() functions in order to have better
> code-gen.
> 

*sigh*, so I forgot to adjust the other primitives to the slightly
tweaked range of these new functions..
