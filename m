Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92E5A301F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiHZTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbiHZTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:41:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6548381685
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:41:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so5006220ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qH9fXuLG/2N7XJd2Ax6mCY7hEPgeeICD6t/tT+e4ZA0=;
        b=OpNlxqMQbRgNEJYIapLZRyQ8QLwCr73YGaTNiV0QC490OmZqzOw8r4qyVuMJ9681dr
         No7PNh11cqUCQ6/tlGADYZyVLggenKnKCbhwK3EhhA7NtQAfrR6gJfRDHAKdwOLHx5t8
         vBiepUa6W5cge4oVs0JpvJo51S3Adxw2YNf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qH9fXuLG/2N7XJd2Ax6mCY7hEPgeeICD6t/tT+e4ZA0=;
        b=a+GlkWex5Lz788ARmZGtnzfGFBqFOUegZUPftTEYijeMdJVOgWzlxj7pDmq2eXfYoF
         87YoP4jvYV4puBAPLL5RZqhXgCa2vkvCflAonldRatLqFHY7OOCRa3/lrdxxA4FYo01N
         YRYmsJFY1qqN/76rB1pmf1SsnqCmoVftJjBJLMVK4Q51xaTX0HT8396iLgjOQf/5/jaD
         VP8ga3e0K8Bjtgh4q5hrhtvHSRB/IuoicPzgLQ6MuHsDMzhZ7eYj9Cbh6efKAdtO11JY
         T23aZzEDiR23dkrfY7veKwlsT5XWOyUdKuKwdSX68jiG/9/V2TESuNBcBdcOk/ocS0EN
         94cQ==
X-Gm-Message-State: ACgBeo3Vni/4B178/1OHrojQqseehgfPXveCGDgXzLA2sxohLykCoIlE
        +P6vcE1hVjYC1Y90vEFQk3PEwgp+TNvalzhuLYg=
X-Google-Smtp-Source: AA6agR42Lgl18BL7HZY1PFN9IunLTylK/knNyiNUI74g+4byUn6H4bNf2r030x7VvGVL6fGQmTWHbw==
X-Received: by 2002:a17:907:9625:b0:730:ad62:9c86 with SMTP id gb37-20020a170907962500b00730ad629c86mr6312431ejc.281.1661542914433;
        Fri, 26 Aug 2022 12:41:54 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ku1-20020a170907788100b00738467f743dsm1254343ejc.5.2022.08.26.12.41.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 12:41:53 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id nc14so95330ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:41:53 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr600450wrp.281.1661542902549; Fri, 26
 Aug 2022 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org> <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
 <CAHk-=wg-LXL4ZDMveCf9M7gWWwCMDG1dHCjD7g1u_vUXsU6Bzw@mail.gmail.com> <20220825215754.GI25951@gate.crashing.org>
In-Reply-To: <20220825215754.GI25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 12:41:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
Message-ID: <CAHk-=wj_nfiLk_bzjD8GWFFzm17syvOYqS=Y7BOarMSTkMiamQ@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:10 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> But UB is defined in terms of the abstract machine (like *all* of C),
> not in terms of the generated machine code.  Typically things will work
> fine if they "become invisible" by inlining, but this does not make the
> program a correct program ever.  Sorry :-(

Yeah, and the abstract machine model based on "abstract syntax" is
just wrong, wrong, wrong.

I really wish the C standard people had the guts to just fix it.  At
some point, relying on tradition when the tradition is bad is not a
great thing.

It's the same problem that made all the memory ordering discussions
completely untenable. The language to allow the whole data dependency
was completely ridiculous, because it became about the C language
syntax and theory, not about the actual code generation and actual
*meaning* that the whole thing was *about*.

Java may be a horrible language that a lot of people hate, but it
avoided a lot of problems by just making things about an actual
virtual machine and describing things within a more concrete model of
a virtual machine.

Then you can just say "this code sequence generates this set of
operations, and the compiler can optimize it any which way it likes as
long as the end result is equivalent".

Oh well.

I will repeat: a paper standard that doesn't take reality into account
is less useful than toilet paper. It's scratchy and not very
absorbent.

And the kernel will continue to care more about reality than about a C
standard that does bad things.

Inlining makes the use of the argument go away at the call site and
moves the code of the function into the body. That's how things
*work*. That's literally the meaning of inlining.

And inlining in C is so important because macros are weak, and other
facilities like templates don't exist.

But in the kernel, we also often use it because the actual semantics
of "not a function call" in terms of code generation is also important
(ie we have literal cases where "not generating the 'call'
instruction" is a correctness issue).

If the C standard thinks "undefined argument even for inlining use is
UB", then it's a case of that paperwork that doesn't reflect reality,
and we'll treat it with the deference it deserves - is less than
toilet paper.

We have decades of history of doing that in the kernel. Sometimes the
standards are just wrong, sometimes they are just too far removed from
reality to be relevant, and then it's just not worth worrying about
them.

          Linus
