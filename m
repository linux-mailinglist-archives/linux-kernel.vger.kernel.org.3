Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20058565DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiGDTRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGDTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:16:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AD1E1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:16:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i17so7290412ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MM4ez9sq6uBjf7T2AcL2UYNl+8nxT4N2iGuYkE53QQE=;
        b=hM6KgRdJckBe4bzC+IcRSC7lVdxBNHuWzTR9qbdyHQUEx0yLi33qBKXpEulNeapiqS
         laTzHjtCEdg71do6SFrzgzbtUfLzBDw03llXfnRTZmsFTWrIjKyDT8wyKG57tf5X4led
         nsoUHxFpJGeHUekjMViMmo8mgjNaTgaoZFXcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MM4ez9sq6uBjf7T2AcL2UYNl+8nxT4N2iGuYkE53QQE=;
        b=kijsUZZoArQspWJ+dKRgit/tepCylaAW7oyOrPQ2NusCLb0v6nNPFNGl3V2cg5+hOC
         H32sdxqKeAMBuCTTZ60dPwolaAIgYhvWFfJ6ALj3UN98e/Ix4nzgcAAQPnK0FwF4tAvY
         awNfyFB15nEBd0hMIJEFpsHOXyn/Tj7EVLjQxEMLhf0zoOGCB1+Pd0B0XJiNbOwEd6zG
         JSluDfnVyj0o1IuOrwQDIB+87DkZb0D0RfgwgTbFdm+yIox5+gEmYTxvM42RIa0Yz4hS
         oI4eJczw+sBCCVD0creWuYEQp2BQHgFq9NoMwzPqmD9Jw9mSb5yxdqLRv8JK+DIjPcwc
         Rrmg==
X-Gm-Message-State: AJIora8vpXBxKMMWPtDIAU0jxK2j24DxArgxZiaM7t0rtGZwHneNgy1E
        UbWKEJs+iMWodphM484G91eWg0o95DpgBLQLWoc=
X-Google-Smtp-Source: AGRyM1vP3YST+to1/RaphHGc3NhZdnPMQQKUyzeNoBBMnt1+Dan6peu+IpTEUdinJcEIlE6g6K2FCA==
X-Received: by 2002:a2e:8804:0:b0:25a:7158:328d with SMTP id x4-20020a2e8804000000b0025a7158328dmr17373366ljh.217.1656962213943;
        Mon, 04 Jul 2022 12:16:53 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q17-20020ac246f1000000b00478ee191091sm5261282lfo.153.2022.07.04.12.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 12:16:53 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a39so12045694ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:16:51 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:21b:ad72:5401 with SMTP id
 g7-20020a5d64e7000000b0021bad725401mr27236387wri.442.1656962200967; Mon, 04
 Jul 2022 12:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV>
In-Reply-To: <YsM5XHy4RZUDF8cR@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 12:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
Message-ID: <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, I've thrown a mount_lock check in there, running xfstests to
> see how it goes...

So my reaction had been that it would be good to just do something like this:

  diff --git a/fs/namei.c b/fs/namei.c
  index 1f28d3f463c3..25c4bcc91142 100644
  --- a/fs/namei.c
  +++ b/fs/namei.c
  @@ -1493,11 +1493,18 @@ static bool __follow_mount_rcu(struct n...
      if (flags & DCACHE_MOUNTED) {
          struct mount *mounted = __lookup_mnt(path->mnt, dentry);
          if (mounted) {
  +           struct dentry *old_dentry = dentry;
  +           unsigned old_seq = *seqp;
  +
              path->mnt = &mounted->mnt;
              dentry = path->dentry = mounted->mnt.mnt_root;
              nd->state |= ND_JUMPED;
              *seqp = read_seqcount_begin(&dentry->d_seq);
              *inode = dentry->d_inode;
  +
  +           if (read_seqcount_retry(&old_dentry->d_seq, old_seq))
  +               return false;
  +
              /*
               * We don't need to re-check ->d_seq after this
               * ->d_inode read - there will be an RCU delay

but the above is just whitespace-damaged random monkey-scribbling by
yours truly.

More like a "shouldn't we do something like this" than a serious
patch, in other words.

IOW, it has *NOT* had a lot of real thought behind it. Purely a
"shouldn't we always clearly check the old sequence number after we've
picked up the new one?"

                   Linus
