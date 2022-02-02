Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6C4A7B65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiBBXB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiBBXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:01:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C6C061714;
        Wed,  2 Feb 2022 15:01:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d188so1005341iof.7;
        Wed, 02 Feb 2022 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQ6YlbcUeFT4O0Nhx5T4/GpxgiCqtz3B2qSA3LJqXC0=;
        b=H5gnVwBgv0BQwl4PVZ6+7lRxMM7lzcosf6ft80+GoLc8IqEgezcDKymg3+1w5bd+6m
         kI2P/av2BwDlilA6ZqhHThlM3med9Z7q2KwXc7/Nna01L/wxXC24he6Jm7PbfuWvsIqs
         M3E/i1RRtg/hBlNFvZvOxlzJ6AQTuViO4T/ajceDT6gDB3UuPfnhbHj3IrV6pIFeH4Yo
         ivgw5XzMsaQLzEsLxeaozAZxbUzpw78ML2SUGhngwzzWGUCMrzp6yArxJyExZhBMs3ib
         7TJ3UjapkIxoveDi7L4Wja1ziyg7kicui7Le+ylVdNsTYsATrzs+2eAo1+ZXQhEkBvZD
         s3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQ6YlbcUeFT4O0Nhx5T4/GpxgiCqtz3B2qSA3LJqXC0=;
        b=LJnTA56T+lrI25WvyHQhmxjqQc95GRp7CLLnqOIPqAKi4KYr20jrPe/hwb5qtT4SEz
         vQnImsTq0/Hx4fCXEQxj2iUEoOy3spwQvTALUKQ4/tQsq9CPQlGYKH7zafqFvBMBtYut
         wGdFEk6cjCTloT961iKyAkZJpYnYLhjJjPQztOgud30q2Z4YYKi0I4YSOgBgnGnh6048
         2bo6JGIAr2wN0kLQPGRD/1JQvFyUStfbYXjY6RTNCbmQZRHTyFdM0yJ9IGWcJb5A3TFU
         rQNb1ROZQYaUbZSXseS61ZOR2/kLpsDUMP9RuVj4/GRe75SCoQWgqaQttv8X7O3vUyDx
         mAWQ==
X-Gm-Message-State: AOAM531t1Gl5/dAgsQnALnjgf4DgjXYnwThikk4akBR++L+TAxNZ1XQx
        mV/RNifPtCvbXzAWxQCmx0t1CXLp5K3unwPf0HM=
X-Google-Smtp-Source: ABdhPJyzifSWutAPofCeunWEFMCxCCtEpD6jJ8xxmWnsmNAA7l8ym/NPzWQVAFa5k0qyW4OKknY4JeOlfFTBVC7OnvE=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr16910109jab.186.1643842884934;
 Wed, 02 Feb 2022 15:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20220131204357.1133674-1-keescook@chromium.org>
 <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com> <CANiq72neVsdLRyLn24avMhLCaHxMEiG0bD-ZkG46O7J29FanYA@mail.gmail.com>
 <6d75ee32e7c3415ebcfa12e61d26aa87@AcuMS.aculab.com>
In-Reply-To: <6d75ee32e7c3415ebcfa12e61d26aa87@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Feb 2022 00:01:14 +0100
Message-ID: <CANiq72nep38_aFpUNc5C3Po_AKmuiogqvzc_pJgvixJqy9POwg@mail.gmail.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 11:20 PM David Laight <David.Laight@aculab.com> wrote:
>
> The type of the result depends on the type of the 2nd and 3rd arguments.
> Not on the value of the first one.

I am not talking about the first operand. The behavior of the
conditional operator has a few cases. Since you mentioned promotions,
it looked like you were thinking about what happens for the arithmetic
types case, i.e.

"""If both the second and third operands have arithmetic type, the
result type that would be determined by the usual arithmetic
conversions, were they applied to those two operands, is the type of
the result."""

which could lead to thinking that the expressions need to have the
same type as you mentioned, but that is not true, and the arithmetic
types case is not used in the macro either. The cases used are the
null pointer constant vs. pointer and the pointer to void vs. pointer
to object type.

> It has nothing to with the condition, the compiler is trying to 'sort out'
> a suitable return type.
>
> I suspect the mismatched pointer types might even be a gcc extension.

That is why I said it does not fit the constraints of the operator.
The standard does not describe what happens in such a case.

Cheers,
Miguel
