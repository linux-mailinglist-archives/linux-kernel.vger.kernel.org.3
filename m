Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA26571137
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiGLEYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLEXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:23:53 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D08B1A385;
        Mon, 11 Jul 2022 21:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657599818; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lYy2koBE8WQhh9HsLuGC8iyWBoYe4JjtACHNpzHZH99GbFxPjOIcaR4+kATOZVHTaT/RW42it+SRCDKNO7SqfnxQBf9Lj/vwWsHU3U4tzEM5RZGSk2zShNWfpNA9mINgA1Lmhu5fid3g9iEp7HsMNPgJC9TZ+daMGh1bMf1xKUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657599818; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AYZhl4Tgx5eXsw054d7yEPiQv66vkg0JPurDrzFEdv0=; 
        b=Hdd/Ff0B9wGPEc5WEtB/YnzgqXvJFPIGnI4JP9rkFCd4T95isyhFcaOJjSqFkcNL6ywomEXaiOo1rFVaZuXe8OkwjgIwOB4G9PWOSMcToXV4ptjNuDGw/mMJELLqd/JxYig3dn1HXJULFgYa5JSv/EK744xmc+Tlo9HK72p2NbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657599818;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AYZhl4Tgx5eXsw054d7yEPiQv66vkg0JPurDrzFEdv0=;
        b=V5rJcwOxbzzZIC4sbkyYEN3bVl2QRlwZdwcw8n/JqG1DQE7qXaM9iEx4PRnRF5Rg
        jBhigsObcYHRzKwGoCtW9bFxFhuE+jbM+bv+RYhGpXYtiF5Xk45KmebxhDRoVOF1m1W
        6KEa90MDYHaWYOyAjS1Tk2dCMOh0jcVeoYHUV6q8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657599816384969.9914766883284; Mon, 11 Jul 2022 21:23:36 -0700 (PDT)
Date:   Tue, 12 Jul 2022 12:23:36 +0800
From:   Li Chen <me@linux.beauty>
To:     "David Hildenbrand" <david@redhat.com>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Li Chen" <lchen@ambarella.com>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>
Message-ID: <181f0a5f2a5.cf94ce78513585.4158910057206462182@linux.beauty>
In-Reply-To: <c2d4c6ac-fad7-d5b3-8cbf-f62a7db5b998@redhat.com>
References: <20220711122459.13773-1-me@linux.beauty>
 <20220711122459.13773-3-me@linux.beauty> <c2d4c6ac-fad7-d5b3-8cbf-f62a7db5b998@redhat.com>
Subject: Re: [PATCH 2/4] mm/sparse: skip no-map memblock check when
 fill_subsection_map
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
 ---- On Mon, 11 Jul 2022 22:53:36 +0800  David Hildenbrand <david@redhat.com> wrote --- 
 > On 11.07.22 14:24, Li Chen wrote:
 > > From: Li Chen <lchen@ambarella.com>
 > > 
 > > When mhp use sparse_add_section, don't check no-map region,
 > > so that to allow no-map reserved memory to get struct page
 > > support.
 > > 
 > > Signed-off-by: Li Chen <lchen@ambarella.com>
 > > Change-Id: I0d2673cec1b66adf695251037a00c240976b226f
 > > ---
 > >  mm/sparse.c | 4 +++-
 > >  1 file changed, 3 insertions(+), 1 deletion(-)
 > > 
 > > diff --git a/mm/sparse.c b/mm/sparse.c
 > > index 120bc8ea5293..a29cd1e7014f 100644
 > > --- a/mm/sparse.c
 > > +++ b/mm/sparse.c
 > > @@ -690,7 +690,9 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 > >  
 > >      if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
 > >          rc = -EINVAL;
 > > -    else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
 > > +    else if (memblock_is_map_memory(PFN_PHYS(pfn)) &&
 > > +         bitmap_intersects(map, subsection_map,
 > > +                   SUBSECTIONS_PER_SECTION))
 > >          rc = -EEXIST;
 > >      else
 > >          bitmap_or(subsection_map, map, subsection_map,
 > 
 > I'm not sure I follow completely what you are trying to achieve. But if
 > you have to add memblock hacks into mm/sparse.c you're most probably
 > doing something wrong.
 > 
 > Please explain why that change is necessary, and why it is safe.

In the current sparse memory model, free_area_init will insert all memblock.memory into subsection_map and no-map rmem is also a 
memblock.memory. So, without this change, fill_subsection_map will return -EEXIST.

I would say it's not a good idea to insert no-map memblock into subsection_map, and I have no idea why sparse do this.
So, I simply skip no-map region here.

As for safety:
1. The caller of fill_subsection_map are mhp and *_memremap_pages functions, no-map regions are not related to them, so existing codes won't be broken.
2. This change doesn't change memblock and subsection_map.

 > 
 > If the subsection map already spans memory (iow, subsection map is set)
 > you intend to add, then something already added memory in that range?

No matter with or without this patch, fill_subsection_map will always return -EEXIST for mapped memory, so that's not a problem.
The key point here is I allowed no-map region to pass the check and didn't change anything to the mapped region.

Regards,
Li
