Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA251C27B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380124AbiEEO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349409AbiEEO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:27:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FD5AA6C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651760648; x=1683296648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OhcxbBgmutkoElcmxsM0ZTVXHgDmWx9IZ8gbNt7Pzfc=;
  b=iZbB9vH8NBsBAxWg2OPciFQ9NgTXmYsueGhHp04hDLXIhbo9avqMauXA
   7JZuw1oACTBINvKb0F6U1aorTXyKKSij1o+RoZH93J6J9qffzfsz0xG2t
   Ex7z99Uj5SgjNUyZo3i6ydbzRUoFQhYznrgahRksNrjtyosXTmQCGBgHB
   v4g9NdPLiFEbITUTKErGQYjvGoOgaJPrj3T17A1IrKgWlPn6w7u6Ge/ay
   xCzeAXRkrj6GOl/F2+ukMnCHS9850N1s9Z0A2NYxpU0t2XrHSiSD4SMZP
   DbfawA+5Dfnfx07i1CY3eWYnwlb4z38RrWhYGSVtTWEAntJIlrEkRGCvM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268271785"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268271785"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:24:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="537354032"
Received: from evegaag-mobl1.amr.corp.intel.com (HELO [10.209.187.127]) ([10.209.187.127])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:24:06 -0700
Message-ID: <ecb2ab76-8b48-13a6-559a-21f73fcf6cea@intel.com>
Date:   Thu, 5 May 2022 07:24:26 -0700
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
 <52541497-c097-5a51-4718-feed13660255@intel.com>
 <CAAPL-u_G8dzXCjx=xcnemgXGQxwnVUFEy_NJzHsJOHapUm-9Ew@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAPL-u_G8dzXCjx=xcnemgXGQxwnVUFEy_NJzHsJOHapUm-9Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 23:35, Wei Xu wrote:
> On Wed, May 4, 2022 at 10:02 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> That means a lot of page table and EPT walks to map those linear
>> addresses back to physical.  That adds to the inefficiency.
> 
> That's true if the tracking is purely based on physical pages.  For
> hot page tracking from PEBS, we can consider tracking in
> virtual/linear addresses.  We don't need to maintain the history for
> all linear page addresses nor for an indefinite amount of time.  After
> all, we just need to identify pages accessed frequently recently and
> promote them.

Except that you don't want to promote on *every* access.  That might
lead to too much churn.

You're also assuming that all accesses to a physical page are via a
single linear address, which ignores shared memory mapped at different
linear addresses.  Our (maybe wrong) assumption has been that shared
memory is important enough to manage that it can't be ignored.

>> In the end, you get big PEBS buffers with lots of irrelevant data that
>> needs significant post-processing to make sense of it.
> 
> I am curious about what are "lots of irrelevant data" if PEBS data is
> filtered on data sources (e.g. DRAM vs PMEM) by hardware.  If we need
> to have different policies for the pages from the same data source,
> then I agree that the software has to do a lot of filtering work.

Perhaps "irrelevant" was a bad term to use.  I meant that you can't just
take the PEBS data and act directly on it.  It has to be post-processed
and you will see things in there like lots of adjacent accesses to a
page.  Those additional accesses can be interesting but at some point
you have all the weight you need to promote the page and the _rest_ are
irrelevant.

>> The folks at Intel that tried this really struggled to take this mess and turn it into a successful hot-page tracking.
>>
>> Maybe someone else will find a better way to do it, but we tried and
>> gave up.
> 
> It might be challenging to use PEBS as the only and universal hot page
> tracking hardware mechanism. For example, there are challenges to use
> PEBS to sample KVM guest accesses from the host.

Yep, agreed.  This aspect of the hardware is very painful at the moment.

> On the other hand, PEBS with hardware-based data source filtering can
> be a useful mechanism to improve hot page tracking in conjunction
> with other techniques.

Rather than "can", I'd say: "might".  Backing up to what I said originally:

> So, in practice, these events (PEBS) weren't very useful
> for driving memory tiering.

By "driving" I really meant solely driving.  Like, can PEBS be used as
the one and only mechanism?  We couldn't make it work.  But, the
hardware _is_ sitting there mostly unused.  It might be great to augment
what is there, and nobody should be discouraged from looking at it again.
