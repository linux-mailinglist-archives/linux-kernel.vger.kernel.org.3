Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31994534DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiEZLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiEZLVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:21:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD52C52
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653564102; x=1685100102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3UfK5LmPaRzbKe05FjBGuRV4gJXJ0211VX0BroG/Lc=;
  b=Cw0wDGaSwbPvGdSFMs4XRcNKJRRetdnDHufnAXZgM7MRBhSS9pR+j+Pk
   GsyVgxYT5nHkjyVqdOOPmPHsBegRxuKOwJMi1iqEi0OU9Cax71kOCrGmn
   NEg12h3ReHAXQFam3ExA2fYYSz5tIKXwSNXjD0yN/24b/7fawYqc18XY+
   5Fo1vzySZO4nV01sk9pjW8fUib30QNQ5JtBbD4jlDYapkWzpGr3RFgU8/
   fPd4bX9NqkNw3Nj7VbMcoZs9GV172ji2wYidtZIxFJCSzXc/qxEyUDz1C
   VGeZ7Kt68uoxB1PO70DizOjyTsz7CIHCdegTv2O1ZwQvKZ3fY0gT0K8ih
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="337170454"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="337170454"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 04:21:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="704484668"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 04:21:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nuBYd-000Lfw-TH;
        Thu, 26 May 2022 14:21:35 +0300
Date:   Thu, 26 May 2022 14:21:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gareth Powell <gpowell@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in
 brcmstb_pm_probe
Message-ID: <Yo9ivyinKV4alJu8@smile.fi.intel.com>
References: <20220526075325.27356-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526075325.27356-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:53:22AM +0400, Miaoqian Lin wrote:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> In brcmstb_init_sram, it pass dn to of_address_to_resource(),
> of_address_to_resource() will call of_find_device_by_node() to take
> reference, so we should release the reference returned by
> of_find_matching_node().

Looks legit,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> index 3cbb165d6e30..70ad0f3dce28 100644
> --- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> +++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> @@ -783,6 +783,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = brcmstb_init_sram(dn);
> +	of_node_put(dn);
>  	if (ret) {
>  		pr_err("error setting up SRAM for PM\n");
>  		return ret;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


