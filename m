Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D604DE936
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiCSQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiCSQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:12:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBF3D1F0;
        Sat, 19 Mar 2022 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647706250; x=1679242250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jT2K8DJWA+z2Zz3dGYKXYccoMAG+5tTycAaznfXpHQA=;
  b=Vuo4BX2e+bqRWw8DJNA81ot5CibUPZSiUTYjiH0JDdSwRmw37xKXtAHM
   Ko/GQyBylP2XLSc/7wcfS10kUxhdzc0zkXYmu4JtuzpGn6oK1IpBvwGsF
   8l9XsotLdZ2RO/49CgXa/NboMd/IeA1THOLw6JLu6jpruy+RlQqggtzeb
   Y1Ulkmo49LuPjr2FKHj3FinBuc7jLVXr7MWMhcB4YjwIrwHn4ZV253eip
   da7Y8ieWG9GFr1G+uaMxAd7h1bH1d0L7cR0TDcK2iWl30ubjE4ha1WwSN
   fchURRw0a5ym6jt2p3/sM4V8dvyhnflSe0rhAsBgXjfq1U9J2yAg4AzFn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="239469487"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="239469487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:10:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="715921144"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:10:47 -0700
Date:   Sat, 19 Mar 2022 16:10:38 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        marco.chiappero@intel.com, fiona.trahe@intel.com,
        wojciech.ziemba@intel.com, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat: Fix unsigned comparison with less than zero
Message-ID: <YjYAfqkhjeDD+glJ@silpixa00400314>
References: <1647569459-18376-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647569459-18376-1-git-send-email-baihaowen@meizu.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:10:59AM +0800, Haowen Bai wrote:
> drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c:67:5-8: WARNING: Unsigned expression compared with zero: ret < 0
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
> index 6d10edc..0143835 100644
> --- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
> +++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
> @@ -52,7 +52,7 @@ static const char *const dev_cfg_services[] = {
>  static int get_service_enabled(struct adf_accel_dev *accel_dev)
>  {
>  	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
> -	u32 ret;
> +	s32 ret;
>  
>  	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
>  				      ADF_SERVICES_ENABLED, services);
A fix for this is already in the cryptodev tree:
    844318dfd31f ("crypto: qat - fix a signedness bug in get_service_enabled()")

Thanks,

-- 
Giovanni
