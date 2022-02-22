Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1044BF4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiBVJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBVJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:33:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A4A2516
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3iLjqgJEnGAdr8zF+Sn6XYn8tIjrfh5Ii/qv9Svt0s=; b=S66n8VWTMAiqk9sMFOjJ/ng+Uj
        zEf/fQwqAByQAsaVQKPUHNulLqK4kaxHYNpOF0VpjItDAqkmn5q5nbIEwpKVBWmtbfFS3cmHSHJ1K
        ZRBwkULj/W9WUi0fd8xHEsA9Qs5VHmxBq4AwkyBR/Le7aUB/RihzZqHn6rdB+mrhEVwcQnpMp9gZP
        Ki8Utdtiv+XOHeuQdnVz+BplaitcY2Q8PZTa09hT43JRqMla9GWFruvEnrPjZBAmZjcTN3eh/5jse
        rkpl6W+t7pbaVZ+jRFQHxkehHowXVgVMqnK7iecjsfTrtYWytLFTCr5x0J1Uc5X9enFe7jAl6mTZ1
        JMLti5pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMRXM-002dJs-Ua; Tue, 22 Feb 2022 09:32:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28E6E3005B2;
        Tue, 22 Feb 2022 10:32:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AC18200D182B; Tue, 22 Feb 2022 10:32:48 +0100 (CET)
Date:   Tue, 22 Feb 2022 10:32:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <YhStwI95PmMyxgqx@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.395399333@infradead.org>
 <6874fd181ad46cd48f12da6ff5c955a64e193564.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6874fd181ad46cd48f12da6ff5c955a64e193564.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:38:22AM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-02-18 at 17:49 +0100, Peter Zijlstra wrote:
> > +       cr4_set_bits(X86_CR4_CET);
> > +
> > +       rdmsrl(MSR_IA32_S_CET, msr);
> > +       if (cpu_feature_enabled(X86_FEATURE_IBT))
> > +               msr |= CET_ENDBR_EN;
> > +       wrmsrl(MSR_IA32_S_CET, msr);
> 
> So I guess implicit in all of this is that MSR_IA32_S_CET will not be
> managed by xsaves (makes sense).
> 
> But it still might be good to add the supervisor cet xfeature number to
> XFEATURE_MASK_SUPERVISOR_UNSUPPORTED, with analogous reasoning to
> XFEATURE_MASK_PT.

Yeah, no, I'm not touching that.
