Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E35558B88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiFWXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiFWXHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:07:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504885DF3B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656025643; x=1687561643;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dK5AkiFzx6BZn0opH02USW8M+3ZT6QfoFeqIc0A1zU=;
  b=lVWVIeGc3aKhpIxMOvFFGf+BBJJtl5rOQ4YH40XGz5uzPr8A6k4VE7B+
   YJZOtvU7KLlfToxaxOC0yOtxxyWYOIyDex5rjrnwL/0d37J57qZcBdvJA
   lxhsxOeI1vx0F5ycNqe3TDWReUemBiP/cqkzy6Sbbh7dx4UygSZrzantu
   x1iTUbROlnliNW8mW5fJaOnfMitfq1uHdIfNHNjYxFXPi9XVAsSFF2Y3c
   RzNJ6wub3csns76uOqwz+i1d6CWxer+5AL/0gQIJkhO8ucpVvDGrRkjb+
   N8wX2Rmc7csBh1PYCZCmkqHrexLWxAJ1WPhBNqxulw7AlPcyDvulGPsfX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306330217"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306330217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:07:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="915421573"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.125.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:07:22 -0700
Message-ID: <bacbf819cc7a8ad6c1ca2a668c412ec8ee2c6edc.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] mm/memory-tiers Add functions for tier memory
 usage in a cgroup
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
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
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Jun 2022 16:07:21 -0700
In-Reply-To: <875ykuabth.fsf@linux.ibm.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
         <94a10c772c50d378b81dad654476551bfc50e3d7.1655242024.git.tim.c.chen@linux.intel.com>
         <875ykuabth.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-21 at 09:48 +0530, Aneesh Kumar K.V wrote:
> Tim Chen <tim.c.chen@linux.intel.com> writes:
> 
>  +unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg)
> > +{
> > +	struct memory_tier *top_tier;
> > +
> > +	top_tier = list_first_entry(&memory_tiers, struct memory_tier, list);
> > +	if (top_tier)
> > +		return mem_cgroup_memtier_usage(memcg, top_tier);
> > +	else
> > +		return 0;
> > +}
> 
> As discussed here, we would want to consider all memory tiers that got
> compute as top tier.
> 
> https://lore.kernel.org/linux-mm/11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com
> 
> V6 patchset actually walk the full memory tier hierarchy reverse and consider any
> memory tier with higher or equal rank value than the first memory tier with CPU as top tier.
> 
> https://lore.kernel.org/linux-mm/20220610135229.182859-12-aneesh.kumar@linux.ibm.com
> 

Thanks.  Will take that into consideration for future patches.

Tim

