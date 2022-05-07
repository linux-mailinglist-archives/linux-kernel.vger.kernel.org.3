Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046AE51E622
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446196AbiEGJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446211AbiEGJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:39:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F89E0DF;
        Sat,  7 May 2022 02:35:37 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f2so10452960ioh.7;
        Sat, 07 May 2022 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZNzsVrF/FcJvo9Hb6oxdeCucYsKZ0bPUQkM35LuhDM=;
        b=aOR+dClEDq4ka5peKJkJ+SVeypHJt8v7QFv5GZsVU44P8xiRejD4l0feJywNW9Kyc0
         24FLXPPWLdCA5JyOMLj2U+lqhHxGb8Qu8aPvAe7wuc/DO/x4PqexuvvN5RqiwNoI2Gvw
         2NKMVNm2dDqbI3E5WbIRa2xQFYwzz2oE/gTVJPiVU1V4ZJg7FKvp6xgvx4A/QXx+WXKj
         SrOc/2Bmhd0US8GCBt9sAvPP+8x+TrVT7SdExrKvdyDr/n9VVUi5Rj8tfMCBjJWMcesV
         3jE8D54m3MSzg/EzMcf/Mxj5Q931FmssBtJf1cmqiINzQe6gxnAVqcSwbDmyJtNitJu+
         AFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZNzsVrF/FcJvo9Hb6oxdeCucYsKZ0bPUQkM35LuhDM=;
        b=gBp9g3UnubqPR+oYr62xV4p+jKoBrljJq5KEQpFfq7/H7Ee9Q57ZT2lwIKcrWchpsY
         Rzi7kbRmNUzMphwczmQJsbxLsHj7BcHb+AgHrQuIR3tEyTZiqv+w8v62cpim8/M4D2TY
         q1IYBmhmVc5+pxUjPrdjKoo9U6dkzR6s5iZ8bC8UYTu1mH0hgvmoPkx81BB9QD0vkk1n
         U96g8M2tJ4ygbeTUxn0usn7j3vXf2CVd8Oxbszk7LvOvrjcxSl89Vu6yUA8XOstvYSTR
         rscG1XoGuayTsmI387pGnE8rlJvb5eR0Bv5sKbDI/zq4PVEmIeN70Twgjs4/dhymVgZ1
         P4AQ==
X-Gm-Message-State: AOAM5317Y2KcPSJ9AtAK5MJviHSb2/gxZ//yuRKi5s6okrimjLBfVfkK
        fS5jQ9a6soUbIdkxuenb8PGstG+yOhRc155/ewswJHHtf5QN0VdM
X-Google-Smtp-Source: ABdhPJwpN37rdDexq9vnm4/NAHDFzeiYs14RFO3E2/qnvch/osQIaJ0eg9tZllJB/YMonf/oKeNo67Lhhug4DmILUB8=
X-Received: by 2002:a02:c6af:0:b0:32a:f5f6:34bc with SMTP id
 o15-20020a02c6af000000b0032af5f634bcmr3308433jan.186.1651916137444; Sat, 07
 May 2022 02:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-15-ojeda@kernel.org>
 <202205070117.28F31079@keescook>
In-Reply-To: <202205070117.28F31079@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 11:35:26 +0200
Message-ID: <CANiq72n+2qrwo4X=SQQ9X3YcKYg=k_4GObEWBJcntqVq9EfQ-A@mail.gmail.com>
Subject: Re: [PATCH v6 14/23] vsprintf: add new `%pA` format specifier
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 10:19 AM Kees Cook <keescook@chromium.org> wrote:
>
> Maybe add a test to yell if pA is seen in a .c file (like the runtime
> check in this patch).

+1, Rasmus and Petr suggested static analysis, but a quick check in
`checkpatch.pl` cannot hurt either. Will do.

Cheers,
Miguel
