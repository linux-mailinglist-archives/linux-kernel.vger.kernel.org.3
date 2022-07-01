Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B256368D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGAPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGAPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:04:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38658F71
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656687896; x=1688223896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8o2fHDh/g5iXlzvVYERvl5noxe79p0pRuoz17CCpmc=;
  b=B9kYJC5Rq4mWopIAVjNQ1XRb13hTTd3l2JSv0rMSYoY/dAc8Q4QyVf3V
   GYsUqBR1ZGyDeOdjvQ1LM7kSUk/2C2giSXroG+zBz/PM1IoKPG5b59qMW
   ub7HbloJhppXe2Bwu0BRdGVcyMl639Ts7iIGzNWTF31eLOQc6LD9IBjKJ
   I2CF6tw9hcw5zTxkiRCzx4idCdjZAJsM5ed/D+8L6PZPHwtB2wSUBfZ80
   Cbja2fEViTtwkDjMonqAK2oWvL48RI49B4YmeTduaUnFJ+uROs/svbIA1
   VTxO0JsivPBrRgsbzjMnRbp7dsSxoaGKo8MRgDJTbO6diM0bdVOP4sj9f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="263068599"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="263068599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 08:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="681429652"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2022 08:04:52 -0700
Date:   Fri, 1 Jul 2022 23:04:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220701150451.GA62281@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jul 01, 2022 at 04:37:00PM +0200, Christoph Lameter wrote:
> On Fri, 1 Jul 2022, Feng Tang wrote:
> 
> >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> 
> It would be good to avoid expanding the basic slab handling functions for
> kmalloc. Can we restrict the mods to the kmalloc related functions?

Yes, this is the part that concerned me. I tried but haven't figured
a way.

I started implemting it several month ago, and stuck with several
kmalloc APIs in a hacky way like dump_stack() when there is a waste
over 1/4 of the object_size of the kmalloc_caches[][].

Then I found one central API which has all the needed info (object_size &
orig_size) that we can yell about the waste :

static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
                gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)

which I thought could be still hacky, as the existing 'alloc_traces'
can't be resued which already has the count/call-stack info. Current
solution leverage it at the cost of adding 'orig_size' parameters, but
I don't know how to pass the 'waste' info through as track/location is
in the lowest level.

Thanks,
Feng



