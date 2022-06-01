Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B4539D51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbiFAGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349858AbiFAGjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:39:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB76941AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654065559; x=1685601559;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NTe1lvhDhuLR2ENfcohwPccU6QLRUxsLG1PgvvGRWbs=;
  b=IwmCQ5Q5vQteVwbEnQ55J3fbAwsk7iu0oMcwiEIE8uM5i1V9pjLo0Zec
   9kZ8t0hSxIybPYzA7+2Q5wZhWYNI52mqA1ypPQ39hYq7J9WTwsDwAXAnC
   fQaivHW2E3cmKFvIeSgYCkhAtk+e66FJv6c3H54xATzEXczrOLmt/23GA
   UmAOn2y3PjnsC6I7jcdv8MqfJSNnFrKO3dWKsdAT4GNxSK6MAAS0P5Hd6
   +IgKo5xZpAulPzmqjl13Jt75KmwOF4Nv5PbUiRjFygrQ2ObBbp8EjrgTj
   nfXAns01wSTnsAGhKWAyak4/hWNmnS+IAmWO+0zKy5wVUn79IMfMg89RV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361863234"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361863234"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 23:39:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="706925259"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 23:39:16 -0700
Message-ID: <dafc1451-d3f9-150a-2d95-12bc4616f3bc@linux.intel.com>
Date:   Wed, 1 Jun 2022 14:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220531185110.GJ1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 02:51, Jason Gunthorpe wrote:
>> Oh, I've spent the last couple of weeks hacking up horrible things
>> manipulating entries in init_mm, and never realised that that was actually
>> the special case. Oh well, live and learn.
> The init_mm is sort of different, it doesn't have zap in quite the
> same way, for example. I was talking about the typical process mm.
> 
> Anyhow, the right solution is to use RCU as I described before, Baolu
> do you want to try?

Yes, of course.

Your discussion with Robin gave me a lot of inspiration. Very
appreciated! I want to use a separate patch to solve this debugfs
problem, because it has exceeded the original intention of this series.

Best regards,
baolu
