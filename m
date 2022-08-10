Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B958E45D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiHJBJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiHJBJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:09:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDE7FE65
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660093757; x=1691629757;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=y16BOvHxV1nZ3NiVQoMe+MGNwetNYFK6shxb0qVq6cM=;
  b=d1ApnK5IS2+3DyFsYfh6vyAv7rYOID6GFP/SGbhY0aAVx8KwQ0++URMT
   vI2dFcwkPtdDpmsaXYCDE93ZGvWAtbu4P/LlwNFyYV4IN99ey/0Q6QANV
   pivEhIf0XcDobqotyNe6oNQkTYTCfQj/swOToua58BAydsHt+0c/kjBl0
   e8KYsRlzXXNaIlvj8l6+dgX0ZgUz6ehBU4Odjme5wfrzkv1OUzzGLEmct
   qiaBlW0keknhKtSvOfT6eN4+uxGoQa7uesBH1ImTM6w/D1E3aYacKRydr
   4WBjNrNFzmxCBuKsgELuGBxzd4pC39wkT4KOdtWufA7edbLvkP3u0uW1d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="270743874"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="270743874"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:09:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="781058671"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:09:10 -0700
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v13 4/9] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
        <20220808062601.836025-5-aneesh.kumar@linux.ibm.com>
        <87o7wuglrq.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <46c8d7c2-004f-1945-8614-2452d4f28d2a@linux.ibm.com>
Date:   Wed, 10 Aug 2022 09:09:07 +0800
In-Reply-To: <46c8d7c2-004f-1945-8614-2452d4f28d2a@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 9 Aug 2022 11:03:22 +0530")
Message-ID: <87o7wsgb0s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 8/9/22 8:34 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> By default, all nodes are assigned to the default memory tier which
>>> is the memory tier designated for nodes with DRAM
>>>
>>> Set dax kmem device node's tier to slower memory tier by assigning
>>> abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE. Low-level drivers
>>> like papr_scm or ACPI NFIT can initialize memory device type to a
>>> more accurate value based on device tree details or HMAT.
>> 
>> I don't know how ACPI NFIT can help here.  Can you teach me?
>> 
>> Per my understanding, we may use the information provided by ACPI SLIT
>> or HMAT (or device tree via papr_scm) to create memory types.  Before
>> that is implemented, we just create a memory type with default abstract
>> distance.
>> 
>
> My idea is to use ACPI NFIT driver that creates a persistent memory region
> (nvdimm_region_create) to also create memory type and assign that to the
> NUMA node mapping that region. For now NFIT driver manages all the persistent
> memory region/DIMM creation (drivers/acpi/nfit/core.c). It can also do the
> memory type creation using other ACPI information like SLIT/HMAT etc. Similarly
> CXL driver can do the same using CDAT.

I still think that it's better to create memory types in dax/kmem.c and
CXL driver.  But we can discuss further on that later.

Best Regards,
Huang, Ying
