Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF645A1E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbiHZBuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHZBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:50:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4596E896
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661478651; x=1693014651;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=A+vo5oKdJvtFxj1nipyEpEz7lA9nkfXY7dHnH/JK1uc=;
  b=l5x/wlNXzRZBMMQjtTF5CFaIgK/Eo7zGYf+uMO6LJ7dGzlhW0IGOlcNI
   rMpatYa3AEeefOjRh2zMAaRs57ax7vOSonmp4THTmKwQ2Lwvguy3a0uOP
   cY5ZhgzVMlrTSZECd4TSGiDbE8W9LKzmiyDTQK0HgeLh+msYdXjIsOcPJ
   seGl9xoZ4h715EL8KAo3CXLf+MMqT2qWcGkWfu+2FFD2NnDqgsbuPnoEh
   gFn+oQ64nsR/GCcWC8wTVDqidLjaV+blwk9/a+mhOYoX2LY1xevw4vXCy
   9hBW06pY7bAbPybmIZOLA9xcJmTy75s2mlbWr/dWCeFfpxVP73XYtnIJa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293140433"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="293140433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 18:50:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="643487574"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 18:50:46 -0700
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
Subject: Re: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
Date:   Fri, 26 Aug 2022 09:50:43 +0800
In-Reply-To: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 25 Aug 2022 14:53:24 +0530")
Message-ID: <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch adds /sys/devices/virtual/memtier/ where all memory tier relat=
ed
> details can be found. All allocated memory types will be listed there as
> /sys/devices/virtual/memtier/memtypeN/

Another choice is to make memory types and memory tiers system devices.
That is,

/sys/devices/system/memory_type/memory_typeN
/sys/devices/system/memory_tier/memory_tierN

That looks more natural to me.  Because we already have "node" and
"memory" devices there.  Why don't you put memory types and memory tiers
there?

And, I think we shouldn't put "memory_type" in the "memory_tier"
directory.  "memory_type" isn't a part of "memory_tier".

> The nodes which are part of a specific memory type can be listed via
> /sys/devices/system/memtier/memtypeN/nodes.

How about create links to /sys/devices/system/node/nodeN in
"memory_type".  But I'm OK to have "nodes" file too.

> The adistance value of a specific memory type can be listed via
> /sys/devices/system/memtier/memtypeN/adistance.
>
> A directory listing looks like:
> :/sys/devices/virtual/memtier# tree memtype1
> memtype1
> =E2=94=9C=E2=94=80=E2=94=80 adistance

Why not just use "abstract_distance"?  This is user space interface,
it's better to be intuitive.

> =E2=94=9C=E2=94=80=E2=94=80 nodes
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memtier
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> Since we will be using struct device to expose details via sysfs, drop st=
ruct
> kref and use struct device for refcounting the memtype.
>

Best Regards,
Huang, Ying
