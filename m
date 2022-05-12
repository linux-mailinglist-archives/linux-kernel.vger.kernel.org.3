Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34275256DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbiELVM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiELVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:12:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9EF5DE69
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652389972; x=1683925972;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xEM/Zk24Z91Nu9Mfk4uyW9jIi/U1i8D6/+PSEsiXcGk=;
  b=ErMB3au89ofzuAyfLP6VPBcajg375jctOaF0wm8Kk/arRJ6GP1DuhWrn
   Mgn40yKJ53Y90QwaY9PHfyRJ4c/zPxRKSka6g1+mGl8SFVMxdnkp/Pobu
   reP1P4w1x8x6PQ5g/39WUmpovlK8TOlGjB4Ldu+5pt1oDre1k4CI1iJuM
   bNgemD2N5BUXiyu6VGFjCbwyfn5eeUW3UUlJkHbWZimJjrizNl33xS1Hd
   ihRMiUc2bBW4wp8ohWHYchlF4PG/37up8sd/zP0Bw71po5HXBxgU0bCSN
   6IiEVpOa5ZZqeRIILfhRvnx4vZO+H/xwD0gCvD3yBiiZUUF/lSmOW1wux
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267729186"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="267729186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:12:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="594875294"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.114.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 14:12:51 -0700
Message-ID: <333438929a8680317bdae02da921d1e50fb9b0b3.camel@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Date:   Thu, 12 May 2022 14:12:51 -0700
In-Reply-To: <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
         <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
         <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
         <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
         <87y1z7jj85.fsf@linux.ibm.com>
         <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 01:15 -0700, Wei Xu wrote:
> 
> I am OK with moving back the memory tier nodelist into node/.  When
> there are more memory tier attributes needed, we can then create the
> memory tier subtree and replace the tier nodelist in node/ with
> symlinks.
> 
> So the revised sysfs interfaces are:
> 
> * /sys/devices/system/node/memory_tierN (read-only)
> 
>   where N = 0, 1, 2
> 
>   Format: node_list
> 
> * /sys/devices/system/node/nodeN/memory_tier (read/write)
> 
>   where N = 0, 1, ...
> 
>   Format: int or empty

This looks good to me.  Just wonder if having just 1 tier
lower than DRAM is sufficient. We could have wide performance
range for such secondary memories and is one tier sufficient for them?

Tim

