Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03DC523515
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiEKOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiEKOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:10:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8026569B4E;
        Wed, 11 May 2022 07:10:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D48C468C4E; Wed, 11 May 2022 16:10:34 +0200 (CEST)
Date:   Wed, 11 May 2022 16:10:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Conor.Dooley@microchip.com,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: linux-next: Tree for May 3
Message-ID: <20220511141034.GA31732@lst.de>
References: <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com> <20220509141122.GA14555@lst.de> <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com> <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com> <20220511062232.GA32524@lst.de> <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com> <20220511064832.GA761@lst.de> <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com> <20220511123724.GA25121@lst.de> <YnvDdPz4S5IJ7l/5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvDdPz4S5IJ7l/5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:08:52PM +0300, Mike Rapoport wrote:
> I guess the default to use memblock_alloc_low() backfires on system with
> physical memory living at 0x1000200000:
> 
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000001000200000-0x000000103fffffff]
> 
> The default limit for "low" memory is 0xffffffff and there is simply no
> memory there.

Is there any way to ask memblock for a specific address limit?
swiotlb just wants <= 32-bit by default.  With the little caveat
that it should be 32-bit addressable for all devices, and we don't
know the physical to dma address mapping at time of allocation.
