Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F5A8E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiIAGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIAGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:45:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C865642
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662014714; x=1693550714;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=hNxVVK32D6iCwH0/rf/rQNVbgNj+5447bH9KuDWgOqE=;
  b=jJwqmZH8UQwA6XK+S7wqp50UCzk79ffgbYNzCyfkCVmX96TIIOawolB/
   Pl3uq2fpF2iGXSefZPuGUv7PXfVShCjhi++3Pa/mpZDj1WOfMIWwFUXYV
   XvCXv4JOK0MRQ3RZY2gqyXKG8xFTTAY25WJUJyZBFgmy+IhqXYTAKw3Hi
   z2ZcJq8emh8awNdkrSSzEREDDVtbqNNtBxbKz6Ev+IeXzdM8Gk0srTbPF
   WM/3/Manz3954bA+EZEdASdjBYZ7wVk96IVa2Yd9EVnMM8vDacgBbtjoJ
   Z3FjSH6Pv1P5x6tzf4Y7LrqM4Yf69RQOKBp4IcPhoRXzgBp97AogoPh/J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357348973"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="357348973"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:45:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="615226088"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:45:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH mm-unstable] mm/demotion: Assign correct memory type for
 multiple dax devices with the same node affinity
References: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
        <87a67j1uyk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <c484fb58-6bc2-1103-a95d-1587232f56ba@linux.ibm.com>
Date:   Thu, 01 Sep 2022 14:45:02 +0800
In-Reply-To: <c484fb58-6bc2-1103-a95d-1587232f56ba@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 1 Sep 2022 11:54:42 +0530")
Message-ID: <87y1v3zj81.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 9/1/22 11:45 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> With multiple dax devices having the same node affinity, the kernel wrongly assigned
>>> default_dram memory type to some devices after the memory hotplug operation. Fix this by
>>> not clearing node_memory_types on the dax device remove.
>> 
>> Sorry for late reply.
>> 
>> Just for confirmation.  There are multiple dax devices in one NUMA node?
>> 
>> If you can show the bug reproducing steps, that will make it even easier
>> to understand.
>> 
>
> NUMA nodes are assigned per region and you can have multiple devdax namespace with same NUMA node affinity. 

I think that the patch description will be clearer if we added the above
line into it.

> dax0.1 and dax0.2 are examples. To recreate you can follow the below steps
>
>
> root@ubuntu-guest:/sys/devices/system/node/node3# ls
> compact  cpumap    meminfo   memory34  memory36  memory38  memory41  memory43  memory45  memory47  memory50  memory52  memory54  numastat   uevent
> cpulist  distance  memory33  memory35  memory37  memory39  memory42  memory44  memory46  memory49  memory51  memory53  memory55  subsystem  vmstat
> root@ubuntu-guest:/sys/devices/system/node/node3#
> root@ubuntu-guest:/sys/devices/system/node/node3# for mem in memory*; do echo 0 > $mem/online; done
> root@ubuntu-guest:/sys/devices/system/node/node3# cd /sys/bus/dax/drivers
> root@ubuntu-guest:/sys/bus/dax/drivers# echo dax0.0  > kmem/unbind
> root@ubuntu-guest:/sys/bus/dax/drivers# cd /sys/devices/system/node/node3/
> root@ubuntu-guest:/sys/devices/system/node/node3# ls
> compact  cpumap    meminfo   memory42  memory44  memory46  memory49  memory51  memory53  memory55  subsystem  vmstat
> cpulist  distance  memory41  memory43  memory45  memory47  memory50  memory52  memory54  numastat  uevent
> root@ubuntu-guest:/sys/devices/system/node/node3# for mem in memory*; do echo 1 > $mem/online; done

Thanks a lot for detailed information.

Best Regards,
Huang, Ying
