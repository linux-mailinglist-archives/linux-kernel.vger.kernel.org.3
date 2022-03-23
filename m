Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161764E5056
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiCWKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCWKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:32:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83E6EB0A;
        Wed, 23 Mar 2022 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648031451; x=1679567451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SV0+1VOXq+yxYQQCFdKG0nZadXPiB8XCijjjUS7LwI4=;
  b=MvHPNDY+0MNQM4fPyPTgPVAxo+zI3eqAeFin9sfkcNlh2BvYHvzrE+/o
   8HJ22J20aLHSNkzUz2/DRlKPjdJkijHYIQVUT8dXTE2dDc+5QWfUUQ0KV
   ham8QzQ0iJlx6By9IWOSrkahnQWeLgK6ow98qh/KEe4gYQhU0KTVfutJ7
   tUCtAG99kEKcp0C9xob6EWyCNyAYr/cwKXbYu8+jlBhzeblTeM5V3cSc0
   KsO8d5kUqiSA2NVl8GUoy0NyFRKW3FHy45aUFxHJR3QQbZicEyOuoDd0S
   1nYqActMOtfh2cO9CZ1L5irMod2llowrZ4vDJE2yT+MLx7tSg9vjM+VHr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="240238208"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="240238208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 03:30:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="515731387"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 03:30:47 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Mar 2022 12:30:45 +0200
Date:   Wed, 23 Mar 2022 12:30:45 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     "bleung@google.com" <bleung@google.com>,
        "Malani, Prashant" <pmalani@google.com>,
        "jthies@google.com" <jthies@google.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB4/TBT device routers should wake up during S0ix when
 something gets connected/disconnected or a DP monitor gets plugged in
Message-ID: <Yjr21UzWmj4NjItA@lahna>
References: <20220323101818.3503-1-rajat.khandelwal@intel.com>
 <CO1PR11MB48357FE72D34818360D2105E96189@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48357FE72D34818360D2105E96189@CO1PR11MB4835.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you want it to be woken up when something is plugged to the USB4 port
then I suggest to add this to the "wakeup" capability of the usb4_port
itself (see drivers/thunderbolt/usb4_port.c). And make it disabled by
default too.

On Wed, Mar 23, 2022 at 10:26:37AM +0000, Khandelwal, Rajat wrote:
> +Mika
> @Malani, Prashant @bleung@google.com This is the patch which fixes the partner issue. Kindly escalate your thoughts. 
> 
> Thanks
> Rajat
> 
> -----Original Message-----
> From: Khandelwal, Rajat <rajat.khandelwal@intel.com> 
> Sent: Wednesday, March 23, 2022 3:48 PM
> To: mika.westerberg@linux.intel.com
> Cc: Khandelwal, Rajat <rajat.khandelwal@intel.com>; bleung@google.com; jthies@google.com; Malani, Prashant <pmalani@google.com>; Rao, Abhijeet <abhijeet.rao@intel.com>; Regupathy, Rajaram <rajaram.regupathy@intel.com>; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] USB4/TBT device routers should wake up during S0ix when something gets connected/disconnected or a DP monitor gets plugged in
> 
> Device routers don't wake up during S0ix when something is plugged in/out or if a DP monitor gets connected. This causes the linux device to not wake up during S0ix cycling as the host router didn't wake up because the device router didn't. This patch adds a new functionality to linux.
> 
> Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
> ---
>  drivers/thunderbolt/switch.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c index d026e305fe5d..4f8056724aa4 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -3067,13 +3067,11 @@ void tb_switch_suspend(struct tb_switch *sw, bool runtime)
>  			tb_switch_suspend(port->remote->sw, runtime);
>  	}
>  
> -	if (runtime) {
> +	if (runtime || device_may_wakeup(&sw->dev)) {
>  		/* Trigger wake when something is plugged in/out */
>  		flags |= TB_WAKE_ON_CONNECT | TB_WAKE_ON_DISCONNECT;
>  		flags |= TB_WAKE_ON_USB4;
>  		flags |= TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE | TB_WAKE_ON_DP;
> -	} else if (device_may_wakeup(&sw->dev)) {
> -		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
>  	}
>  
>  	tb_switch_set_wake(sw, flags);
> --
> 2.17.1
