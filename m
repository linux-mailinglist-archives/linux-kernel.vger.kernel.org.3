Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D074812C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbhL2Mm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:42:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:14448 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234936AbhL2Mm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640781746; x=1672317746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jui3xLb6WZ2KwqvoVRVXy986ZVVExc+O3v3w2B1ICes=;
  b=kxQMxGCFEitnILfqFRdsEhv9id0wRRbIe6PTeOIHjVZrkmAAhFTc6D2/
   4xiMMWBI0e8ENPSXn6SdsyOP8mwCW+VisD6PjP8nwbQrPZci0PpOjpC6o
   lnNHr40g9ljlddUd/CsJzeedUw62VYW1rzt/ORAfsNYvRzVOQ3YNrGddG
   x5vM+Oq9kdjk8bxIQtyYhq5l4DkX3Nn09kOFAAxlDLg907CXPJXUV0dEL
   6k5rzMj7BeXG8+sdddwL/QlIkjNCdE1kRyn4eqKuGTacJRib3rFJ7q3+v
   L+7reOXG6HHFM6v2kQzIonDpEsziB999KmIkoFl/bRIgvdZiaypTJDcHE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304873298"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304873298"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 04:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="524810746"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2021 04:42:23 -0800
Message-ID: <9276faa0-33dd-5d95-41f0-be8f3903d57d@linux.intel.com>
Date:   Wed, 29 Dec 2021 14:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2 17/23] counter: intel-qep: Convert to new counter
 registration
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raymond Tan <raymond.tan@intel.com>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
 <162c710f-4fa2-1cb4-e332-83e33e510e42@linux.intel.com>
 <20211228105621.3mfrvwlkj4n5qhar@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211228105621.3mfrvwlkj4n5qhar@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 12:56, Uwe Kleine-König wrote:
> On Mon, Dec 27, 2021 at 05:02:39PM +0200, Jarkko Nikula wrote:
>> On 12/27/21 11:45, Uwe Kleine-König wrote:
>>> This fixes device lifetime issues where it was possible to free a live
>>> struct device.
>>>
>>> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>    drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
>>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>>
>> Should the Fixes tag rather be b6c50affda59 ("counter: Add character device
>> interface") instead of when each drivers were introduced? I mean was it
>> possible to hit the issue before /dev/counter was introduced?
> 
> I'm not sure if there is an issue before this, but it was already wrong
> before for sure. Maybe it's possible to hold a reference somehow via
> sysfs?
> 
> The thought that made me tag the individual driver commits was: With the
> approach used to fix the issue all drivers need to be modified and an
> unconverted driver doesn't benefit from the availability of
> counter_alloc() / counter_add() if it isn't used. So all trees that
> include b711f687a1c1 but not "counter: intel-qep: Convert to new counter
> registration" are broken (more or less exploitable). So I think the
> added Fixes line is the right choice.
> 
Fair enough. Noticed only now after this patch (with patches 1, 4, 8 and 
13 applied) second counter instance initialization fails:

[    8.113999] sysfs: cannot create duplicate filename '/dev/char/244:0
[    8.139604] Call Trace:
[    8.139606]  <TASK>
[    8.139608]  show_stack+0x3d/0x3f
[    8.139615]  dump_stack_lvl+0x5b/0x82
[    8.139619]  dump_stack+0x10/0x12
[    8.139621]  sysfs_warn_dup.cold+0x17/0x27
[    8.139624]  sysfs_do_create_link_sd+0xc2/0xd0
[    8.139629]  sysfs_create_link+0x1c/0x30
[    8.139631]  device_add+0x54f/0x7c0
[    8.139635]  ? cdev_default_release+0x20/0x20
[    8.139638]  cdev_device_add+0x47/0x90
[    8.139642]  devm_counter_add+0x61/0xe0 [counter]
[    8.139647]  intel_qep_probe+0x16f/0x1b0
...
[    8.325081] intel-qep 0000:00:18.6: error -EEXIST: Failed to add counter
[    8.371793] intel-qep: probe of 0000:00:18.6 failed with error -17

Positive result is that following test doesn't produce an oops after a 
few iterations like before this patch.

while :; do { sleep 5; echo bang; } > /dev/counter0 & sleep 1; echo 
0000:00:18.4 >/sys/bus/pci/drivers/intel-qep/unbind; sleep 8; echo 
0000:00:18.4 >/sys/bus/pci/drivers/intel-qep/bind; done
