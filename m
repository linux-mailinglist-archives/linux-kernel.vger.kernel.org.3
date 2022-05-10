Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244D5209C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiEJAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiEJAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:04:19 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C712BD0F3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:00:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a22so12157267qkl.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ibOO/2Z3Vfs+oa3W3i28/woPMJReYnyxPcCH3V9xpEs=;
        b=PGfogSyjud6Z/U+Tnrdng5NQRymWDhri1yqLua9o4+JZufae9l6ep9anQcuAj8ByCv
         ZsX/aOvhWbGYWUF+Bj3MBJ2msZnx+ET8C6Kyc+S86kHjbIFIe7Si9yGFhBS6FYp2tlHW
         /ZapA9UARbWLy3tk7vfLJXhOQWm6siTg6w5ENgXK/PjNf3GDai7nHKb8fJCQNRoL/XWS
         VK20n7EI6+pO51sf3XgSLCWvltawUpDhtOdxJ7uhyD8Y4GBZur4NerQGwYz/ytgGnBl+
         HNgd8xsJaENNLapyB3q6rhwLncr6+4YvNVGWXGbjPyIoWgrlnxXGKTisaw/m59GsZkZb
         1MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ibOO/2Z3Vfs+oa3W3i28/woPMJReYnyxPcCH3V9xpEs=;
        b=gACc6uwsV94PoHms7oVnMB+YywxZ7GNPK9bGceE4P0uugvQK3dqekdXIAmzbIYGQi1
         ULPDt88nQVtXvevygw079qO9Pn4h9GW7dgnyYu5QH1uUugfQLrr53E0lH842QEsVaEre
         aCaIQpAVwEcIsjZLuLhSvXpverIJO71fuEpRNKFeP6mNMRmkZBWp8tj2meHp+lM3ACiz
         8mp04NAQ/MmxQsOqeNcYFgg2N3pA3p+kS7+uAYwQo/eo9xioNspLtCrTYxe2pPCCAcVR
         aXD2w+wAMR8VSahj2Shrhp7UZHwGWwJkVgWZhHSmTHkPGynmBb3Lxfr9pihVOUjaZRsT
         xdug==
X-Gm-Message-State: AOAM531VysoKyQGxbJuBpccMi10qEQCd0CJxsiXGLLfoQDFCT7kGsvZU
        iE90NltHZKbV2q20zL2tgoP9oGz70yhCLr27aU3S9LgjUNo=
X-Google-Smtp-Source: ABdhPJzdn+4+t7APmbnzAxJHw3SKUWsUacTcc8OdvDUUn8eY5KP+3SdObklD1Ou8fxdmEe6hb6KRmj8FSZAJjcpEpjQ=
X-Received: by 2002:a05:620a:24cd:b0:6a0:414c:a648 with SMTP id
 m13-20020a05620a24cd00b006a0414ca648mr13467916qkn.465.1652140823731; Mon, 09
 May 2022 17:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com>
In-Reply-To: <20220509074330.4822-1-jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 10 May 2022 09:00:12 +0900
Message-ID: <CAJrd-UvRgtox=JD3jMKiUouHO7Jj42_qAfsZv5Rx38TKMdLv1A@mail.gmail.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

let me add Joonsoo Kim

2022=EB=85=84 5=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:39, Ja=
ewon Kim <jaewon31.kim@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The page extension can be prepared for each section. But if the first
> page is not valid, the page extension for the section was not
> initialized though there were many other valid pages within the section.
>
> To support the page extension for all sections, refer to memblock memory
> regions. If the page is valid use the nid from pfn_to_nid, otherwise use
> the previous nid.
>
> Also this pagech changed log to include total sections and a section
> size.
>
> i.e.
> allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x8000=
000)
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  mm/page_ext.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 2e66d934d63f..506d58b36a1d 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct notif=
ier_block *self,
>  void __init page_ext_init(void)
>  {
>         unsigned long pfn;
> -       int nid;
> +       int nid =3D 0;
> +       struct memblock_region *rgn;
> +       int nr_section =3D 0;
> +       unsigned long next_section_pfn =3D 0;
>
>         if (!invoke_need_callbacks())
>                 return;
>
> -       for_each_node_state(nid, N_MEMORY) {
> +       /*
> +        * iterate each memblock memory region and do not skip a section =
having
> +        * !pfn_valid(pfn)
> +        */
> +       for_each_mem_region(rgn) {
>                 unsigned long start_pfn, end_pfn;
>
> -               start_pfn =3D node_start_pfn(nid);
> -               end_pfn =3D node_end_pfn(nid);
> -               /*
> -                * start_pfn and end_pfn may not be aligned to SECTION an=
d the
> -                * page->flags of out of node pages are not initialized. =
 So we
> -                * scan [start_pfn, the biggest section's pfn < end_pfn) =
here.
> -                */
> +               start_pfn =3D (unsigned long)(rgn->base >> PAGE_SHIFT);
> +               end_pfn =3D start_pfn + (unsigned long)(rgn->size >> PAGE=
_SHIFT);
> +
> +               if (start_pfn < next_section_pfn)
> +                       start_pfn =3D next_section_pfn;
> +
>                 for (pfn =3D start_pfn; pfn < end_pfn;
>                         pfn =3D ALIGN(pfn + 1, PAGES_PER_SECTION)) {
>
> -                       if (!pfn_valid(pfn))
> -                               continue;
> -                       /*
> -                        * Nodes's pfns can be overlapping.
> -                        * We know some arch can have a nodes layout such=
 as
> -                        * -------------pfn-------------->
> -                        * N0 | N1 | N2 | N0 | N1 | N2|....
> -                        */
> -                       if (pfn_to_nid(pfn) !=3D nid)
> -                               continue;
> +                       if (pfn_valid(pfn))
> +                               nid =3D pfn_to_nid(pfn);
> +                       nr_section++;
>                         if (init_section_page_ext(pfn, nid))
>                                 goto oom;
>                         cond_resched();
>                 }
> +               next_section_pfn =3D pfn;
>         }
> +
>         hotplug_memory_notifier(page_ext_callback, 0);
> -       pr_info("allocated %ld bytes of page_ext\n", total_usage);
> +       pr_info("allocated %ld bytes of page_ext for %d sections (1 secti=
on : 0x%x)\n",
> +               total_usage, nr_section, (1 << SECTION_SIZE_BITS));
>         invoke_init_callbacks();
>         return;
>
> --
> 2.17.1
>
