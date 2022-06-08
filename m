Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2D54282D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiFHHMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbiFHGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:51:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1517DDCC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654670562; x=1686206562;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb5Q9Xorlzkgr5sm1kTa2c32QeDSwnsiMBz2O49CaLE=;
  b=fBC7l95KaVGahUWADJqLf71dXMxBk+1Tgolrdqq6VlV+/jie6oYVqrGp
   oZasi6YW6mnLy24NAhZQbjz4xUko1fWKXyAXz36uuduLbEm11txeS+DcX
   J1QrxJFjMzXUi95VdvKP7PyhOeS1B9Mx3q8Opm2AcOMnRXZhdkH7Vd98i
   a//HchoNXd2PGNcOUZYGVU2bG5ANv7HNvq5p3X3fxpDqfZPiz1rkgzF8r
   XsCT+RV6cqZbgwn2j3A7gC1g4nL+7IM1ZOeWplXCCFtXUj0LX1GU+Phii
   FIgxIf/3dWZIJAFH7hSSrTuOpQXhVK9iNYTk6A49d/s90nD/rMdwu7cck
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363136883"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="363136883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:42:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636616169"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:42:36 -0700
Message-ID: <052e3ba49bf815393ca4b51650134faee0d70feb.camel@intel.com>
Subject: Re: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
Date:   Wed, 08 Jun 2022 14:42:33 +0800
In-Reply-To: <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
         <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
         <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 10:25 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 1:45 AM, Tim Chen wrote:
> > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > 
> > >   
> > > 
> > > 
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

No.  We need a convenient way to access memory tier information from
inside the kernel.  For example, from nid to memory tier rank, this is
needed by migrate_misplaced_page() to do statistics too, iterate all
nodes of a memory tier, etc.

And, "allowed" field of struct demotion_nodes (introduced in [7/9] is
per-memory tier instead of per-node.  Please move it to struct
memory_tier.  And we just need a convenient way to access it.

All these are not complex, unless you insist to use memory_tier_lock and
device liftcycle to manage this in-kernel data structure.

Best Regards,
Huang, Ying

> > > +		if (node_isset(node, memtier->nodelist))
> > > +			return memtier;
> > > +	}
> > > +	return NULL;
> > > +}
> > > +
> > > 
> > 
> > Tim
> > 
> 
> -aneesh
> 


