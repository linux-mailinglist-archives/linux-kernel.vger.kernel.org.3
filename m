Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A65A8F14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIAHC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiIAHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:02:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A8124864
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662015709; x=1693551709;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=V5eFPntE7kEE/MubUOdAVDILHNkJ4zNIH5bzumuL+3k=;
  b=UVBgClmIGJ8XlmlPXOZsEWkSP8h7R+UhfHcHtDbmeyQhDrDo22EAb1qp
   PjefgHSnw/xKMN8wSmvDETORsD4ES8jadqkOfxMJJCvtO2pauBfkq/MZE
   IVmTmVBQ6y5OPru9EWviVUu13s5jkAwAUiq8kL8hCS1X39ngEKA2B8D1h
   WP7rzzl9ORBPCq4W/5Uv86zKUoHp+KTQAsW2elBbwW0DXykMisFhz3CvC
   3A01NwZcyepP3DyhVZ/LvUIreZE8rRZR7ljCZWZgSX8r2pQfDpJS+nbz9
   3x7w0gG/LAksPqkx0227yy9g/4TSahH4PvTEH3JsUPbcuyt2ZJxBQWvbz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296418944"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296418944"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:01:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="642205433"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:01:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Yang Shi <shy828301@gmail.com>,
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
Date:   Thu, 01 Sep 2022 15:01:39 +0800
In-Reply-To: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 30 Aug 2022 13:47:36 +0530")
Message-ID: <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
> related details can be found. All allocated memory tiers will be listed
> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>
> The nodes which are part of a specific memory tier can be listed via
> /sys/devices/virtual/memory_tiering/memory_tierN/nodes

I think "memory_tier" is a better subsystem/bus name than
memory_tiering.  Because we have a set of memory_tierN devices inside.
"memory_tier" sounds more natural.  I know this is subjective, just my
preference.

>
> A directory hierarchy looks like
> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> memory_tier4/
> =E2=94=9C=E2=94=80=E2=94=80 nodes
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tiering
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> All toptier nodes are listed via
> /sys/devices/virtual/memory_tiering/toptier_nodes
>
> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
> 0,2
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> 0,2

I don't think that it is a good idea to show toptier information in user
space interface.  Because it is just a in kernel implementation
details.  Now, we only promote pages from !toptier to toptier.  But
there may be multiple memory tiers in toptier and !toptier, we may
change the implementation in the future.  For example, we may promote
pages from DRAM to HBM in the future.

Do we need a way to show the default memory tier in sysfs?  That is, the
memory tier that the DRAM nodes belong to.

Best Regards,
Huang, Ying

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>
> Changes from v2:
> * update macro to static inline
> * Fix build error with CONFIG_MIGRATION disabled
> * drop abstract_distance
> * update commit message
>
>

[snip]
