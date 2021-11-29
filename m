Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5184616DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbhK2Nqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbhK2Noa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:44:30 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE9C06175D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:26:13 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so41742534ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jLSyxGIPPAZsrcMRpmNOT8BBNjdeI6FtIZETH5WpPBg=;
        b=S2zPfUWZjvsNyCsE248fr7k5eKZE6C1Jtf1JUjOR03Hhlodvx3Jf/Xe07usCe47xRn
         fjQGM86pHpajJeSWPLX5/2gfjlpCGGqPXtTdJrWv0OtW0zIggGmI2EHaVcGKTV+cyrwT
         0wXLzxBB6mGaUQ2ZAKYBu0Gomc+GPdSNarMtWHOHNwpGlXdeUApLgT4QQNblJaNhtqMx
         Pp+fJq9GpP0F105StjTuADFewvrCMDYAfHBRPXUynKmyaA1mHAIVigAfO6a8GrGXmRe9
         uRsTDpZ2QFUmpOEOKX5jaqFZ/LsZLvu78FBWCql3dSqKzdDLCSpXUUVggmAAvM2CYLFG
         6HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jLSyxGIPPAZsrcMRpmNOT8BBNjdeI6FtIZETH5WpPBg=;
        b=kroNUfbSepamcrVhtllqrDo0ovmxIk0Amf5Xa75sSH/+JS+SWTwddhK3HnytzZJ1wL
         T8IyF5t2qZZwPbY5zcyyIVRLUfRnW0Nje4/zcDIaQpoisH82IRcsxk2SQAG8tm4qLYBA
         cX1ngkTIMDjHL//O19KC9sRVsG6WDU7U0emtzVpfpvyP3qS/hfvT6wzILp66p0Cx7t3X
         dRDfsS7ItJDT7LAaLlpLDE5qT2nxpvlUU2FUp1D0rbCVzdwrhB/0OmzMahN09UBOsoMk
         aVlyol85A3SM0ac6NgaiQ/miFSi4ECdUx0scv1sZXTPukMK5Y0v8lmb+lVHy6lZt6KHt
         0daw==
X-Gm-Message-State: AOAM533tyE0IO77Ykl7Y2PAudHWwNDhXd2KoIvj2SM/JTbxoQ6Dr49Aw
        vhrk2GsSZ4N0UpULaCAkJm8R/Bu0n4jbsrby1Vb1IhgmM3gjBg==
X-Google-Smtp-Source: ABdhPJw2xUJawW9/Ze4jSl0i30u0x4kQAg098sTZsGUOC0qnIfL3NuTn+D6yxKstU2B0yewGsDbX4yS8WerhhqAi7Y8=
X-Received: by 2002:a25:7084:: with SMTP id l126mr1773231ybc.310.1638188772741;
 Mon, 29 Nov 2021 04:26:12 -0800 (PST)
MIME-Version: 1.0
References: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com> <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
In-Reply-To: <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Mon, 29 Nov 2021 20:26:02 +0800
Message-ID: <CA+WzARmTSD_S22xHSp2TinobzEXDwZzPU5vv7NX7-SqtUOtA5g@mail.gmail.com>
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
Preallocation of gigantic pages cant=E2=80=98 work in all the environment, =
not
only in single node.
I think the issue is because of the replacement
nodes_weight(node_states[N_MEMORY] with
nr_online_nodes in my patch of last version. Sorry for my careless. I
didn't notice that  parameter
nid is int =EF=BC=8Cbut nr_online_nodes is unsigned int. so, this if (nid >=
=3D
nr_online_nodes) is always
true when nid is NUMA_NO_NODE(-1).  I will send a fix  as soon as passible.
This is really a low-level mistake ^^
> >
> > Also unrelated, is there any progress on allocating 1GB pages on demand=
 so that I could
> > allocate them only when I run a VM?
>
> That should be possible.  Such support was added back in 2014 with commit
> 944d9fec8d7a "hugetlb: add support for gigantic page allocation at runtim=
e".
>
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
