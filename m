Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AF57A506
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiGSRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiGSRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:19:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855284F679
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:19:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so15435319pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xkPfqfZ7XIrq2AnqCBsjcp9AsmxwMCYlbObzPflz9Q=;
        b=rGaUQNJJtt++T9BeKnuUJ0B7X8yS5Rb/PXC+C7a482tKuy3KWaRh9Ddi9+7CcMza9h
         jxP/Pf7MmMwI94B56z4Rd+XIwe7lg5t4YORxgT8JYmXPHkhPtEvY74Tz1CQx7lt1t08R
         yx5422ouZ1MQqjlpbYR5pAJBlPeMDGytQEFaDSWEBEEuixLCSRkMTqK0QgKKEOx7S6iw
         ud+aaSoOuZHBRulPiKOyVyWWNCrGoy623ZMv3bp591RcsdC9fAJ+gw3uWeFufQMUCN6F
         8fYl/HWYzWmghr1Q069CfiuRO/kaTIMoooNZ56s5C31o3If6LTabvK3X3YUTyLqX1woy
         5BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xkPfqfZ7XIrq2AnqCBsjcp9AsmxwMCYlbObzPflz9Q=;
        b=NOqQDdU+aqBebM8ciE10IxxxMqs64OZiflk3nfmqbtD6qHIbp9mRUPdOtdk1l6FRcj
         +iZHppG/irSX8MKRdhxDYEzkN/QRCSlbpMFelNeBJTnVKnJV2IkUdbNXeONsSQ7SWRls
         0Mzpoz1AcQLNRxO27QHcUy73N6xxaa6TbPfttxK50fbeDy49iGfqnTSl1X1Lt25PzYxP
         aupJ1W8F0CH9gTsTpup6wxAkuqF3Gpg8kB10tjXqOwMgp961EqZ4q0/mInX5BsIU3BRe
         6rGpE9XOaJlJ3FnLhVps/YM30oqIGGADDcNi5KnxAPVA1vDL7kUw0m6Q/QoSQRpnzS1e
         E1Fg==
X-Gm-Message-State: AJIora9C8k6mWwMZB5pw94q11GZodl6KBmvElsXE3aDLzCVOV6sRiaBT
        SiRwlrtYocNs+OylIYC0xmLb8Q==
X-Google-Smtp-Source: AGRyM1vpE4hmeLpWTzT/s+WyuAdI1FSy7WbUdFYnbFOayVYu+YvkZYVHaccD1HPEp0Yc3aVJ2fo63w==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id i6-20020a170902cf0600b0016bcc335bcemr34348756plg.152.1658251165816;
        Tue, 19 Jul 2022 10:19:25 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:893a:f024:99b0:7299])
        by smtp.gmail.com with ESMTPSA id x22-20020a17090a165600b001f035bfcc53sm13833679pje.18.2022.07.19.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:19:25 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:19:18 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <Ytbnlms90+LBLbrY@google.com>
References: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:11:27PM -0700, Linus Torvalds wrote:
> On Mon, Jul 18, 2022 at 5:03 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So it already only adds the pattern to things that have their address
> > taken, not all functions?

The preamble is added to address-taken static functions and all global
functions, because those might be indirectly called from other
translation units. With LTO, we could prune unnecessary preambles from
non-address-taken globals too.

> > If so, that's simple enough to sort out: don't do any RSB stack
> > adjustment for those thunks AT ALL.
> >
> > Because they should just then end up with a jump to the "real" target,
> > and that real target will do the RSB stack thing.
> 
> Put another way, let's say that you have a function that looks like this:
> 
>   int silly(void)
>   {
>        return 0;
>   }
> 
> and now you have two cases:
> 
>  - the "direct callable version" of that function looks exactly the
> way it always has looked, and gets the 16 bytes of padding for it, and
> the RSB counting can happen in that padding
> 
>  - the "somebody took the address of this function" creates code that
> has the hash marker before it, and has the hash check, and then does a
> "jmp silly" to actually jump to the real code.

Clang's current CFI implementation is somewhat similar to this. It
creates separate thunks for address-taken functions and changes
function addresses in C code to point to the thunks instead.

While this works, it creates painful situations when interacting with
assembly (e.g. a function address taken in assembly cannot be used
for indirect calls in C as it doesn't point to the thunk) and needs
unpleasant hacks when we want take the actual function address in C
(i.e. scattering the code with function_nocfi() calls).

I have to agree with Peter on this, I would rather avoid messing with
function pointers in KCFI to avoid these issues.

Sami
