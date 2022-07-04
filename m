Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CD6565D21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiGDRhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGDRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:36:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109112AD1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:36:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x10so5158135edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJyesbik3li+nd7lTgRBI8S9OD6JxlDs1GIHpVzW1PQ=;
        b=fwlp1HglFHpX7O+wTF2XFvDWUo4ymN7/Rg1c4kPC5Eo6huCSyB0caRrsz6TFxUX8uX
         qHBcGYMvaNyvVCGIUL8QHtTWVIH0IUT+rGAL3vVJRHDlPNjZBZEB7KnXg7NwJI8bS3PZ
         v4KpFB9uFWPZ7wy3+FjBv+XuIC8U8KIqUqUIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJyesbik3li+nd7lTgRBI8S9OD6JxlDs1GIHpVzW1PQ=;
        b=Sb5VgViOBPidOMzFxoYrubt+wv5074lOfJ7bsskJYH1AUAHYjvhG1Z0D8F2pv89rKS
         px4SYIuV8KyIaHnSRPsrFBgGzpr7T/JDJkfqpYlGqZiGntPB/Nh93hrevIdDjhLz7EGk
         Hnp1kI3Vg7IHOw6VZtWI5lK3OfcnGDW+tzyU87eCpE31RiNXwZkxmlz7Rpov5ldhzCaD
         HTQ02YMN3JjJ42GJUe+GEDYVHJpicx0IOmfPO0zMzu/itd0EQRrfFBPkohFYz0AG3YFZ
         TRqvXWnA9epxX1kKVztH5BUuNrHiHt4PAK9ufPZzXQL9By4CUU5a4J5ykkuiXaFlRfe2
         H1JA==
X-Gm-Message-State: AJIora99iFtI/FrzNDsUfM7D0EpdIagIdBKNC52QXbs0lWkalmnKZKYA
        zXalHeCTZEvTyzgqPKNrULey+KiHoGUvajBMLXY=
X-Google-Smtp-Source: AGRyM1vaFU3NHq2ggGtNWhbV0/kNGo47u1LzAy62f4rJDSdl5CLV/Qia4e65iPDIRFAw8jmKIHspyw==
X-Received: by 2002:aa7:d30b:0:b0:43a:4bea:75c6 with SMTP id p11-20020aa7d30b000000b0043a4bea75c6mr9560244edq.12.1656956195296;
        Mon, 04 Jul 2022 10:36:35 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7d648000000b004377151dfbdsm18015082edr.50.2022.07.04.10.36.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 10:36:34 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id sb34so17767526ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:36:32 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr27345923wrx.281.1656956181432; Mon, 04
 Jul 2022 10:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com> <YsJWCREA5xMfmmqx@ZenIV>
In-Reply-To: <YsJWCREA5xMfmmqx@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 10:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
Message-ID: <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Sun, Jul 3, 2022 at 7:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, trying to write a coherent documentation had its usual effect...
> The thing is, we don't really need to fetch the inode that early.

Hmm. I like the patch, but as I was reading through it, I had a question...

In particular, I'd like it even more if each step when the sequence
number is updated also had a comment about what then protects the
previous sequence number up to and over that new sequence point.

For example, in __follow_mount_rcu(), when we jump to a new mount
point, and that sequence has

                *seqp = read_seqcount_begin(&dentry->d_seq);

to reset the sequence number to the new path we jumped into.

But I don't actually see what checks the previous sequence number in
that path. We just reset it to the new one.

In contrast, in lookup_fast(), we get the new sequence number from
__d_lookup_rcu(), and then after getting the new one and before
"instantiating" it, we will revalidate the parent sequence number.

So lookup_fast() has that "chain of sequence numbers".

For __follow_mount_rcu it looks like validating the previous sequence
number is left to the caller, which then does try_to_unlazy_next().

So when reading this code, my reaction was that it really would have
been much nicer to have that kind of clear "handoff" of one sequence
number domain to the next that lookup_fast() has.

IOW, I think it would be lovely to clarify the sequence number handoff.

I only quickly scanned your second patch for this, it does seem to at
least collect it all into try_to_unlazy_next().

So maybe you already looked at exactly this, but it would be good to
be quite explicit about the sequence number logic because it's "a bit
opaque" to say the least.

                   Linus
