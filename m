Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697F5A1075
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiHYM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbiHYM3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:29:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9036B2D82;
        Thu, 25 Aug 2022 05:29:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 020CD34D64;
        Thu, 25 Aug 2022 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661430579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYtU0uX5Uangsm66t/wYZRvYCZUDcfsOFGKs7m0LRwA=;
        b=PwlDFnYzV6AHBS0rte5AMD4fqHy7t7pST2hVZNqpE2PyOhSuJxt+EE+jSSTY/8GDxLtICu
        bn2dTg1K8AOrkuFoD4YAkuFiKHWD7Qo1uL7ibTT0YvWbEIGci3iikg3WfkRrsH8mH2qJhX
        /IUqSFSE/U/2K8pidbTlFq3TyKX2amU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661430579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYtU0uX5Uangsm66t/wYZRvYCZUDcfsOFGKs7m0LRwA=;
        b=dA1aHCdYclApW3JNVffDbQ7o3Ui1mJxE5MQfruu3LWzOBH4AlTRB4FWTVvfj7A1LpkUAct
        qEY8gdwQQ5ev21Bg==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C675A2C141;
        Thu, 25 Aug 2022 12:29:38 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id BD33C65CB; Thu, 25 Aug 2022 12:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id BBE4B6343;
        Thu, 25 Aug 2022 12:29:38 +0000 (UTC)
Date:   Thu, 25 Aug 2022 12:29:38 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
In-Reply-To: <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.20.2208251219590.24312@wotan.suse.de>
References: <20220824152420.20547-1-bp@alien8.de> <20220824172929.GA25951@gate.crashing.org> <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net> <20220824224144.GC25951@gate.crashing.org> <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 25 Aug 2022, Peter Zijlstra wrote:

> > > STT_FUNC_NORETURN would do I suppose, except then all
> > > the tools will need to be taught how to deal with that, which is also
> > > very painful.
> > 
> > What is that?  Even Google has no idea.  Hrm.
> 
> Something I just made up :-) A new symbol type for noreturn functions
> would be very useful.

But very, very, very painful for everyone else :-)  And: there are only 15 
symbol types, and in the OS-specific range only two are left (GNU_IFUNC is 
the taken one in that range).  That's too few to waste it on this very 
specific purpose.  A second symtab-like structure might work out, but 
then, what about attribute(frobnicate)?  Or one of the other actually 
existing ones that influence codegen?  Extending debuginfo might be an 
idea, but will bloat it even more.  Tears everywhere.

Just stay with probalistic hacking?  :-)  (And see below)

> Now, as mentioned we have heuristics that try and detect if a function
> is noreturn or not; but all those fail horribly if the function is in
> another translation unit for example.

You could add another mode of operation in objtool that merely scans all 
disassembled function bodies and emits a new list of candidate noreturn 
functions.  You run it from time to time to see if the hard-coded list is 
still sensible.


Ciao,
Michael.
