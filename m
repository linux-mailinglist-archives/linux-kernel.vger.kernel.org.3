Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D538157A294
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiGSPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGSPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:03:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36714D4C7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658242999; x=1689778999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pNuvj59Pj8ObVhOokpmEpjaj9BqgjjBBTE9CWA97oY=;
  b=D3nDejhudVLDzwbuHgMEe5pwjUvxwp9XQYHM49SceVfH2LpDZpfdV0bo
   5qVZqgVxplf+LWwQlnmTH+zWs5Q3YieEXg/nFpZp6NyBSIFxnyEunoeEs
   LyZPkNBAY0SQvMHZ7/GGDX+hFvCBF9P9WJgxrCRhHej4NBWfnGpCL6Frd
   tgpwpcpVuCYoieirjZplLltC9bjVCRVhgzhmBCQ+oGbezNFpmhvDnUl0I
   KWZA79pE136/YhaP7V0CbVg0d4X5xFw6GD81iaVw0WAL+Th98JlhWTLqX
   qclMOTXchv1Lkpc5donaUZVzLjVkyEhhU7kaLe6cG9axS16JTNyUiiwzD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372814799"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="372814799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 08:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="739892680"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2022 08:03:10 -0700
Date:   Tue, 19 Jul 2022 23:03:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220719150315.GB56558@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
 <20220713073642.GA69088@shbuild999.sh.intel.com>
 <45906408-34ce-4b79-fbe4-768335ffbf96@suse.cz>
 <20220715082922.GA88035@shbuild999.sh.intel.com>
 <20220719134503.GA56558@shbuild999.sh.intel.com>
 <5ad51c9f-ce84-5d1b-309c-6e475cebca97@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad51c9f-ce84-5d1b-309c-6e475cebca97@suse.cz>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:39:58PM +0200, Vlastimil Babka wrote:
> On 7/19/22 15:45, Feng Tang wrote:
> > Hi Vlastimil,
> > 
> > On Fri, Jul 15, 2022 at 04:29:22PM +0800, Tang, Feng wrote:
> > [...]
> >> > >> - the knowledge of actual size could be used to improve poisoning checks as
> >> > >> well, detect cases when there's buffer overrun over the orig_size but not
> >> > >> cache's size. e.g. if you kmalloc(48) and overrun up to 64 we won't detect
> >> > >> it now, but with orig_size stored we could?
> >> > > 
> >> > > The above patch doesn't touch this. As I have a question, for the
> >> > > [orib_size, object_size) area, shall we fill it with POISON_XXX no matter
> >> > > REDZONE flag is set or not?
> >> > 
> >> > Ah, looks like we use redzoning, not poisoning, for padding from
> >> > s->object_size to word boundary. So it would be more consistent to use the
> >> > redzone pattern (RED_ACTIVE) and check with the dynamic orig_size. Probably
> >> > no change for RED_INACTIVE handling is needed though.
> >> 
> >> Thanks for clarifying, will go this way and do more test. Also I'd 
> >> make it a separate patch, as it is logically different from the space
> >> wastage.
> > 
> > I made a draft to redzone the wasted space, which basically works (patch
> > pasted at the end of the mail) as detecting corruption of below test code:
> > 	
> > 	size = 256;
> > 	buf = kmalloc(size + 8, GFP_KERNEL);
> > 	memset(buf + size + size/2, 0xff, size/4);
> > 	print_section(KERN_ERR, "Corruptted-kmalloc-space", buf, size * 2);
> > 	kfree(buf);
> > 
> > However when it is enabled globally, there are many places reporting
> > corruption. I debugged one case, and found that the network(skb_buff)
> > code already knows this "wasted" kmalloc space and utilize it which is
> > detected by my patch.
> > 
> > The allocation stack is:
> > 
> > [    0.933675] BUG kmalloc-2k (Not tainted): kmalloc unused part overwritten
> > [    0.933675] -----------------------------------------------------------------------------
> > [    0.933675]
> > [    0.933675] 0xffff888237d026c0-0xffff888237d026e3 @offset=9920. First byte 0x0 instead of 0xcc
> > [    0.933675] Allocated in __alloc_skb+0x8e/0x1d0 age=5 cpu=0 pid=1
> > [    0.933675]  __slab_alloc.constprop.0+0x52/0x90
> > [    0.933675]  __kmalloc_node_track_caller+0x129/0x380
> > [    0.933675]  kmalloc_reserve+0x2a/0x70
> > [    0.933675]  __alloc_skb+0x8e/0x1d0
> > [    0.933675]  audit_buffer_alloc+0x3a/0xc0
> > [    0.933675]  audit_log_start.part.0+0xa3/0x300
> > [    0.933675]  audit_log+0x62/0xc0
> > [    0.933675]  audit_init+0x15c/0x16f
> > 
> > And the networking code which touches the [orig_size, object_size) area
> > is in __build_skb_around(), which put a 'struct skb_shared_info' at the
> > end of this area:
> > 
> > 	static void __build_skb_around(struct sk_buff *skb, void *data,
> > 				       unsigned int frag_size)
> > 	{
> > 		struct skb_shared_info *shinfo;
> > 		unsigned int size = frag_size ? : ksize(data);
> 
> Hmm so it's a ksize() user, which should be legitimate way to use the
> "waste" data. Hopefully it should be then enough to patch __ksize() to set
> the object's tracked waste to 0 (orig_size to size) - assume that if
> somebody called ksize() they intend to use the space. That would also make
> the debugfs report more truthful.

Yep, it sounds good to me. Will chase other corrupted places, hope
they are legitimate users too :)

Thanks,
Feng



