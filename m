Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942ED578DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiGRW4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiGRW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:56:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC2E0D7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:56:06 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 64so23548607ybt.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFiFHivs8Lja1WLmWY06OuHT01tol+Zj00tV0o3LV8U=;
        b=AhoPVIiIoLF4TMNFR34Ra10DQtCyQ872y3I+ySo+v2Huysy0iVdBO4fkhi4otyg9bo
         +yYk8NGnSR/QIyC/fjZtV10JPWtJuQIJksprUMnd+zc45E+HNVxBU0cOga46XwXnRW6p
         eBkEfDEBH/DeFrO7xZLsC8jx6UlZ2uB2w9qug7gk54OoNrDIaGS4F3Dmq3lBzv3UYmeO
         aX5IW8iWjCyrUv3M4wjopwZpeSzZSdn7dT22QywPaaDNfKv9fzmAOsO1vtlLQIjm+mrE
         cDehz8k0/NAL1UqPN17M35wEZOS7q6V5rl0GUZKkzSk2vpdm89bK9xsYNSbX8NrjPVnU
         54tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFiFHivs8Lja1WLmWY06OuHT01tol+Zj00tV0o3LV8U=;
        b=QBa1jA0uw7pgwOQ7ISwPmnm/7IM69bYNtmgIxrzmBNIJUBJ8ibJx+8GJfx69u0XLVd
         2V871kn5gq+XZRCLWBX0vF7UxTcnbGXiQ+VoiWsWjiZf+f1U7hFkLpwhKHPW3GUBFAxF
         v84JLV8Ykuzgq6QDo0YviZWmswI8m4ZI7hXWzaCJEC6kGvuLPDgiRUYBXDBeTzaGLKlz
         lriNU/dn2x9MQFFZBtLvwoVC3SxVUaVHrKHCTBnDZqAqMRy7Ra9AcBbEmOgRNSIRxYQH
         cgcduei21OkKB/5XSvuKlpOJndocrOf7n+xo3i7VYnJwOMvUmFV07aW4Hj0VSUG/JLyv
         p1kg==
X-Gm-Message-State: AJIora97wKV70mf2qIftrH7o63JBs/YmssLur06cvQB7A8ieinG5rBMr
        YnUjZ1PKkLdyb1G3YWT+OpfxWBcaiKGdzi6Hn+uc5g==
X-Google-Smtp-Source: AGRyM1uRm7j447ZnKCxiSZY19hSKPSsuVmTNNr/lbpQP38W5/Yligt058HwACnK3CZFyzkWaVTAsdtzOpCndVzBVYyk=
X-Received: by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP id
 t13-20020a056902124d00b0066d5ce65924mr30346821ybu.320.1658184965712; Mon, 18
 Jul 2022 15:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
In-Reply-To: <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 18 Jul 2022 15:55:29 -0700
Message-ID: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
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

On Mon, Jul 18, 2022 at 3:47 PM Joao Moreira <joao@overdrivepizza.com> wrote:
> Thus the hash will be 6 bytes before the function entry point. Then we
> can get the compiler to emit a padding area before the __cfi_\func
> snippet and, during boot, if the CPU needs the call depth tracking
> mitigation, we:
> - move the __cfi_func into the padding area
> - patch the call depth tracking snippet ahead of it (overwriting the old
> __cfi_\func:)
> - fix the cmpl offset in the caller
>
> func_whatever:
>         ...
>         cmpl $0x\hash, -FIXED_OFFSET(%rax)
>         je 1f
>         ud2
> 1:
>         call *%rax
>         ...

The problem with this is that the cmpl instruction contains the full
type hash, which means that any instruction that's FIXED_OFFSET from
the cmpl is a valid indirect call target as far as KCFI is concerned.
-6 was chosen specifically to make the ud2 the only possible target.

Sami
