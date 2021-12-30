Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1831481B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhL3K0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:26:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:58130 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhL3K0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640860004; x=1672396004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GokUgCNQWYAa+qiBp8nH5H5kQA99Yiif4FghNsU1Gmk=;
  b=labrCX3h4QCk0Q32DXG4Cs6aV8xOp/38GfKnoDXURKRrqp6kc+G+olDu
   qILfvA4KfnyzHsdeRDuhTebiGut94u0GX6M20kTrWpw7vAxazgAwWPwRY
   HD9SP/U9lkUc1JQP247o+wMYWeCihfUq/FMS/qlEucDI/5Fh4PU0/IY/X
   RRoP8vy01qlMZqvLKdbjRRIYQl3ZKWQ5GLJZzcKwXfcz9pf2n3PDuyTSC
   sgWWBzBu2kmedTWia9wmhvr6rBjfzSQ7M0idXZHeU6sRSWENrFZFBvfn/
   6u0rXPp70aqw4NJ/mojsp4flB/UsH/n8yNjRot4Kv70R6Vbw466XJSeUh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222324353"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="222324353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 02:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="468775390"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by orsmga003.jf.intel.com with ESMTP; 30 Dec 2021 02:26:41 -0800
Message-ID: <87af88b5-048d-8671-53b7-30dfcba3f19f@linux.intel.com>
Date:   Thu, 30 Dec 2021 12:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 17/23] counter: intel-qep: Convert to new counter
 registration
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-18-u.kleine-koenig@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211229154441.38045-18-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 17:44, Uwe Kleine-König wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Following test will cause an oops usually after a few iterations before 
this patch:

while :; do { sleep 5; echo bang; } > /dev/counter0 & sleep 1; echo 
0000:00:18.4 >/sys/bus/pci/drivers/intel-qep/unbind; sleep 8; echo 
0000:00:18.4 >/sys/bus/pci/drivers/intel-qep/bind; done
