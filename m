Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3909659F61D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiHXJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiHXJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:23:10 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312B83F24
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:23:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y4so12424764qvp.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xWe+ZWv+j/DBZNUi9i5IoxbVooEDeShD1NU+nnYJNXA=;
        b=gp773N5DOmVojdNAUa1mrNy4Pfqyv6ZLwgIWUY2J8rlNHYAVh8MGtgBx+13uSVw3gK
         BXZKwrhhY8lJcbdbY4/hJ4VGtZzysEZiuNHFI4W9EnMxZ9ueJXIQJcaOC1CaHnLhrLZm
         9fM6R4fi3R68FLw8nulsKIZxAu/CAdxEwNFP7LJUEwa2KwYJ2+0uHEjDnhG0tZSaLqdO
         p0DbtPTqxGcW6WxkePGNPLblV3lpz+j9YTcxUKLchhao9pk7j3fDQvu8qckBq0SE9a9X
         oJ/BdPAC467Ryhms/QrVBxAD8umb3dFVPigVC/q6Ho5daMIcQa0bUYsdHFg73h7CGRP4
         Jrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xWe+ZWv+j/DBZNUi9i5IoxbVooEDeShD1NU+nnYJNXA=;
        b=zzp/guif0cgvX4fkbYV5BoUS++fvjdJ0QDNj6gvhRVZFNSMpdMr1RCGUUKhxqKUIdR
         WaKUmhPR5L6zp+FHGizWDy3g+/so6o9n/YOCIDpTFe5n+0IQe5si9k8Cc0F4RtxSCxnn
         yVCr9oeRJcpLHqldRJlAelZbTQi7Ay5u+VdGRAH+LhzUQFkJu9F8/QIouxisR5Qq5YqG
         H/+DwaeIlg5lmbAhOjtfwUYtIm8/JaTsux7zz0sUJpW7OMBi/nGrJ2BH2e29M7kuS0Lm
         0k/x/OabvY0ROThHW23/qhotpgoaN7haouozFZ7WDVFtrFNHtpDPxHjaAD75UyZkgONe
         lPLg==
X-Gm-Message-State: ACgBeo1kU5/LwfZ1BWCpgqFqyc/3aBZTtdM2zMg74tPUqhSkGE9v/nfd
        Ldt9J5RpJehsDTUfAaXhPkLBPSCteNiGfittx7Y=
X-Google-Smtp-Source: AA6agR4+nBwGguvI1TocNXQnQepP9HPl6F1Gzap9lirrw8XsRCc77Rl+5alq4xmmvOHIjoENZfXk5mbg7+d6SRNQHcE=
X-Received: by 2002:a0c:aadb:0:b0:497:1283:c849 with SMTP id
 g27-20020a0caadb000000b004971283c849mr2011106qvb.11.1661332989119; Wed, 24
 Aug 2022 02:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com> <20220824012624.2826445-3-yury.norov@gmail.com>
In-Reply-To: <20220824012624.2826445-3-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 12:22:33 +0300
Message-ID: <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
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

On Wed, Aug 24, 2022 at 5:17 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
> despite that 'next' is known to be slower than the 'first' version.
>
> Now that we have a common FIND_FIRST_BIT() macro helper, it's trivial
> to implement find_first_zero_bit_le() as a real function.
>
> Moving find_*_le() to a separate file helps to fit the FIND_FIRST_BIT()
> to the _le needs by wiring word_op to swab.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
> Like other find_*_le() functions, the new one takes void *addr, instead
> of unsigned long *. This should be fixed for all in a separate series.

From this comment it is unclear to me why we can't fix them first and
then apply this with the correct type?

...

> +#define word_op swab
> +#include "find_bit.h"

Looking at this, I would rather always require to define __ffs_word_op
(or whatever name) in the user and replace #ifndef in the find_bit.h
with
#error "The __ffs_word_op must be defined before including find_bit.h!"

-- 
With Best Regards,
Andy Shevchenko
