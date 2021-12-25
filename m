Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2647F2C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhLYJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 04:27:49 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36628 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLYJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 04:27:48 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1BP9RTeH004895;
        Sat, 25 Dec 2021 18:27:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1BP9RTeH004895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640424449;
        bh=jgxVp0+hzHhAZSEC48cVfqqHG3Y9AaeF03F4b3mLM8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AmbhxEcpihmN9MdEnDDZ1nVt31TPGukbUgVT4V8J8vFZEDMNoYV+YEWXADdWK9A/s
         NNIqCTisnGlVQuKSegPMaEUXazGp8b4sYcoJVlN1Jb6+KXNScvZyS/mcudGq6+X2YG
         BH+Ul4Fm24DwXzh7RTx3bnCvyazUBNEXnGZUZvqfTDqw/uWlRHFHqzp2u+vKE4cuY0
         d8/9Mkwjjp3EwxDJiG5U6ZkmMzvhWoGcTbEbhne/TRDmhQfb6jllsQN/8sLcxgZStC
         5sUN85+dnmvBZPufQMDXxjcAH8UstT6kkn+2TbRyBI98GQpUJHzsBGdtgUSEd2sY/z
         5wOJhu/kIkkxQ==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id c2so9485227pfc.1;
        Sat, 25 Dec 2021 01:27:29 -0800 (PST)
X-Gm-Message-State: AOAM533ZDgma3U/HJ5AqW0WLKw1ZYVnusmF5S4uTqlhnqLqNLF4jeDip
        cyf5YA/M+QiAmjW+ZNhnz8dIcDinHQfJE1lhdTE=
X-Google-Smtp-Source: ABdhPJxYL1ONJdnvk57/qcJ7sTORdC8ycxF2/MS3/yv/oUZB9Mj/KGRaiUEF/pHx/egQFPWwmJj/jJ+mnexCKsE4YCs=
X-Received: by 2002:a05:6a00:1484:b0:4bb:86a:c061 with SMTP id
 v4-20020a056a00148400b004bb086ac061mr9959483pfu.36.1640424448714; Sat, 25 Dec
 2021 01:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com>
In-Reply-To: <20211223141113.1240679-1-Jason@zx2c4.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Dec 2021 18:26:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
Message-ID: <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/crypto: blake2s: include as built-in
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:11 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In preparation for using blake2s in the RNG, we change the way that it
> is wired-in to the build system. Instead of kconfig mazes and ifdefs, we
> use weak symbols, so that an arch version can override the generic
> version. Then we include the generic version in lib-y, so that it can be
> removed from the image if the arch version doesn't fallback to it (as is
> the case on arm though not x86).


As I replied in another email, this does not work like that.

Since 7273ad2b08f8ac9563579d16a3cf528857b26f49,
libs-y are all linked when CONFIG_MODULES=y.



So, what this patch is doing are:

 - Add __weak to the generic function
 - Make modules into built-in.


Both generic functions and ARM-specific ones
will remain in vmlinux.

__weak makes it difficult to track which function is
actually used.
Using #ifdef CONFIG_* (as the current code does)
is better.



>
> diff --git a/Makefile b/Makefile
> index d85f1ff79f5c..892ea632ea63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -668,7 +668,7 @@ drivers-y   := drivers/ sound/
>  drivers-$(CONFIG_SAMPLES) += samples/
>  drivers-$(CONFIG_NET) += net/
>  drivers-y      += virt/
> -libs-y         := lib/
> +libs-y         := lib/ lib/crypto/


If this is merged, someone will try to
add random patterns.
libs-y         := lib/ lib/crypto/ lib/foo/bar/ lib/foo/ba/baz



lib-y and libs-y are a bad idea in the first place
and should not be extended any more.

Since this patch is not working as the commit description
claims, and it is going in the bad direction, so

NACK




-- 
Best Regards
Masahiro Yamada
