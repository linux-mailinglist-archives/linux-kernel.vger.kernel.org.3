Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509C748AF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiAKOQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:16:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:45852 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241371AbiAKOQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641910582; x=1673446582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CtkRIdIcSFtO4roDqVbqnO0SVGudoxuXWeAfwaPV4dQ=;
  b=m1IbHCJ8020CdF8tQLDjqHXNJ2FpjhqlJOvTCbA1r0QHy1pXUlxvIGw6
   qAZMAQBqMImBaxAR3odD/oycIEMr9nMEhc68/rkTpq0pVRtda1rqdrVds
   iAyq7fDyXkyRyZcHxir0nSeljX6WeKjQsXF8pwwG4wKH+T+ZJi5nIdLw7
   MS3lbbPhyC9palTisoVTKsmom0LfgULm+MCgyWaI+8aLAXhrcTJFQqYrU
   XHXp/845GXTLNUDJXlPy/eLF0VSNeaEh8Kz9zRyXeD5EM6bY7YfFqOWrg
   o3UoEMTqaPZf8iejh7R2yimec0RuKIhzgDmHEWOZql1RYTtlBCry9b3ih
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306843209"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306843209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:16:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613228878"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:16:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7HvV-009FzU-7q;
        Tue, 11 Jan 2022 16:15:05 +0200
Date:   Tue, 11 Jan 2022 16:15:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111140216.1858823-1-qiulaibin@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:02:16PM +0800, Laibin Qiu wrote:
> In case of shared tags, there might be more than one hctx which
> allocates from the same tags, and each hctx is limited to allocate at
> most:
>         hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> tag idle detection is lazy, and may be delayed for 30sec, so there
> could be just one real active hctx(queue) but all others are actually
> idle and still accounted as active because of the lazy idle detection.
> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
> forever on this real active hctx.
> 
> Fix this by recalculating wake_batch when inc or dec active_queues.

...

>  {
> +	unsigned int users;

Missed blank line here.

>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
>  
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {

Whoever wrote this code did too much defensive programming, because the first
conditional doesn't make much sense here. Am I right?

> +			return true;
> +		}
>  	} else {

> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {

Ditto.

> +			return true;
> +		}
>  	}

...

> +	unsigned int wake_batch = clamp_t(unsigned int,
> +			(sbq->sb.depth + users - 1) / users, 4U, SBQ_WAKE_BATCH);


	unsigned int wake_batch;

	wake_batch = clamp_val((sbq->sb.depth + users - 1) / users, 4, SBQ_WAKE_BATCH);
	...

is easier to read, no?

-- 
With Best Regards,
Andy Shevchenko


