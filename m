Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A74BC1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiBRV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:27:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiBRV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:26:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FA294105
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F6XLv1bRFRRqmsBWMf6nszkh4+LCwgL7bndxsjlmZrM=; b=DC6ffphtUQ5GlTHOhJJQ9varq0
        8jXrHA90NpJOAoJ2ArlqyYfRPwDX9N48lr49z4rfeoobSfehCs3tKqiSPzCrd+y2ViFKK+1VhwX3G
        C8LdtkuOWsVQetH5HJQsAn/4S0H2K9+wD4c0/fxCMaqhXOhIt2RO7bPUjVQR3749Y/C+Upp4atX/U
        PMVIHENG5BjmBucJFKEUSqea/prv9KBbs1zpQHlWRc1Oirs3vHK2xPlYYJu0+x6Uml5VwRsHX3r2Q
        de83tejjvPr7ECWD8Suj5f/289CZCahJpqvlMv4pMA0hGvoo/xcVY9avibllWfBfEWuggQFBR+jxz
        4oSvw6gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLAlN-00Auu9-Ii; Fri, 18 Feb 2022 21:26:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E8B1300296;
        Fri, 18 Feb 2022 22:26:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17DA92BCB5D62; Fri, 18 Feb 2022 22:26:01 +0100 (CET)
Date:   Fri, 18 Feb 2022 22:26:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 05/29] x86: Base IBT bits
Message-ID: <YhAO6fIXpgSbT5ie@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
 <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:49:45PM +0000, Andrew Cooper wrote:
> On 18/02/2022 16:49, Peter Zijlstra wrote:
> > +/*
> > + * A bit convoluted, but matches both endbr32 and endbr64 without
> > + * having either as literal in the text.
> > + */
> > +static inline bool is_endbr(const void *addr)
> > +{
> > +	unsigned int val = ~*(unsigned int *)addr;
> > +	val |= 0x01000000U;
> > +	return val == ~0xfa1e0ff3;
> > +}
> 
> At this point, I feel I've earned an "I told you so". :)

Ha! I actually have a note to double-check this. But yes, I'll stuff
that piece of asm in so I can forget about it.
