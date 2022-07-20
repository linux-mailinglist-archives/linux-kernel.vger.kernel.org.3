Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0C57BD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiGTSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiGTSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:07:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27323AE57
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:07:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so24800635eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfFInv5ImNO15plC0c/RcDxCy7llN2JkDjkw6ed6RCE=;
        b=AasR9VXxENAmKepuQslkxQbHvFYqU1QK/1I7fRsP60vVlub1ST9OvYs4fSJbB4sEcm
         /uuI4OPOwHEvMfjfvkYfZmHgUgIQj/7tb/1DxAZaLOkb1ZqRneukGeIqD/J0HdQEDG9/
         odV/kjT8UkQOwAjH4LXl8Lun4rxoosQoE+iD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfFInv5ImNO15plC0c/RcDxCy7llN2JkDjkw6ed6RCE=;
        b=B2cFh+LpI8OIh6lXCaYBKUnXM93LGDICKncU08lNkZDifFenEIrgOC+RSJOAm6S0jL
         f9tUPtBMzK/GCQULbSOcHVTAtKC+c4gXqc+PWAmQj6/WtN7L0G8J7Vomi/tVoCSrhEbI
         NM2SNxt8SHdXiEfplGF+9ecBpmyxGMXxNMx0ocN4OfdIcIrhZ3zwMyC4S0XY0ovvVaTR
         S0aSfcDDtluw8nuq0S6sstwhoLdhbpCjaHiC90LreNlXHSNAQk0nii2rPt0gVrPT7BgY
         moYh9TUJkQR8DGcgk8R7SJPHMG55j1hNwxLKQqyV2VYzqTWwWRZLSV2Z7TuU9+F6+Doa
         ZlQA==
X-Gm-Message-State: AJIora/+vNashEl7DdFAST3qn1fgQbGTPnPvUIZtxQEcHukm1AXm07MX
        bIZk7J6EEHbeLMzpqqzBER2xmwuBbxrnHZB9K6g=
X-Google-Smtp-Source: AGRyM1tcOsYFocD9SuVauwYs6dZ7vXVXRm60cZiKNVMlMaDTHb9FDCoeX/1nTN7pdzWoW0yxuo+k7g==
X-Received: by 2002:aa7:d155:0:b0:43a:bc8d:8d75 with SMTP id r21-20020aa7d155000000b0043abc8d8d75mr52493768edo.322.1658340465357;
        Wed, 20 Jul 2022 11:07:45 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ez7-20020a056402450700b0043a87e6196esm12569182edb.6.2022.07.20.11.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:07:43 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bu1so27234333wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:07:42 -0700 (PDT)
X-Received: by 2002:adf:dd91:0:b0:21e:4e97:c146 with SMTP id
 x17-20020adfdd91000000b0021e4e97c146mr2233216wrl.281.1658340462416; Wed, 20
 Jul 2022 11:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <20220720125736.48164a14@gandalf.local.home>
 <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
 <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net> <20220720135016.3178ffc6@gandalf.local.home>
In-Reply-To: <20220720135016.3178ffc6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jul 2022 11:07:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
Message-ID: <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Jul 20, 2022 at 10:50 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> [    2.464117] missing return thunk: lkdtm_rodata_do_nothing+0x0/0x8-lkdtm_rodata_do_nothing+0x5/0x8: e9 00 00 00 00

Well, that looks like a "jmp" instruction that has never been relocated.

The 'e9' is 'jmp', the four zeros after it are either "I'm jumping to
the next instruction" or "I haven't been filled in".

I'm assuming it's the second case.

That lkdtm_rodata_do_nothing thing is odd, and does

    OBJCOPYFLAGS_rodata_objcopy.o   := \
                            --rename-section
.noinstr.text=.rodata,alloc,readonly,load,contents

to put the code in an odd section. I'm assuming this hackery is
related to it then not getting relocated.

                    Linus
