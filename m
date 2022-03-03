Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C954CB810
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiCCHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD1231902;
        Wed,  2 Mar 2022 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646293647; x=1677829647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zuBLV0n7JURTuSzn8qbNt8uwizHW3bq1hZyOCBYUPq0=;
  b=a/Ximz412s18uFnYkH9qxXxQeBMM+Lnx1EbBrBlw5PfT5VKjRubCBSRz
   q0995Cws1bLA3DtPj3ncQlOnsY6XkU18pf2tlFbtdloPZIK53clMonFUN
   G3Se8AN5jT0FRccFXsPk9/VwidMhzuAOtkQbipSMXWj3igeL8sY8XXV3d
   PTJuW0kXeI1wCmhcVO/z9QJw73Arg2hW5InfTWPu5r3hVXUcUZ10Hhobn
   oWK6qJKrU76XsQdZt+uTayx0WxGgcwFSpGc4yhNptde/IhCNAR7t6ZE34
   T5ZIT9CuUJCezFtso4TN5507O6KXniw3WmIPobR1yPEOLisB+aOawe+bc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="237114412"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="237114412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:47:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="551637872"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:47:24 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Mar 2022 09:47:22 +0200
Date:   Thu, 3 Mar 2022 09:47:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [PATCH 3/5] drivers/thunderbolt: Don't make DROM read success
 compulsory
Message-ID: <YiByip/y6p68j6lP@lahna>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
 <20220302220709.3138846-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302220709.3138846-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Mar 02, 2022 at 04:07:07PM -0600, Mario Limonciello wrote:
> The USB4 specification doesn't make any requirements that reading
> a device router's DROM is needed for the operation of the device.
> 
> On page 207 of the USB4 1.0 spec it does mention that a CM may use
> the DROM to make decision though:
> ```
> After enumerating a Router, the Connection Manager may read the
> contents of the Router’s DROM. If, after reading the contents of
> DROM, the Connection Manager decides that it does not want the
> Router in its Domain...
> ```

You don't need to quote the spec for Thunderbolt patches. I can read,
and it's not like it is going to change anyway ;-)

> Other connection manager solutions don't necessarily read it or gate
> the usability of the device on whether it was read.

Indeed.

> So make failures when reading the DROM show warnings but not
> fail the initialization of the switch.
> 
> Link: https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip

Also no need to "link" the spec. I know where the spec can be
downloaded.

Ditto for all patches.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/switch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 294518af4ee4..ac87e8b50e52 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -2784,10 +2784,8 @@ int tb_switch_add(struct tb_switch *sw)
>  
>  		/* read drom */
>  		ret = tb_drom_read(sw);
> -		if (ret) {
> -			dev_err(&sw->dev, "reading DROM failed\n");
> -			return ret;
> -		}
> +		if (ret)
> +			dev_warn(&sw->dev, "reading DROM failed: %d\n", ret);
>  		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
>  
>  		tb_check_quirks(sw);
> -- 
> 2.34.1
