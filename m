Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA214CA46E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiCBMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiCBMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:07:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B58C0859;
        Wed,  2 Mar 2022 04:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646222778; x=1677758778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AnjlKf1LQKzOgzxBT/jxnMz1bZYSfLAR8Dv3xXjRDio=;
  b=ZQsY8Ow8nwoLaosyScGJFXUnkNAat/0ujx/vtvV7Uxt5xfOCJ6ZgoaZz
   IF/OzVls2jwyTuBRxghvzNtaj04WxRsBxGpBLqnUSe2LyMTDDT8oey4he
   XqQN4FFH0cQbaVl+O/bGJNCexsPYdKnmDdRUBwVXXf6PRmu/ChfARUxtv
   YH2Pr0lAv7uXFUbTD9lTW1sOWkn8cvQxHjvCMhZp2bSkxMJ1ysE591tvS
   hsemIhhMoeCWiY7mZSgBbMa1aP4hMXV/LKuE7xO7FXVkFMHXp3cyu18Oc
   GSbt1pH/SCdifmRYfHnYIbbbnZkv38aMp8TPj3iHq0zFo3tnozIAq5N2/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236894996"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="236894996"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="686116074"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2022 04:06:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Mar 2022 14:06:00 +0200
Date:   Wed, 2 Mar 2022 14:06:00 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: Forward plug orientation to typec
 subsystem
Message-ID: <Yh9dqPh69wcI3har@kuha.fi.intel.com>
References: <20220226125912.59828-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226125912.59828-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 01:59:12PM +0100, Sven Peter wrote:
> In order to bring up the USB3 PHY on the Apple M1 we need to know the
> orientation of the Type-C cable. Extract it from the status register and
> forward it to the typec subsystem.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c     | 5 +++++
>  drivers/usb/typec/tipd/tps6598x.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 7ffcda94d323..16b4560216ba 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -256,6 +256,10 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_opmode(tps->port, mode);
>  	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
> +	if (TPS_STATUS_TO_UPSIDE_DOWN(status))
> +		typec_set_orientation(tps->port, TYPEC_ORIENTATION_REVERSE);
> +	else
> +		typec_set_orientation(tps->port, TYPEC_ORIENTATION_NORMAL);
>  	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), true);
>  
>  	tps->partner = typec_register_partner(tps->port, &desc);
> @@ -278,6 +282,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
>  	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(status));
> +	typec_set_orientation(tps->port, TYPEC_ORIENTATION_NONE);
>  	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
>  
>  	power_supply_changed(tps->psy);
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 3dae84c524fb..527857549d69 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -17,6 +17,7 @@
>  /* TPS_REG_STATUS bits */
>  #define TPS_STATUS_PLUG_PRESENT		BIT(0)
>  #define TPS_STATUS_PLUG_UPSIDE_DOWN	BIT(4)
> +#define TPS_STATUS_TO_UPSIDE_DOWN(s)	(!!((s) & TPS_STATUS_PLUG_UPSIDE_DOWN))
>  #define TPS_STATUS_PORTROLE		BIT(5)
>  #define TPS_STATUS_TO_TYPEC_PORTROLE(s) (!!((s) & TPS_STATUS_PORTROLE))
>  #define TPS_STATUS_DATAROLE		BIT(6)
> -- 
> 2.25.1

thanks,

-- 
heikki
