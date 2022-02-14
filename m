Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FC4B3E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiBNA16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiBNA15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:27:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE16C13EB0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644798470; x=1676334470;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kcElbae+RGFK/QaqPxibrAKD4Hv4dczBgQ4u6tcccQU=;
  b=dykdR9aNnrZP/+cYPFlkmnzksagKrhO94QxEA5be5n80Nim1+blP9i9f
   ubJIDSVfa+JwTf7uMvagnVtGcdGi43UwIDiXH12G5PN3bS+JM/jNCjNlv
   7rIEM/NmMXpO3h8FSXX+/LBkMGMxYCmjjQ2EbQluCn4HGKafSqiwTMq7X
   EVRYL3MEPAcZIiGGwfXRNrF7anYhL2sEOC8gG9Q2JrdekJPHGekan5UE/
   EREykuaVmmGjNTUzCYN1ckGZrNNcy0Rg0Hy+9SDFEzyvTCSljL+rBkUTx
   syJeuEwMyso/qnYkMY+XdO3VpYIZ/y1dAXt3c7pJqvKuSexbXiGj0J4N1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336411066"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="336411066"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 16:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680101107"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 16:27:48 -0800
Message-ID: <574b5298-005e-a083-284b-9b6b52c600f5@linux.intel.com>
Date:   Mon, 14 Feb 2022 08:26:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220211130144.GM4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220211130144.GM4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2/11/22 9:01 PM, Jason Gunthorpe wrote:
> On Mon, Feb 07, 2022 at 02:41:32PM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
>> fat and a bit messy. This series tries to cleanup and refactor the
>> driver to make it more concise. Your comments are very appreciated.
> 
> I wanted to take a closer look at what you are trying to do with rcu,
> but these patches don't apply. Please always sent patches against a
> well known tree like v5.17-rc or the iommu tree, or something.
> 
> Anyhow, I think you should split the last 4 patches out of this series
> and send them seperately.

Sure! I will resend this series soon.

Best regards,
baolu
