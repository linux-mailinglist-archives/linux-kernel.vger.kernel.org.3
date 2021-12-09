Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377F346F268
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbhLIRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhLIRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:47:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E253C061746;
        Thu,  9 Dec 2021 09:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9514CE2788;
        Thu,  9 Dec 2021 17:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10FC004DD;
        Thu,  9 Dec 2021 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071851;
        bh=LrhoCgwHK5aNa/je1bFGkrzamyGORwE0jAi/o+7cq0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+Und83WPf689ACgYKD8KAU8iKmz/AfKjHjnZbrlXN2RPAdq6HHZsBtNtAl3vIon+
         hp/dLz6qerzservK6Wm3Kr17j+nJY1Z3Y3/Xp59E9tsxOloZsLflMHp+hxm21GOHPv
         IhnaDeYwOQOkdmrcn23ALacGdGWfnfkiVcyZlgvA5ZpE/5VeHQ34eAycra0wfupezK
         BbzJmpqD+cxVaQRwIIrzdYDeDyzSPZRcOnbXHFTo+H/a+uOx2dsobBXrHgpUhO/Zp2
         kECgO8iNdaVXXeFukO/VUOUjcV2G3g+zbKyQ4QZoKljkwFzgfgxtqtMk467H5ofmE+
         Hrp5g0xyQsA9A==
Received: by mail-ed1-f53.google.com with SMTP id x10so4736301edd.5;
        Thu, 09 Dec 2021 09:44:10 -0800 (PST)
X-Gm-Message-State: AOAM532nfiX0VmU5DmdaIVybZoJtd1nl9gN5waO6N9DW43wX1t1b2H3f
        WibNy5uJHPeftSw+MOG9xduEAIQGv1OGPLQ9bg==
X-Google-Smtp-Source: ABdhPJxap0Qok1U7I64dLvD5c+qEPGQ3YzYlUS5GiU4rvfeVx52ezhzIk8JVKlHaoAWcLEY/BvtlX2hLDzjNdj873WE=
X-Received: by 2002:a17:906:5e14:: with SMTP id n20mr17330757eju.466.1639071644253;
 Thu, 09 Dec 2021 09:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-11-thunder.leizhen@huawei.com> <YaaitPTArUZEriob@robh.at.kernel.org>
 <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com> <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
In-Reply-To: <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Dec 2021 11:40:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2nt0Kr9jykq-SELk-6E4BAyFCVrRaNRC01Uz5Jqf-Jw@mail.gmail.com>
Message-ID: <CAL_Jsq+2nt0Kr9jykq-SELk-6E4BAyFCVrRaNRC01Uz5Jqf-Jw@mail.gmail.com>
Subject: Re: [PATCH v16 10/11] of: fdt: Add memory for devices by DT property "linux,usable-memory-range"
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 7:59 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2021/12/1 10:55, Leizhen (ThunderTown) wrote:
> >>> +   }
> >>>
> >>> -   memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> >>> +   memblock_cap_memory_range(rgn[0].base, rgn[0].size);
> >>> +   for (i =3D 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
> >> s/ &&/,/
>
> Hi Rob:
>   I want to keep "&&" unchanged, do you mind? I'm going to post an
> updated version tomorrow, hopefully the last.

Looks like that was obviously correct, so no objections.

Rob

>
> > Hi Rob:
> >
> > The comma operator may not be suitable for logical judgment. The logica=
l judgment
> > before commas (,) is ignored.
> >
> > Here's my test=EF=BC=9A
> >
> > C code=EF=BC=9A
> > int main()
> > {
> >         int i, j;
> >
> >         printf("&&:\n");
> >         for (i =3D 0, j =3D 0; i < 2 && j < 3; i++, j++)
> >                 printf("i=3D%d, j=3D%d\n", i, j);
> >
> >         printf("\ncomma:\n");
> >         for (i =3D 0, j =3D 0; i < 2, j < 3; i++, j++)    //(i < 2=EF=
=BC=89 before comma is ignored
> >                 printf("i=3D%d, j=3D%d\n", i, j);
> >
> >         return 0;
> > }
> >
> > Output=EF=BC=9A
> > &&:
> > i=3D0, j=3D0
> > i=3D1, j=3D1
> >
> > comma:
> > i=3D0, j=3D0
> > i=3D1, j=3D1
> > i=3D2, j=3D2
> >
> >
