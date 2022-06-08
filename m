Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58B542830
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiFHHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354397AbiFHGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F9ED714
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654668609; x=1686204609;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wSpGqlJOs7netwFupcWWwUUiv8vP2SDhvcyzrkviMpI=;
  b=nI4UK6g2LehhIK5IUPM/BzT7jeCn5Jbk694ihEDY5HnkcQySy1P+8vQZ
   j3ovHrklHiz/ghi5pI4M7qOr3k4It5DPp8IpYD++PbOr+xSz9a1UU999a
   tZYCjISv5qbQx/ST12sb36Cxs/NxJFjz/DrqwyngaSV9qVCGy/mcjlu1V
   aIP17EQxL7JKPzVa0Xghce/Vmapu46S4p99G4crLbR3yFGzKpvGZF9L9p
   jYAcTuOVn2zJSjbFlohFDbV0VRpPmKtqVe5xdNYHm1oZOhXufEUI8GxjZ
   hXnv4hFtlRZegEadULUAeSGPVISmRbxKH4ERgOIAvBGY3fzJbIt9RPqeq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274326300"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="274326300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:10:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="826761637"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:10:04 -0700
Message-ID: <71a0734bc918b7a6cf75b0b411b7b6a87f0bda92.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
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
Date:   Wed, 08 Jun 2022 14:10:02 +0800
In-Reply-To: <f5480a57-4335-d982-8462-d4465369082d@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
         <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
         <f5480a57-4335-d982-8462-d4465369082d@linux.ibm.com>
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

On Wed, 2022-06-08 at 10:07 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 12:13 AM, Tim Chen wrote:
> ...
> 
> > > 
> > > +
> > > +static void memory_tier_device_release(struct device *dev)
> > > +{
> > > +	struct memory_tier *tier = to_memory_tier(dev);
> > > +
> > 
> > Do we need some ref counts on memory_tier?
> > If there is another device still using the same memtier,
> > free below could cause problem.
> > 
> > > +	kfree(tier);
> > > +}
> > > +
> > > 
> > ...
> 
> The lifecycle of the memory_tier struct is tied to the sysfs device life 
> time. ie, memory_tier_device_relese get called only after the last 
> reference on that sysfs dev object is released. Hence we can be sure 
> there is no userspace that is keeping one of the memtier related sysfs 
> file open.
> 
> W.r.t other memory device sharing the same memtier, we unregister the
> sysfs device only when the memory tier nodelist is empty. That is no 
> memory device is present in this memory tier.

memory_tier isn't only used by user space.  It is used inside kernel
too.  If some kernel code get a pointer to struct memory_tier, we need
to guarantee the pointer will not be freed under us.  And as Tim pointed
out, we need to use it in hot path (for statistics), so some kind of rcu
lock may be good.

Best Regards,
Huang, Ying



