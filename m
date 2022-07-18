Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68F578E65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGRXmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGRXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:42:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E33244D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so24121114ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2wWsHBzWaoHMXXFu8RTrRcffXzVK/Y99IpZoEKnNG0=;
        b=h7wyNYsXSRuaLt0cfCGQ+xiqw67XsNzuawdivwWuxMtgMqdp2Dqhsw2k/QTIf7bqru
         WK0RiIY5eZXEJLpKIGNyMH/TE6LwhseEu7uPrBg83fCnNSIQKbI5ZUPi+QHnWVf6tph4
         bFxha4ILzSHYlSUo9DCjQA9w3LHF8NnVGjQBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2wWsHBzWaoHMXXFu8RTrRcffXzVK/Y99IpZoEKnNG0=;
        b=bGlISPuK1CyETqyD1RKI6IiOP8g7oslxhONlMSoTLzS2OjCWggVQEqc51tPjlU8Dj3
         4ekA5RmS1egPoynDpr1akM5PBc8t6KOJ/BUhB6th3Xy0WKcZhgdXGaKbB2tmAEQAiOCn
         7Fo81P/b2pLCZ2+JyrXNV78QQUH9K8aEl4GcZyc37GFackDt0+9CZDqyGJiea5eKZdMl
         ZqZdFtVIkfGt4AT8RXH0HnUjFQ61aIipvdm6Xqmyf7mKyPki2KHi1n90dR/xQF8lUnAF
         1vdjEdMTaPOP2p/G3BGfb7C96gJ2HNnqJDVdym3xaLwIi53UJvxh9WposSgCnHk+K6m3
         G6ug==
X-Gm-Message-State: AJIora9p34e1GqFYVOwIGHnMRapXXAc3Cy+2z/wj/SIDreVe492KTHE5
        19FjTfQbU/jZ32sNxg+SNcUQcx6RwYcli8462VY=
X-Google-Smtp-Source: AGRyM1tjmYBmP5wl5uqOVSe2rpCUGoyhQV2lYWZjUz+COABmW7DeweepY0dUMQHTO6FXsej8WqpSpA==
X-Received: by 2002:a17:907:7f8e:b0:72f:11ec:f5f8 with SMTP id qk14-20020a1709077f8e00b0072f11ecf5f8mr13440428ejc.343.1658187770670;
        Mon, 18 Jul 2022 16:42:50 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id lb2-20020a170907784200b0072f2e409575sm2120686ejc.98.2022.07.18.16.42.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:42:47 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so8214752wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:46 -0700 (PDT)
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id
 z17-20020a05600c221100b003a3214988e1mr2129287wml.8.1658187765714; Mon, 18 Jul
 2022 16:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com> <87fsiyuhyz.ffs@tglx>
In-Reply-To: <87fsiyuhyz.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 16:42:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
Message-ID: <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
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

On Mon, Jul 18, 2022 at 4:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But that's an implementation detail, right? Whatever we put in between
> will still be a fixed offset, no? It's a different offset, but that's
> what patching can deal with.

No, what Sami is sayin that because the "cmpl" *inside* the function
that checks the hash value will have that same (valid) hash value
encoded as part of it, then you actually have *two* valid markers with
that hash value.

You have the "real" marker before the function.

But you also have the "false" marker that is part of the hash check
that is *inside* the function.

The "real marker + 6" points to the function head itself, and so is ok
as a target (normal operation).

The "false marker + 6" points to the "UD2", and so is *also* ok as a
target (bad guy trying to mis-use the false marker gets trapped by
UD2).

               Linus
