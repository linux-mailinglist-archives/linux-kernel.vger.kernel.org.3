Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA965AA47A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiIBAdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiIBAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:33:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2E9E12E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662078787; x=1693614787;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=8qubwDEk7bK1thYQZ5HsOms2XEz5Np/BfJ6RKgPJUN8=;
  b=ZgLUBkRu1uvx4bqUBCTX0S92gZY3litj8W1IkU8Kc3InhewUanapHeKI
   JbuzDzganO6F1NOGheaKHA1RhVlwivAzhBmahETDLA5QUiuISEoAXZ3Gf
   olP127YkntHsWBj9gX7mvrivdJAEVZZEj1TdxLMLSZ6GbFjlOGRtUgaek
   HQU+yDn9J21Wd/6UE+aRHc+583WPXL2cBbT7LJBD+NmKWhCZsvnvtYZMK
   7kQx7Y+t8y3jazgBXaiKn6pLQvxYDWX7UOli53QLCVMu+S5jcafgExLPH
   SvoJyPUwm40mP+V1Bfwm0FcSuAsuPvMsh3ony4KLXkTN9gwG2wy1A8kH+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278878607"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="278878607"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:33:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563716721"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:33:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
        <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
Date:   Fri, 02 Sep 2022 08:29:54 +0800
In-Reply-To: <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 1 Sep 2022 13:54:27 +0530")
Message-ID: <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 9/1/22 12:31 PM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>=20
>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory t=
ier
>>> related details can be found. All allocated memory tiers will be listed
>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>
>>> The nodes which are part of a specific memory tier can be listed via
>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>=20
>> I think "memory_tier" is a better subsystem/bus name than
>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>> "memory_tier" sounds more natural.  I know this is subjective, just my
>> preference.
>>=20
>>>
>>> A directory hierarchy looks like
>>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>>> memory_tier4/
>>> =E2=94=9C=E2=94=80=E2=94=80 nodes
>>> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tiering
>>> =E2=94=94=E2=94=80=E2=94=80 uevent
>>>
>>> All toptier nodes are listed via
>>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>>
>>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>>> 0,2
>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>>> 0,2
>>=20
>> I don't think that it is a good idea to show toptier information in user
>> space interface.  Because it is just a in kernel implementation
>> details.  Now, we only promote pages from !toptier to toptier.  But
>> there may be multiple memory tiers in toptier and !toptier, we may
>> change the implementation in the future.  For example, we may promote
>> pages from DRAM to HBM in the future.
>>=20
>
>
> In the case you describe above and others, we will always have a list of
> NUMA nodes from which memory promotion is not done.
> /sys/devices/virtual/memory_tiering/toptier_nodes shows that list.

I don't think we will need that interface if we don't restrict promotion
in the future.  For example, he can just check the memory tier with
smallest number.

TBH, I don't know why do we need that interface.  What is it for?  We
don't want to expose unnecessary information to restrict our in kernel
implementation in the future.

So, please remove that interface at least before we discussing it
thoroughly.

>> Do we need a way to show the default memory tier in sysfs?  That is, the
>> memory tier that the DRAM nodes belong to.
>>=20
>
> I will hold adding that until we have support for modifying memory tier d=
etails from
> userspace. That is when userspace would want to know about the default me=
mory tier.=20
>
> For now, the user interface is a simpler hierarchy of memory tiers, it's =
associated
> nodes and the list of nodes from which promotion is not done.

OK.

Best Regards,
Huang, Ying
