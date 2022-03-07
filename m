Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A74D0050
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiCGNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbiCGNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:42:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962C85BE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:41:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw13so31905927ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDtHiuzRSPUUhv37WHg1hpRhTtt8kJmpqwIsIBim/LY=;
        b=p7sl5WfJ2ShXKDJ4y0/+0o5mgJLTU3UrQ+7mPUbqwp6CuI8po+SceD5FBLnpEeHZpQ
         +Jv9KdfjTGU5mN0p2vQoeL9KpDN1/rXKe/CQJBtL+qGIpuARgarkfWplMxTmELHdxkmc
         6OdjxyQzeB1ET7WLtIhorHyl22UFMd4ee7f9NmMYpuWk3yWPvQ3Y/z0he9H0ij2pVdMb
         ocRHToEqFm4dy00wpv0bWNPxzPeWXzVOuKg/l1mhob2uGnR2rebRbC2spkNJ8+z8khEA
         Dzq5P4652iXuLadzh6QvFiaa8CCFr1g6C088nKu+j5TRn9X5WzzsMLoTR0bhUkP2gkm/
         O0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDtHiuzRSPUUhv37WHg1hpRhTtt8kJmpqwIsIBim/LY=;
        b=kGBNQvEqyZdoJRjFGHLkodHA5gWhcVpt6a41JISLvG+EGueG7UI6syzNj3hhidtBG2
         1Ym4cgo0RhlZ9UhtEZSOPs2goMH5lem028TxN7vHWEsqDLeDmIGZMlwTcrtVR6uFdRrw
         vpuZfyUE9yWfJcZco4SVMUyrE7ek8eWASmQeEfb38F3Cvisaf1sxbx+g05tAqG7d7tPn
         ztPDW9LXBvD294bfVXsNL7nlSXNW5Nx9Zsh1WNB6FRFMKoA+NdpVaJ7ClKKu1Al6+z+T
         mfpQuBOBMm8UwjbPyjnD/zKasa0MaOTSA+Vw/kntaTKWoZDhRzVguJAQa26ST8nuUCyE
         LLKQ==
X-Gm-Message-State: AOAM533mMOdcZw7MiWkNFYxBRcbjDSfDi6u1hEfOWALhgkvj4wjR2gyr
        puSDyEA4nSHm87meoJtbl+dKGCZYbDaVA/7PtDM=
X-Google-Smtp-Source: ABdhPJyb4sZHtRSQ0djiiC4NoaPoPG1jHpGz/TgyrH/+W1lhQG5qF64gXaemVneOUkIG1sa4qHPqIxwWfS5njLGcuRU=
X-Received: by 2002:a17:907:728b:b0:6da:97db:b66d with SMTP id
 dt11-20020a170907728b00b006da97dbb66dmr9026489ejc.636.1646660513857; Mon, 07
 Mar 2022 05:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com> <20220307105810.1747024-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220307105810.1747024-1-alexandr.lobakin@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 15:40:33 +0200
Message-ID: <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Mar 7, 2022 at 1:00 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Date: Fri, 4 Mar 2022 20:46:08 +0200
> > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >
> > > This pattern is harmless but because it occurs in header files
> > > (example find_first_bit() from linux/find.h [1]) and because of the
> > > include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
> > > (164714/532484) of all warnings when compiling all modules at W=2
> > > level.
>
> Nice catch, thanks! I wanted to submit the very same fix, but
> postponed it for some reason, and now here we are.
>
> > Have you fixed W=1 warnings?
> > Without fixing W=1 (which makes much more sense, when used with
> > WERROR=y && COMPILE_TEST=y) this has no value.
>
> How is this connected?

By priorities.
I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.

> When I do `make W=2 path/to/my/code`, I want to see the actual code
> problems, not something that comes from the include files.
> When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
> actual new warnings, not something coming from the includes.
> It's much easier to overlook or miss some real warnings when the
> stderr is being flooded by the warnings from the include files.
> I'm aware there are some scripts to compare before/after, but I
> don't want to use them just because "this has to value".

I rephrased above.

> I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
> because then I'm not able to spot the actual shadow or type limit
> problems in my/new code.
> I fixed several `-Wshadow` warnings previously in the include files
> related to networking, and *nobody* said "this has no value" or
> NAKed it. And `-Wshadow` has always been in W=2.

Yes, because people rarely enable COMPILE_TEST + WERROR.
To be clear, my comment is given in that scope.

-- 
With Best Regards,
Andy Shevchenko
