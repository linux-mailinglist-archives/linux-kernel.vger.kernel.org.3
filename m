Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788AE578554
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiGRO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiGRO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:27:02 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC626FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:27:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31e45527da5so10394797b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtj0EAXN9U90VAEHDyJp+h4NOUaHKEG8aPk/GVml+8g=;
        b=sdl0ANPhWcYPKRHeSiX1ABKy52Q5uvPDzWi8yihz91FuiqXXxpmBjVZ9WIUQy6cTHc
         SVeSJDUI7mE0oz1+jwRcPlb5SNGDfV6W12sAtvt7t07e1nVG0CA7y1C5GJrYMdhOiTXQ
         zZ94pG2BXNmmp3guQGPtbHGYaGZ6xiPeBWVZacMwDedrGf1lyWCFPkaki4fyOdCWuWhf
         Hjw6S8dfyMpJeJXQ9A8p+Cuk9qR3a3Sjxx3KSzyTuA9O7XbyBemHwAdQGk8SOEsoT7LK
         xd9g/XFSsdVj9oXrndkCoI96eLOyfjql8zI7+HdJ0er6oSeib3d2Gdn1G5gJfE3uIFFq
         Zqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtj0EAXN9U90VAEHDyJp+h4NOUaHKEG8aPk/GVml+8g=;
        b=mEKntE6zR/zQ4HbRLpXgYY9hgg3Fryi9b+MKOv8tapdca6u82C/KYcAcVbANSlw+Pe
         CMZhjbz/iEMGGPzniMvAVpOq47i76PG1bBkOoUeWz8tXZQsrKlvTqXBgmclLD9t5dhKm
         0ut/Ey3d/zKVVFvvGSlNHzhVj0ne4kO+1n4SvicKlZMYpZhSgwjt7wvfHSgDIGwIG8yA
         nZNR2fobtiq8CwkxHA4Elz4fBH1Lf1rrT7dtRZUQpfChEtwjWAkVfBeXwK/jzCQQSYBS
         eRsVfwseCR4aOfiAEJm6M4cZk3J+nBB7DWwYA6+Slz4NsT3rijt/+/EvJxIJgutW77Lj
         wxuA==
X-Gm-Message-State: AJIora+BZ+JVS1xYGH/mzx1Lfi9FAYb/JU/1UVqa3MP/iTo7QIkQymMm
        TrVpPVv9wZAqQpHSe3NQy0VTgrN9yDcgcOl7vKwo2w==
X-Google-Smtp-Source: AGRyM1s20EyQDEGyRPBZ7Wv7r8r/+XMLmzdGIFx3v1owTss4vMR1A0bYTVN4giqCYWmMweRoaJzVLm5YlcC2vG/Heo0=
X-Received: by 2002:a81:5a0a:0:b0:31d:ad7c:8fa5 with SMTP id
 o10-20020a815a0a000000b0031dad7c8fa5mr30075011ywb.512.1658154421240; Mon, 18
 Jul 2022 07:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628113714.7792-1-yee.lee@mediatek.com> <20220628113714.7792-2-yee.lee@mediatek.com>
 <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
 <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org> <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 18 Jul 2022 16:26:25 +0200
Message-ID: <CANpmjNPhhPUZFSZaLbwyJfACWMOqFchvm-Sx+iwGSM3sxkky8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 at 20:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
[...]
> > - This patch has been accused of crashing the kernel:
> >
> >         https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020
> >
> >   Do we think that report is bogus?
>
> I think all of this is highly architecture-specific...

The report can be reproduced on i386 with CONFIG_X86_PAE=y. But e.g.
mm/memblock.c:memblock_free() is also guilty of using __pa() on
previously memblock_alloc()'d addresses. Looking at the phys addr
before memblock_alloc() does virt_to_phys(), the result of __pa()
looks correct even on PAE, at least for the purpose of passing it on
to kmemleak(). So I don't know what that BUG_ON(slow_virt_to_phys() !=
phys_addr) is supposed to tell us here.

Ideas?
