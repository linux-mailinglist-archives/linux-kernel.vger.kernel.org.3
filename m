Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBC57ED54
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiGWJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:50:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745B18356
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 02:50:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658569853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shPfA4VrLOcA7ea2l4vd1uSpydXF4fBQr+v82fxzpgU=;
        b=gTuH8lCvrU/A4vFuJ1aZpHJcMTGIkzVdeyAiaBz0QTceXPjzqqYUWkRAgYfFmZUn+8A1Bh
        X2v8cWsPLahARzM93dmA1Kj8Hp+3oDl3P3w5FiEeYmR8DROfX61NHrXSuqtjMTPm5r3Bs2
        v4D208tC17QQ1sCCJrQYjTA9fLPtkJXM4+GNFbtCsD6VdelKURqUxCRpOkCuDp2paT73bI
        5EL3HDp8WY+uSTsAEGDB+DwFlbxKZ/yUZq1hFz9G6hotOSx362k7AKk6h0ipp4cZ3XpKbs
        U5WdHCdJOoPa9M5a+Ypo4YPr7a4qE7fiBLCsFTSmuHR8YsUjwoxlEiE+IEZsZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658569853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shPfA4VrLOcA7ea2l4vd1uSpydXF4fBQr+v82fxzpgU=;
        b=RCzMsFzP8YCwrK+yaG7+EIl8xCmQd240TRmjXpCVs51EYaMv96zKym6wxrtHEGR1I0YyMW
        AlzFV8hruwh+HLCg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
References: <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
Date:   Sat, 23 Jul 2022 11:50:53 +0200
Message-ID: <87ilnotawy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21 2022 at 17:54, Peter Zijlstra wrote:
> On Wed, Jul 20, 2022 at 11:13:16PM +0200, Peter Zijlstra wrote:
> The idea is the above callthunk that makes any offset work by not having
> the full hash as an immediate and allow kCFI along with
> -fpatchable-function-entry=N,M and include M in the offset.
>
> Specifically, I meant to use -fpatchable-function-entry=16,16, but alas,
> I never got that far.

That's embarrasing. I missed that option in the maze of gcc
options. That would have spared me to stare at gcc code :)
