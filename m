Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA54B9B20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiBQIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBQIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:31:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87324CDC7;
        Thu, 17 Feb 2022 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645086659; x=1676622659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IaBxTCiW4IYAN8h9khdUrEJ7yUralv1XQeZfmtbiNs=;
  b=lnvShajUDlLr/rxo9H4RWPExvLC3Uf3OggJU4Hv3OZAuHSmQpzxg/f3B
   RKNl6A524g3jdZqwnpggtXImryyPcCPS3bjjIeWZjRKojBAPzUTez7hZf
   EGXq4wb0/lKU/feTy2WUgtlnrvGNYpwl/M2dLYGBZAAAvi17odDusAzzF
   EBQxNORfo8FtwlGakqbuVlCLhml/TtP4e6lcqq48HbqWz1Odab0dWqQ6c
   3S7dxpDpzw1M6+SB0PBAPKWRHEHTUFiIgCIChovxXj7hfLyBPNO+eutnS
   tmYBH8zJiGq/zkkdfmssxThT5UUpG4ImLuT4f6+lTcfxRYc9VIqOngP5i
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249660342"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249660342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="681860947"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Feb 2022 00:30:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 17 Feb 2022 10:30:56 +0200
Date:   Thu, 17 Feb 2022 10:30:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] tps6598x: clear int mask on probe failure
Message-ID: <Yg4HwO2SKGDvOASz@kuha.fi.intel.com>
References: <e6b80669-20f3-06e7-9ed5-8951a9c6db6f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b80669-20f3-06e7-9ed5-8951a9c6db6f@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:22:04AM -0700, Jens Axboe wrote:
> The interrupt mask is enabled before any potential failure points in
> the driver, which can leave a failure path where we exit with
> interrupts enabled but the device not live. This causes an infinite
> stream of interrupts on an Apple M1 Pro laptop on USB-C.
> 
> Add a failure label that's used post enabling interrupts, where we
> mask them again before returning an error.
> 
> Suggested-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Should this be marked as a fix?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 6d27a5b5e3ca..7ffcda94d323 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -761,12 +761,12 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret < 0)
> -		return ret;
> +		goto err_clear_mask;
>  	trace_tps6598x_status(status);
>  
>  	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
>  	if (ret < 0)
> -		return ret;
> +		goto err_clear_mask;
>  
>  	/*
>  	 * This fwnode has a "compatible" property, but is never populated as a
> @@ -855,7 +855,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	usb_role_switch_put(tps->role_sw);
>  err_fwnode_put:
>  	fwnode_handle_put(fwnode);
> -
> +err_clear_mask:
> +	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
>  	return ret;
>  }

-- 
heikki
