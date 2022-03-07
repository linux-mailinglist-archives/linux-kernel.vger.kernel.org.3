Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9E4D005D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiCGNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiCGNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:46:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0C8BF77;
        Mon,  7 Mar 2022 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660754; x=1678196754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MDK7Kzd2L9dS7JgpYPIzEINPjykQ1ZJDbm/MnVbfElQ=;
  b=BGhG0qpfbhHSGVDZxeA601rsPGH/z7jtiFfLT85l1UmOUZ/8MxA9eSye
   4PAqVaFYrBKh4bpd+FwWZW6JYEBJPH8Iqiend9IvhIQi9ZA3OrKfniQVX
   6sQt5jHKTv5l6HGvbi+pknt/znKHIV7hDV2u9QzCkgXP0pPVAqGI99P1h
   1OjLgygHhEgCytdjEOYvcXzv/v87grAaWUyHn8IbNQb/OdeWGWpSuAQp6
   fDL71TpAT+NgenIiHMMOgkuV5BZs0t85PQXODeBb4+UdZk9Bopc4RLuvc
   Quwo46hZrpKnYZhweDXj6DWrtx/XRkJ9x2b8T5wh8zSWnvJ4ZsoX78DZW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="253220956"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="253220956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:45:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643249501"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:45:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRDff-00CnJB-7O;
        Mon, 07 Mar 2022 15:45:07 +0200
Date:   Mon, 7 Mar 2022 15:45:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     shruthi.sanil@intel.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v9 2/2] clocksource: Add Intel Keem Bay timer support
Message-ID: <YiYMYuENpb1VJV9G@smile.fi.intel.com>
References: <20220307113147.19496-1-shruthi.sanil@intel.com>
 <20220307113147.19496-3-shruthi.sanil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307113147.19496-3-shruthi.sanil@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:01:47PM +0530, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> The Intel Keem Bay timer driver supports clocksource and clockevent
> features for the timer IP used in Intel Keem Bay SoC.
> The timer block supports 1 free running counter and 8 timers.
> The free running counter can be used as a clocksource and
> the timers can be used as clockevent. Each timer is capable of
> generating individual interrupt.
> Both the features are enabled through the timer general config register.

...

> +		pr_err("%pOF: FW_BUG: Prescaler is not enabled\n", np);

FW_BUG is a macro. The above is an incorrect use of it.

...

> +		pr_err("%pOF: FW_BUG: free running counter is not enabled\n", np);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


