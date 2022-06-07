Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02C54273C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiFHBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453119AbiFGXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:14:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16893B4EE5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654635899; x=1686171899;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPcIftRj6V6O6B26UF70MyNErLXGhjWNb6LX0nAvIH0=;
  b=OXyOO2/+sbp8npJP4nWVU3b9GSfH7blo8zVXIQQgEglsQyKY9RrRgcdq
   2ISm/yAOG1ICHPVLJiyLXx7YS5eBwS/5zQqry9gMgVVzCnXNK05WOhZ+3
   jBKhLKuMQbjOHH9i5zsQuaDnoEP4laJzTWiHsn8Xw1am1kutWGLwybOtW
   LrztkVxqFU5loWHUgYq8pqHh++01C4TC1bBzoow8rdWZM9Dq44dUKTv3n
   qNmEeNQ02HMhr5BpJlLClW6LtRKBYOBV1HSoF7YAP5OO7/IL2genxHyYl
   hMeH/iau0UHgysQ5v2qNg9YKsBO8vJQZqN3A3aU+z8Opai5QOM6QSbqSm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277746378"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277746378"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584375949"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:15:59 -0700
Message-ID: <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
Date:   Tue, 07 Jun 2022 13:15:59 -0700
In-Reply-To: <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> 
>  
> +static struct memory_tier *__node_get_memory_tier(int node)
> +{
> +	struct memory_tier *memtier;
> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {

We could need to map node to mem_tier quite often, if we need
to account memory usage at tier level.  It will be more efficient
to have a pointer from node (pgdat) to memtier rather
than doing a search through the list.


> +		if (node_isset(node, memtier->nodelist))
> +			return memtier;
> +	}
> +	return NULL;
> +}
> +
> 

Tim

