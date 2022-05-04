Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0951ABCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376882AbiEDRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356364AbiEDRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:21:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFDA4EDE5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651683724; x=1683219724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CTg7Xyv27hMl+wBuAu9Sk2WDDBF7tqVYHYYBMKvmxj0=;
  b=lFAHEtRDiWcLrAPxJEEIg50D2RCU7/xit3h7h1WdMqxcUG3lLSHglH7X
   QV9FenAOdWsPDEU0pLuzcOHG93+e6S3RJ0OvDUqpW3SONpHzqRRh/0yWN
   QnliSs1p2yyUOrHz7tzmD2JzpT+Dner2S/ghLhOsiAd+n3dZffcgsUORB
   rjk5Y9qOqTz3C8vQuTX/p8j9jWl1d8zaIvTXCe8teYDf+w+NTcevm1PnN
   jUEgltbt7Ei0zzkFbH+NzFc1WicD3yysYe9vWbJE8eUww18vyd/a6lT8B
   MOgJIJuV2UrXTmEw5hpvWN52abJhM4ATxJPU++IBXN79dDBbfzwUcx8fg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267422323"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="267422323"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 10:02:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="562814255"
Received: from jrhamric-mobl.amr.corp.intel.com (HELO [10.212.121.177]) ([10.212.121.177])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 10:02:00 -0700
Message-ID: <52541497-c097-5a51-4718-feed13660255@intel.com>
Date:   Wed, 4 May 2022 10:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
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
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com>
 <87mtfygoxs.fsf@nvdebian.thelocal>
 <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com>
 <CAAPL-u9UkG1WMQm5u1eAe+4-d04aqVAXc9H0gLSegYoHctkCnw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAPL-u9UkG1WMQm5u1eAe+4-d04aqVAXc9H0gLSegYoHctkCnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 18:31, Wei Xu wrote:
>> Well, x86 CPUs have performance monitoring hardware that can
>> theoretically collect physical access information too.  But, this
>> performance monitoring hardware wasn't designed for this specific use
>> case in mind.  So, in practice, these events (PEBS) weren't very useful
>> for driving memory tiering.
> The PEBS events without any filtering might not be useful for memory
> tiering, but the PEBS events with hardware-based data source filtering
> can be useful in driving promotions in memory tiering. Certainly,
> because these events are not designed for this specific use case in
> mind, there are inefficiencies using them for memory tiering, e.g.
> instead of just getting a heat counter for each hot page, we can get
> events repeatedly on the hot pages.

Also, I believe the addresses that come out of the PEBS events are
virtual addresses (Data Linear Addresses according to the SDM).  If the
events are written from a KVM guest, you get guest linear addresses.

That means a lot of page table and EPT walks to map those linear
addresses back to physical.  That adds to the inefficiency.

In the end, you get big PEBS buffers with lots of irrelevant data that
needs significant post-processing to make sense of it.  The folks at
Intel that tried this really struggled to take this mess and turn it
into a successful hot-page tracking.

Maybe someone else will find a better way to do it, but we tried and
gave up.
