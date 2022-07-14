Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9866575394
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiGNRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGNRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:00:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE81812AB9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:00:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so3226354edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkKAKPPtro79xKHDPBehtihMhR7Lh7lQwIdzYzaJOZw=;
        b=Mr94LDjwnV8nGBNNVAJX0c9LMeMtH4cDpRa5fj+6lq8ilb1VFMXaD3H2Ik9nf7Im9V
         XZyhuuiBGMSLiEDZ8jkg99ghi7VhgSI6uCGroUHirIu1a+9FR19M3SveBO6J6ruu/gBv
         73wvSSvqkb+WbC+/4GP+cysrOXahEAqgw1UYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkKAKPPtro79xKHDPBehtihMhR7Lh7lQwIdzYzaJOZw=;
        b=WN6HGbRUNjeUXtpBoeebE2EfZXgrmBuJXgNH9FvoQ+jhFjudvBaSx2lU6mTVUT5lFa
         F3Vtz1EjklvDtie+4tNZw+6wtGxaZOUoZudK98V32/HSxT5gH5AtwleCq61fJfv7g98V
         fSpfBMyU4tX3oFqHPbWQTSftkmtFOQZLGA8bD1nKBiMYjPrk7nFZqs8nuW+RHQpoqDBR
         yDGa8rk4FcqQffg8de3TK38Ykrgfb8dIQaLriyTMpgSq3pfvw8q0VGtQOQo6AUM2bTUT
         DqWRtmfdNOMsDGJNm7iduoF2I+NzSJY5JTJ7qZ/zqXkKAITu990eST9EMT+MhYgd4++N
         tBLQ==
X-Gm-Message-State: AJIora8OQZNx4w5AV+bq4l8d2jizabiOAiMIzZVINENLlXYbfpiWwQyf
        t9EYvcOmVowlWZhIchJGhiNHRffPsBtp9euQbuI=
X-Google-Smtp-Source: AGRyM1si/yxHtjxWyL0QTeGsxw7L7QzihPvpPhtimktQArUZc7WzQCCFuQlrqEcjgszQrw86inQv1w==
X-Received: by 2002:aa7:cac7:0:b0:43a:c5ba:24a6 with SMTP id l7-20020aa7cac7000000b0043ac5ba24a6mr13293233edt.84.1657818001142;
        Thu, 14 Jul 2022 10:00:01 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id zk8-20020a17090733c800b00705cd37fd5asm895181ejb.72.2022.07.14.10.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:00:00 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so1392546wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:00:00 -0700 (PDT)
X-Received: by 2002:a7b:cd97:0:b0:3a2:dfcf:dd2d with SMTP id
 y23-20020a7bcd97000000b003a2dfcfdd2dmr15971099wmj.68.1657817517167; Thu, 14
 Jul 2022 09:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183238.844813653@linuxfoundation.org> <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
 <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net> <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
 <CAHk-=wgq1soM4gudypWLVQdYuvJbXn38LtvJMtnLZX+RTypqLg@mail.gmail.com> <Ys/bYJ2bLVfNBjFI@nazgul.tnic>
In-Reply-To: <Ys/bYJ2bLVfNBjFI@nazgul.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 09:51:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdafFUFwwQNvNQY_D32CBXnp6_V=DL2FpbbdstVxafow@mail.gmail.com>
Message-ID: <CAHk-=wjdafFUFwwQNvNQY_D32CBXnp6_V=DL2FpbbdstVxafow@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
To:     Borislav Petkov <bp@alien8.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
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

On Thu, Jul 14, 2022 at 2:02 AM Borislav Petkov <bp@alien8.de> wrote:
>
> I'm guessing you're thinking of cutting an -rc7 so that people can test
> the whole retbleed mitigation disaster an additional week?

Oh, absolutely. Doing an -rc7 is normal.

Right now the question isn't whether an rc7 happens, but whether we'll
need an rc8. We'll see.

Oh, I do hate the hw-embargoed stuff that doesn't get all the usual
testing in all our automation.

             Linus
