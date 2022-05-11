Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8922523334
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiEKMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiEKMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:37:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5136EB0A66;
        Wed, 11 May 2022 05:37:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA5BC68C7B; Wed, 11 May 2022 14:37:24 +0200 (CEST)
Date:   Wed, 11 May 2022 14:37:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Conor.Dooley@microchip.com
Cc:     hch@lst.de, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: linux-next: Tree for May 3
Message-ID: <20220511123724.GA25121@lst.de>
References: <20220503172926.08215c77@canb.auug.org.au> <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com> <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com> <20220509141122.GA14555@lst.de> <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com> <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com> <20220511062232.GA32524@lst.de> <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com> <20220511064832.GA761@lst.de> <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:10:40AM +0000, Conor.Dooley@microchip.com wrote:
> Without even trying the patch, I double checked the boot log from
> 3f70356edf56 and I get a "software IO TLB: Cannot allocate buffer"
> With the patch its a "software IO TLB: swiotlb_init_remap: failed
> to allocate tlb structure". So spot on & I feel like an idiot for
> not spotting that before!
> 
> Is failing being fatal valid, or should it fail gracefully like it
> used to do? To me, blissfully unaware about swiotlb, the "current"
> behaviour of failing gracefully makes more sense.

Given that we're at -rc6 I think the most important thing for now is to
avoid a regression and restore the old behavior.  I'll send out a
series with this and the nslab related fixes for Xen today.

But we should look into why allocating the memory fails for your
plaforms.  Does it have very little memory?  I can't really think
of why else the memblock allocation for swiotlb would fail.
