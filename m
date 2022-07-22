Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1A57E997
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGVWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:18:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E38B4BB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:18:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so7345813edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUGRVyI3vxRAlk7ATFo7wshgPDlwlGHM2lpGBfmxUcA=;
        b=Rk4qoE0eYse92T/eDlTmRN64KJqj5ws8vSi4yAtSF2Kbs+Sk4OcV2a9pL4+5IyazTO
         mGn5MzcuLfYNhArgxSlR3DWqxvkBYF95n3rY25PYYu8xYJUkuftwhQjHglAAI1UqRCFM
         fzG2/2QFSshaJqH8xb3ul9DvHYhopvRU+0ZCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUGRVyI3vxRAlk7ATFo7wshgPDlwlGHM2lpGBfmxUcA=;
        b=zCKCX+Nr/AvOxhBE/PRqtcjf8dBOC35/wl6dzX0/iSH9I+dqtNvo3EbVMYnlMmw0RD
         JXFjBielnqxA1nm4as9vmOjK2BU5++4nIoH3PeuVp6Vv5qZmM5WmTUtCi19Lnhqh+8VZ
         gi1tiu5Jgo51qoE3g5AUHeDzi/c9q1rnkyQ2eHD2wRbRXIMUbfaKqMbA+P7fqzyXjYRc
         JwGF4R/KLMEmpgNZlprY+1+H5Kuk8kJGROf9parzkGf71aMoZS7dHBl8+McCZw+vRhry
         tFR4sQrrAdECr0tJHsNklHpLXcYVbzv7jMIVozKztbW2utPBGS3hguUmwR6FoYgrfpFP
         0R2w==
X-Gm-Message-State: AJIora9LWuLWyCv0D3pH+9PWxyspL+LadzQloxrzg0uT/jonJ9DcJnwq
        yTyCLOHdPT2n2StyO1tHwFqhgBu7w6zizJTh
X-Google-Smtp-Source: AGRyM1tTE7yxBxDklX7UyFCPibw0VQYfO/VuHXDe5ZSvPoOCy8XGIMv83qtVOodNI/aZZSoEShVLjQ==
X-Received: by 2002:a05:6402:4244:b0:43a:ded8:563b with SMTP id g4-20020a056402424400b0043aded8563bmr1883622edb.222.1658528331230;
        Fri, 22 Jul 2022 15:18:51 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906292a00b007262a1c8d20sm2480446ejd.19.2022.07.22.15.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 15:18:50 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso3176684wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:18:49 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr1135428wmf.38.1658528329364; Fri, 22 Jul
 2022 15:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <e84fd559e79152d7065f7ceb3bcdd9af6b496ac5.camel@linux.intel.com>
In-Reply-To: <e84fd559e79152d7065f7ceb3bcdd9af6b496ac5.camel@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jul 2022 15:18:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-m=Oo5jy_+0ojXahT6bb_HvuU5=Lo0iALsjruo8j6Dg@mail.gmail.com>
Message-ID: <CAHk-=wj-m=Oo5jy_+0ojXahT6bb_HvuU5=Lo0iALsjruo8j6Dg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Fri, Jul 22, 2022 at 1:11 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> Here are some performance numbers for FIO running on a SKX server with
> Intel Cold Stream SSD. Padding improves performance significantly.

That certainly looks oh-so-much better than those disgusting ibrs numbers.

One thing that I wonder about - gcc already knows about leaf functions
for other reasons (stack setup is often different anyway), and I
wonder it it might be worth looking at making leaf functions avoid the
whole depth counting, and just rely on a regular call/ret.

The whole call chain thing is already not entirely exact and is
counting to a smaller value than the real RSB size.

And leaf functions are generally the smallest and most often called,
so it might be noticeable on profiles and performance numbers to just
say "we already know this is a leaf, there's no reason to increment
the depth for this only to decrement it when it returns".

The main issue is obviously that the return instruction has to be a
non-decrementing one too for the leaf function case, so it's not just
"don't do the counting on entry", it's also a "don't do the usual
rethunk on exit".

So I just wanted to raise this, not because it's hugely important, but
just to make people think about it - I have these very clear memories
of the whole "don't make leaf functions create a stack frame" having
been a surprisingly big deal for some loads.

Of course, sometimes when I have clear memories, they turn out to be
just some drug-induced confusion in the end. But I know people
experimented with "-fno-omit-frame-pointer -momit-leaf-frame-pointer"
and that it made a big difference (but caused some issue with pvops
hidden in asm so that gcc incorrectly thought they were leaf functions
when they weren't).

                    Linus
