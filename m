Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA04BE020
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359031AbiBUNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:23:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359028AbiBUNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:23:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374421E21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1jw4QCDDG+dnzq5XQgBCgmJVKTljbhRv7BVuT5xZ2U=; b=VcusZoj1rkj4rTxMtEmTlTU/Ux
        Choa690NHAFFaG8kaGupw/PdeEv93b/Ce1y3M7vPRuaUkDEks1onEJ1V7nJ6tRUahx6pjYdzIVoZa
        iBrHlTj8n2nRkQttn0KbFeFgLidRt6TB7s2xfLCmU14OItNGdtPBoJQ52Po0djpQf44cZLC2uwIKD
        CWHhgSR4YJkJaKJEQEqg4rdsc3jkiCYWwuJoF01/Gg0BotGx7cpVwSQQ6zrFEwvEwUIuM3QUiOY5l
        qWVRNVsOSLY5UVSnb0vq2na+OmVj/LH42hxI0jQ/vRYKrvfDjnN56qzVrx/SLl+LacAVZl55bb2dS
        6ojAWdFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM8eG-00Bdwy-FR; Mon, 21 Feb 2022 13:22:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67E0E30045A;
        Mon, 21 Feb 2022 14:22:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF54D2D5BE0AA; Mon, 21 Feb 2022 14:22:37 +0100 (CET)
Date:   Mon, 21 Feb 2022 14:22:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 15/29] x86: Disable IBT around firmware
Message-ID: <YhOSHfocRmYlY3JM@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.456054276@infradead.org>
 <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org>
 <20220221100615.GK23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221100615.GK23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:06:15AM +0100, Peter Zijlstra wrote:
> 
> Could you trim replies so that I can actually find what you write?
> 
> On Mon, Feb 21, 2022 at 12:27:20AM -0800, Kees Cook wrote:
> 
> > >+#ifdef CONFIG_X86_IBT
> > >+
> > >+u64 ibt_save(void)
> > >+{
> > >+	u64 msr = 0;
> > >+
> > >+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
> > >+		rdmsrl(MSR_IA32_S_CET, msr);
> > >+		wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
> > >+	}
> > >+
> > >+	return msr;
> > >+}
> > >+
> > >+void ibt_restore(u64 save)
> > 
> > Please make these both __always_inline so there no risk of them ever gaining ENDBRs and being used by ROP to disable IBT...
> 
> Either that or mark them __noendbr. The below seems to work.
> 
> Do we have a preference?

The inline thing runs into header hell..
