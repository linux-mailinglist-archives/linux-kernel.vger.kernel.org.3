Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4276058D24C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiHIDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHIDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:14:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9865A1759D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660014841; x=1691550841;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=rapC+xk33EA/lz7q1a+W/DDjjYOU9PGdfL3uB3RSTtk=;
  b=Ld+pqFl0KS0LUKQ8ximVgm/yuAC3xYuex/0f3wMC9C1w/cIzexAN7LbO
   6WqdC//Lyur47PFS172lt153nZSU2V28NZP3RTbbVlvekzVpkgVQHwgC4
   XJdO1OIcPovC+gjT3wDQcHJm9ONNs+Y4kimqaYFxaLu3WCnr7q0h4QMJQ
   w4CJZ4bsxnSfI3ETgIwJ/AivTGIdV0mkKewl6A/ELulB1j0AFhpAdxJ2o
   13LY1oP4RD15gxw9ItC/vPdFj2T7rKIw2WBWzym+6IcHJ9oc8i9SB0jpo
   xrokBZIorSnxbaHCpCMJw4ivOh+HIoAqp3U3z1guawOP/+W0O6EL0ihdS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352472395"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="352472395"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:14:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="932318884"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:13:57 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v13 9/9] lib/nodemask: Optimize node_random for nodemask
 with single NUMA node
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
        <20220808062601.836025-10-aneesh.kumar@linux.ibm.com>
Date:   Tue, 09 Aug 2022 11:13:54 +0800
In-Reply-To: <20220808062601.836025-10-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 8 Aug 2022 11:56:01 +0530")
Message-ID: <87fsi6glcd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> The most common case for certain node_random usage (demotion nodemask) is with
> nodemask weight 1. We can avoid calling get_random_init() in that case and
> always return the only node set in the nodemask.

I think that this patch can sit between [5/9] and [6/9], just after it
is used.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  lib/nodemask.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/lib/nodemask.c b/lib/nodemask.c
> index e22647f5181b..c91a6b0404a5 100644
> --- a/lib/nodemask.c
> +++ b/lib/nodemask.c
> @@ -20,12 +20,21 @@ EXPORT_SYMBOL(__next_node_in);
>   */
>  int node_random(const nodemask_t *maskp)
>  {
> -	int w, bit = NUMA_NO_NODE;
> +	int w, bit;
>  
>  	w = nodes_weight(*maskp);
> -	if (w)
> +	switch (w) {
> +	case 0:
> +		bit = NUMA_NO_NODE;
> +		break;
> +	case 1:
> +		bit = __first_node(maskp);

Per my understanding, first_node() is the formal API and we should use
that?  Just like we use nodes_weight() instead of __nodes_weight().

Best Regards,
Huang, Ying

> +		break;
> +	default:
>  		bit = bitmap_ord_to_pos(maskp->bits,
> -			get_random_int() % w, MAX_NUMNODES);
> +					get_random_int() % w, MAX_NUMNODES);
> +		break;
> +	}
>  	return bit;
>  }
>  #endif
