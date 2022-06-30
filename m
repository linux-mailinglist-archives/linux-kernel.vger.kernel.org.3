Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148BD560F54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiF3Cr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiF3Crv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:47:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2E3B02D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 701C6B82718
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4921C34114;
        Thu, 30 Jun 2022 02:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656557268;
        bh=q4b1LJ2DwRDteJ3iTMyAFDQxG0jHMQ+puHrfpRpsSCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KHQuPbMara6fJJNuTBPMcoIs0XXta5ogWsfuxzDDfaGdl+2yKvMEMvhAdnWo/Bqgs
         YHCM4qLx2j/0JANzk/mhQxitqSJeEIJICbburn+iHGcMx2IXS7L9EJ1FdTFsO7Uckn
         ovTRCIFbdeGlqXZlQiwckRC/P/Co3qNfzuRpQ3KI=
Date:   Wed, 29 Jun 2022 19:47:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-Id: <20220629194747.62effc10a994f67e26fe96af@linux-foundation.org>
In-Reply-To: <20220630023844.GA4668@shbuild999.sh.intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
        <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
        <20220630023844.GA4668@shbuild999.sh.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 10:38:44 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Hi Andrew,
> 
> Thanks for the review!
> 
> On Wed, Jun 29, 2022 at 07:30:06PM -0700, Andrew Morton wrote:
> > On Thu, 30 Jun 2022 09:47:15 +0800 Feng Tang <feng.tang@intel.com> wrote:
> > 
> > > kmalloc's API family is critical for mm, with one shortcoming that
> > > its object size is fixed to be power of 2. When user requests memory
> > > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> > > in worst case, there is around 50% memory space waste.
> > > 
> > > We've met a kernel boot OOM panic, and from the dumped slab info:
> > > 
> > >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > > 
> > > >From debug we found there are huge number of 'struct iova_magazine',
> > > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > > 1016 bytes. Though the issue is solved by giving the right(bigger)
> > > size of RAM, it is still better to optimize the size (either use
> > > a kmalloc friendly size or create a dedicated slab for it).
> > 
> > Well that's nice, and additional visibility is presumably a good thing.
> > 
> > But what the heck is going on with iova_magazine?  Is anyone looking at
> > moderating its impact?
> 
> Yes, I have a very simple patch at hand
> 
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -614,7 +614,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>   * dynamic size tuning described in the paper.
>   */
>  
> -#define IOVA_MAG_SIZE 128
> +#define IOVA_MAG_SIZE 127

Well OK.  Would benefit from a comment explaining the reasoning.

But we still have eleventy squillion of these things in flight.  Why?

>  #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>  
>  struct iova_magazine {
> 
> I guess changing it from 128 to 127 will not hurt much, and plan to
> send it out soon.

