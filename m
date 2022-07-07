Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9E569E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiGGJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGGJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:18:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFB2CDDC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657185489; x=1688721489;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BUxVY3iStR4ugijNmMBdAZwPF0rqfSTjbUNrFsBmpe8=;
  b=NGZe7soYXdoc3fIHeqST4FbwT1MLlJFxyou/7vK9IIt0KTSxR336nu4F
   4ajg9PEA+gRzDCNVj+pQ+dcA1I8Xrii1ZT2nQnGB6Xgqiq2/KB/v6Y1Bz
   voXWB3IZ/DWDNAnts14BFYEKPNCqrqk8Wu5JqxuRDH/BKisGb8+fV+VEq
   3k1y68D0BIA4WMaZEbjTw9VgLwsVMaGVOL3Je8lI3bctJuNXSHYcrHIcA
   bToDaq8xIz9x7UJPOpmf53ZX5fxAxsZx7OsZb9YmAlaAYQqC3xju9Ka8Y
   ocbIlNKQGLsNtyfI7707LgNTr9UxGPD/3okq/sxjfDzvjvTeVaM/u855s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263761475"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="263761475"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:18:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="651058747"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:18:06 -0700
Message-ID: <93f60759-ab1c-7506-161f-2cd07e184dda@linux.intel.com>
Date:   Thu, 7 Jul 2022 17:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Content-Language: en-US
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
 <20220706025524.2904370-2-baolu.lu@linux.intel.com>
 <849557ab-9c1b-a2ff-6fc6-6564f38d1187@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <849557ab-9c1b-a2ff-6fc6-6564f38d1187@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 16:30, Ethan Zhao wrote:
>> -static int show_device_domain_translation(struct device *dev, void *data)
>> +static int __show_device_domain_translation(struct device *dev, void *data)
>>   {
>> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> -	struct dmar_domain *domain = info->domain;
>> +	struct dmar_domain *domain;
>>   	struct seq_file *m = data;
>>   	u64 path[6] = { 0 };
>>   
>> +	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
>>   	if (!domain)
>>   		return 0;
>>   
>> @@ -359,20 +359,39 @@ static int show_device_domain_translation(struct device *dev, void *data)
>>   	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>>   	seq_putc(m, '\n');
>>   
>> -	return 0;
>> +	/* Don't iterate */
>> +	return 1;
>>   }
> 
> Using this return value trick to change the caller behaviour, seems not 
> saving
> 
> anything, but really cost me a few seconds more to know the 
> *incantation* --
> 
> 'Don't iterate' :) .

This is defined by iommu_group_for_each_dev(). Return value 0 means
continuing to next one, while non-zero means stopping iteration.

Best regards,
baolu
