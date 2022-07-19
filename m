Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB1578F80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiGSBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:02:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7329C84
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:02:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so24423655ejs.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7B8C2QP8Fw8N+gzO0HhTRjwCPBV+x5eTN6iB8Fc1ob0=;
        b=brSztL/ujHQ7QyIpCxI3xIDeRK7HKsiGn6mxK9tyzhuycUQF/uFCvoa6389WQP6eYF
         dqtReRWV2C4EAaUQU5soyAgx12MpiRPKo8vUPBoWUZcap87SkP9b4cKOVvVIQaBK62bl
         utxYppperGL1gB1La5oP3g8wBx+DOcZHumZ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7B8C2QP8Fw8N+gzO0HhTRjwCPBV+x5eTN6iB8Fc1ob0=;
        b=AAMV6tkcyWLT5Ja628qBHO9n0cRBIQpiu2tlW9gScuXI8dnvUH8c2fgECwvkj2z6By
         At9SVB8xF297nq97bNbdbbQ/M+Q2CaGcxPwKdiy0r8rj+AFFYz7iOC8XOd59jTxnWEMn
         O/+1SYhcJahZy9XpWwDWhlh8uGHUC0ppq3QOjtRpI0KfCmNGBrRr344hB3b5HTtcasEh
         8e6akK/EQcxDjjWfQnfb+Fde6qrynaZAPTLI1p0TnQaOKv2oL5RAd+C4jaBi4Ew/5Aa8
         UgdiKDww7vx/CFJAvYjQTOFUJU/GELesHJ/H+vdYpy2jiObiuz5vDsXhJE0H+cxmw3z8
         BGQg==
X-Gm-Message-State: AJIora/V2a+dllzKhSFz1qZurpplbG7STiYD/+FJ1u1oBne2uaJFTBD0
        8zDHaMZC7CQZy8szeDoSvaKp7G5+bWTafmFRXhE=
X-Google-Smtp-Source: AGRyM1vP7mD5NmVKOsV4eKxIh+lxRaLQf4TKzUdxfRqELD/Z9KWQ5r9dV67XbATToiBrV1fKgHnadQ==
X-Received: by 2002:a17:907:c14:b0:72b:6762:de34 with SMTP id ga20-20020a1709070c1400b0072b6762de34mr28022971ejc.94.1658192549133;
        Mon, 18 Jul 2022 18:02:29 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090636d300b00722e7e48dfdsm5976270ejc.218.2022.07.18.18.02.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 18:02:27 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bu1so19408471wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:02:26 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr25238485wry.97.1658192546536; Mon, 18
 Jul 2022 18:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net> <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com> <YtX5enG0eN1XUzGR@worktop.programming.kicks-ass.net>
In-Reply-To: <YtX5enG0eN1XUzGR@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 18:02:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfeNc3kFGt7W1RAkbArspfy_usPMvd4nT3AP90HqvmKQ@mail.gmail.com>
Message-ID: <CAHk-=wjfeNc3kFGt7W1RAkbArspfy_usPMvd4nT3AP90HqvmKQ@mail.gmail.com>
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

On Mon, Jul 18, 2022 at 5:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So it's like 2:15 am here, so I might not be following things right, but
> doesn't the above mean you have to play funny games with what a function
> pointer is?

Yes, but probably no more than compilers already do.

On x86, function pointers are simple, and just pointers to the first
instruction of the function.

But that's actually not true in general, and several other
architectures have *much* more complicated function pointers, where
they are pointers to special "function descriptor blocks" etc.

So I bet gcc has all that infrastructure in place anyway.

And the whole "use a different address for a direct call than for an
indirect call" is still much simpler than having an actual separate
function descriptor thing.

At worst, you'd actually always generate the thunk for the indirect
call case, and let the linker kill unused cases. The compiler wouldn't
even have to know about the two cases, except to use a different names
for the direct call case.

Do I claim it would be *pretty*? No. But I bet the existing CFI
patches already do things like this anyway.

(I have llvm sources on my machine too, because I used to build my own
clang from source back when I was testing the asm goto stuff. But
unlike gcc, I've never really *looked* at llvm, so I'm not familiar
with it at all, and I'm not going to try to figure out what the CFI
code actually does, and instead just handwave widely while saying "I
bet it already does this".)

               Linus
