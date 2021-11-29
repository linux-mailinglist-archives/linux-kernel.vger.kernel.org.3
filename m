Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A502460FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbhK2I1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbhK2IZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:25:48 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBDC061757
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:18:10 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v203so39929022ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LrGZYEwY75NOA8kLQXYDveo+smG1qDqvJX56rg4HJ7w=;
        b=fjDnlTXvTE+6fKJ7pyvLjC8CkLbOdrD1B1udsBfn1lv/WzsRH07uQp2ZkQwBSIlkla
         fUh53XNCfMbGFWmO9vNCPFZFzu/3+bILZikJ27QlAXCMzFYKRqPWAM7PizSp+LB9heMp
         Bm5f2VST1/eQdDNdkZgKcHQlhPZ1Ku3CwzwRKwd5GEkq8jwLam8SJE5ea6hn4LXwVcg5
         juHGLQkzfOepV2x3ZykPqezE6o5lSKUfLZjCvUuQkfBoYiNOeYGsS2k7AHiLAkDa6O5W
         tdtoqwOhAc2GTGeLrJlm/oobdmjh8+FhfdjHr9ThRSA13fuujaqKwp4upNwLqvZpxoPc
         3pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LrGZYEwY75NOA8kLQXYDveo+smG1qDqvJX56rg4HJ7w=;
        b=WgqD7H/BZpBzVQC0n4nD6q4kJi/nqLK6gKB/DAfhoX+jFzhfdNKOmfxtSYxHMs46ap
         sscruOSLzYKsciV+l5RhjtstSmfF2+ln19eZPVkuBWTJlEO9QuXqkBAmDxyb4UfHF52g
         aaYFpMO1VPh+XIddd6gGMuNO6KYY4bzGyAzmBTJCL1wnC4Qn2hqMS+Go2iolpaoHqihN
         s0xDXPZ5mpp4VGIDA6zCa+KVr0kiTlrQC1Xt5yQezPzAt57OJIuxSgtP/tzgrC9kLHkP
         kPJHfu/q1+kouiO7cuDe0j5Dcaq4VxAOSblnJ+wGKEz8/5BE4/U+sGoY3AReQHPTgqGU
         9WHw==
X-Gm-Message-State: AOAM53324jskgbelQUrOhqJDjNKWqiK0dZt/3Ql9EY3eb+cc/+5WBMVp
        NqeCeTO3qtyJ3Y3GYslnMs4ecU5mxU684YG9XFY=
X-Google-Smtp-Source: ABdhPJzn789KF+5ksWANaMYpXZm0jA8vt+r1K+bpyNvLeQUtrWy7jCeYBDGG2ASgVjHxM3DXEhR61f8mZExExrbuuGQ=
X-Received: by 2002:a25:2446:: with SMTP id k67mr5816069ybk.556.1638173889741;
 Mon, 29 Nov 2021 00:18:09 -0800 (PST)
MIME-Version: 1.0
References: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com> <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
In-Reply-To: <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Mon, 29 Nov 2021 16:17:58 +0800
Message-ID: <CA+WzARm4LAD+kk4ooH=9gsTcKXLT-N1=9YSUyP62TwkB1kub0Q@mail.gmail.com>
Subject: Re: Commit 'hugetlbfs: extend the definition of hugepages parameter
 to support node allocation' breaks old numa less syntax of reserving
 hugepages on boot.
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2021=E5=B9=B411=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:31=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 11/28/21 03:18, Maxim Levitsky wrote:
> >
> > dmesg prints this:
> >
> > HugeTLB: allocating 64 of page size 1.00 GiB failed.  Only allocated 0 =
hugepages
> >
> > Huge pages were allocated on kernel command line (1/2 of 128GB system):
> >
> > 'default_hugepagesz=3D1G hugepagesz=3D1G hugepages=3D64'
> >
> > This is 3970X and no real support/need for NUMA, thus only fake NUMA no=
de 0 is present.
> >
> > Reverting the commit helps.
> >
> > New syntax also works ( hugepages=3D0:64 )
> >
> > I can test any patches for this bug.
>
> Argh!  I think preallocation of gigantic pages on all systems with only
> a single node is broken.  The issue is at the beginning of
> __alloc_bootmem_huge_page:
>
> int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> {
>         struct huge_bootmem_page *m =3D NULL; /* initialize for clang */
>         int nr_nodes, node;
>
>         if (nid >=3D nr_online_nodes)
>                 return 0;
>
> Without using the node specific syntax, nid =3D=3D NUMA_NO_NODE =3D=3D -1=
.  For the
> comparison, nid will be converted to an unsigned into to match nr_online_=
nodes
> so we will immediately return 0 instead of doing the allocations.
>
> Zhenguo Yao,
> Can you verify and perhaps put together a patch?does
>
> >
> > Also unrelated, is there any progress on allocating 1GB pages on demand=
 so that I could
> > allocate them only when I run a VM?
>
> That should be possible.  Such support was added back in 2014 with commit
> 944d9fec8d7a "hugetlb: add support for gigantic page allocation at runtim=
e".
>
Yes, I will test it and provide a patch to fix this issue.
> >
> > i don't mind having these pages to be marked as to be used for userspac=
e only,
> > since as far as I remember its the kernel usage that makes some page un=
moveable.
> >
>
> Of course, finding 1GB of contiguous space for a gigantic page is often
> difficult at runtime.  So, allocations are likely to fail the longer the
> system is up and running and fragmentation increases.
>
> > Last time (many years ago) I tried to create a zone with only userspace=
 pages
> > (I don't remember what options I used) but it didn't work.
>
> Not too long ago, support was added to use CMA for gigantic page allocati=
on.
> See commit cf11e85fc08c "mm: hugetlb: optionally allocate gigantic hugepa=
ges
> using cma".  This sounds like something you might want to try.
> --
> Mike Kravetz
>
> >
> > Is there a way to debug what is causing unmoveable pages and doesn't le=
t
> > /proc/sys/vm/nr_hugepages work (I tried it today and as usual the numbe=
r
> > it can allocate steadly decreases over time).
>
>
>
>
