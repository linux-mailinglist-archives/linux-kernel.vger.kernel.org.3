Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E850FE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350554AbiDZNG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350540AbiDZNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:06:54 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA779179EB9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:03:46 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id x21so3021579qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uifP1i9V8cFMAAUigBgse0Z5PpFOoiSZg9jz3V1kgwk=;
        b=aOCUiBZpeMeuRubH+F1iBtRFKPaRIXSVovMDgBcmO49VM3sjc0lCSe1haECFnV3J9Y
         o14jXGzUwMeGywUSuMe9vaAAtVfInqhsRaPN8bCYPfuieZzDzftsaTB864rtRD8OkI16
         pFawfGYGxW0WPE91a+XRaokVUvFV0nSAos2pAB+aoPXYgiodr4MdyjuMpR2bcN5zhZrZ
         HNzMPiwQQx2MX8NfDudTif8jeQtqJQOM1ZJPOcHH1GwKUB3dG0XIRIu4+dLBidxQ/2ZM
         tuzo+FMvpgqukBI8UyAGwUp7CkJ0LM+J24fEkGJ9bCBY8Rl9uprc6vHgIpRtbWnzTtWy
         dQYQ==
X-Gm-Message-State: AOAM532cFWKsh7nkqoMC2nSx+oNvweWV+1+K1JWC9CGa4YBLs4bGat9p
        6xn4SvTtRp/wKAxkrIq8m9SQeUW1S0vUxg==
X-Google-Smtp-Source: ABdhPJwF2nu0lwXKc/IbV0CTA1YwP8VN3eX1Fcr7o76YZ0anxxUQmggvGg/r/3XEo1EQi3CTcdWPnQ==
X-Received: by 2002:ac8:4e93:0:b0:2f3:64a8:8331 with SMTP id 19-20020ac84e93000000b002f364a88331mr7930484qtp.159.1650978225274;
        Tue, 26 Apr 2022 06:03:45 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id b2-20020a37b202000000b0069c7ad47221sm6452841qkf.38.2022.04.26.06.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 06:03:45 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ef5380669cso181143097b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:03:44 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr21816204ywb.132.1650978224551; Tue, 26
 Apr 2022 06:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <202204170710.LwCV5Ec0-lkp@intel.com> <202204181515.FC6649DC81@keescook>
In-Reply-To: <202204181515.FC6649DC81@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Apr 2022 15:03:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com>
Message-ID: <CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com>
Subject: Re: [kees:for-next/lkdtm 6/6] drivers/misc/lkdtm/cfi.c:62:37:
 warning: cast from pointer to integer of different size
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Apr 19, 2022 at 9:20 PM Kees Cook <keescook@chromium.org> wrote:
> On Sun, Apr 17, 2022 at 07:26:33AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/lkdtm
> > head:   2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> > commit: 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25 [6/6] lkdtm: Add CFI_BACKWARD to test ROP mitigations
> > config: sparc-randconfig-r026-20220417 (https://download.01.org/0day-ci/archive/20220417/202204170710.LwCV5Ec0-lkp@intel.com/config)

Just received a failure for m68k-allmodconfig on next-20220426:

drivers/misc/lkdtm/cfi.c:62:37: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
drivers/misc/lkdtm/cfi.c:62:10: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
drivers/misc/lkdtm/cfi.c:62:37: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
drivers/misc/lkdtm/cfi.c:62:10: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]

> > compiler: sparc-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> >         git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> >         git fetch --no-tags kees for-next/lkdtm
> >         git checkout 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/lkdtm/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/misc/lkdtm/cfi.c: In function 'set_return_addr_unchecked':
> > >> drivers/misc/lkdtm/cfi.c:62:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >       62 |         ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> >          |                                     ^
> >    drivers/misc/lkdtm/cfi.c:72:13: note: in expansion of macro 'no_pac_addr'
> >       72 |         if (no_pac_addr(*ret_addr) == expected)
> >          |             ^~~~~~~~~~~
>
> Hmm. I don't see why this is warning. The macro looks like untagged_addr():
>
> #define untagged_addr(addr)     ({ \
>         u64 __addr = (__force u64)(addr); \
>         __addr &= __untagged_addr(__addr); \
>         (__force __typeof__(addr))__addr; \
> })

The offending macro is:

#define no_pac_addr(addr)      \
          ((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))

On 32-bit, addr is a 32-bit pointer, which is cast to a 64-bit integer first,
then to a 32-bit pointer again.
All of these need intermediate casts to uintptr_t.

oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
