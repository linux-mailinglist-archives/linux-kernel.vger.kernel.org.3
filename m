Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092D50E791
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiDYR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiDYR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:56:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99810772F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:53:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w1so27559080lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LM5ApeDrM+ZiQkhPKo2nD8z3VPb3CiZfRSSBlkwszA=;
        b=BsY4pOkfn3DG5B5zct/wRzU14afza6Td5Lww1u3ewMVuTqlUDLuuUSSqkL5GiYshCE
         Af5nvn4SN/67YfETMMEi2NtXlQOejoI+5yvUA5qfEs9uGHOdZvqJA8BxEijrFHNTDfUl
         aDeCEhneNkVbrDwdkHnVsK7wqLVmqL9Kk0+S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LM5ApeDrM+ZiQkhPKo2nD8z3VPb3CiZfRSSBlkwszA=;
        b=VoYDlhgmZM9+FcmJhSg3oQfsGoMKOjf4TExIBkj/du0VwrmfjAZjBpzPwTu/CumsTg
         uTlSEUkenzSCvWtIBuPnxMLrP/bRkStBgO7zIi5DLHDSVCrYqNzZhhodidAl0T6d8lrK
         4XNzREzE5S50o7Roe0QhSHYVEGeKY8+bSd6EjrInAkE1FubaxyE+9O3/2VZdWKX7o4wv
         JJEMfqG9+LsCwHRsWEWIRWlAZt4Q3FscBUBjD+hEsyH7YzCg3PdGzqIV60w51VMoTh/s
         bsXUNI+qDXSOh0ZOb+tu127/sBn+cVsxOQQbZWXNYdRIiEFoln1A/ZAwH6Rz3XWTEtsU
         MB6Q==
X-Gm-Message-State: AOAM531SfquPjDThu/u/PozsnlIcXENPKivLuoBaPHl8A/W59qzArPzQ
        ajjmWAY8xxpAHETzLHy8tYBssyXrBnkjJO6Z4/0=
X-Google-Smtp-Source: ABdhPJwX5ZJGL6IRDOkMIIW2et6ZUHboUxHNxh97eeC+DkcQ9o5u/8+72fEE5VFqmAJEb713gJLazQ==
X-Received: by 2002:a19:4f56:0:b0:471:f883:7af0 with SMTP id a22-20020a194f56000000b00471f8837af0mr8720394lfk.284.1650909220194;
        Mon, 25 Apr 2022 10:53:40 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t5-20020a19dc05000000b004720e0fa073sm250221lfg.252.2022.04.25.10.53.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:53:39 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id bq30so27583345lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:53:39 -0700 (PDT)
X-Received: by 2002:a05:6512:1193:b0:471:af88:2d74 with SMTP id
 g19-20020a056512119300b00471af882d74mr13719233lfr.531.1650909219017; Mon, 25
 Apr 2022 10:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com> <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Apr 2022 10:53:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhP7EdVkj9V2aWbUtPbC=rNxvJ1R1Bs45jFz4KT3xg-Q@mail.gmail.com>
Message-ID: <CAHk-=wjhP7EdVkj9V2aWbUtPbC=rNxvJ1R1Bs45jFz4KT3xg-Q@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
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

On Mon, Apr 25, 2022 at 5:07 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> We are subtracting values that are in the 0 ... 255 range.

Well, except that's not what the original patch did.

It was subtracting values that were in the -128 ... 255 range (where
the exact range depended on the sign of 'char').

But yeah, I think bit8 was always safe. Probably. Particularly as the
possible ranges across different architectures is bigger than the
range within one _particular_ architecture (so you'll never see "255 -
-128" even when the sign wasn't defined ;)

> > Also, I do worry that this is *exactly* the kind of trick that a
> > compiler could easily turn back into a conditional. Usually compilers
> > tend to go the other way (ie turn conditionals into arithmetic if
> > possible), but..
>
> Some old version that I tried used "(ch - '0' + 1) * ((unsigned)(ch - '0')
> <= 9)" - it worked with gcc, but clang was too smart and turned it into a
> cmov when compiling for i686 and to a conditional branch when compiling
> for i586.
>
> Another version used "-(c - '0' + 1) * (((unsigned)(c - '0') >= 10) - 1)"
> - it almost worked, except that clang still turned it into a conditional
> jump on sparc32 and powerpc32.
>
> So, I came up with this version that avoids comparison operators at all
> and tested it with gcc and clang on all architectures that I could try.

Yeah, the thing about those compiler heuristics is that they are often
based on almost arbitrary patterns that just happen to be what
somebody has found in some benchmark.

Hopefully nobody ever uses something like this as a benchmark.

             Linus
