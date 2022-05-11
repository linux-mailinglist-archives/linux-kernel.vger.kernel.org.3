Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED38523508
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiEKOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244381AbiEKOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:09:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620D69CF2;
        Wed, 11 May 2022 07:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5842B823EC;
        Wed, 11 May 2022 14:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C47C34113;
        Wed, 11 May 2022 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652278139;
        bh=o5xX6sJ490PzLKK/fZ+dg3ieCtWuIK0BIN2ZYglmcSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/+LK5uTuasJGcDXqcF0GVH52u8hAaFrbSlhBgleKlgPB7qeqLE8MUdP/dRazvxAj
         fJO7MaZY7xv0y+UW3ku69aRzDb9DOLILNqSNj2vSSCgm5YnH7PUqFDFncN7BAYnkcg
         c+DkyByzeTdpz75jqmSzoLs5Vknvl9nlTD9hAvL592nLUO6vVeGr+ODWqZC/cSmp0Y
         qdJsQvy++Rkw+C0A7IzSXvCYG6CCRBcaabzK+f8zFhtiTU4THNb2IllRWRMUxiHPbt
         ZTDup+yr2W2r41FyAeLLayyfwMxHnxVXlgAN0ThDChpyafU9H11iaw4ZcjSufwgQfW
         eQ/2qxMLDcPVQ==
Date:   Wed, 11 May 2022 17:08:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Conor.Dooley@microchip.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <YnvDdPz4S5IJ7l/5@kernel.org>
References: <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com>
 <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
 <20220509141122.GA14555@lst.de>
 <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com>
 <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
 <20220511062232.GA32524@lst.de>
 <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
 <20220511064832.GA761@lst.de>
 <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
 <20220511123724.GA25121@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511123724.GA25121@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:37:24PM +0200, Christoph Hellwig wrote:
> On Wed, May 11, 2022 at 10:10:40AM +0000, Conor.Dooley@microchip.com wrote:
> > Without even trying the patch, I double checked the boot log from
> > 3f70356edf56 and I get a "software IO TLB: Cannot allocate buffer"
> > With the patch its a "software IO TLB: swiotlb_init_remap: failed
> > to allocate tlb structure". So spot on & I feel like an idiot for
> > not spotting that before!
> > 
> > Is failing being fatal valid, or should it fail gracefully like it
> > used to do? To me, blissfully unaware about swiotlb, the "current"
> > behaviour of failing gracefully makes more sense.
> 
> Given that we're at -rc6 I think the most important thing for now is to
> avoid a regression and restore the old behavior.  I'll send out a
> series with this and the nslab related fixes for Xen today.
> 
> But we should look into why allocating the memory fails for your
> plaforms.  Does it have very little memory?  I can't really think
> of why else the memblock allocation for swiotlb would fail.

I guess the default to use memblock_alloc_low() backfires on system with
physical memory living at 0x1000200000:

[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000001000200000-0x000000103fffffff]

The default limit for "low" memory is 0xffffffff and there is simply no
memory there.

-- 
Sincerely yours,
Mike.
