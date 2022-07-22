Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6ED57E3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiGVPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGVPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:38:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886779B9E2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:38:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f11so4723733pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/rSrjqI9Kq8RGPKAfu3pLnMgTVnevgNO0y+F18A2TzA=;
        b=WV5ctrz1+PeXgAcPRgqLh7wTHjXOYjUq7qOFHH+CFxhTLBBYOLTD+T3aVeQ1iTf3FA
         GbZ7o8cHdT5y5ztZFwpClnuN12p9WyBM7hU5B1u8zJBOz+KcUddlwgj6imTzQdZlyqPk
         4CLZUWxvX0Ok+/+BTIJ/8g/nnstbkvCescOLG5DLZwysC4X0X94hY/3EM+XKtKfPfPXE
         HD5I4/NC0qfDahqJ3gzdmQ6nbSSfTmW5El49xlu8tPrNeTrxiLpxVUITqdG4u1JgoKMu
         UTG4p3PGbkF4GZXtTcYNnXop/EHetIENWcN9rzpO3wQiGhKULw+UIaW1iPE8qhkoZEjm
         mQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rSrjqI9Kq8RGPKAfu3pLnMgTVnevgNO0y+F18A2TzA=;
        b=w4N6+JlbMMS8u89lhdMhufiYJN7aewJS3ORfm4yrSdlPY4zp8qrVlQc7XwIXQcVv/z
         RfmrdAWiYRfV2qSk3GM15Vm1Ddsn+YjKP16vsfa2exl3nmgDFvrHeK3TWutobPbtkFmK
         T3+YQUDbft6TNLre/Ue41RA8RH6azIDFWzO5Knol3zvlRYU1PQopxlIDqO2RiokjUgd5
         ANwJzDLns1fIbxY8A1WXdwjfxebgZuZ0vslSS6eqEXMpYuLlTdBTuliJMdeUefmYp/+l
         JIlP+Yp7r7KjsWYG2C7UCAEZTIg8CuL/eZaMyLL5ivZR/PIV4p6rp4dpN1X97cB+SAmB
         bQBw==
X-Gm-Message-State: AJIora8eegYw6UiPLUz01nLewcLGa415XFqpBFVNM1QNHxIg5gdX53nm
        zHxq15xJHeWCJWNzKpUSELzXfg==
X-Google-Smtp-Source: AGRyM1uUCt0KWEUdn9kQFCsjfgk6yZN3GCybr7vj94Wr78VgjCgbCHabQq7Pyo+XCqIkQs17HeKssg==
X-Received: by 2002:a05:6a00:1d8f:b0:52a:b787:b480 with SMTP id z15-20020a056a001d8f00b0052ab787b480mr455620pfw.71.1658504305473;
        Fri, 22 Jul 2022 08:38:25 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:9655:152c:19f:5d09])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b0016782c55790sm3983157plk.232.2022.07.22.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:38:24 -0700 (PDT)
Date:   Fri, 22 Jul 2022 08:38:17 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YtrEaTNs896AjWqh@google.com>
References: <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
 <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
 <YtnsTs8XkPS4nXdi@google.com>
 <Ytp6ooFQMLr3/h6v@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytp6ooFQMLr3/h6v@worktop.programming.kicks-ass.net>
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

On Fri, Jul 22, 2022 at 12:23:30PM +0200, Peter Zijlstra wrote:
> and things are 'good' again, except for functions that don't get a kcfi
> preamble, those are unaligned...

One way to fix this would be to just emit an empty KCFI preamble for
non-address-taken functions when patchable-function-prefix > 0, so all
the functions end up with the same alignment.

Note that Clang doesn't keep the function entry aligned with
-fpatchable-function-entry=N,M, where M>0. It generates .p2align 4,
0x90 before the nops, but if you want to maintain alignment for the
entry, you just have to tell it to generate the correct number of
prefix nops.

> I couldn't find where the patchable-function-prefix nops are generated
> to fix this up :/

It's all in AsmPrinter::emitFunctionHeader, look for emitNops.
 
> Also; could you perhaps add a switch to supress ENDBR for functions with
> a kCFI preamble ?

I'm planning to do that in a follow-up patch. I would rather not add
features that are not critical to the initial patch to avoid further
delays in getting the compiler changes accepted.

Sami
