Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EC4E4422
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiCVQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiCVQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:23:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD727CF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:21:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w7so30672056lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24K1hLJb9rmuEHEKW5a8QYhjnmRyomvMSDjxeIg/X38=;
        b=VYS/UqPlwEg8dUg0nl76d7UJ1IUszygkxcr1j2/1mvgghsV+p3mYrgwsp34aOKQ6tk
         ScvhZMD1nx0OBvbT+5UaohuxHTKJjXselVVpziaLmccjKez67+onMBakhk/M73Kxl+Ut
         p2gOZHShBVjr2xBbgB8NPD9eut9eQpbmThYAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24K1hLJb9rmuEHEKW5a8QYhjnmRyomvMSDjxeIg/X38=;
        b=Tsu3PXl6rga9I/EoSHeqLrkblBz/UzJt3DOglLOgxgxAN31m/cyr4JRU/rjCrZkDHu
         UgZ+Q0gw8BW4R/CeBfDO3lXsjXH2rjx8pgGn0Q3VwmT8kqTFbqxzhTySyp/9pDRSFXlb
         s23JROtrWwyIKGtOMCQ37/b75JHVuG57C0CsJGxFrCGRTFgCGwC1eZdxLfvsWaPBaW++
         2GIQYBYZDmPwk4P9kfPxKD7/JM7+8O0ZpCqxwIEWvxT6r2/8zDNpzkkoe7EA+jpLTswT
         ov2eFGY6qX3PfuwWShUeHt09QfRaWxFn89yneTwpoe8l/MUWEa1oWbbmutCi66UaXW4W
         Fmug==
X-Gm-Message-State: AOAM532zuiG1qNKH3zie866U+g7MUQDFIx/+y+g0nkOiTJC13ghDUAvj
        KbtSyQe7GFSr+RFrv1eMrzoBJ3zJPWc1jjgEDq0=
X-Google-Smtp-Source: ABdhPJzVdYDrI7Avz0dUvM+NHcWHMjxWGqx+F8tEq7GuINFjbMbA/SymkGnYbGEY6BD8Lh1aHP33YA==
X-Received: by 2002:a05:6512:3a89:b0:44a:43ca:93ae with SMTP id q9-20020a0565123a8900b0044a43ca93aemr1445329lfu.307.1647966099036;
        Tue, 22 Mar 2022 09:21:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm2520356ljg.133.2022.03.22.09.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 09:21:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id c15so24636860ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:21:37 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr19763021ljc.506.1647966097175; Tue, 22
 Mar 2022 09:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
In-Reply-To: <20220322155820.GA1745955@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 09:21:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
Message-ID: <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Tue, Mar 22, 2022 at 8:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch (or a later version of it) made it into mainline and causes a
> large number of qemu boot test failures for various architectures (arm,
> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> denominator is that boot hangs at "Saving random seed:". A sample bisect
> log is attached. Reverting this patch fixes the problem.

Ok, it was worth trying, but yeah, it clearly causes problems for
various platforms that can't do jitter entropy and have nothing else
happening either.

Will revert.

Thanks.

               Linus
