Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9257BC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiGTRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbiGTRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:25:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442C1B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pFpGMzqUPjI7i/5145DxoFt8ywldYy6rEYyRWkNVjSw=; b=sPdlSECo2Nma2PNnHKBWFsvRoi
        KAKFuRYu7lg/BYRKHWqIjYxc+0hG4rkKxEEDjWGqBr0AXGjbbDSzAy0+NYFOexlTK7kbeOstAdqok
        K56euDgkYbWWkx2gbkeyYw/wa+oqh4dQbQXvxxVze1QyRCaVastTZR8gGCZXgSuMdf/VM3O+8x/AE
        RlNR48hOfhS1/DDSHtb36lgkxCvlaitroFENrZQDjcIt41Qy00LNoMdVhlX4CGgb96nsixAHC5xZ6
        kTYL3Q14aUCcsh9myMZETXnC+H604S3nGv/X3Uwm7uNLCj1Zcpt0sHVAl7Fe6VznYsS8kLJM5wyc0
        lfPsEdNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEDR4-00Ee8I-E3; Wed, 20 Jul 2022 17:24:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8298A980BBE; Wed, 20 Jul 2022 19:24:32 +0200 (CEST)
Date:   Wed, 20 Jul 2022 19:24:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <20220720125736.48164a14@gandalf.local.home>
 <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:09:37AM -0700, Linus Torvalds wrote:
> On Wed, Jul 20, 2022 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [    2.488712] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:558 apply_returns+0xa3/0x1ec
> 
> That warning is kind of annoying, in how it doesn't actually give any
> information about where the problem is.
> 
> I do note that we only fix up JMP32_INSN_OPCODE, and I wonder if we
> have a "jmp __x86_return_thunk" that is close enough to the return
> thunk that it actually uses a byte offset?
> 
> But that WARN_ON_ONCE() should probably be changed to actually give
> some information about where the problem is.

There's a patch for that:

  https://lkml.kernel.org/r/20220713213819.460771-1-keescook@chromium.org

it seems to have gotten lost, let me go queue that.
