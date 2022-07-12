Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE15715C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiGLJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGLJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:31:31 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB159CE2A;
        Tue, 12 Jul 2022 02:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657618275; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=esepyqqENhbUHssqbm3w5bD5cdhGO5fi2Rhz8vN7REpruv8h5AblXGWeHGMfA9CuPc0LxktiSlmHc0n4RDO4uc3GXuGbn6b+1ZOlqZqOk5xdCrVt/1P8fB3E60rphH+ZAQ9FWeikvWSzzHJeDKmtyixozeQOWMblbKccAnnARuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657618275; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0D684KlQxe15o6oPTlLFmpWsKQgQVLQH0JtURWns8cw=; 
        b=gWxrPwEeg3nDSUhtbtH0/Xo5toBJDzLtgUCngbwwy7b/qXsE91WtAXt+TMZl3FJNpVMTJh5ZUSTUSYE1dPOHCodPK2lIZntIx8qU2b+eI470DkAvCIOBArmKXmHnz7nI2BzmEB4ett02PWa53oNf4dBfVNQu0l1aeWv1r2pkYB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657618275;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0D684KlQxe15o6oPTlLFmpWsKQgQVLQH0JtURWns8cw=;
        b=nYbhbFyMB24s2IBlrQPVHYwrZ0Qx9G5U6vygHoQ12UM8PR/GHKdFKyhPLy5IxZRu
        Lv/ipEBG63JcgQ4nBhmUF1XfXqu8jHsKWgaMUE5AFqXcjfZOVrM17A7Up2J9hMXOWnc
        3ggyzk4gH9y4h1PMtH/FTkJIJvHwaEsYCPibLvgA=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657618273698671.8295056333932; Tue, 12 Jul 2022 02:31:13 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:31:13 +0800
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
Message-ID: <181f1bf9584.f463724e580236.5502316582440422915@linux.beauty>
In-Reply-To: <4cf14bde-fb4c-99d9-58ce-a788a700d5f3@redhat.com>
References: <20220711122459.13773-1-me@linux.beauty>
 <20220711122459.13773-3-me@linux.beauty>
 <c2d4c6ac-fad7-d5b3-8cbf-f62a7db5b998@redhat.com>
 <181f0a5f2a5.cf94ce78513585.4158910057206462182@linux.beauty> <4cf14bde-fb4c-99d9-58ce-a788a700d5f3@redhat.com>
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
 ---- On Tue, 12 Jul 2022 15:31:08 +0800  David Hildenbrand <david@redhat.com> wrote --- 
 > On 12.07.22 06:23, Li Chen wrote:
 > > Hi David,
 > >  ---- On Mon, 11 Jul 2022 22:53:36 +0800  David Hildenbrand <david@redhat.com> wrote --- 
 > >  > On 11.07.22 14:24, Li Chen wrote:
 > >  > > From: Li Chen <lchen@ambarella.com>
 > >  > > 
 > >  > > When mhp use sparse_add_section, don't check no-map region,
 > >  > > so that to allow no-map reserved memory to get struct page
 > >  > > support.
 > >  > > 
 > >  > > Signed-off-by: Li Chen <lchen@ambarella.com>
 > >  > > Change-Id: I0d2673cec1b66adf695251037a00c240976b226f
 > >  > > ---
 > >  > >  mm/sparse.c | 4 +++-
 > >  > >  1 file changed, 3 insertions(+), 1 deletion(-)
 > >  > > 
 > >  > > diff --git a/mm/sparse.c b/mm/sparse.c
 > >  > > index 120bc8ea5293..a29cd1e7014f 100644
 > >  > > --- a/mm/sparse.c
 > >  > > +++ b/mm/sparse.c
 > >  > > @@ -690,7 +690,9 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 > >  > >  
 > >  > >      if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
 > >  > >          rc = -EINVAL;
 > >  > > -    else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
 > >  > > +    else if (memblock_is_map_memory(PFN_PHYS(pfn)) &&
 > >  > > +         bitmap_intersects(map, subsection_map,
 > >  > > +                   SUBSECTIONS_PER_SECTION))
 > >  > >          rc = -EEXIST;
 > >  > >      else
 > >  > >          bitmap_or(subsection_map, map, subsection_map,
 > >  > 
 > >  > I'm not sure I follow completely what you are trying to achieve. But if
 > >  > you have to add memblock hacks into mm/sparse.c you're most probably
 > >  > doing something wrong.
 > >  > 
 > >  > Please explain why that change is necessary, and why it is safe.
 > > 
 > > In the current sparse memory model, free_area_init will insert all memblock.memory into subsection_map and no-map rmem is also a 
 > > memblock.memory. So, without this change, fill_subsection_map will return -EEXIST.
 > > 
 > > I would say it's not a good idea to insert no-map memblock into subsection_map, and I have no idea why sparse do this.
 > > So, I simply skip no-map region here.
 > 
 > The thing is:
 > 
 > if the subsection map is set, then there already *is* a memmap and you
 > would simply be ignoring it (and overwriting a memmap in e.g.,
 > ZONE_NORMAL to be in ZONE_DEVICE suddenly, which is wrong).
 > 
 > 
 > Reading memblock_mark_nomap():
 > 
 > "The memory regions marked with %MEMBLOCK_NOMAP will not be added to the
 > direct mapping of the physical memory. These regions will still be
 > covered by the memory map. The struct page representing NOMAP memory
 > frames in the memory map will be PageReserved()"
 > 
 > 
 > So having a memmap for these ranges is expected, and a direct map is not
 > desired. What you propose is a hack. You either have to reuse the
 > existing memmap (which is !ZONE_DEVICE -- not sure if that's a problem)
 > or we'd have to look into teaching init code to not allocate a memmap
 > for sub-sections that are fully nomap.
 > 
 > But not sure who depends on the existing memmap for nomap memory.

 Points taken, thanks! I will try to dig into it.

Regards,
Li
 > > 
 > > As for safety:
 > > 1. The caller of fill_subsection_map are mhp and *_memremap_pages functions, no-map regions are not related to them, so existing codes won't be broken.
 > > 2. This change doesn't change memblock and subsection_map.
 > > 
 > 
 > Sorry, but AFAIKT it's a hack and we need a clean way to deal with nomap
 > memory that already has a memmap instead.
 > 
 > 
 > -- 
 > Thanks,
 > 
 > David / dhildenb
 > 
 > 
