Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E95908A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiHKWMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:12:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9EA0316
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:12:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so6083857pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=OaIrkj9R9JywIX725xkBPhpXdGqairQfBX0VVLZM/go=;
        b=PX9vP9e6D2i3BRyZIySwJPDwHZx7MDUBg6U5qRUg5aispyC8WAyr3Pv8uyVvQhlvEz
         RTKtOCkS4QygbmLPynk0vftHzNBqCz15oBYSTIYhE94i0LCQR6BknkOUvScurFBTnb2a
         4og4ZP2b8dNIfA+lVGi/77/+uXNCAd6lVc00uxhG+VKLw5Vw+htZ9EOr0ccjbOJb9Yka
         367PUfLyCGVuykPzpCgGJReFq+9EwFmjFjKv3QSYHj6omBI45WM7AkGdtAj39X3Ri2I2
         z2xnfGw4ZAble6fV1USkw4ESzm9ysBiDgG2zKFhGjOvhRkMI+e2pMaAGEcS6DxTuBa24
         erjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=OaIrkj9R9JywIX725xkBPhpXdGqairQfBX0VVLZM/go=;
        b=ziyUxycA6OgIQb8qlR8FYaZSzpa5hOPM6bVyZ2NmAgmV/vFlPGwP2at7WQn1wW9xzY
         wQQRLx4oz40lgWEEn3VaGK4RH2r9GOZ9d4yikQHGIGBf/6X30vXJx0FTIJP8NZMvXmzs
         xFERqwzH5d6WVqugmRArlQVxuT/k3C/YnPWGMFzetb6jV707xPNDDZg6d9qBRSKKBv3p
         Rt60vk+PI9lWJJToIR6BIkDjjsOQGzeb4kUVaYxZ1U1DXPqQGAsHvcwGPzgXxuD103/e
         iW03KqoDggjHqXBJ+8W6ObZ9stA82rhpqNJOzPaNp1Oh3UrLSpBCirVLocIUElnkwlV2
         0z8Q==
X-Gm-Message-State: ACgBeo1wXgoJEzfYX5UeeGPsrrW4V1W5VoeEc0Me0WbSEBuMN8O86WhH
        h1AotDn4JBff8Pv3LuwqsXx2heq3O0lMDCGHmZ4=
X-Google-Smtp-Source: AA6agR4Ot+zakUPtBASQJ+JpMLGbKl6h8feAP2zD6KXiS0sw8eytNEw/mfvgwHuT1R2IzYUAVJhtM2W/oTP4/jDPM6k=
X-Received: by 2002:a17:902:a516:b0:16d:4379:f34a with SMTP id
 s22-20020a170902a51600b0016d4379f34amr1199760plq.26.1660255938814; Thu, 11
 Aug 2022 15:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com> <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com> <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com> <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
 <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com> <3195C304-2140-4E5D-890D-AC55653193E5@fb.com>
 <CAOUHufaggjiYAywB646N5Rj48eSJDjir8oLwDVu039ymbLm0PA@mail.gmail.com>
In-Reply-To: <CAOUHufaggjiYAywB646N5Rj48eSJDjir8oLwDVu039ymbLm0PA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 11 Aug 2022 15:12:06 -0700
Message-ID: <CAHbLzkpRVOOGK2d0L25A4PKfEbHngm-WEWWH34UYVg1O40Tiig@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     Yu Zhao <yuzhao@google.com>
Cc:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 2:55 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Aug 11, 2022 at 1:20 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote=
:
> >
> > Hi Yu,
> >
> > I=E2=80=99ve updated your patch set from last year to work with folio a=
nd am testing it now. The functionality in split_huge_page() is the same as=
 what I have. Was there any follow up work done later?
>
> Yes, but it won't change the landscape any time soon (see below). So
> please feel free to continue along your current direction.
>
> > If not, I would like to incorporate this into what I have, and then res=
ubmit. Will reference the original patchset. We need this functionality for=
 the shrinker, but even the changes to split_huge_page() by itself it shoul=
d show some performance improvement when used by the existing deferred_spli=
t_huge_page().
>
> SGTM. Thanks!
>
> A side note:
>
> I'm working on a new mode: THP=3Dauto, meaning the kernel will detect
> internal fragmentation of 2MB compound pages to decide whether to map
> them by PMDs or split them under memory pressure. The general workflow
> of this new mode is as follows.

I tend to agree that avoiding allocating THP in the first place is the
preferred way to avoid internal fragmentation. But I got some
questions about your design/implementation:

>
> In the page fault path:
> 1. Compound pages are allocated as usual.
> 2. Each is mapped by 512 consecutive PTEs rather than a PMD.
> 3. There will be more TLB misses but the same number of page faults.
> 4. TLB coalescing can mitigate the performance degradation.

Why not just allocate base pages in the first place? Khugepaged has
max_pte_none tunable to detect internal fragmentation. If you worry
about zero page, you could add max_pte_zero tunable.

Or did you investigate whether the new MADV_COLLAPSE may be helpful or
not? It leaves the decision to the userspace.

>
> In khugepaged:
> 1. Check the dirty bit in the PTEs mapping a compound page, to
> determine its utilization.
> 2. Remap compound pages that meet a certain utilization threshold by
> PMDs in place, i.e., no migrations.
>
> In the reclaim path, e.g., MGLRU page table scanning:
> 1. Decide whether compound pages mapped by PTEs should be split based
> on their utilizations and memory pressure, e.g., reclaim priority.
> 2. Clean subpages should be freed directly after split, rather than swapp=
ed out.
>
> N.B.
> 1. This workflow relies on the dirty bit rather examining the content of =
a page.
> 2. Sampling can be done by periodically switching between a PMD and
> 512 consecutive PTEs.
> 3. It only needs to hold mmap_lock for read because this special mode
> (512 consecutive PTEs) is not considered the split mode.
> 4. Don't hold your breath :)
>
> Other references:
> 1. https://www.usenix.org/system/files/atc20-zhu-weixi_0.pdf
> 2. https://www.usenix.org/system/files/osdi21-hunter.pdf
