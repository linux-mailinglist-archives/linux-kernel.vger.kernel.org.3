Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0716524662
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbiELHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiELHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:03:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B457B12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652339025; x=1683875025;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2BoPkenWCDtGr5uisyAJ+mBH2Rf2kRq/FNVqeUodPQc=;
  b=ZpgMFcEVxMlVjm1Ez1YSVa3LQaLy/3RbjD0u6zcOr5aQNwmvIgjEp1qj
   uz9sr2RKdKnsT5dJVeuUUUfNUREeQHRX86dQMbVHfGZpZTD7amyMrVaj4
   87hfy4Qe2y2czrjP2Ga8DOiWWeHUFRwWTry843//VqAAKo15RZEHUCzD+
   doW4U3RfudPZgqUYRhN8HW2ILHZRJyvY72Pc4AKIzVrdF3VxdVWZl78Se
   B1drLnpozpniYCXABYtw1C5ILqAtUasi/ssbDXQfecA5AoxXtmPB0pYIJ
   Sk7+YeAQPANuVbesy8TwGNaHIyeXOjXZmca6Aa+J1ret2hOedJ2oLOHMV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267500389"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="267500389"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:03:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="697915194"
Received: from ruonanwa-mobl.ccr.corp.intel.com ([10.254.212.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:03:39 -0700
Message-ID: <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
Date:   Thu, 12 May 2022 15:03:36 +0800
In-Reply-To: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> Sysfs Interfaces
> ================
> 
> * /sys/devices/system/memtier/memtierN/nodelist
> 
>   where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> 
>   Format: node_list
> 
>   Read-only.  When read, list the memory nodes in the specified tier.
> 
>   Tier 0 is the highest tier, while tier 2 is the lowest tier.
> 
>   The absolute value of a tier id number has no specific meaning.
>   What matters is the relative order of the tier id numbers.
> 
>   When a memory tier has no nodes, the kernel can hide its memtier
>   sysfs files.
> 
> * /sys/devices/system/node/nodeN/memtier
> 
>   where N = 0, 1, ...
> 
>   Format: int or empty
> 
>   When read, list the memory tier that the node belongs to.  Its value
>   is empty for a CPU-only NUMA node.
> 
>   When written, the kernel moves the node into the specified memory
>   tier if the move is allowed.  The tier assignment of all other nodes
>   are not affected.
> 
>   Initially, we can make this interface read-only.

It seems that "/sys/devices/system/node/nodeN/memtier" has all
information we needed.  Do we really need
"/sys/devices/system/memtier/memtierN/nodelist"?

That can be gotten via a simple shell command line,

$ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'

Best Regards,
Huang, Ying

