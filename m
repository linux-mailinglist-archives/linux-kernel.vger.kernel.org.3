Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625C4E282C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiCUNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348168AbiCUNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:53:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EF15DA95;
        Mon, 21 Mar 2022 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647870735; x=1679406735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z8aewv7UAAbDhfYqkIWekrC7Fv3E1m/ILqiu4BxD2mM=;
  b=X/yFZ4JuN01BOFdj57J+6Gq7QykOjAv/nMwxH+afJboNC51tLCt+yFIV
   QVzFb5Kaa3d8LPLrC4aROJXoHFkBd5tIRO4QtOSIw3zTJq9E1RZIPEmUG
   Ve9gobHMICjgpDucRROS9CJWAa8RfWM2gG+igU2S1LLDVgZz33H2KqxFt
   4EsyFThY2uQBFfB8CfusuPvxgbZA+xQvsbkgEnaHc4OkPDwTvrllwuJBt
   rqLS8grE6eRLjkbTgM3QAM+NfdZHqQbtiL0rSbQG0i52n21g2LZupqZEs
   5FH8c/I3D4KxELaoXWRbSFPWrACWUFJ/q1zDms5LGc+EjdpaV4JoG9H5S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257504962"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257504962"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 06:52:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="543232520"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 06:52:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nWIRd-003vDy-0Y;
        Mon, 21 Mar 2022 15:51:37 +0200
Date:   Mon, 21 Mar 2022 15:51:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
References: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
 <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:50:19AM +0100, Wolfram Sang wrote:
> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.

...

> +	for (i = 0; i < priv->trig_len; i+= 2) {

Missed space.

> +		do {
> +			ret = gpio_la_get_array(priv->descs, &state);
> +			if (ret)
> +				goto out;
> +
> +			ndelay(delay);
> +		} while ((state & priv->trig_data[i]) != priv->trig_data[i + 1]);
> +	}

...

> +static int fops_buf_size_set(void *data, u64 val)
> +{
> +	struct gpio_la_poll_priv *priv = data;

> +	int ret = 0;

Instead of this assignment and other related things, can we do the following?

> +	void *p;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +
> +	vfree(priv->blob.data);

	priv->blob.data = NULL;
	priv->blob.size = 0;

> +	p = vzalloc(val);
> +	if (!p) {
> +		val = 0;
> +		ret = -ENOMEM;
> +	}

	p = vzalloc(val);
	if (!p)
		return -ENOMEM;

> +	priv->blob.data = p;
> +	priv->blob.size = val;
> +
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_buf_size, fops_buf_size_get, fops_buf_size_set, "%llu\n");

> +	priv->trig_data = buf;
> +	priv->trig_len = count;
> +
> +	return count;
> +}
> +
> +static const struct file_operations fops_trigger = {
> +	.owner = THIS_MODULE,
> +	.open = trigger_open,
> +	.write = trigger_write,
> +	.llseek = no_llseek,
> +	.release = single_release,
> +};

Can it be wrapped by DEFINE_SHOW_ATTRIBUTE()?

...

> +	dev_info(dev, "initialized");

Not sure how this one would be helpful.

-- 
With Best Regards,
Andy Shevchenko


