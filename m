Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD59517208
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiEBO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbiEBO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:58:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D421AE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YttNPnloQVd2Mgtd4qh1LVWzGbOYyikCld4Yn2jXJd8=; b=HsdG5RnnaP6tqPf5ffNlaVSFIX
        4uRd6sKzfE02z+HA1IhxNanlssfvXnO5h9AEQh1ZZfLKGdwLeEcpjmZEdubxVX3mnigbtfDUrJ3VA
        /U+V0qt3gzr8D9z0ZxYE/nrQjzT3BMHBjr868nrpTm13mF6zIaHrjdSRYsFSf3H/5erneGPPf/nbx
        seCSzhy8SOiXPjhIthtbW9O0c/oEeHW1NvSxJv4kYDWz8v7cbtma+MQCeDglhoXBOHT2vCxR+g7Q0
        xs5/MmYu22NQ/LzTRQxOcMTjkJTSYX+Y1zOQObONz/01nEO/ECyBJSBZMivhjIKMR4Yj2o4MNrenH
        dTISZWHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlXRw-00EtbN-AU; Mon, 02 May 2022 14:54:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8416430031D;
        Mon,  2 May 2022 16:54:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B5B620288CEB; Mon,  2 May 2022 16:54:53 +0200 (CEST)
Date:   Mon, 2 May 2022 16:54:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/3] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
Message-ID: <Ym/wvdBuvFuHzw15@hirez.programming.kicks-ass.net>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.350926848@infradead.org>
 <Ym/X/BuXCi8H0vud@hirez.programming.kicks-ass.net>
 <Ym/buh8nDPFhohc2@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym/buh8nDPFhohc2@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 03:25:14PM +0200, Marco Elver wrote:
> On Mon, May 02, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> > 
> > Subject: jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Mon May  2 12:30:20 CEST 2022
> > 
> > When building x86_64 with JUMP_LABEL=n it's possible for
> > instrumentation to sneak into noinstr:
> > 
> > vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/jump_label.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
> >  #include <linux/atomic.h>
> >  #include <linux/bug.h>
> >  
> > -static inline int static_key_count(struct static_key *key)
> > +static __always_inline int static_key_count(struct static_key *key)
> >  {
> > -	return atomic_read(&key->enabled);
> > +	return arch_atomic_read(&key->enabled.count);
> 
> Curious if this compiles - s/.count// ?

It does if you have JUMP_LABEL=y... (-:

*sigh*... how I about I go back to mowing the lawn and try again
later...
