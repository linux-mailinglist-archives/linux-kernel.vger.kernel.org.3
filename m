Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DDD4E58FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiCWTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCWTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:17:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C484EF9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:16:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id w7so2898981ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aQ8PVebNkP5Ngyhm8F6kHWtaTqkz4R3YcdblPBwyDI=;
        b=fAT+V9bk48p4My40xsqTwmj+FyqZ14OqgwWvchp7CKXZmHRCNxWlJ4LPz67pWc29Lt
         eN93ankeJlSQBNWgRwsYYqXAki5qU+QGNYUYIIizMueCZChsDVG/WXc9Z2z4l1wvgbzS
         KF+yfy+oGJn6K8VlWpTadosPiqA/LpgCH20Ah0tlMk0+TzZ9UI/osixk4kTgn6SSL0mM
         K9A8cWEiOIr7QsjNtNhwreGDAQd5ZFqhJROkGQUu+fJvIjrAie2pG4GkHlSnmI/WTcTp
         kagj6LXbztiRrVX/r0soHdzBvD7wJ8h4o5GhlHsPtb2P5fuinhTnxleOtrLHj63SZ9R6
         VYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aQ8PVebNkP5Ngyhm8F6kHWtaTqkz4R3YcdblPBwyDI=;
        b=OyeMmm8M6Ac+ERt+jADzoeKoe0bhOqfJaR8GP4dWtT6AAFR46UKsuFS73m443Y0n6X
         5oN60XwAFURLNF29Hdky710Tb2+uDrKhFdLgZ0Fj5DJG1aLDuI8JO9/coOFCBYiO4jlW
         xG9oWaIg9wsW/u76yujMI+R6Y3auz6D64j5zVDcc6jd7N2PRV3h7tpDXL7phjZYWl2/2
         2mwjTHoG7MPJKIT37vk8fnLmadSTjgNxFZPjJBh1hB3BmLemj/qKy2ee75nc1Cdv/Ph2
         JvMlpvXFAIrhr8vz2YNt9ollFOj8Ds8HDwJtRg3qhTNyRicrBHId+ZJYSasKa/i98K0v
         wY7A==
X-Gm-Message-State: AOAM530MDC9mMOSHSyiv/Ggb3qa5GvDb4aKVPaYI3xU/HFGY+ImGiS7/
        mdFeoBLw4BKGs2DhZqOHo6cUWF34BgfWh+1zl8obs9jGDAs=
X-Google-Smtp-Source: ABdhPJxTinNjnLkn9/jcKwOEQcZFkf38H5ZUCyfbjg0sMg7REpF3Qu/DP+MfGH1JHANC7mgzhptyKQiHBQXRyQ2suo0=
X-Received: by 2002:a05:6638:dce:b0:31a:256b:6b92 with SMTP id
 m14-20020a0566380dce00b0031a256b6b92mr798009jaj.308.1648062968762; Wed, 23
 Mar 2022 12:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
 <20220308151119.48412-4-andriy.shevchenko@linux.intel.com>
 <CANiq72mVnHWi-tZmT4g+2Y96eYu=Hm=oMKn6RkwpXWh7ARATAA@mail.gmail.com> <CAHp75VfMHWObRFs=-fOQnkV=KkAKWuqRF=JLUfzqruTa2U9XjQ@mail.gmail.com>
In-Reply-To: <CAHp75VfMHWObRFs=-fOQnkV=KkAKWuqRF=JLUfzqruTa2U9XjQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Mar 2022 20:15:57 +0100
Message-ID: <CANiq72=0NLgH4rmRNXMTo2TXLd9KcqEZ2yX40ytcTxSYkq1xKQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Andy,

On Sat, Mar 19, 2022 at 12:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> With [] and parameters not being bytes by type one needs an additional
> processing step to figure that out. When I see u8 ...[3] I immediately
> understand that there are 3 _bytes_. Moreover, [] is error prone when
> one may add something to the buffer with the expectation that it will
> work somehow (for example, with an old device you need 3, with new
> device revision you need 4 bytes and passing 4 bytes breaks the old
> device). Of course most of that quite likely won't happen.

I agree it is better to be explicit -- I just found the commit message
very confusing, i.e. the type will always be `u8`, what is unclear is
the total length, not so much the type change.

I think the best approach when one needs an array to stay a particular
size due to some external constraint (like hardware) would be to use a
`static_assert` with a comment mentioning where the requirement comes
from. Or at least a comment above the array.

Either way, I applied this one too to -next a few days ago. Thanks!

Cheers,
Miguel
