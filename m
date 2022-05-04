Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D281519815
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbiEDH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiEDH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:29:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30701EEEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649154; x=1683185154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zOXvk5xSpwk+RNWool8HSke68015qO3LDNaYLqS9tb4=;
  b=URo7svdIy6ztjwm2O9FUKl4eKELVbWmDE2cFhR3jxwL+a6E2BAH1orug
   bwIxWdhqAT/mTeNu8H19ljEc1t/Qenj7N4uFHypiCWVxdLVmaN+OwDbA/
   ZEFZQPtYjr/jiilafa4E4vQ5bmn9f7N1EVd4688gaJZ4RI7Us4yn3rBbl
   AMwx35p0q0+mFiyjQOOXVN3gx6dtY7EiGidnlv1LfFbqN0SIm7t1rjMnp
   Wqc/FjAFAS/uxJfwIGH5cJx0yQNBEEdUbamHMPGDTmJjfExr6jqJug8hA
   YYFtP6/O90fV7OzJAvUasCcYk42TVcxQAstYkRr8a4p6nEY8IBUV8Z8Mc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354125995"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="354125995"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:25:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734278002"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223]) ([10.255.30.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:25:52 -0700
Message-ID: <74172660-e9e9-6589-7755-50bcd8b0aca6@linux.intel.com>
Date:   Wed, 4 May 2022 15:25:50 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502130546.GI8364@nvidia.com>
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

Hi Jason,

On 2022/5/2 21:05, Jason Gunthorpe wrote:
> On Sun, May 01, 2022 at 07:24:31PM +0800, Lu Baolu wrote:
>> The SNP bit is only valid for second-level PTEs. Setting this bit in the
>> first-level PTEs has no functional impact because the Intel IOMMU always
>> ignores the same bit in first-level PTEs. Anyway, let's check the page
>> table type before setting SNP bit in PTEs to make the code more readable.
> Shouldn't this be tested before setting force_snooping and not during
> every map?

The check is in the following patch. This just makes sure that SNP is
only set in second-level page table entries.

Best regards,
baolu

