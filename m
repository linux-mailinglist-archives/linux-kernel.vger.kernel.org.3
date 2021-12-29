Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77F4813A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhL2Nte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:49:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:5537 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhL2Ntd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640785773; x=1672321773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=anZN01Crx5ZF6OUj2MH0zGoUy0Or8FI4/GF+5LBVEBc=;
  b=ElGIgVGeRtL+SGmKcM+6KpUFRCFia7CEk2j+idiZz4wPwFyh+N9vQf0p
   pwgqywSEfEDI3KIv9q8v8n+XbbcKS8sPIuskCAJeTuI23mfVpCThYqtwq
   +oRdHHKsvYIYYVdzRPY4V7MGVGrlo6QIR6mXNtaU4C0gTCzo0BRqXXI+M
   89hDccxL2euPcq7VPYJhpUrnMyciqySJxsVR9nT80XHMgznuAje2fJVCr
   jlS+SzXbdYH3/TPxQWpsJ+wVGsUzv41SZEfO0lzSlUgjKXYxlbUZNNVmf
   Avk6rzPFSjh3zhb67tYjsvlWqTAZag6ueKrul3Zch1sr8OA1QGIsRFM1b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="221516560"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="221516560"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="524821653"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2021 05:49:30 -0800
Message-ID: <1d3c1df9-42b8-e451-f622-32d8c1e6d1b5@linux.intel.com>
Date:   Wed, 29 Dec 2021 15:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
 <20211228180017.37c2703d@jic23-huawei>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211228180017.37c2703d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 20:00, Jonathan Cameron wrote:
> On Mon, 27 Dec 2021 10:45:16 +0100
> Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:
>> +	if (err < 0)
>> +		goto err_chrdev_add;
>> +
>> +	device_initialize(dev);
>> +	/* Configure device structure for Counter */
>> +	dev->type = &counter_device_type;
>> +	dev->bus = &counter_bus_type;
>> +	dev->devt = MKDEV(MAJOR(counter_devt), id);
> 
> As 0-day pointed out id not initialized.
> 
This was the reason why second counter instance initialization failed 
for me when testing the patch 17. I fixed it locally by changing the 
line a few rows above the MKDEV():

-	dev->id = err;
+	dev->id = id = err;
