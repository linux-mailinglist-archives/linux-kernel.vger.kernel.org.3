Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE158F895
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiHKHtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiHKHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:49:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039148E9B4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:49:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D1F968AA6; Thu, 11 Aug 2022 09:49:46 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:49:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811074946.GB14956@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz> <20220325164856.GA16800@lst.de> <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz> <YupFSpXOrcfXJNya@dhcp22.suse.cz> <YuqNToCACD8kKBG+@MiWiFi-R3L-srv> <YuqOrJKcgfamdXkk@dhcp22.suse.cz> <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv> <YuqX0OAItlMDfRUV@dhcp22.suse.cz> <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:01:28PM +0800, Baoquan He wrote:
> After attempts, I realize it's time to let one zone DMA or DMA32 cover
> the whole low 4G memory on x86_64. That's the real fix. The tiny 16M DMA
> on 64bit system is root cause.

We can't for two reasons:

 - people still use ISA cards on x86, including the industrial PC104
   version, and we still have drivers that rely on it
 - we still have PCI and PCIe devices with small than 26, 28, 30 and 31
   bit addressing limitations

We could try to get the 24-bit DMA entirely out of the zone allocator
and only fill a genpool at bootmem time.  But that requires fixing up
all the direct users of page and slab allocations on it first (of
which 90+% look bogus, with the s390 drivers being the obvious
exception).

Or we could make 'low' memory a special ZONE_MOVABLE and have an
allocator that can search by physical address an replace ZONE_DMA
and ZONE_DMA32 with that.  Which sounds like a nice idea to me, but
is pretty invasive.

