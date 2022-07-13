Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98D573CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiGMTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:11:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27311EC5F;
        Wed, 13 Jul 2022 12:11:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i206so3853028ybc.5;
        Wed, 13 Jul 2022 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uX6Kc2kAxANJpf80UpilSQ2SInJgmyK49SONOFQNv5c=;
        b=iqVLGZ4UHwqB4eZdQyeXhiOEO+3NmpiA/ZmKUZ3pojmgFsncTkpWmPWEH6+ykG18ae
         mHYXJpDCYYAX+LOCja5quKdYDeVwQBkzP5VSKjvA+JOqHRBeG0ePsnW3S6y8aZMwu+Xv
         us7pMqfk3SeJPMf4E8N6+/hDpkiDabfhM6Xus346kN48d+1zkrjBRPjbWfCPS2NGUJVf
         OT/KyT3Vo5ti4qLNEhIuyE1W6+6HvnH+ENqkryha0rdTdP2IyVbgzSxvuJlXWF9HGYDN
         ND6a5hAb2qfk94K/GM/VejQ+ISdNeM7+bhoN96fn8G7yXSbzZP7/52zcbjLwybjCTJOY
         8LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uX6Kc2kAxANJpf80UpilSQ2SInJgmyK49SONOFQNv5c=;
        b=7Si0YeJ4WC8UN7+3qkM3URyXvOuTUyDg9rbRBaK2kqFMnWmMSJ8gvuCq5shx/f+/yi
         eok9NEKz9i4nWmTVVr9xJY0XE2yDp9R73rQXZEAH5cSxr3gMPvJ+dgej4Vcp2Eysnxs0
         qAPWbwBE8vSXy2+Hcj8Vt2MwXy58ygw8FZvXN3TPCdqAcXCSgDECF0dWf4g8UZwVtjfD
         L8so3tuOB6YByXQvxRCGdD8NFAq0KTlWid1uedb8lPRJNvOEHIvTVZGQb/wf+t8ZHHkJ
         4YS3fmqQvFTd+d6cKL5JVBD7bXfy5QKvLIwNUL/ITIr4BnteL46m2YAnXlo5C+dmKoKx
         8mdA==
X-Gm-Message-State: AJIora8lwddCcr9w29VWfN6SSseSlr9kZAQzHl/2owlekJ9QE0s+x0oH
        xj+hTYoW8rx3Jv1aywtxJnI/lWX+zGaiAJYgXuA=
X-Google-Smtp-Source: AGRyM1ubtEnBQBhsUQ4cfAfwgVqIR998ItYnbTDQhKD2W4fja/tTb/hnXkjG4PQuVLspPo/Bt6mh1j4EftGpjQ1ATcI=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr4782371ybt.385.1657739470007; Wed, 13
 Jul 2022 12:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220713163201.136202-1-sebastian.fricke@collabora.com> <Ys8Txuq9/u/EL6sj@yury-laptop>
In-Reply-To: <Ys8Txuq9/u/EL6sj@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 21:10:33 +0200
Message-ID: <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, knaerzche@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        bob.beckett@collabora.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
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

On Wed, Jul 13, 2022 at 8:56 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:

...

> I'd suggest you to try implementing
>         bitmap_copy_from(dst, src, dst_off, len)
> or even
>         bitmap_copy_from(dst, dst_off, src, src_off, len)
> if you expect that you'll need more flexibility in the future.

Do you think it would be useful?

We have bitmap_replace() & bitmap_remap(). Wouldn't that be enough?

-- 
With Best Regards,
Andy Shevchenko
