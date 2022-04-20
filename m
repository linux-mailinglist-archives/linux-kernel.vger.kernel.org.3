Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB5508479
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377004AbiDTJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351352AbiDTJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:09:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C612756;
        Wed, 20 Apr 2022 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650445600; x=1681981600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uf3MUfIrMG7NSD6MLuF40FAUsLWXCYmgBZwz5nCggiw=;
  b=HRPLN2c+ZFkwho5c3pPTyUFilYVZMWOyZksjSB+IdFiRrLariD1Q2vTu
   2DXWpzRANm3YuoCe9iIHjojy4GqXJyA7++mDQk4vy6mLPVsNsYhJUB1ar
   XqPZr9LxQJZ8yYEfFzIVoZ5Wagy/SqgUshXqDQEw/SO7PJ5vbu4/XlVJ1
   YD5m3U/JZdKDwPrKNE7uAIYVjXg6rbIpc6WvqczgrZ7ZFVlO/An6P/Rq8
   Y6ji3Ow9tETniJA6NLT1vPunht6VD230NfyOnESgnwaz0jahugq0gT6Bs
   yi4n/xwM8F6iD3FAP7C13wsE1NeDXnG2U8opbG1tayMM1VfVKWLL1rmGH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326880507"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="326880507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="702568859"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Apr 2022 02:06:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Apr 2022 12:06:36 +0300
Date:   Wed, 20 Apr 2022 12:06:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     gregkh@linuxfoundation.org, cy_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: rt1719: Fix build error without
 CONFIG_POWER_SUPPLY
Message-ID: <Yl/NHAaXFh1UzFdI@kuha.fi.intel.com>
References: <20220418082425.41566-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418082425.41566-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Apr 18, 2022 at 04:24:25PM +0800, Ren Zhijie kirjoitti:
> Building without CONFIG_POWER_SUPPLY will fail:
> 
> drivers/usb/typec/rt1719.o: In function `rt1719_psy_set_property':
> rt1719.c:(.text+0x10a): undefined reference to `power_supply_get_drvdata'
> drivers/usb/typec/rt1719.o: In function `rt1719_psy_get_property':
> rt1719.c:(.text+0x2c8): undefined reference to `power_supply_get_drvdata'
> drivers/usb/typec/rt1719.o: In function `devm_rt1719_psy_register':
> rt1719.c:(.text+0x3e9): undefined reference to `devm_power_supply_register'
> drivers/usb/typec/rt1719.o: In function `rt1719_irq_handler':
> rt1719.c:(.text+0xf9f): undefined reference to `power_supply_changed'
> drivers/usb/typec/rt1719.o: In function `rt1719_update_pwr_opmode.part.9':
> rt1719.c:(.text+0x657): undefined reference to `power_supply_changed'
> drivers/usb/typec/rt1719.o: In function `rt1719_attach':
> rt1719.c:(.text+0x83e): undefined reference to `power_supply_changed'
> 
> Add POWER_SUPPLY dependency to Kconfig.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 25d29b980912 ("usb: typec: rt1719: Add support for Richtek RT1719")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 8f921213b17d..ba24847fb245 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -56,6 +56,7 @@ config TYPEC_RT1719
>  	tristate "Richtek RT1719 Sink Only Type-C controller driver"
>  	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
>  	depends on I2C
> +	depends on POWER_SUPPLY
>  	select REGMAP_I2C
>  	help
>  	  Say Y or M here if your system has Richtek RT1719 sink only
> -- 
> 2.17.1

-- 
heikki
