Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633458432E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiG1Phm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiG1Phk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:37:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ADA56B81
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659022660; x=1690558660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uMQQhSgBy0QjPsC+CGQ9eOoRHsp9u4FCCDd+xJaVmTc=;
  b=fjP9B3OSKzYUYQXf8Z/46Lqp4kRf0PH27H8LAiZwioODMyDGCFd7x8fI
   9mJKcIquokjWllu2M4hAprTBFICxhKP3keRVVm/jJDKzJRr1pPKaVaG/9
   G051h1Fq1JuToEFIhGtKYQJ7b9GPaUsWwwuz4T34mR0ElbBC5p5eTcDlZ
   4IPtsPjUZMltI/JjOxvJAeIVvI/BKdugRe960WQtVh+uf7yTtcBaK1RAz
   S6wtuY53poua6EVG4Le7RUFE07pLlipGB57HMChKgqZXEVwHpZ7c0TLAy
   /69u0DVOqM83axq8h+B+N4Fdxyz3OnV/yo8iZkkfddPIiyrgmwQIvizdP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286091942"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="286091942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:37:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="633741699"
Received: from tesmoryn-mobl.amr.corp.intel.com (HELO [10.212.62.40]) ([10.212.62.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:37:38 -0700
Message-ID: <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
Date:   Thu, 28 Jul 2022 10:37:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com> <YuJAll2MEgKF0MVM@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuJAll2MEgKF0MVM@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Greg,

>> +static int intel_sysid_probe(struct platform_device *pdev)
>> +{
>> +	struct intel_sysid *sysid;
>> +	struct resource	*regs;
>> +
>> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
>> +		GFP_KERNEL);
>> +	if (!sysid)
>> +		return -ENOMEM;
>> +
>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!regs)
>> +		return -ENXIO;
>> +
>> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
>> +	if (IS_ERR(sysid->regs))
>> +		return PTR_ERR(sysid->regs);
>> +
>> +	platform_set_drvdata(pdev, sysid);
>> +
>> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
> 
> You just raced with userspace and lost.  Please use the default group
> for the platform device.
> 
> I need to go remove this function, it should not be used at all as it is
> broken.

Can you elaborate on the issue and suggested replacement?

We used this function for the SoundWire sysfs based on your review
comments (2 years ago?) that we should not muck with kobj, and that
function devm_device_add_group() is also used in a probe function.

Thanks!
-Pierre
