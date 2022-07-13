Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9783573CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiGMSkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiGMSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:40:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1AF2F3A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:40:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so15231346edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTaNdUVQ+FmmgGgyaGPbQquf7hxH0Xo9Q96HHi4sep8=;
        b=L73SZ+mHgtriwniSrAhSkxjXKDDXd0WPgqFSlQUlKk5euLzrMbPjkEmJ9R+ZsDkWsH
         g0Meu4SIWMqSxjGIrdgkCgnmWaUXM68miVezQGPM9PXgHGoW1g8lxifty3vtR7bbVqJ1
         7asnHsF2ys8kx0XarbxrDW+2kekvsiZEVyWFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTaNdUVQ+FmmgGgyaGPbQquf7hxH0Xo9Q96HHi4sep8=;
        b=iYme6eqfFvXeh6ZO9MIZkx3vpO7vlpSS2bdA9OY5yC/Q8hbfGNz6J+LEzG8x4Rew1b
         jJd1g93OyXDn7nFALsYdDsXF9x6LEWQUZGwBizK848XxhBAHztvdqrRDGNrMC0bY5T6g
         Yba3OaV8SWL+n/i/dqc5L7dBkxVXUQIn5xZr0O8OJnWMbqIzJsDkHQBjvcD7CUSYMkJl
         C6wk4sfxO9XGV1AQ8i8M9HYH8mRls3rSyBqrmmrPJqsCG52P0XJgC99F34UQ6ehZVsi2
         moXBILQ1RP+QTVn+QdY/guA+kEUuwzFTGRU48fZaq+aRiSaWey2EQ/xZBUl/UJVO4+Lv
         5QHg==
X-Gm-Message-State: AJIora/SCZ6lkM9Q9cXkOVZCWdB7bv4rmPmAQxybh3S8VHvlQpir2O1/
        cbGuym+X4Fj5lFYVZweDLZ2c07jjxT5pD14nYrQ=
X-Google-Smtp-Source: AGRyM1u/Sbl/07cNGip327lfbzHqTs+13SPP1FsbbLk9bch1ZWTJZgmU4fKGwUeoexQWDDlqkL+iBw==
X-Received: by 2002:a05:6402:48d:b0:43a:cccd:89d9 with SMTP id k13-20020a056402048d00b0043acccd89d9mr6726284edv.257.1657737622444;
        Wed, 13 Jul 2022 11:40:22 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0072b1cb2818csm5233282ejh.158.2022.07.13.11.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:40:20 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id f2so16695401wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:40:19 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr4766164wrh.193.1657737619653; Wed, 13
 Jul 2022 11:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183238.844813653@linuxfoundation.org> <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
 <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net> <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
In-Reply-To: <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 11:40:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq1soM4gudypWLVQdYuvJbXn38LtvJMtnLZX+RTypqLg@mail.gmail.com>
Message-ID: <CAHk-=wgq1soM4gudypWLVQdYuvJbXn38LtvJMtnLZX+RTypqLg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Wed, Jul 13, 2022 at 11:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think that that is where the "xaddw_ax_dx+8" comes from: some
> code assumes that FASTOP_SIZE is 8, but that xaddw_ax_dx case was
> actually 9 bytes and thus got that "int3 + padding" in the next 8
> bytes.
>
> The whole kvm x86 emulation thing is quite complicated and has lots
> of instruction size #defines and magic.
>
> I'm not familiar enough with it to go "Ahh, it's obviously XYZ", but
> I'm sure PeterZ and Borislav know exactly what's going on.

And I see that Thadeau already figured it out:

  https://lore.kernel.org/all/20220713171241.184026-1-cascardo@canonical.com/

So presumably we need that patch everywhere.

              Linus
