Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25CD578B43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiGRTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiGRTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA031DFA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:51:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf4so23283519ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6A956WYUO29o8aXvwOKjdN1VhCZMhvt6dhIwD6j8CI=;
        b=ZE0mxgV5M/vTD2TZG9dzY+IbFs/6eOD12TS2xwBjR8UELYWPsck5+pF0NHrkTuTIzX
         1wkYnO6fQmjf59ZEN6F9YKBr0FKQR8U5s2g6mmzXbe0Zt/jRf5KBCO8ACndAB7g6/mYN
         n7NfXgDjPBdcsmEnOnkQj1GN49Eo+Vrd8OYnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6A956WYUO29o8aXvwOKjdN1VhCZMhvt6dhIwD6j8CI=;
        b=AJD09rL+JkpDHSPQcbWL1jpjmbSZ+ggT85BovRUHgGyBnebGCbxdgYIxOiPl0yfCAS
         C7iN1g13fs26+0OwxWbiqFMqmejZzrwTgN+7NxvevV6pYUqBzTUkwYLlOtjGBM7FLQ0f
         Mx51xxOaz8gzqUYOXmA1dRwvTDoXkEdsgoZU9J8emxb18/vlt4LicmJg9XIbF9+balsz
         jzWZezYzi14IzPVizerAuM3KKk0/cDgwKHjbHP7iZP6Rl/6JqBFgdB8HwpYdwPLDakjS
         koqiJVBl8XJmRHE5Wh5l8/dfywxtnCi7R8NKaGGN7cTz/FG6Uj7ZHbWdD6v3KG9/BDuF
         vCZA==
X-Gm-Message-State: AJIora/WPoFKXqOlfZYnIqTdWqOZiP5Y7Gwg4oTMkSxqnPkqPuwCYgrX
        eYu3Om8x12B/XX19GmeB1hRmGw0AAY4aX4S7lPI=
X-Google-Smtp-Source: AGRyM1u/NAfjetOkEJcdox9v+/vGriZvV9n5yu+6J2SYiX5S3VlR1ZgZ/1ASsE250v8IhEGH/1H5gA==
X-Received: by 2002:a17:907:7205:b0:72f:38ec:f70e with SMTP id dr5-20020a170907720500b0072f38ecf70emr4916216ejc.130.1658173897204;
        Mon, 18 Jul 2022 12:51:37 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id lv8-20020a170906bc8800b0072b91a3d7e9sm5814921ejb.28.2022.07.18.12.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 12:51:36 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso40376wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:51:35 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr19795045wmf.38.1658173895466; Mon, 18
 Jul 2022 12:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx> <87tu7euska.ffs@tglx>
In-Reply-To: <87tu7euska.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 12:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
Message-ID: <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
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

On Mon, Jul 18, 2022 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Let the compiler add a 16 byte padding in front of each function entry
> point and put the call depth accounting there. That avoids calling out
> into the module area and reduces ITLB pressure.

Ooh.

I actually like this a lot better.

Could we just say "use this instead if you have SKL and care about the issue?"

I don't hate your module thunk trick, but this does seem *so* much
simpler, and if it performs better anyway, it really does seem like
the better approach.

And people and distros who care would have an easy time adding that
simple compiler patch instead.

I do think that for generality, the "-mforce-function-padding" option
should perhaps take as an argument how much padding (and how much
alignment) to force:

    -mforce-function-padding=5:16

would force 5 bytes of minimum padding, and align functions to 16
bytes. It should be easy to generate (no more complexity than your
current one) by just making the output do

        .skip 5,0xcc
        .palign 4,0xcc

and now you can specify that you only need X bytes of padding, for example.

                        Linus
