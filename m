Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659E50AB86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442484AbiDUWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442479AbiDUWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:33:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87C3A739
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:30:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x33so11161927lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9cAYvb1fajnuuWroVGBAQg2SyMPi+ao+icYUcRJyvU=;
        b=GN446QivH3vBBLm/lBdLdrQsSdaGiQFAOD0yQkse5mbC3iu1rO495JlJwm5qbIfZyk
         i/nWhcq/hJuvqAnpg/6yVZ4qDSrZwS4DuiJSB9qv1XoAa0u69k5zn6ksqP6ATEQZDK3g
         JYVFBovhxc1lT2JRbxK3kBBtrE8OgoR0iTq4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9cAYvb1fajnuuWroVGBAQg2SyMPi+ao+icYUcRJyvU=;
        b=JA/09jRIwvwKUT6vSrtFmpNKPE07W8kWqjcjaIPH+FGbBfh8v3DRYsjCryAwfjMLT0
         XiMj/by1MvG7HDQxkwtovcXTmWU6j/4/BZgicFwsDoUvBBo9HZqBl4DPTLrX88a4KvGz
         wYhNP0QUZDMaDgXHV53CAVNgN7pzPajJkCpOhRQcXepqC0knHta5v6ebCFsWNl5eVNrm
         OJ3R/KfN3PNVQlEAtrg7q3xu7zRpTIYWqeESMK/mrsaKbn3INyiH4jLhufunbrJn1jY0
         jij4VO2ZFAVwvfGFT4hQrc8TbcMgYj/+UO1YFNMxbEZ5LVGmtVAy4Rk2SAqjqYRlN2qm
         u3UA==
X-Gm-Message-State: AOAM53361NLfCZYQecWbg6Hf2BH4p6vLiNvbnBv2ejgamY+R640qwXbV
        p7iFfbK2wv8N0FuEh2jX2jAIwZuGGVJqCkmnsho=
X-Google-Smtp-Source: ABdhPJxR6+Y3bSvN2qupI6Zl7W0MJTdhKrY5JUnBlKgsouJlrcDoIC8bwPdXrOxX6pqM4vQUTIDCfg==
X-Received: by 2002:a05:6512:3f01:b0:46b:a5ba:3b89 with SMTP id y1-20020a0565123f0100b0046ba5ba3b89mr1101397lfa.28.1650580245707;
        Thu, 21 Apr 2022 15:30:45 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea446000000b0024b0abb3984sm17267ljn.134.2022.04.21.15.30.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 15:30:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 17so7469703lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:30:42 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr1064274ljg.291.1650580242430; Thu, 21
 Apr 2022 15:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com> <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
In-Reply-To: <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 15:30:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
Message-ID: <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 2:53 PM Song Liu <songliubraving@fb.com> wrote:
>
> However, we cannot really use the same function at free time. The
> huge page is RO+X at free time, but we are only zeroing out a chunk
> of it. So regular memset/memcpy won=E2=80=99t work. Instead, we will need
> something like bpf_arch_text_copy().

I actually think bpf_arch_text_copy() is another horribly badly done thing.

It seems only implemented on x86 (I'm not sure how anything else is
supposed to work, I didn't go look), and there it is horribly badly
done, using __text_poke() that does all these magical things just to
make it atomic wrt concurrent code execution.

None of which is *AT*ALL* relevant for this case, since concurrent
code execution simply isn't a thing (and if it were, you would already
have lost).

And if that wasn't pointless enough, it does all that magic "map the
page writably at a different virtual address using poking_addr in
poking_mm" and a different address space entirely.

All of that is required for REAL KERNEL CODE.

But the thing is, for bpf_prog_pack, all of that is just completely
pointless and stupid complexity.

We already *have* the other non-executable address that is writable:
it's the actual pages that got vmalloc'ed. Just use vmalloc_to_page()
and it's RIGHT THERE.

At which point you just use the same bpf_jit_fill_hole() function, and
you're done.

In other words, all of this seems excessively stupidly done, for no
good reason.  It's only making it much too complicated, and just not
doing the right thing at all.

                Linus
