Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAE542AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiFHJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiFHJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:09:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FDFC836
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654676886; x=1686212886;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8K6LeNsRWmnLejKyvvzLEzNHPs1j7CKcbVI/K2R0Ois=;
  b=SbqT+dC8JUTAzl61PFw0c87HhFXMytLdtq1eVO2I7EgGtTNQvgYxU6tg
   95C/dBffrEOkTPpCo+rpVkvMLrcU/UFKUwPfJjxBT6lEo1OlUAhBF5P5Z
   KayUUA7jnXnI7YBTn5+/R9a3DVEXlFbMpkm48qDu65upP6EKNNEUSfYYr
   XzlSq3PEMUxAImgil5f3n0wThgHRCa1QkQQsINahjLZuJqowfdbI2v/kQ
   POC3aj9pDQlJL8L9SsVtvm1cnUmDdXlP5akFwVqv7PGx0ZRD/YMUHSbYF
   5rcCJF9c4NuMArQ+PML3Vd7Auxnc3kBqYeUPBhMVXGAZWXLvxTsplOqJd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274340315"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="274340315"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:28:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="723742180"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:28:02 -0700
Message-ID: <13a58454fc2512242d5ff69e9067afc926c3b563.camel@intel.com>
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Wed, 08 Jun 2022 16:27:59 +0800
In-Reply-To: <b4ea5d02-40d9-9928-1094-9befed7ae4ff@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
         <604403db000ced33f997688ce82eaa43ed6c8bbe.camel@intel.com>
         <b4ea5d02-40d9-9928-1094-9befed7ae4ff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 13:54 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 12:46 PM, Ying Huang wrote:
> > On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> > 
> > [snip]
> > 
> > > 
> > > +static int __init memory_tier_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
> > > +	if (ret)
> > > +		panic("%s() failed to register subsystem: %d\n", __func__, ret);
> > 
> > I don't think we should go panic for failing to register subsys and
> > device for memory tiers.  Just pr_err() should be enough.
> > 
> 
> So you are suggesting we continue to work with memory tiers with no 
> userspace interface?

Yes.  We don't need to panic system for this.

Best Regards,
Huang, Ying

> > > +
> > > +	/*
> > > +	 * Register only default memory tier to hide all empty
> > > +	 * memory tier from sysfs.
> > > +	 */
> > > +	ret = register_memory_tier(DEFAULT_MEMORY_TIER);
> > > +	if (ret)
> > > +		panic("%s() failed to register memory tier: %d\n", __func__, ret);
> > > +
> > > +	/*
> > > +	 * CPU only nodes are not part of memoty tiers.
> > > +	 */
> > > +	memory_tiers[DEFAULT_MEMORY_TIER]->nodelist = node_states[N_MEMORY];
> > > +
> > > +	return 0;
> > > +}
> > > +subsys_initcall(memory_tier_init);
> > > +
> > > +#endif	/* CONFIG_TIERED_MEMORY */
> > 
> > 
> 


