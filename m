Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30AD47FE09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhL0PCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:02:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:29166 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhL0PCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640617363; x=1672153363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lDkW70GEnpDAm2umrI8X4/Ruqk46bn+YeHPfFWti618=;
  b=ikiVylVSfdw2JSl2mks3FwF7fwHcCwNWmREFvPE0exwl3kMg78J4ULFf
   qZFD6C7H8kM/pSrvawCibKLQmW5vfW8szlhkVmSemA5QtI6PkQ90vylJr
   bXv2U4K+ff/soNNzUa1fEGRuZCEQhgH2JCYXuifq3OKqqCdqjaA5xSZti
   3OatqaG+woQfqGBil4s0lxX9JNdW0TECSFDXdS3VfzJMdde4aY5Sko8I4
   f1Rgh5GxobMVYRPugJLYBR+0eELx0A1X7TFoaetDG76h6BCtReTK375b/
   ww3DMSx3eV2s25QPVTcr0M4ES+kuz18ZSX7uhRqbeaXw0/WZMhOz3HGhj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="301975686"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="301975686"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 07:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="686307218"
Received: from mylly.fi.intel.com (HELO [10.237.72.175]) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 07:02:40 -0800
Message-ID: <162c710f-4fa2-1cb4-e332-83e33e510e42@linux.intel.com>
Date:   Mon, 27 Dec 2021 17:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2 17/23] counter: intel-qep: Convert to new counter
 registration
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:45, Uwe Kleine-König wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
Should the Fixes tag rather be b6c50affda59 ("counter: Add character 
device interface") instead of when each drivers were introduced? I mean 
was it possible to hit the issue before /dev/counter was introduced?

Jarkko
