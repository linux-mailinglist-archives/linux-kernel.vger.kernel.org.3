Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598F5AE87B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiIFMfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiIFMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:35:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854A19297
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:35:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x5so7824567qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=FZksdU12pLfzW5mzHMGsEGTK3wlFdOKHCYK4iAsjsiI=;
        b=lZa0cs4iGUNUwFXW7UI48KvoLL5Oa1UA5SyT1ntEro6NGKZyGY/8QFxniXnRptRjy8
         vhWHeju2wgBEnjzIpdJxpC59cvyiqhPN4e1qyvW05L6fxwSPCge8o8zMOgpRoOiDIUgX
         llf1tyt+1aLHRF4kMemLGVHdIrf/TgFwCwlemSx3zWDCabKHtpmkKmsZOf+/MPRs4ndd
         o7KVqleidylkjaOP+pDWY8FUUyY8cc99ONrGjXOtp93iG/bGMAyfuAe8WerGpp/zXN6u
         oDYdNx4P/WSObJ5W5Dbkb/rVeHeTZWRr8zyoKd8pgfKyE5gZewhuKp6CtucEfhh8D4j8
         7Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FZksdU12pLfzW5mzHMGsEGTK3wlFdOKHCYK4iAsjsiI=;
        b=HLXT2ceLbCuWGF8P76grf0oYqdFVnbLH5e1ErXcetPLOGGBOLwvLcKp1huMJWgKVtp
         PhkfBVxISJ0+5DkehZoczSSatZ8arqNWDyeTN+jIxT6zt3VQWal7IvtuqISEmNY+WF2L
         8MQHf23E71hgk2WF4NOYHcyQqy1Xu+ZrNOJHs6qlhpeSNphKJw4aJ52dU7TXhoEeuuSG
         pIuKhyynynO9Fp95xnLFdgIiIT3kt8WzIf+6VjJXYVgO4/I2K2uL1gvAMghVx+ReKUhR
         3g92bUJhnC6z+YyOspXr5rvXjPoueNNULWtGLDQp/9gNwP9H3m+MQEMkLe3DBXqlvI6y
         iUWw==
X-Gm-Message-State: ACgBeo2gpQdYO3L8fQioSucGjneOWRnFBzb6tDkXy8t19sHx3rnDwZRr
        jzSjBDfWZbsXgjwLFNo+P/1QXeaV65pSePBGnK4=
X-Google-Smtp-Source: AA6agR4dko+tRdnO4TKFH72LosJ8iXjC4v0hVWtxl/3ACep2ViT8nWBRfvpUzBHN6ulm0i0spR7CR5QJCjW6sV0yKkk=
X-Received: by 2002:a05:622a:1cc:b0:343:6f2c:eb1b with SMTP id
 t12-20020a05622a01cc00b003436f2ceb1bmr44442429qtw.550.1662467713972; Tue, 06
 Sep 2022 05:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220904193020.65556-1-casionwoo@gmail.com> <696a1a53-87b5-7517-3c05-82217c8eb190@arm.com>
In-Reply-To: <696a1a53-87b5-7517-3c05-82217c8eb190@arm.com>
From:   Jeungwoo Yoo <casionwoo@gmail.com>
Date:   Tue, 6 Sep 2022 14:35:02 +0200
Message-ID: <CAMguKxboV7iVz6J77cZZcrKv-q6QprO1THE-gnXv-ourf1GKoA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Remove d-cache clean operation at preserve_boot_args().
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 9=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 12:47, R=
obin Murphy <robin.murphy@arm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2022-09-04 20:30, Jeungwoo Yoo wrote:
> > Kernel expects only the clean operation as a booting requirement in
> > arm64 architecture [1], therefore, the kernel has to invalidate any
> > cache entries after accessing a memory in the booting time (before
> > enabling D-cache and MMU) not to overwrite the memory with the stale
> > cache entry.
> >
> > Same applied in preserve_boot_args(), kernel saves boot arguments into
> > 'boot_args' and invalidates the corresponding cache entry. However,
> > according to the 'dcache_inval_poc()' implementation, the cache entry
> > will be not only invalidated but also cleaned. That means if there is a
> > stale cache entry corresponding to the address of the 'boot_args', the
> > saved boot arguments in 'boot_args' will be overwritten by the stale
> > cache entry. Therefore, it uses 'dv ivac' instruction directly instead
> > of calling 'dcache_inval_poc()'.
>
> You've already said in the first paragraph that we expect these
> locations to be clean. Clean lines are not written back, so your
> reasoning here is spurious. If boot_args has somehow become dirtied such
> that the clean operation *would* write back to memory, that can only
> mean one of two things: either the kernel image was not cleaned per the
> boot protocol, in which case there's every chance that other things will
> also go wrong elsewhere and there's not much we can do, or the prior
> stores hit in the cache (either unexpectedly or because the MMU was left
> on), in which case we almost certainly *would* want writeback here anyway=
.

Yes, you are right. I misunderstood that the "clean operation" will
propagate the content from the d-cache to the memory always.
However, as the cache line is already cleaned by the bootloader and
not modified in the d-cache, the "clean operation" in
"dcache_inval_poc()" will be ignored.
Thank you for your correction.

>
> > The address of the 'boot_args' is aligned to the cache line size and th=
e
> > size of 'boot_args' is 32 byte (8 byte * 4), therefore, a single
> > invalidate operation is enough to invalidate the cache line belonging t=
o
> > the 'boot_args'.
>
> The architecture allows the CWG to be as small as 2 words, so this is
> clearly untrue.
>
> Thanks,
> Robin.
>
> > Sometimes clean operation is required not to lose any contents in the
> > cache entry but not the target of the invalidation. However, in this
> > case, there is no valid cache entries at a very early booting stage and
> > preserve_boot_args() is not called by any other (non-primary) CPUs.
> > Therefore, this invalidation operation will not introduce any problems.
> >
> > [1] in Documentation/arm64/booting.rst:
> > The address range corresponding to the loaded kernel image must be
> > cleaned to the PoC.
> >
> > Co-developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> >
> > Co-developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> > Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> >
> > Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> > ---
> >   arch/arm64/kernel/head.S | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index cefe6a73ee54..916227666b07 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -121,9 +121,7 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
> >
> >       dmb     sy                              // needed before dc ivac =
with
> >                                               // MMU off
> > -
> > -     add     x1, x0, #0x20                   // 4 x 8 bytes
> > -     b       dcache_inval_poc                // tail call
> > +     dc      ivac, x0                        // Invalidate potentially=
 stale cache line
> >   SYM_CODE_END(preserve_boot_args)
> >
> >   SYM_FUNC_START_LOCAL(clear_page_tables)



--=20
Best Regards,
Jeungwoo Yoo
