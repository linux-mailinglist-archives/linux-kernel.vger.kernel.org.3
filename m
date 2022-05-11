Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295425235B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiEKOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiEKOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:38:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA351581;
        Wed, 11 May 2022 07:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7418B8242D;
        Wed, 11 May 2022 14:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4790FC34114;
        Wed, 11 May 2022 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652279878;
        bh=+EwM9/Fo/mYHUrlVBMU+VRCENMG+agU2bXee/mgnCV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oivTdHg0ETsFfYJ3nLcAkKMxQ0DDelY3MOQqxmOwu5Xuv22ns3iZdX45d3cAK7+gA
         Drnv1xYGqunk1VYAvfQrEnWxX7yE2xkTN9e1KfddBiCN3mAwL3f6DfrJaK6WQu1ULj
         R+yHyy8Jwl4ab3b5AxKaHsVWivIS8vlYpjD1fX6ud5I8IPbdqvKya+zboCzBQO9+CC
         FkWxj+PybERog6k6gyAWL+OGBO5AQ59i5DWruA/S8fs1QdRO0+mqbP5ngzmYGyk/nM
         Jowgp9Xe/3mCaMVPGsw7O1QHK+cJV9R0BBGohbDBjcvMUwyp/hYsgYwMruZRMuv0pC
         bePN1FXBaE7DA==
Date:   Wed, 11 May 2022 17:37:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Conor.Dooley@microchip.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <YnvKPu5uQ8rqEcvV@kernel.org>
References: <20220509141122.GA14555@lst.de>
 <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com>
 <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
 <20220511062232.GA32524@lst.de>
 <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
 <20220511064832.GA761@lst.de>
 <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
 <20220511123724.GA25121@lst.de>
 <YnvDdPz4S5IJ7l/5@kernel.org>
 <20220511141034.GA31732@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511141034.GA31732@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:10:34PM +0200, Christoph Hellwig wrote:
> On Wed, May 11, 2022 at 05:08:52PM +0300, Mike Rapoport wrote:
> > I guess the default to use memblock_alloc_low() backfires on system with
> > physical memory living at 0x1000200000:
> > 
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000001000200000-0x000000103fffffff]
> > 
> > The default limit for "low" memory is 0xffffffff and there is simply no
> > memory there.
> 
> Is there any way to ask memblock for a specific address limit?
> swiotlb just wants <= 32-bit by default.  With the little caveat
> that it should be 32-bit addressable for all devices, and we don't
> know the physical to dma address mapping at time of allocation.

There is 

void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
			     phys_addr_t min_addr, phys_addr_t max_addr,
			     int nid);

that lets caller to specify min and max limits

Presuming that devices see [0x1000200000-0x103fffffff] as
[0x200000-0x3fffffff] we may try something like

	min = memblock_start_of_DRAM();
	max = min + 0xffffffff;

	if (flags & SWIOTLB_ANY)
		max = MEMBLOCK_ALLOC_ACCESSIBLE;

	tlb = memblock_alloc_try_nid(bytes, PAGE_SIZE, min, max, NUMA_NO_NODE);

-- 
Sincerely yours,
Mike.
