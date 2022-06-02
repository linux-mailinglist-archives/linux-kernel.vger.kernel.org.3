Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491C53B3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiFBGnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFBGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:43:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DFADF7A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654152226; x=1685688226;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KUS8mVgdTc5Hj0xMVFCoSGE47Yrh0WZN2tGJ3zjuvKw=;
  b=cdga+2IJg81u6D5Zx6HQhOTz3NYEY3s2/eobr7pmK9w9D3bY4xZp9dUp
   E0W+sKmSXR2ihkkqYYCO/VH2v6T2AB+4F16gLrtONv8CKKC02cCXbscOm
   JGotsms/nOlrFZ90z81s2WkyRrWppkEIvpYwDwWl1tsXROgKE1B0F8kO0
   dKAPuvq06yCiso9i7svownivtJSrdvcvEam91zvB1mOdTtomi/Ns4ly8P
   8ENwUhJOZXwmWQ+v267ZnAFAsUkRqCNhosfGpJ3SbaQvq3ouTqC+r+3TK
   Ibe2etcMLuDDWx7VKvhtUYatLsmyoByFYcRsngPihrqLYZ1fC5LwGFCvc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275570229"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275570229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:43:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="606683307"
Received: from yanqingl-mobl1.ccr.corp.intel.com ([10.254.212.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:43:41 -0700
Message-ID: <2316b2f571cd812b5c2e4335c2ed51a227005098.camel@intel.com>
Subject: Re: [RFC PATCH v4 6/7] mm/demotion: Add support for removing node
 from demotion memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
Date:   Thu, 02 Jun 2022 14:43:38 +0800
In-Reply-To: <20220527122528.129445-7-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-7-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> This patch adds the special string "none" as a supported memtier value
> that we can use to remove a specific node from being using as demotion target.
> 
> For ex:
> :/sys/devices/system/node/node1# cat memtier
> 1
> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> 1-3
> :/sys/devices/system/node/node1# echo none > memtier
> :/sys/devices/system/node/node1#
> :/sys/devices/system/node/node1# cat memtier
> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> 2-3
> :/sys/devices/system/node/node1#

Why do you need this?  Do you have some real users?

Best Regards,
Huang, Ying


[snip]


