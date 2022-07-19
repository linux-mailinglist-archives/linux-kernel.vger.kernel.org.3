Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC4578EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiGSAMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiGSALv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:11:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616E33E05
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e15so17522689edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMo0RZPvbvUkGqUmAbZDT304PxMfJDJI6wT8NNNm6AU=;
        b=VbrxZfmbdb0fBotXV5gttLpu+DEloBL38HB3JH4U6m5dguc5xUADUlXG+eSWpusiLv
         i74DqNQUdhVzgp/cIfLgp/4om4uIqRtsOZ1vz+HdJXv5xArhqyscy/PdBScscsaGLBrk
         BaBMyKJtT5v6V5WLPdTd7jO3k96LyllQSx0QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMo0RZPvbvUkGqUmAbZDT304PxMfJDJI6wT8NNNm6AU=;
        b=MuTp8ck4UCTqlNMt7Dsh9u68ZwBavUDI+Qc4XvUdEFvbUEDqE2gFFJr0trTC0rVT9U
         bWSL8T/kH6LCuvK5JsMvfV7MAAZWK91HffzPkcYzhpLjlSUP9lP90osXD/6xxFDl6EZu
         meY1mCb24gtExHP9YLMerBD6yKm7tNAKlYfgy2VfQvB5YrqnbnRgVZV1c9yxHcnqsSOP
         wF2iZa7py9ktV/NvFh9AA7cmjI/X+Ubm6N0MdxWy7YevkvLDzOLesNAVoEwhsf6aTfbB
         wXwIPc5XoyNOmnBufiPK/IjZn5ZE3njDbeKPggalan5FxSaJwAaD4vqs+pWa0RVP/ABr
         Hguw==
X-Gm-Message-State: AJIora+KADmiuXzVp3yM4iwimJXyvyM7luy0kyRbm4dRJ7EDUtrMPppp
        E5DRCWW01Gsrx3ahe81icZ4i1dcX3dtTwp2j2tI=
X-Google-Smtp-Source: AGRyM1vI6CAjuvAOyHjdXGByArVDkLwqgK0oIAWj7JTLu46LemIgfduSMqw8jllCCrb1cjiA8Z+wtA==
X-Received: by 2002:a05:6402:42c8:b0:43a:a1ee:a097 with SMTP id i8-20020a05640242c800b0043aa1eea097mr39900229edc.150.1658189507287;
        Mon, 18 Jul 2022 17:11:47 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b00722bc0aa9e3sm5987957ejo.162.2022.07.18.17.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 17:11:45 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id d16so19283311wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:44 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr24384691wrv.281.1658189503754; Mon, 18
 Jul 2022 17:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net> <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
In-Reply-To: <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 17:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
Message-ID: <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 5:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it already only adds the pattern to things that have their address
> taken, not all functions?
>
> If so, that's simple enough to sort out: don't do any RSB stack
> adjustment for those thunks AT ALL.
>
> Because they should just then end up with a jump to the "real" target,
> and that real target will do the RSB stack thing.

Put another way, let's say that you have a function that looks like this:

  int silly(void)
  {
       return 0;
  }

and now you have two cases:

 - the "direct callable version" of that function looks exactly the
way it always has looked, and gets the 16 bytes of padding for it, and
the RSB counting can happen in that padding

 - the "somebody took the address of this function" creates code that
has the hash marker before it, and has the hash check, and then does a
"jmp silly" to actually jump to the real code.

So what the RSB counting does is just ignore that second case entirely
as far as the RSB code generation goes. No need to have any padding
for it at all, it has that (completely different) kCFI padding
instead.

Instead, only the "real" silly function gets that RSB code, and the
"jmp silly" from the kCFI thunk needs to be updated to point to the
RSB thunk in front of it.

Yes, yes, it makes indirect calls slightly more expensive than direct
calls (because that kCFI thing can't just fall through to the real
thing), but considering all the *other* costs of indirect calls, the
cost of having that one "jmp" instruction doesn't really seem to
matter, does it?

                    Linus
