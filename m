Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50F4CB807
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiCCHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:44:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B015C9ED;
        Wed,  2 Mar 2022 23:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646293423; x=1677829423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uFbDZllnjgFcPHD9kmqzGdMepkMXyq0m/mHoU/oLtz0=;
  b=M+p7vCVkJ+MJx45rqoNhHJJK8DV5Xh11er0XPuG/L4Z54rawI/IMDBfM
   3ZTGGeI+8CHcRwthPig3q1bimjR8YO9R113Lc1AZMFhlQbF7mm3yKga0F
   mK8XpOMGoC09GtX9CQ6ir/+rc5Qm/APjSMVCgnu6TSipnN6VAXizAbEWm
   Ay9ot2+DTaCVVc7oHRmMUw+APi4O8RdqoOEBfasXLKtkqhs6WeWmGksdc
   PEpGyt2hpeZBf49zFCITIcEJBLnVPA+f5J97WXNtkVT3x/dIyZPU4oPXF
   g42z9HzIQAChaAveAbgDmdnULOl8sk9ZGBzb9tqORmT0BIYdBzCC/9Nlp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340035954"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340035954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:43:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="779158794"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:43:41 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Mar 2022 09:43:38 +0200
Date:   Thu, 3 Mar 2022 09:43:38 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [PATCH 2/5] drivers/thunderbolt: don't resume switches without
 uid set
Message-ID: <YiBxqkG9iB9x8SMW@lahna>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
 <20220302220709.3138846-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220709.3138846-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Mar 02, 2022 at 04:07:06PM -0600, Mario Limonciello wrote:
> Switches might not have a uid set if the DROM read failed during

That's "Routers" and "UID" :)

Also $subject should have prefix "thunderbolt: " not
"drivers/thunderbolt". Please capitalize the summary too:

  thunderbolt: Do not resume routers if UID is not set

The patch itself looks good to me.

> initialization previously.
> 
> Normally upon resume the uid is re-read to confirm it's the same
> device connected.
> * If the DROM read failed during init but then succeeded during
>   resume it could either be a new device or faulty device
> * If the DROM read failed during init and also failed during resume
>   it might be a different device plugged in all together.
> 
> Detect this situation and prevent re-using the same configuration in
> these cirucmstances.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/switch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index b5fb3e76ed09..294518af4ee4 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -2980,6 +2980,10 @@ int tb_switch_resume(struct tb_switch *sw)
>  			return err;
>  		}
>  
> +		/* We don't have any way to confirm this was the same device */
> +		if (!sw->uid)
> +			return -ENODEV;
> +
>  		if (tb_switch_is_usb4(sw))
>  			err = usb4_switch_read_uid(sw, &uid);
>  		else
> -- 
> 2.34.1
