Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06DE51A25B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbiEDOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351374AbiEDOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:40:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371AE1FA62
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651675033; x=1683211033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x8yNkRPcszEI2c/X3ll8pl0xnbd8y7LswHd7vWavS3A=;
  b=c5bwNua+pD7fmSX0Ryxmrpfh9IuIszybeUIq2svcSNc9JDqn9iotPR9J
   w/LlCgv2jfKVwjQBhxMhCCPWlh+/kpMMZOBRSJ2+Exg29VKRDyUsm77mn
   e1qfiN9UfKoNyr0MeJpBRJGgguAvpLYlTuLPvK0ZaFmW2txXNPZOqUP6j
   r0BqWhjrjEUIjKsdJABKGHVMUwQcJXdCSo7P7zIdz0MQ1Hb76a7xTcPyl
   O/OZRwvaZoJH/uhJau5TzEplBfPgFEGFvT2bRtDUG3T82P+ik/X3rq5Wo
   pFjYoy8+py1VENLMK28Cz+4Ch7ZEMdmSF3F5/+3TAmjLe6v5deqlAnRmI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354218779"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="354218779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 07:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="734423264"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 07:37:08 -0700
Message-ID: <16365887-3034-c4b8-da91-eee6a9f976b2@linux.intel.com>
Date:   Wed, 4 May 2022 22:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu/vt-d: Set SNP bit only in second-level page
 table entries
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-3-baolu.lu@linux.intel.com>
 <20220502130546.GI8364@nvidia.com>
 <74172660-e9e9-6589-7755-50bcd8b0aca6@linux.intel.com>
 <20220504133142.GE49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220504133142.GE49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 21:31, Jason Gunthorpe wrote:
> On Wed, May 04, 2022 at 03:25:50PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/2 21:05, Jason Gunthorpe wrote:
>>> On Sun, May 01, 2022 at 07:24:31PM +0800, Lu Baolu wrote:
>>>> The SNP bit is only valid for second-level PTEs. Setting this bit in the
>>>> first-level PTEs has no functional impact because the Intel IOMMU always
>>>> ignores the same bit in first-level PTEs. Anyway, let's check the page
>>>> table type before setting SNP bit in PTEs to make the code more readable.
>>> Shouldn't this be tested before setting force_snooping and not during
>>> every map?
>>
>> The check is in the following patch. This just makes sure that SNP is
>> only set in second-level page table entries.
> 
> I think you should add a 2nd flag to indicate 'set SNP bit in PTEs'
> and take care of computing that flag in the enforce_no_snoop function

Yours looks better. Will add it in the next version.

> Jason

Best regards,
baolu

