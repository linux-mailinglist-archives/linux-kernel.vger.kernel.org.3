Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704305754C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiGNSRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiGNSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:17:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB368DDF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:16:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so3449434edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hK5ocrmgpve0PHNj3o4tIMSgRA6JbzmNbYxh+aYsl2k=;
        b=ZCnQcVQGg0nfALVvWkqkGriFOMCDXxk6m2CvS9WlJvQ5Scn8GJJrBt/WYG0OuGJ5tK
         rHkj30PPf39TjXc7DVh1SMiF5ndE1lqe4ZrZMbqaj1klcnvokOZK149gaK/RwqMZK3U6
         NPUauVqcy8ILPqpKTcOikT324FVRl/5HXS6Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hK5ocrmgpve0PHNj3o4tIMSgRA6JbzmNbYxh+aYsl2k=;
        b=VBUD6fihDPVcOvsrFMCFXF9xaKDWZs7N+ZGQNTZA2x3JMd2WLmpJiJ2sGdw7Id1v+/
         sz7dhtA0KU2R4L2CoXnY4MA5+0PcvRkW6qhvuatkZHUyiRGQXO52OLBiWM2Mdx0s6HyE
         d4uzXGIzuy+hqpExU187c1yy706vQeXWF29Z+7EEs92wql/hN2ozbUeDKTCkj8wdmnFj
         23zrPnNhYIlDkOhYMJAzC1x6jxkYkqF9CM1ll6q8T50RpnR9mMaS+kioEx3D4bCOO0GX
         poG7DOSkv2lRfD0dFKE3Wq7elrCFv1O8pN5Vqj7yBJKeFkAmE9JYZR3NgZ39cGRRdOvx
         j9CQ==
X-Gm-Message-State: AJIora+flhKX9J0xehj2xCalxDTamkorQm3wqsC7Qszux1lu3sA5poa6
        poE584JRLaqJSUBW7fIPWJeMYb+f4GL3OPYiCN0=
X-Google-Smtp-Source: AGRyM1uPFMo0l11QnXGEKbULyhLcKNiwY4fjqxIH7fpAFOlJMMz8rd9TUU7tQxGV+Ny2nrDh3nXiBA==
X-Received: by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id eq5-20020a056402298500b00439651bc1f4mr13956630edb.276.1657822617765;
        Thu, 14 Jul 2022 11:16:57 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id sb12-20020a1709076d8c00b0072b2ffc662esm965430ejc.156.2022.07.14.11.16.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 11:16:57 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bu1so3622854wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:16:56 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr9469726wrw.274.1657822616453; Thu, 14
 Jul 2022 11:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183238.844813653@linuxfoundation.org> <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
 <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net> <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
 <CAHk-=wgq1soM4gudypWLVQdYuvJbXn38LtvJMtnLZX+RTypqLg@mail.gmail.com>
 <Ys/bYJ2bLVfNBjFI@nazgul.tnic> <6b4337f4-d1de-7ba3-14e8-3ad0f9b18788@redhat.com>
 <8BEC3365-FC09-46C5-8211-518657C0308E@alien8.de> <CAHk-=wj4vtoWZPMXJU-B9qW1zLHsoA1Qb2P0NW=UFhZmrCrf9Q@mail.gmail.com>
 <YtBQutgSh2j3mFNB@worktop.programming.kicks-ass.net> <CAHk-=wjAouqJQ=C4XZVUmWEV9kerNzbOkK9OeErpHshNkcR=gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjAouqJQ=C4XZVUmWEV9kerNzbOkK9OeErpHshNkcR=gQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 11:16:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYia1fnjJFiJ59xZv4ROqqTfG4crQNWxb71JYJf5B-Lg@mail.gmail.com>
Message-ID: <CAHk-=whYia1fnjJFiJ59xZv4ROqqTfG4crQNWxb71JYJf5B-Lg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boris Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kvm list <kvm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>, patches@kernelci.org,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anders Roxell <anders.roxell@linaro.org>
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

Oh, btw, how bad would it be to just do

     #define FASTOP_SIZE 16
     static_assert(FASTOP_SIZE >= FASTOP_LENGTH)

and leave it at that?

Afaik both gcc and clang default to -falign-functions=16 *anyway*, and
while on 32-bit x86 we have options to minimize alignment, we don't do
that on x86-64 afaik.

In fact, we have an option to force *bigger* alignment
(DEBUG_FORCE_FUNCTION_ALIGN_64B) but not any way to make it less.

And we use

        .p2align 4

in most of our asm, aling with

    #define __ALIGN          .p2align 4, 0x90

So all the *normal* functions already get 16-byte alignment anyway.

So yeah, it would be less dense, but do we care? Wouldn't the "this is
really simple" be a nice thing? It's not like there are a ton of those
fastop functions anyway. 128 of them? Plus 16 of the "setCC" ones?

               Linus
