Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F43578EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiGSAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiGSAIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:08:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447532D83
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:08:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so17462805edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+cot110De+UzG3wtW+Sy/wDH7YJ9KM5/a2EnekXAdA=;
        b=cnBODFppPN/QvytnTP/lRKnwByklCxNj/EX3D6zURE6vFkzZTEi+ZSCE3JvX/E75gX
         Ft/sJfCxXwc3LbvLSdi6LsjVl26SpqCXat727Jk5pfwbdOvF8oPbkt5ZfJ0lwJ7XqrXR
         LsgzqxgQQxn1h00DrWAKZRocBut9YdbKL+cp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+cot110De+UzG3wtW+Sy/wDH7YJ9KM5/a2EnekXAdA=;
        b=PiAqil+6CurhFAMvsPesONWJcqxJnpP5wL0euy1bAdkQhZ5URYMmQByZFAYj9M7RyU
         wRAaQMGw31y0XiKml/MeLXTEkNvKyNyH85GmI7DExZ7ET/ZcG9D1KOPLmnvuOB6Gggdd
         X+MM1BlAVhcN72A1eAmHKrT6CgjRL2htgFMNNgDYk0rSpPyMY10QoB6fTo1cG0hYmked
         JM2qlf3oXKTtehwVNxrnAfPYXT3YyHlIeLbx8EYP5Qbh6bMgZzcfQU1p519mX2naSizy
         bI1zhsHDek7NgDQQkT1eSxCFCFSvZlR9b14/KQnfUEbHd6mcBQOYYaxPeweqCTKCjJCM
         E8mQ==
X-Gm-Message-State: AJIora+7RGRjeARvLMQV2Oel1zmRuHQIa17M/Odmhv+Dh1BY2qip1zRE
        oJBogGWWSyUUqMW0Rgb/tWGSd0fb/bHrJWNZcSk=
X-Google-Smtp-Source: AGRyM1vsnv5KjxRQJBynCHIEKxoLT2TCvXrl3rsJra+p+oP3GJ4fjoxtTN2rwmAtfteOdCc72dI34Q==
X-Received: by 2002:a05:6402:2936:b0:43a:711c:7c9b with SMTP id ee54-20020a056402293600b0043a711c7c9bmr41267600edb.144.1658189296568;
        Mon, 18 Jul 2022 17:08:16 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b00722e0b1fa8esm5987387ejo.164.2022.07.18.17.08.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 17:08:16 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so41255wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:08:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr35068586wmq.154.1658188924208; Mon, 18
 Jul 2022 17:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
In-Reply-To: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 17:01:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
Message-ID: <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Jul 18, 2022 at 4:52 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, I think that would be a better model - yes, you lose 8 bits
> of hash, but considering that apparently the current KCFI code
> *guarantees* that the hash pattern will exist even outside the actual
> target pattern,

Gaah, I'm being stupid,. You still get the value collision, since the
int3 byte pattern would just be part of the compare pattern.

You'd have to use some multi-instruction compare to avoid having the
pattern in the instruction stream. Probably with another register.
Like

        movl -FIXED_OFFSET(%eax),%rdx
        addl $ANTI_PATTERN,%rdx
        je ok

so that the "compare" wouldn't use the same pattern value, but be an
add with the negated pattern value instead.

The extra instruction is likely less of a problem than the extra register used.

             Linus
