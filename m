Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1654DA06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358794AbiFPFvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFPFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:51:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6B5B8A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655358710; x=1686894710;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6CPFqI+DZfksboiu6czsCYW6mduq7vXgJ23i+ORFdY=;
  b=dqTYz7J+nbSJlXpp1aQcoNMlzTD3ZyWGgM+RE/DHOZxlyS2y1KnnbJXD
   6uhPaOm0uGIZK2cbuW1Cjz0GifZlb4NYP53eL9K8fohVCP0MGhLvZ7s/Z
   aU0UqRJEsxETmpVnDhkHdscCdX7ROKEpZQjFEqBXeOE6k97axJw19ENYP
   D6+1rs6x1gQhU9C5qFK+edqzbbZj1chv9nfOKxEgH5ffMtl2gBtKer4hu
   XGwYZ98BS4IxqLOQg+ZS2RaUhKV3GoR2XuWvnw2YKV705hJIaOoBIoT2K
   EYYbwO2NJVEjVudSF7vsdhWbxL+X9QUzwqD99N2C7CO4Bjy+K0Ewfg/I7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340827669"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="340827669"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:51:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="641377454"
Received: from junyizh1-mobl.ccr.corp.intel.com ([10.254.214.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:51:45 -0700
Message-ID: <04c89154526444781f025043de890bba55282781.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Thu, 16 Jun 2022 13:51:42 +0800
In-Reply-To: <cbfe5abe-155b-ac79-2daa-06d9dd60b55a@linux.ibm.com>
References: <YqDncfLeEeBaosrY@cmpxchg.org>
         <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
         <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
         <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
         <YqdEEhJFr3SlfvSJ@cmpxchg.org>
         <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
         <Yqdc4DE8gYJ3zesO@cmpxchg.org>
         <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
         <YqjZyP11O0yCMmiO@cmpxchg.org>
         <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
         <CAAPL-u9hjR8sFeUYM46TXPg-Lho6hr0zaLvrGhg9=htRrPtjqw@mail.gmail.com>
         <cbfe5abe-155b-ac79-2daa-06d9dd60b55a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 10:17 +0530, Aneesh Kumar K V wrote:
> On 6/16/22 9:15 AM, Wei Xu wrote:
> > On Wed, Jun 15, 2022 at 6:11 PM Ying Huang <ying.huang@intel.com> wrote:
> > > 
> > > On Tue, 2022-06-14 at 14:56 -0400, Johannes Weiner wrote:
> > > > On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:
> 
> ....
> 
> > > As Jonathan Cameron pointed, we may need the memory tier ID to be
> > > stable if possible.  I know this isn't a easy task.  At least we can
> > > make the default memory tier (CPU local DRAM) ID stable (for example
> > > make it always 128)?  That provides an anchor for users to understand.
> > 
> > One of the motivations of introducing "rank" is to allow memory tier
> > ID to be stable, at least for the well-defined tiers such as the
> > default memory tier.  The default memory tier can be moved around in
> > the tier hierarchy by adjusting its rank position relative to other
> > tiers, but its device ID can remain the same, e.g. always 1.
> > 
> 
> With /sys/devices/system/memtier/default_tier userspace will be able query
> the default tier details.
> 

Yes.  This is a way to address the memory tier ID stability issue too. 
Anther choice is to make default_tier a symbolic link.


Best Regards,
Huang, Ying

