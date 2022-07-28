Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC98C58446B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiG1Qxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiG1Qxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:53:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4942371BDC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659027216; x=1690563216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=daeOdoRNV6EtJvAH4DKhhNq1uuHrMofKvOUMeqjcUYo=;
  b=g2QGw4Vg8ZrNf050vyCM4docI5eypRhzoDDcaaUPkLJzMLiFJPNbR0oS
   qNX4mk36jWbOx7QNQceYmyGWCXd5KoKuWt1W/sdfROmBXjJCJQsII8+1Z
   plLNhyUPAXagPwQuPKYAVAyDI4BgKDH7fNvVk4Lkqf5aDBDw7k02uplQE
   uMygtEBqAOHjgzDAY739tlDyinIapcrde0lRbadt0Ts3pl86hkLTPM1OY
   tWhjPJ9ml0lwtUNZ0fovsZHuOpnKCbUJ2zW8hgScZCj6J26CSCHCdNAH+
   luyQbsfiUcsvAO/MOI7BMeZetn74jlpjRL2eI/JVdsMXuprvdGkxAGEVq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268945131"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="268945131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 09:53:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="633773817"
Received: from tesmoryn-mobl.amr.corp.intel.com (HELO [10.212.62.40]) ([10.212.62.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 09:53:34 -0700
Message-ID: <7686403c-7252-ef7a-70fc-040c5ab8cb79@linux.intel.com>
Date:   Thu, 28 Jul 2022 11:53:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com> <YuJAll2MEgKF0MVM@kroah.com>
 <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
 <YuKyTKHk3c7DibX3@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YuKyTKHk3c7DibX3@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 10:59, Greg KH wrote:
> On Thu, Jul 28, 2022 at 10:37:37AM -0500, Pierre-Louis Bossart wrote:
>> Thanks for the review Greg,
>>
>>>> +static int intel_sysid_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct intel_sysid *sysid;
>>>> +	struct resource	*regs;
>>>> +
>>>> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
>>>> +		GFP_KERNEL);
>>>> +	if (!sysid)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	if (!regs)
>>>> +		return -ENXIO;
>>>> +
>>>> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
>>>> +	if (IS_ERR(sysid->regs))
>>>> +		return PTR_ERR(sysid->regs);
>>>> +
>>>> +	platform_set_drvdata(pdev, sysid);
>>>> +
>>>> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
>>>
>>> You just raced with userspace and lost.  Please use the default group
>>> for the platform device.
>>>
>>> I need to go remove this function, it should not be used at all as it is
>>> broken.
>>
>> Can you elaborate on the issue and suggested replacement?
>>
>> We used this function for the SoundWire sysfs based on your review
>> comments (2 years ago?) that we should not muck with kobj, and that
>> function devm_device_add_group() is also used in a probe function.
> 
> Use the default_groups pointer in the driver structure.

did you mean dev_groups?

I am not following the idea, for SoundWire all the attributes are really
device-specific or described by ACPI and cannot be hard-coded in the
driver structure.
