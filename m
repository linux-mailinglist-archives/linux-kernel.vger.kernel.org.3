Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A25A1FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiHZEb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHZEb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:31:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A17CAC97
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661488284; x=1693024284;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xh7fXVrVZZ8TR/92mtZODU9ZNKLc8hVgtACRH5wtXEc=;
  b=FFTzJoMOcSsB4NVBgcxZKc1+5YjFS/+DCgcdLto/QbfavtbrQC8aD8G2
   VozpDKlFyrR0jILnjvesbHSNFUpTd1wnBV32mLtSt6AezGnpiJwOXIYsy
   g39zt3XqNiIMqhreOuaC4q32cKhpiM4O3JTAxQDLhzdMfT0PplqyBl0/H
   BBnSeHdTmawpIM5UaFw0AP60YbmmBx75LVqhmQ05qJvFVx5pam7P/Ugxt
   zInslkfMzyj6AfKTtNgxrRQpYBPhLidI3Yhf+hW6im7O9tVMl8wMh9o5a
   MHJM24Jb01d8Vn81Rz6nAjscNw+KEtnVf+FywrN0nt6l813gS3PyJU8ME
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320513851"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="320513851"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:31:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="699717298"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 21:31:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [RFC PATCH 2/2] mm/demotion: Expose memory tier details via sysfs
In-Reply-To: <20220825092325.381517-2-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 25 Aug 2022 14:53:25 +0530")
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
        <20220825092325.381517-2-aneesh.kumar@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 26 Aug 2022 12:31:10 +0800
Message-ID: <871qt339td.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> All allocated memory tiers will be listed as
> /sys/devices/virtual/memtier/memtierN/
>
> Each memtier directory contains symbolic link for the memory types
> that are part of the memory tier. A directory hierarchy looks like
>
> :/sys/devices/virtual/memtier# tree memtier512/
> memtier512/

So you suggest to use abstract_distance_start as memory tier ID?  That
will make memory tier ID stable unless we change abstract distance chunk
size or abstract distance division points.  That is, we have at least 2
choices here

1. memory_tier0, memory_tier1, memory_tier2, ...

The ID will start from 0.  This is easy to understand by users.  The
main drawback is that the memory tier ID may be changed when a NUMA node
is onlined/offlined.  That is, the memory tier ID is relatively
unstable.

2. memory_tier<abstract_distance_start1>, memory_tier<abstract_distance_sta=
rt2>, ...

The ID will be discontinuous. So it's not as intuitive as 0,1,2,....
The main advantage is that the memory tier ID will not change when a
NUMA node is onlined/offlined.  The ID will be changed only when we
change abstract distance chunk size or abstract distance division
points.  That is considered relatively seldom.

Personally, I prefer the 2nd choice too.  But I want to collect opinions
from other people too.

> =E2=94=9C=E2=94=80=E2=94=80 memtype1 -> ../memtype1
> =E2=94=9C=E2=94=80=E2=94=80 memtype2 -> ../memtype2

I think abstract_distance_start and abstract_distance_end is the key
information of a memory tier too.  So we should show them here.

> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memtier
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> The nodes which are part of a specific memory type can be listed via
> /sys/devices/system/memtier/memtypeN/nodes.
>
> The adistance value of a specific memory type can be listed via
> /sys/devices/system/memtier/memtypeN/adistance.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Best Regards,
Huang, Ying

[snip]
