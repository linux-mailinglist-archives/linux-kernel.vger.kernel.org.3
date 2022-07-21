Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456C257D353
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiGUScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiGUScw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:32:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CE86C2C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:32:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so4643556ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R73YgZrLIlJfKQP7Dz276GH0gHxdx2MZ5pIXDHc/zZQ=;
        b=Yo+krzexnqWdMuTKccVWI9awZtte9vIYfO1Tncd/bvZBbmw/2tNO0HXSH5gCRmCmYH
         Ze/lfza3ylQtn3Cmp0YpH71s1BqX9JsyEUI4Z8Yj0pa8KzhhbVAr4WrBx4nVeNT5SWJz
         a7H05pSW1e8DJRZpuhC8/OAjU4mdKrbZ+TcoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R73YgZrLIlJfKQP7Dz276GH0gHxdx2MZ5pIXDHc/zZQ=;
        b=IQdh2TZsLh9/8b1tLS1jaEg2SqaIik1jJLdglWalbq7iJj+baXXuhA8PSLhgY1e6Fk
         NiGaOwAzRcAaGpH0Y790fJzAF5MK1VenHVIjls5qM2i8QYxX36Pfr7f+JUPViJr8jlXg
         g83YOOK1VXBeQDG8XiLpOb6WWh0RgrucwLtxasQPnzXILgTNgb5TVhNKvx/aLKM8sAsI
         58J12GCBW1ZQ7WMUMS1Y9FsFfJfRuY0XrzCOFYfOCxpq1bFznmHKGFTBvPOzeo972ghE
         VrcUPShZRC2YvHmhGuLzohGKjAHyhxgrQrR0vcPtXCAfJvETSO/kZAI89y+rLX8klCc2
         bPOA==
X-Gm-Message-State: AJIora/DW3+ZYC8iRAFt2KONtWN4qoNOPTS6IEd2WOWMLwCpkBZ1EpyS
        O/U4/lrXFjvJ6OVsR+gr2OQxD37KQkUZGj//0fA=
X-Google-Smtp-Source: AGRyM1tzetdyIYoCA99u9+hpz3tuiFqIfGAiUIH0ngiqEh5iDEyahifZc7afnMYOl0jX5qMsCfVwlA==
X-Received: by 2002:a17:907:96a1:b0:72b:918c:13f with SMTP id hd33-20020a17090796a100b0072b918c013fmr42440204ejc.659.1658428369458;
        Thu, 21 Jul 2022 11:32:49 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm1402284edb.75.2022.07.21.11.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:32:48 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id u5so3479122wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:32:48 -0700 (PDT)
X-Received: by 2002:a05:6000:1049:b0:21e:584f:3574 with SMTP id
 c9-20020a056000104900b0021e584f3574mr2487570wrx.274.1658428368088; Thu, 21
 Jul 2022 11:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net> <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com> <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net> <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com> <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
In-Reply-To: <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jul 2022 11:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=Z++NTkd5972_WSHJQ-G63k5-2eYjsQWkRvtW5+fEdQ@mail.gmail.com>
Message-ID: <CAHk-=wh=Z++NTkd5972_WSHJQ-G63k5-2eYjsQWkRvtW5+fEdQ@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
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

On Thu, Jul 21, 2022 at 11:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> R11,R11 are caller-saved, and since this is the actual call site, the
> caller must already have saved them or marked them clobbered.

Ok. I don't know the context, but I was thinking along the lines of
the same hash value perhaps being used multiple times because it has
the same function type.  Then using the "addl" trick means that the
hash value in %r10 will be changing and cannot be re-used.

But I guess this is *much* too late for those kinds of optimizations,
as it literally just outputs the raw instruction sequence, and so the
(negated) hash value will always be re-generated anyway, no re-use
possible.

             Linus
