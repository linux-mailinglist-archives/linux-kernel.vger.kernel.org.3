Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53612507EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358912AbiDTCVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:21:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AB30F54
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:19:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn33so259640ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzcM0Fy8zoXIYtzw0zgKr6w3uu0pvrZ7K2myKeDxUvc=;
        b=XlMHlA1yW/3psqu/gqNph/O3AA7PrGeW5068j/3DUXbJp9LCr/qQwXvvlCgRY66YZs
         bfbo2buBJiwcJj5XorkSa+q8/5Dd97EEFrzXKMkVvKZ2Q6hHadvYR+AeJLYW8cad9NkT
         BkTcdQwom8v7pt4NN84cQ97G02o6Ks7iPjqGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzcM0Fy8zoXIYtzw0zgKr6w3uu0pvrZ7K2myKeDxUvc=;
        b=G13U3XjPfWenPIe31+SUrvnWIBILWZN00Q5iz4YR+xSu/i2hmwLXnayehThoDLNKgB
         ceKBhbBhPqsrF53UBOj5yF5imsD1GthH4+YhEZmYCrAtXEBPe40OXvZjLzDD7NKPp58t
         6D1ZVsJ2Wgckb92uzFa5TCp213/KG50Lw2+RInHrA6mrnhHkOSTiUYy2cGUSw2MwBk2c
         L9Cn9xfxy1fQIj5g5UaHMlIHLJLMxb2VpOUBgkQeJWqOmiBuQCpyO71lD0do455KPg51
         O8cvn7hHkyOTdbjJ4+ew/Nl+SOnGFn873F9MCIuQF7SqIc73KtrkPXrnaOO2lOMk7vw/
         qoQw==
X-Gm-Message-State: AOAM533+Wxosc/8DI/MJIZ/UENwGnQ4glzv5yZjDtq9lB0DQ1uwdWrHW
        5ZOZiqO5bYmR+Q2I6ql4Ba0SMquQDOCzz/uttvs=
X-Google-Smtp-Source: ABdhPJwWSaOKSr5HNjyEqgLsr0uTd7VQR9sC0EbC35LD/1LAu/KdUeyQCJuOJX8jeZvItSwKbQqjGA==
X-Received: by 2002:a2e:a26b:0:b0:24d:b6e5:1097 with SMTP id k11-20020a2ea26b000000b0024db6e51097mr9546740ljm.110.1650421147558;
        Tue, 19 Apr 2022 19:19:07 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n7-20020a196f47000000b0046d1859fc45sm1672834lfk.102.2022.04.19.19.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 19:19:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y11so260888ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:19:07 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr12387816ljg.291.1650421146776; Tue, 19
 Apr 2022 19:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com> <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
In-Reply-To: <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Apr 2022 19:18:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
Message-ID: <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
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

On Tue, Apr 19, 2022 at 7:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Here is the quote from Song's cover letter for bpf_prog_pack series:

I care about performance as much as the next person, but I care about
correctness too.

That large-page code was a disaster, and was buggy and broken.

And even with those four patches, it's still broken.

End result: there's no way that thigh gets re-enabled without the
correctness being in place.

At a minimum, to re-enable it, it needs (a) that zeroing and (b)
actual numbers on real loads. (not some artificial benchmark).

Because without (a) there's no way in hell I'll enable it.

And without (b), "performance" isn't actually an argument.

                  Linus
