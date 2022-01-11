Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D148AAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbiAKJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:56:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:49725 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348285AbiAKJ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641894989; x=1673430989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NhMqLNqYtGbtpdo/7urAitfJ25RKbDgQ5dy+XBCizG8=;
  b=BndJVY7Q33OjQ/k4stUNAHTDkvlolhRcLE5VN0vTeSj7cQikcq35W1ZX
   Lesg3Bjqc2ZgUNB/EW84VxvujXJ4PHGeIT/kfzVqB4dXAnml9HukaAx2v
   GIjt6VcHkh//JO3E8E/WH+R9DujeMhQP7KG7MIZfjUK9XLkkHsRh3RN8D
   Xp0qot64OMLWqaioBQ6WtvOquSD7XaeOZHG5bjWS82YLgLKEx3ZTBdEq5
   /o/qL/8S748ojn/8tZBscsRfXpxtpdJTxigYIvPVbBRNForJjbUHDvOcE
   kheZcr5hXVXxoxCWzlvuMLCLUkdJyoXl2i+bNwvT7I32bo8ARR3odhgcy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223430839"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="223430839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 01:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="690942382"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2022 01:56:27 -0800
Message-ID: <53c81521-8cbd-7e7f-df38-ce6c09c77fae@linux.intel.com>
Date:   Tue, 11 Jan 2022 11:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <YdWOkn2Gtd7FSYmR@shinobu> <20220106151355.d4ogjpo3y5qnkrgs@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20220106151355.d4ogjpo3y5qnkrgs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/6/22 17:13, Uwe Kleine-König wrote:
> On Wed, Jan 05, 2022 at 09:26:58PM +0900, William Breathitt Gray wrote:
>> On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-König wrote:
>>>   - I think intel-qep.c makes the counter unfunctional in
>>>     intel_qep_remove before the counter is unregistered.
>>
>> Hello Uwe,
>>
>> Would you elaborate some more on this? I think intel_qep_remove() is
>> only called after the counter is unregistered because the struct
>> counter_device parent is set to &pci->dev in intel_qep_probe(). Am I
>> misunderstanding the removal path?
> 
> If the counter device is unbound (e.g. via sysfs), the following calls
> are made:
> 
> 	intel_qep_remove() (stopping the hardware?)
> 	devm_counter_release (devm callback of devm_counter_register or ..._add)
> 	then the release callbacks of the earlier devm functions
> 
> My concern is, that in the timeslot between intel_qep_remove() and
> devm_counter_release() the device looks like a functional device and
> might be queried/reconfigured/... while the hardware is already dead.
> 
> It's probably not a big issue (unless for example reading the counter
> this race window makes the hardware hang?), but it's at least ugly.
> Maybe the worst effect is that a counter value is missed (which is OK at
> unregister time). Still it would be nicer to first take down the counter
> device and only then stop the hardware.
> 
In HW point of view it should be safe. We do disable the HW in 
intel_qep_remove() but that doesn't render the HW unusable and registers 
are accessible.

Perhaps that line can go since I think it was put there just to stop the 
HW just in case after remove.

Jarkko
