Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494624CAA92
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiCBQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiCBQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F2CFB83
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XEgUZ8A7MHTeA20Di9wn/WKEKRg/ap9UlmNyUR7U1MY=; b=bouIvFr98E+ye7BCxEdZ7dQSCi
        QrdH+h9i1Fwe9mV0xC0/o1RfMlOBCWMrxD5k86PRAJPB0pPtXq4II7N6wmBmJoeqa1JD4mwfAIR12
        /nJTRT+hUaAWGL7z7N7dm91bBrGlfgRHT7oUU73X253yIaK/ZJahQsaBehVEP1mXcdOD0C4pIqDnx
        yZ8Scqcx63NsxaV03n5Lea62AEBi5xg3eZALwBktv1qVZus5F1WLSaGlsfPmxGcCjmPLmyU3nBrMk
        vxOgT0NkygIlnA8BTUEdpQJuiDdiq0oNpE1LiSw/eYWOQCyBKXnapsjt11Y1/N4/fXgGgpSbP33RB
        sevcz/Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPS08-00EeDS-SG; Wed, 02 Mar 2022 16:38:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52D2830018E;
        Wed,  2 Mar 2022 17:38:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CB1F323174FE; Wed,  2 Mar 2022 17:38:54 +0100 (CET)
Date:   Wed, 2 Mar 2022 17:38:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yh+dnkcX6+Vdpwjs@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
 <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
 <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
 <20220301191245.GI11184@worktop.programming.kicks-ass.net>
 <20220301200547.GK11184@worktop.programming.kicks-ass.net>
 <1646236571.m56yc0kmzw.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646236571.m56yc0kmzw.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:29:04PM +0530, Naveen N. Rao wrote:
> Peter Zijlstra wrote:
> > 
> > How does this look?
> 
> I gave this a quick test on powerpc and this looks good to me.

Thanks!

> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -265,7 +265,6 @@ extern int arch_init_kprobes(void);
> >  extern void kprobes_inc_nmissed_count(struct kprobe *p);
> >  extern bool arch_within_kprobe_blacklist(unsigned long addr);
> >  extern int arch_populate_kprobe_blacklist(void);
> > -extern bool arch_kprobe_on_func_entry(unsigned long offset);
> 
> There is a __weak definition of this function in kernel/kprobes.c which
> should also be removed.

*poof*, gone.
