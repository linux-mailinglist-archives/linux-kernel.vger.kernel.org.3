Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA65519278
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiECX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiECX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:57:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2459E2D1C4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651622056; x=1683158056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K8SvhxQm1P62rJiCvMA6jYehYxpt5BXqhVT4BJHzqCc=;
  b=cfuj9TgIlHxV3jgOtttBOUu7YbI/vb1yqUlZ9eW2kP2eWnWnXC6ACGm/
   1sPyxRtp6GfVq/0N+AtWMKO00KAkdU40X6/z5Vwq2a8DVV7dP0iQZxlvM
   +AMn2xOYoVmxSiiy4XSs3GqWxnOnhYXveBqT67yWIeDuRTvJXiYuOEg39
   bq26vZxqwadK3KT7IONGV0pZAUqXoe3DXRVyqA28qNUXx9KEHbJ3CbhBc
   EmN1x+REKSb4gf5YO1UV+qC357iBBZc0P+VV5HzBdoAVw1SMNRctXSMrv
   nL4u/aZqONF/cP59RRIHHQnIw7mz8wkPg21PiUudsyYwSF20jcTaa1pQ2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248163425"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248163425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:54:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="664202274"
Received: from dbandax-mobl2.amr.corp.intel.com (HELO [10.209.188.251]) ([10.209.188.251])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:54:14 -0700
Message-ID: <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com>
Date:   Tue, 3 May 2022 16:54:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com>
 <87mtfygoxs.fsf@nvdebian.thelocal>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87mtfygoxs.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 15:35, Alistair Popple wrote:
> Not entirely true. The GPUs on POWER9 have performance counters capable of
> collecting this kind of information for memory accessed from the GPU. I will
> admit though that sadly most people probably don't have a P9 sitting under their
> desk :)

Well, x86 CPUs have performance monitoring hardware that can
theoretically collect physical access information too.  But, this
performance monitoring hardware wasn't designed for this specific use
case in mind.  So, in practice, these events (PEBS) weren't very useful
for driving memory tiering.

Are you saying that the GPUs on POWER9 have performance counters that
can drive memory tiering in practice?  I'd be curious if there's working
code to show how they get used.  Maybe the hardware is better than the
x86 PMU or the software consuming it is more clever than what we did.
But, I'd love to see it either way.
