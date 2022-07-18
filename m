Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD59578D96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGRWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:35:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2F167C2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:35:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy29so22805730ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMlz+vn5loEPQvtk2SaQWF8f5Es9FhTyrx5oXqrFQto=;
        b=LXdx5yqqLcJnWWBN7zuiHkvtNt375NhjFwaihfI1bDoMaWUqh7bn0ocXOIKSDUruNM
         91c3zN1I0VPb+0P4oTOG5e5isfOY3H47k9zFFW1ZzJTmNE3l7g/2pf2H2mfs9s6yIwdq
         D281SC7mcvLOq+D1/ec0ho6kwwn3Dj3yMtxQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMlz+vn5loEPQvtk2SaQWF8f5Es9FhTyrx5oXqrFQto=;
        b=lrlUIfft1NTAU3k4Awsg+tCxtu0VJkVodck+f912BNL5QS2Qbu/p8hyYNKa+5JsLCL
         cyn8szU/3gk3d286zerjoghe/IMI7cr/Rp0oMi6OHEGJgCrN03/ZQotg02mTl3zjSg1s
         BU8JxJ9D8o11JnTZ93dJlQB+qHDF6tCNHmQ8VYA7ksWajkXqNJ/qeLvKsf1YgKN4RvY+
         8fMHjeXxkKCPl0/INkfkutIgWuHya3xS3hBTv5xpDuZRF/IBvg6obqid9S5tVaEejglJ
         jiICuuWO4irV/H/VND2M0NHV5yD/2Rkq0IT8vEPRUWqr6JCrPiXZc/XJ1N69OaYPIlSS
         MyiA==
X-Gm-Message-State: AJIora8YqQwhoMAoEd1cQn5B8J0wGSvCNUMdMys87wtvrUOjDAYSItxY
        LrdczOf46JQnC8f975z8S67/7UmPgZxP7T5ZS8M=
X-Google-Smtp-Source: AGRyM1s2rCRm9NZi3+BcFN1bdGqZUlRQHoELK5ylXKWIWJbDLygjEwbxB0zAp+ikAbNFrHL0rlXB9w==
X-Received: by 2002:a17:907:28c9:b0:72b:6912:5453 with SMTP id en9-20020a17090728c900b0072b69125453mr26755927ejc.419.1658183709973;
        Mon, 18 Jul 2022 15:35:09 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7c0c4000000b0043a3b90748asm9249109edp.26.2022.07.18.15.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 15:35:09 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bk26so19050757wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:35:08 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr24379660wrw.274.1658183707792; Mon, 18
 Jul 2022 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
 <YtXUAykqgRCY2AX3@worktop.programming.kicks-ass.net>
In-Reply-To: <YtXUAykqgRCY2AX3@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 15:34:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOGOm54vmHJx5t7P3MjWSsda9pLKdSzKziA+TrQcLb_Q@mail.gmail.com>
Message-ID: <CAHk-=wiOGOm54vmHJx5t7P3MjWSsda9pLKdSzKziA+TrQcLb_Q@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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

On Mon, Jul 18, 2022 at 2:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> FWIW, when I was poking at this last week, I found that -falign-function
> only seems to apply to the normal .text section and not to random other
> sections with text we create.
>
> Or rather, I was seeind a lot of unaligned functions that all had custom
> sections despite explicitly using the (what I thought was a global)
> function alignment toggle.

Hmm. This triggers a memory..

I think we may have two different issues at play.

One is that I think our linker script only aligns code sections to 8
bytes by default. Grep for ALIGN_FUNCTION.

And I think that any .align directive (or .p2align) only aligns
relative to that section, so if the section itself wasn't aligned, it
doesn't help to have some alignment within the section.

I may be wrong.

But I can definitely see gcc not aligning functions too, and doing a

    nm vmlinux | grep ' t ' | grep -v '0 t ' | grep -v '\.cold$' | sort

shows a _lot_ of them for me.

I think the main cause is that the ACPI code builds with

    ccflags-y                       := -Os -D_LINUX -DBUILDING_ACPICA

and that '-Os' will disable all function alignment. I think there's a
few other places that do that too.

I don't see the same effect in my clang build, so I think that -Os
behavior is likely gcc-specific.

In my clang build, I do see a few unaligned function symbols, but they
seem to be all our own assembler ones (eg "nested_nmi") and they seem
to be intentional (ie that "nested_nmi" thing is in the middle of the
"asm_exc_nmi" function, which is the real thing and which _is_
aligned).

                Linus
