Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA68543871
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiFHQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbiFHQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:09:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F627C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654704567; x=1686240567;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0yvZkdbEo9Wm5Jp8QeqmDfGK82Rr8wPTjbjd78sR5M=;
  b=lzn246qV+QjxlZyuZORNLNOdSv2i3CynCBLDHLcxP1nzvOYrjPSwSmPx
   QqpHgp1N10trraTIu+qN0QZkaza6UkxJ25mlBQqzKKi58Xoa2bcKiRrTx
   YmgRfBMfEvS08IIYeSIyYOAsjColPC1OTWB8V9nTJEI0S5YPNpiJV+mdq
   Il5gUkhUi7yh9eoATKOgO4hhQGM5ZsjX3MixWdFaLuLnQpiJJdS2tzXF9
   rUx8wtfL2rMF6IK7ZOrcIRjRU6ICeOA3bIEyRhhWdK04dfv0fpkB8kmiO
   kYRm5W2gN9GojKg/Cb5biq0vFUd5rc0WNM/9Zv2MOqYRAOQRnjYRxnoZu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274474137"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="274474137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 09:06:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="615448127"
Received: from schen9-mobl.amr.corp.intel.com (HELO majassow-mobl2.amr.corp.intel.com) ([10.209.124.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 09:06:10 -0700
Message-ID: <fe42ee1ebe85362f888010b1b310e456a49abb4f.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
Date:   Wed, 08 Jun 2022 09:06:09 -0700
In-Reply-To: <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
         <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
         <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 10:25 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 1:45 AM, Tim Chen wrote:
> > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > >   
> > > +static struct memory_tier *__node_get_memory_tier(int node)
> > > +{
> > > +	struct memory_tier *memtier;
> > > +
> > > +	list_for_each_entry(memtier, &memory_tiers, list) {
> > 
> > We could need to map node to mem_tier quite often, if we need
> > to account memory usage at tier level.  It will be more efficient
> > to have a pointer from node (pgdat) to memtier rather
> > than doing a search through the list.
> > 
> > 
> 
> That is something I was actively trying to avoid. Currently all struct 
> memory_tier references are with memory_tier_lock mutex held. That 
> simplify the locking and reference counting.
> 
> As of now we are able to implement all the required interfaces without 
> pgdat having pointers to struct memory_tier. We can update pgdat with 
> memtier details when we are implementing changes requiring those. We 
> could keep additional memtier->dev reference to make sure memory tiers 
> are not destroyed while other part of the kernel is referencing the 
> same. But IMHO such changes should wait till we have users for the same.
> 

I think we should have an efficient mapping from node to memtier from
the get go.  There are many easily envisioned scenarios where
we need to map from node to memtier, which Ying pointed out.

Tim

