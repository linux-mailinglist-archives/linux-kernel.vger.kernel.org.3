Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28B4CA6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiCBN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiCBNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:55:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3317C7910;
        Wed,  2 Mar 2022 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646229272; x=1677765272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6w+YhZ6FWmjUK1vt1o9WKL6bVSK9GReGozO3B7eqIdY=;
  b=LkM58tmfREPpIEgWl5Sl0YrfbFadtL4+b3w1SUREyUaTpoSzQFFWt2B7
   5F+B4apxq66a7aGCzJ3rA482ynmskq0Z85pxs5qmVT2ua1M6DeGX+G8Ye
   nSj2lvt6aMjVM+k3e3O45dvRqMJxO9TeWC0xHMz8QepEqTrHurj9Y6+Dr
   XwYLGiJZzZps1qDsyp+XkUm8brmCbM5XxfLRcOJCUG+RKVlpsae3HR6f3
   V3zYKSGK1ae4Dq5tFiR0KCbUCvVdS/ACW5ubZKiE91tOLhNMqyXqjX2DC
   cB3GCs8Euhc5dQA7ib06C7mz/YdCU8w+s1hE31vf/XHKY3rT4XivGoEAv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253134223"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253134223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:54:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="709513228"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:54:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPPQE-00AJbb-1M;
        Wed, 02 Mar 2022 15:53:42 +0200
Date:   Wed, 2 Mar 2022 15:53:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Message-ID: <Yh925VvqejDe2SR8@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:09:06PM +0100, Daniel Lezcano wrote:
> On 22/02/2022 10:56, shruthi.sanil@intel.com wrote:

> > +		/* Clear interrupt for periodic timer*/
> 
> nit: comment format is:
> 
> /*
>  * my comment
>  */
> 
> One line comment format is usually for the network subsystem

Huh?
Any pointers to the documentation, please?

> > +		keembay_timer_clear_pending_int(tim_base);
> > +	} else {
> > +		/* Disable the timer for one shot timer */
> 
> comment format
> 
> > +		keembay_timer_disable(tim_base);
> > +	}

-- 
With Best Regards,
Andy Shevchenko


