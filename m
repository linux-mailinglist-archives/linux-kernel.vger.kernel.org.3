Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094B570D95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiGKWwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:52:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3E5C9CF;
        Mon, 11 Jul 2022 15:52:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so11297389ejb.4;
        Mon, 11 Jul 2022 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i2JP/AK/462flQNf3WkuAKr99hiwoo70NGIBG6Typ3w=;
        b=ErppBv825hWACq85NgILEoUpFIDS7zhQU4dBsF65NWh9mqK1QibzrTz5JjL/oe9P4P
         xddf9vJAS5jJevier0WxjtSRTzqNqYMTuFMbLyHy18aT7xPi4oZPjKUXEDf3BhSaLDa4
         4O3xw1J1KLXUrMcEs66ayBXSRlLIZbC064ewsp5aVZAPGfL0CMXNAFyBX/9qyBVJbAOu
         xoSUM1m6sng8YQvv6Z+b3Z5XjXwnY/UzydMHSmIOJ28NgRuG0eCkAIYDttY9WOuNkv9g
         v51CIgVGXO+hyPttpvZ9Y8r1QIuDcwQgPgw5HdmKK2Y4Fsxmh65jR/Qqh4XcEPpMGnwl
         PGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i2JP/AK/462flQNf3WkuAKr99hiwoo70NGIBG6Typ3w=;
        b=NcFknJgVFzO3UqiTfsabJm9c8lvh2/D0/UGn9QcYYwK2kvYyxxu6cVaTtFsk8omazf
         jzjwukTSs2iA8RR5GzjsJXxcDooqLawZ88w+eubP7S6YSFOFsgCpXmV5m7kRvwF0c6mZ
         k2T1pLxNZ5pBMT6l3+eQWK6ISAjUV/hm4sKKIPTLTg1uHrsSILq97u9AWqbfQQrCHooC
         xKMjZzZZY9rcBCBYlWFyeWhTuhA6RkUrb/zpI/1itVWUFj58kZ43gLuoHqRu66t0+hTw
         pf3ItG5XQ7TaDksNIluk33ToIp8O9K0A5CClui+eon81yN23lPlhFVImlXpuJiMEy+qh
         udnw==
X-Gm-Message-State: AJIora97OHHr/7rDTkOhv7qUwJ2hr8NbapZToFXw4WL6KztzqIDXzt0G
        JZsfag0sBug9gbmllwpJyA3WVGI9f2VE3CPQaH4=
X-Google-Smtp-Source: AGRyM1u3B9GaqsJzc2ZnGgAx20N9pPna/H/YyY3hApLIj/mDA7Feo0MOU0K0s1MJSpzYriYuHv0RZqEbB9CZJ8ZQIzU=
X-Received: by 2002:a17:906:8a45:b0:72b:31d4:d537 with SMTP id
 gx5-20020a1709068a4500b0072b31d4d537mr17046686ejc.170.1657579957647; Mon, 11
 Jul 2022 15:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220711034615.482895-1-21cnbao@gmail.com> <20220711034615.482895-3-21cnbao@gmail.com>
 <13b283fe-10f7-376f-9b8e-856e4d1e0ede@huawei.com>
In-Reply-To: <13b283fe-10f7-376f-9b8e-856e4d1e0ede@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 12 Jul 2022 10:52:24 +1200
Message-ID: <CAGsJ_4wW=3xsmB1jzcv=sD9OhhPc0v=+odp=JY80vEbMY6OZ_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm: rmap: Allow platforms without mm_cpumask to
 defer TLB flush
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>, x86 <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Yicong Yang <yangyicong@hisilicon.com>, huzhanyuan@oppo.com,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        real mz <realmz6@gmail.com>, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <v-songbaohua@oppo.com>
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

On Tue, Jul 12, 2022 at 1:35 AM Kefeng Wang <wangkefeng.wang@huawei.com> wr=
ote:
>
> Hi Barry=EF=BC=8C
>
> On 2022/7/11 11:46, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Platforms like ARM64 have hareware TLB shootdown broadcast. They
> > don't maintain mm_cpumask but just send tlbi and related sync
> > instructions for TLB flush. task's mm_cpumask is normally empty
> > in this case. We also allow deferred TLB flush on this kind of
> > platforms.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>>
> > ---
> ...
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 169e64192e48..7bf54f57ca01 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -951,6 +951,9 @@ config ARCH_HAS_CURRENT_STACK_POINTER
> >         register alias named "current_stack_pointer", this config can b=
e
> >         selected.
> >
> > +config ARCH_HAS_MM_CPUMASK
> > +     bool
> > +
> >   config ARCH_HAS_VM_GET_PAGE_PROT
> >       bool
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 5bcb334cd6f2..13d4f9a1d4f1 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -692,6 +692,10 @@ static bool should_defer_flush(struct mm_struct *m=
m, enum ttu_flags flags)
> >       if (!(flags & TTU_BATCH_FLUSH))
> >               return false;
> >
> > +#ifndef CONFIG_ARCH_HAS_MM_CPUMASK
> > +     return true;
> > +#endif
> > +
>
> Here is another option to enable arch's tlbbatch defer
>

This option is even better than simply having ARCH_HAS_MM_CPUMASK
since arch might make decisions based on specific hardware characters.
for example,
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-November/165468.html

+bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+     if (!radix_enabled() || cpu_has_feature(CPU_FTR_POWER9_DD1))
+         return false;
+
+     if (!mm_is_thread_local(mm))
+         return true;
+
+     return false;
+}

In this case, having MM_CPUMASK doesn't necessarily mean tlbbatch is needed=
.

> [1]
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20171101101735.23=
18-2-khandual@linux.vnet.ibm.com/
>
> >       /* If remote CPUs need to be flushed then defer batch the flush *=
/
> >       if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> >               should_defer =3D true;

Thanks
Barry
