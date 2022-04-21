Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69A50AAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442103AbiDUViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDUVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:37:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0B3EA85
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:35:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 21so8161182edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nl/sxTqX3tPVuNmSVZ0W9Oabdpfd0rG/HOuhpDMx8IU=;
        b=SGD9XjL10rEx9mfSetxfZDlzHyWhah/RqUC1yuJDs6G0kwXr3WaCGrlxPbDhZrektk
         vMEv5vROGWM1yTs+l7MxtDylQphutpR87FxU5d1udkQrNd3uJmHojGgHG1MGJot8wiAh
         JNzYAMieKMZP8RTasxN1p6T3tb37MEirFAfFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl/sxTqX3tPVuNmSVZ0W9Oabdpfd0rG/HOuhpDMx8IU=;
        b=Aep8XzOw8F0cVQuJcJe7pBtv4wD136Oz/57fQgRp9psglvhlqmMBUcwNr6XrVzFgqk
         k+4ygmg9N7VASkabP8XImqVu8SnGHsjbjGChTVVLEhxfbhLGn0AFxkux0+I1LpS8LzlZ
         b+0ditF9bYxR8GIYQkeu/MTGBcuBVURwFuGmct4A0qbIO+ZL3Yc5NTeHMUyU6OoNcg3I
         x/kRRBlsmisC9fSFSiU38PPU7/OUlx5IrWmrzJOIVM29PDOnrMB8kk0l8elO45Smn75W
         u5g2kdjF3rsgsiBxWvSsu7MF5jG16tNE0vwkkdWqfKAAEFFUq6DRjCVNVpK9ft2bIEPY
         cImA==
X-Gm-Message-State: AOAM531TLp7IDdyv+yMzd6g9MRh6WMOleuMywojR/gFlHXwSBmJO3NYs
        3ec3zlP04o/QytsdDCmtFjI/Xkf/zQrEMaIZwZU=
X-Google-Smtp-Source: ABdhPJwgXDcxWpzhkmAvdiUdszGBKF+Gc9VbVmMPuyndwwbFVQxJ2z0Nw5qYUTafIOpOShK/SXJbXQ==
X-Received: by 2002:aa7:d311:0:b0:423:e539:8581 with SMTP id p17-20020aa7d311000000b00423e5398581mr1576439edq.111.1650576906446;
        Thu, 21 Apr 2022 14:35:06 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709067c0400b006ef810aab6fsm69301ejo.213.2022.04.21.14.34.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 14:34:51 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id u3so8414913wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:34:50 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr927158lfg.52.1650576516819; Thu, 21 Apr
 2022 14:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com> <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
In-Reply-To: <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 14:28:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
Message-ID: <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Thu, Apr 21, 2022 at 12:41 PM Song Liu <song@kernel.org> wrote:
>
> The extra logic I had in the original patch was to erase the memory
> when a BPF program is freed. In this case, the memory will be
> returned to the bpf_prog_pack, and stays as RO+X. Actually, I
> am not quite sure whether we need this logic. If not, we only need
> the much simpler version.

Oh, I think it would be good to do at free time too.

I just would want that to use the same function we already have for
the allocation-time thing, instead of introducing completely new
infrastructure. That was what looked very odd to me.

Now, the _smallest_ patch would likely be to just save away that
'bpf_fill_ill_insns' function pointer in the 'struct bpf_prog_pack'
thing.

It's admittedly kind of silly to do, but it matches that whole silly
"let's pass around a function pointer to a fixed function" model at
allocation time.

I say that's silly, because it's a fixed architecture function and we
could just call it directly. The only valid function there is
jit_fill_hole(), and the only reason it uses that function pointer
seems to be that it's never been exposed as a real function.

So passing it along as a function seems to be _purely_ for the silly
reason that people haven't agreed on a name, and different
architectures use different names (ie power uses
'bpf_jit_fill_ill_insns()', RISC-V calls it 'bpf_fill_ill_insns()',
and everybody else seems to use 'jit_fill_hole'.

I don't know why that decision was made. It looks like a bad one to
me, honestly.

Why not just agree on a name - I suggest 'bpf_jit_fill_hole()' - and
just get rid of that stupid 'bpf_jit_fill_hole_t' type name that only
exists because of this thing?

The bpf headers seem to literally have agreed on a name for that
function -type- only in order to be able to disagree on the name of
the function -name-, and then pass it along as a function pointer
argument instead of just calling it directly.

Very counter-productive.

                 Linus
