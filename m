Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81D659E816
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbiHWQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbiHWQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:55:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA2B901B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264271; x=1692800271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8P0sI5mhh0Ee7pTQqRA4uL9lxSH5/G4KiX1TxtW73P8=;
  b=P4+IGXNou2bbISYXEB/Jk5iMha5yIM3JVxHniSnyd0eE7fmoZaQLxn4L
   qBKrU8AT/HfVLqQlXMziJ3cMYmiDuqSBHNQsu30FWJ5FbF2X6h9QRtgDi
   dArGz9QXgGsUBJg8KHC2QQIOy5hsoRo29ixleMBntd8FdMEmpw5NdaeTq
   ezrXbwrsOE7PzzbiFos4Eb3tVXo203Pmul7UU2NOxcbtjwEqURaTdFURN
   HH2TXB7otcZ5fKUUojVwu3Mh5+Y8o5XueAyqIILJeB0Xok26Mnc/7ghv3
   D9o96fmieQyg3JIHQVfN0WANrPj1dqnZopHKcLbVCU+j0MEAbEA7CHJiV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294486643"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294486643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:17:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="605671257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:17:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUiw-002TH7-36;
        Tue, 23 Aug 2022 17:17:46 +0300
Date:   Tue, 23 Aug 2022 17:17:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 12/30] mfd: intel_soc_pmic: Remove #ifdef guards for
 PM related functions
Message-ID: <YwThilQmxx/sUiLX@smile.fi.intel.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
 <20220808174107.38676-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808174107.38676-13-paul@crapouillou.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 07:40:49PM +0200, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But it needs to be rebased.

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> Cc: Andy Shevchenko <andy@kernel.org>
> 
>  drivers/mfd/intel_soc_pmic_core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
> index 5e8c94e008ed..96303aa87bc1 100644
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ b/drivers/mfd/intel_soc_pmic_core.c
> @@ -104,7 +104,6 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
>  	return;
>  }
>  
> -#if defined(CONFIG_PM_SLEEP)
>  static int intel_soc_pmic_suspend(struct device *dev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> @@ -122,10 +121,9 @@ static int intel_soc_pmic_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
> -			 intel_soc_pmic_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
> +				intel_soc_pmic_resume);
>  
>  static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
>  	{ }
> @@ -143,7 +141,7 @@ MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
>  static struct i2c_driver intel_soc_pmic_i2c_driver = {
>  	.driver = {
>  		.name = "intel_soc_pmic_i2c",
> -		.pm = &intel_soc_pmic_pm_ops,
> +		.pm = pm_sleep_ptr(&intel_soc_pmic_pm_ops),
>  		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
>  	},
>  	.probe = intel_soc_pmic_i2c_probe,
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


