Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E04C4F21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiBYTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiBYTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:54:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F8D0079
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HZTrg86cU89/EReneceXoP7zTLrnbBBH3OgsInB7sow=; b=QYAirtx2iGAq8YTBKxlVCjXzGD
        0+bdQGA1KQouYWwaCd/G9OnDSgkCQNi/L6z2a4iapL7BFgJxDFpd1B0SjZhZJpu3CezbcIToAPm0k
        rdCodNYhIrDJGEF8+tyZl6JVS3twP5o2WBcxvGBl8Tbfys08D6o1eQh9zq1zCw0sq2TSzbJZuoVr3
        gpGjOfG2oBDxhYjoPgPf41w6WXTrQuNzLYg7cKCc4bp8MeTcpK5vN9iB1cKsDBcHpDsLl2921L+3L
        PNUIzovUbaInV3EAuA9mF91Jo1TU8fRGPfocEx6txK1XyiUajyYA+Hz+sz5sU5htTKtcFuaqYmDA9
        D+QqetFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNgeH-00D2NY-MS; Fri, 25 Feb 2022 19:53:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E365C986AEC; Fri, 25 Feb 2022 20:53:03 +0100 (CET)
Date:   Fri, 25 Feb 2022 20:53:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220225195303.GA11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
 <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
 <20220225172644.76fyxjximjrcdbzt@treble>
 <20220225123238.5ceeaae1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225123238.5ceeaae1@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:32:38PM -0500, Steven Rostedt wrote:
> On Fri, 25 Feb 2022 09:26:44 -0800
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > > Damn, I just realized this makes KERNEL_IBT hard depend on KALLSYMS :-(  
> > 
> > Why should the jump label patching code even care whether there's an
> > ENDBR at the jump target?  It should never jump to the beginning of a
> > function anyway, right?  And objtool presumably doesn't patch out ENDBRs
> > in the middle of a function.
> 
> Perhaps Peter confused jump labels with static calls?

The code is shared between the two.
