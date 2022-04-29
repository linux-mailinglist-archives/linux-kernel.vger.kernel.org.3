Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BCD514082
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354093AbiD2CNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiD2CNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:13:02 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210CCBF51D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:09:45 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23T29RMY020789
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:09:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23T29RMY020789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651198167;
        bh=7SFGnUXP06F5Gny6HedRf2nc4WJTXIahAj4+JBfLO6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tFHEDH3kCljzwtknsfQHeMObxy2fRvRh5soEQRTLU9T97uNJ3ocnaFpN8nDqAglFv
         Huo6mhgjGAz0PrtRX3gEoQr7JXY8fMkt1esuDYFaHb50G17f4QvnAYp66Udzz7WnV4
         vHWLHNzeDmdfIMI5A0NssfFeCKvLSFzDhbwZXw2D3kTIqmyD463BUDDg0/AkReCn3u
         LeC/C6m2UtXV7VGLSMy6rRQoIW3quG70g832J7oWLdbaU7m4KPi0j0QyHj0M+vG3i6
         Vk2S1tJHqVY+YHtVAGZ0g+X2VzTXKMy5JB6snO24fFqIN5iYRi6NWXUqLNvBhC9KNb
         4JtkSEbbtugRA==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id h12so5898314plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:09:27 -0700 (PDT)
X-Gm-Message-State: AOAM532GO1DOG8VmHq4cm9oLYcuzS2c4VBR71iEjNh6V9lQliGew7lXt
        afH9qc+CccX5hZLmRFNXV1F/eQgFUzoTh2Y1yZ4=
X-Google-Smtp-Source: ABdhPJyjLglSkmGOqYNcBk8dvwS8zBtRDwgaev2G02+jebOoMZpxLeJxvMJYStRgQwUndL0BhbYfF5WhA2tE65R7ayQ=
X-Received: by 2002:a17:902:bf07:b0:158:d334:852f with SMTP id
 bi7-20020a170902bf0700b00158d334852fmr36336467plb.136.1651198166686; Thu, 28
 Apr 2022 19:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220428043850.1706973-1-aik@ozlabs.ru>
In-Reply-To: <20220428043850.1706973-1-aik@ozlabs.ru>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Apr 2022 11:08:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASiK8RtcDTM-WgFN=ARdhFQ6v=pNYMSafp16OBF_8JgtQ@mail.gmail.com>
Message-ID: <CAK7LNASiK8RtcDTM-WgFN=ARdhFQ6v=pNYMSafp16OBF_8JgtQ@mail.gmail.com>
Subject: Re: [PATCH kernel] RFC: zstd: Fixing mixed module-builtin objects
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Rix <trix@redhat.com>, Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:39 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> a situation when files from lib/zstd/common/ are compiled once for
> ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module) even though
> CFLAGS are different for builtins and modules. So far somehow
> this was not a problem until enabling LLVM LTO where it fails:

I did not notice this potential issue, but you are right.

When an object is shared between vmlinux and a module,
it is compiled with module flags (module wins).


I did not come up with a clean solution in Kbuild.
To avoid this situation, Kbuild must compile different
objects for each, but doing that would complicate Kbuild.



I'd suggest to stop object sharing among modules.

One possible solution might be to move common objects
to a separate zstd_common.ko

  - zstd_compress.ko
  - zstd_decompress.ko
  - zstd_common.ko

You may need to add some EXPORT_SYMBOL
to common functions.




> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
>
> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> POWERPC as explained at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> but the current use of common files is wrong anyway.
>
> This works around the issue by inlining common files and fixing few
> conflicts.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> I tried fixing it by hacking Makefile to produce a separate .o for "y" and
> "m", like this:
>
> +obj-common-y =  common/debug-y.o \
> +               common/entropy_common-y.o \
> +               common/error_private-y.o \
> +               common/fse_decompress-y.o \
> +               common/zstd_common-y.o
> +obj-common-m =  common/debug-m.o \
> +               common/entropy_common-m.o \
> +               common/error_private-m.o \
> +               common/fse_decompress-m.o \
> +               common/zstd_common-m.o
> +obj-common-m := $(addprefix $(obj)/, $(obj-common-m))
> +obj-common-y := $(addprefix $(obj)/, $(obj-common-y))
> +
> +$(obj-common-m): $(obj)/%-m.o: %.c FORCE
> +        $(call if_changed_dep,cc_o_c)
> +$(obj-common-y): $(obj)/%-y.o: %.c FORCE
> +        $(call if_changed_dep,cc_o_c)
> +


I did not look into this closely, but you need to
use if_changed_rule instead of if_changed_dep at least.





-- 
Best Regards
Masahiro Yamada
