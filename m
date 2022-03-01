Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3B4C8402
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiCAG2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCAG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:28:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A27D4833B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646116080; x=1677652080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+coUtu0N9qJ7rXPZFDWZMiy7198iNtKXun0/rsR8NGA=;
  b=PnAc4PxyJy4WeBcq0dd42aZYYhKN9BUZzlUx2vCR5np9i56isw9PN3xV
   b4bNsWbiYDD3jY5dVIiAgm7ti3eA+fYoWGmWATHbQjMxvcrRSrIadL7N2
   +SFda4AOWbN4DxK/7DovubbJ+ZHv+v5FS3ikikODQi1pmZJ4Y5oqgZe6U
   fjW+a8rLkSFye2/wfiL+det8hozMBI15QrJ/rKaByBXY3W5tpBk86AGFx
   TNjhZkGBiUvPwIuzT8w1otpu8UXyc7ihb94Xxc4ZKFLuTnzEe1Y2Wqz+p
   Bo5paERhLUtrtQCOSgyKT4D9Llg1AJCDxjWpw/GhiJOfAMV9UaIXBYPin
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253260669"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="253260669"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:27:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="641150697"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 22:27:57 -0800
Date:   Tue, 1 Mar 2022 14:27:56 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: dd: fix return value of __setup handler
Message-ID: <20220301062756.GJ4548@shbuild999.sh.intel.com>
References: <20220301041829.15137-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301041829.15137-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Feb 28, 2022 at 08:18:29PM -0800, Randy Dunlap wrote:
> When "driver_async_probe=nulltty" is used on the kernel boot command line,
> it causes an Unknown parameter message and the string is added to init's
> environment strings, polluting them.
> 
>   Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc6
>   driver_async_probe=nulltty", will be passed to user space.
> 
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc6
>      driver_async_probe=nulltty
> 
> Change the return value of the __setup function to 1 to indicate
> that the __setup option has been handled.

Thanks for the fix!

Reviewed-by: Feng Tang <feng.tang@intel.com>


> Fixes: 1ea61b68d0f8 ("async: Add cmdline option to specify drivers to be async probed")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/dd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20220228.orig/drivers/base/dd.c
> +++ linux-next-20220228/drivers/base/dd.c
> @@ -810,7 +810,7 @@ static int __init save_async_options(cha
>  		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
>  
>  	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
> -	return 0;
> +	return 1;
>  }
>  __setup("driver_async_probe=", save_async_options);
>  
