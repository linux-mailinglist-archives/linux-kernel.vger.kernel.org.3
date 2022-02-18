Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BE4BC1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiBRVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:15:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiBRVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:15:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B40923D5D2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xyLRkpJKC4SChngItp/NhtDE6LOV0sEN9i6WRQfQcoE=; b=sxw5MB9cb48vr/9QmbuGVykhEn
        AiqFXvMKl4fL5PmTmRX08WxMDV4kQbiwGwjGbzFrz6I7Cjuod00tZj/Sq3StOzWnO85MBjHtwpAaD
        Py8o1GF2HcylC3YgAcaIEsY3qdLoUL8k89qBuw2khqYv4Q5msa9m/ZMJsCcU+ixbEyArFljjvHG5h
        RTghSQ5xKG3X5NUpPlHVeJTIpFIAPeBc+tkr3Uxg/RkcneVu4GShdspGJgIV0gUajyEuxJSv3FxTR
        HUFTASFyItS3onidLM/NkLfEQpgMnUUrihglUspgjJrDPtLtYKtng7HzwZ13Ui2jVfWw/kvZnCDE1
        G6MWM/5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLAb0-00Gwv1-Ek; Fri, 18 Feb 2022 21:15:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 563CD30026F;
        Fri, 18 Feb 2022 22:15:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 223A22BCA7EA5; Fri, 18 Feb 2022 22:15:16 +0100 (CET)
Date:   Fri, 18 Feb 2022 22:15:16 +0100
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
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <YhAMZNDJAjB69cEX@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.395399333@infradead.org>
 <c96d394c-d98e-1ff9-4919-a561c585d4a6@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c96d394c-d98e-1ff9-4919-a561c585d4a6@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 07:31:38PM +0000, Andrew Cooper wrote:
> On 18/02/2022 16:49, Peter Zijlstra wrote:
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -592,6 +593,27 @@ static __init int setup_disable_pku(char
> >  __setup("nopku", setup_disable_pku);
> >  #endif /* CONFIG_X86_64 */
> >  
> > +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> > +{
> > +	u64 msr;
> > +
> > +	if (!IS_ENABLED(CONFIG_X86_IBT) ||
> > +	    !cpu_feature_enabled(X86_FEATURE_IBT))
> > +		return;
> > +
> > +	cr4_set_bits(X86_CR4_CET);
> > +
> > +	rdmsrl(MSR_IA32_S_CET, msr);
> > +	if (cpu_feature_enabled(X86_FEATURE_IBT))
> > +		msr |= CET_ENDBR_EN;
> > +	wrmsrl(MSR_IA32_S_CET, msr);
> 
> So something I learnt the hard way with shstk is that you really want to
> disable S_CET before heading into purgatory.
> 
> I've got no idea what's going to result from UEFI finally getting CET
> support.  However, clearing out the other IBT settings is probably a
> wise move.
> 
> In particular, if there was a stale legacy bitmap pointer, then
> ibt_selftest() could take #PF ahead of #CP.

How's this then? That writes the whole state to a known value before
enabling CR4.CET to make the thing go...

+static __always_inline void setup_cet(struct cpuinfo_x86 *c)
+{
+       u64 msr = CET_ENDBR_EN;
+
+       if (!IS_ENABLED(CONFIG_X86_IBT) ||
+           !cpu_feature_enabled(X86_FEATURE_IBT))
+               return;
+
+       wrmsrl(MSR_IA32_S_CET, msr);
+       cr4_set_bits(X86_CR4_CET);
+
+       if (!ibt_selftest()) {
+               pr_err("IBT selftest: Failed!\n");
+               setup_clear_cpu_cap(X86_FEATURE_IBT);
+       }
+}

