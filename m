Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289E859160D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiHLTmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiHLTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:42:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA6B285C;
        Fri, 12 Aug 2022 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660333351; x=1691869351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UVh9wGe4sOwL5XUI0lWCSw73ZdAjh9fY5902G/5LxJ4=;
  b=b1m4teSDulRi26HrMogOC7ryV2mbr0bmqdJSetENJujF4g0+J9XJWQ7k
   yuhSHMrl3d86Chuc/rvlGm9xXAENb/8kIDSGBTFQnINmGcfHUWtkDcY7x
   bwF0S94vql9+tW14ZmhdfavSDKcGtSWEbeImxFxF23ry49Si/RRbOyNgQ
   GRaR8sBPdc4h6hKcmeA/gsZflTrv56YtnFm347r2Fj2ABZaMF9mJf5WYE
   f+1TQ+gmM0AKQaKJl5JKeIie5o/NKy72vTpMUt6fv3fL+eb3S/GGKmKRt
   SG7nU7hJiuU8ZOodYplw4gueqZFJbVIU45b3S0s3wRpcYKE3aBI8s3HOI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271447681"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="271447681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:42:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="556636122"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:42:28 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D3F5420371;
        Fri, 12 Aug 2022 22:42:26 +0300 (EEST)
Date:   Fri, 12 Aug 2022 19:42:26 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
Message-ID: <YvatIg1ywD5EkxTk@paasikivi.fi.intel.com>
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, Aug 12, 2022 at 02:06:45PM +0100, Stefan Binding wrote:
> The current code expects the type of the value to be an integer type,
> instead the value passed to the macro is a pointer.
> Ensure the size comparison uses the correct pointer type to choose the
> max value, instead of using the integer type.
> 
> Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/acpi/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 7b3ad8ed2f4e..b1d4a8db89df 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
>  				break;					\
>  			}						\
>  			if (__items[i].integer.value > _Generic(__val,	\
> -								u8: U8_MAX, \
> -								u16: U16_MAX, \
> -								u32: U32_MAX, \
> -								u64: U64_MAX, \
> +								u8 *: U8_MAX, \
> +								u16 *: U16_MAX, \
> +								u32 *: U32_MAX, \
> +								u64 *: U64_MAX, \
>  								default: 0U)) { \
>  				ret = -EOVERFLOW;			\
>  				break;					\

Thanks for the patch.

I prefer this fix over the other as it uses the pointer type (rather than
value at a given index). Both have the same effect though.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
