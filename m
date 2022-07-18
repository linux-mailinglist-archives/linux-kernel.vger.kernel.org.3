Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E40578C79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiGRVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGRVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:10:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C29633F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:10:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so15124970lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m1OMyYk7raOHV+TupInm2lbwDMKSzKCsG8N04HxtFk=;
        b=YBKtMTz8k/VF0PZYG9BYjlCdE2HFLOGNa8YEHj5OErDXmax0OAUCwu8Jl2tjefLfu3
         HpKw5wON2rc5OyNFJK0m27+FzgrzO5YPg/wLoZWuIAHi8hOhgslvnYYkPs1byO6W2Vj7
         5x61AvO29R8LgzLW6YX855n04CgqZPwq5uPfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m1OMyYk7raOHV+TupInm2lbwDMKSzKCsG8N04HxtFk=;
        b=fjWxJzSL06Wtat1oMCh78VkucbIcU2SjbsyL3EbAyv2H9ORCHEZV2ewtY6/YjaiS9U
         lLNNrhHTv70X7fNPJ7ju+4kGaJU0olmo/7roQPC1L+j+jXrzuWNvb0O73Gq0RTyfs2sc
         cgR+MePTmKpAaRMUGR7+ErmkxI3IP75jxCIs66SUsn2qjwudJHNaJkqxAtGfmB9qMtOt
         ck/7gnW33Xxhc5P4s/VfWbEqF1EI6U1hbAowuljrae4DuFJ4GBRUY0T9D8XQTk4Vu4hd
         AB0cTXyk4hgCih9stbRWACsCa47pWFHfMMX6zlm+RvO80wu+OpnChZQxOAENxxE9bM5s
         yKLw==
X-Gm-Message-State: AJIora8oqME2PgnZJRxmkhEg4kQv8yBwisqogPZUodMJ3FnZfpJQ1ytt
        b0Rotdv3d/LYdEK5aJZMN+48XUmHCvk9gjtvzhA=
X-Google-Smtp-Source: AGRyM1ujThqljBgc2vxKJr6Cc1AYSGhDTPTTMi+MGQ3oCSdj7nX5BHom7z/DhObEj4qHfqpEu4vEtQ==
X-Received: by 2002:a2e:a40f:0:b0:25d:8e71:bb28 with SMTP id p15-20020a2ea40f000000b0025d8e71bb28mr13071883ljn.72.1658178615134;
        Mon, 18 Jul 2022 14:10:15 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512114200b00489c56f9f80sm2776528lfg.117.2022.07.18.14.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 14:10:14 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bp17so21538118lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:10:14 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr24162164wrw.274.1658178120409; Mon, 18
 Jul 2022 14:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
In-Reply-To: <87o7xmup5t.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 14:01:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
Message-ID: <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jul 18, 2022 at 1:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Yes, Peter and I came from avoiding a new compiler and the overhead for
> everyone when putting the padding into the code. We realized only when
> staring at the perf data that this padding in front of the function
> might be an acceptable solution. I did some more tests today on different
> machines with mitigations=off with kernels compiled with and without
> that padding. I couldn't find a single test case where the result was
> outside of the usual noise. But then my tests are definitely incomplete.

Well, it sounds like it most definitely isn't a huge and obvious problem.

> Yes, I know. But it was horrible enough to find the right spot in that
> gcc maze. Then I was happy that I figured how to add the boolean
> option. I let real compiler people take care of the rest. HJL???
>
> And we need input from the Clang folks because their CFI work also puts
> stuff in front of the function entry, which nicely collides.

Yeah, looking at the gcc sources (I have them locally because it helps
with the gcc bug reports I've done over the years), that
ASM_OUTPUT_FUNCTION_PREFIX is very convenient, but it's too late to do
any inter-function alignment for, because it's already after the usual
function-alignment output.

So I guess the padding thing is largely tied together with alignment
of the function start, so that idea of having different padding and
alignment bytes doesn't workl that well.

At least not in that ASM_OUTPUT_FUNCTION_PREFIX model, which is how
the gcc patch ends up being so small.

               Linus
