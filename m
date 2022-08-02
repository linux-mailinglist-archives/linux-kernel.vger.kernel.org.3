Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C14558787F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiHBH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiHBH6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:58:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF12F38A;
        Tue,  2 Aug 2022 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659427078; x=1690963078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o8494un4vXRlvd50TpzXogqNJizswoyXDmZmi+TkmX0=;
  b=ZTQAEWjCp/Dcra2LEUEQzLviGCfMOuxzX/GVZaDEJzpRP4lQIZcLYgUD
   qK7i9MfGADx6BWxMEqfmAEE2cWtc56/5azOw6+5N9AxCMCdU95REixyjN
   egOtBFxuUCHjCNqEKefju3hrnDco9u+YbeKHzOODDhxv4nZXirJv58kCl
   M6ndhghoqqG5SaGGpBjdnvduTv+lUktS/F3gbt1O5xs1HiKOEj4T43pN5
   08o0Yjztw/lW+JGwP+IugXaQPe5MWEUgYuxc9H5hlRna06BDf55wqAf1s
   6VDQjCuYJzcCk19c7jcLqwZLhF+1Yl57k1qCScO0QOpeDSCAqVsEP/PFt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290563300"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="290563300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744580849"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 00:57:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 10:57:53 +0300
Date:   Tue, 2 Aug 2022 10:57:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting
 when set vconn
Message-ID: <YujZATquqh0srgHm@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-3-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-3-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

On Mon, Aug 01, 2022 at 06:14:42PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> replace overwrite whole register with update bits
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index b56a0880a044..6197d9a05d36 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -5,13 +5,15 @@
>   * Richtek RT1711H Type-C Chip Driver
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/bits.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/usb/tcpm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/usb/tcpm.h>

That header reshuffling is not necessary for this change - at least you
are not giving any reason for it in your commit message.

If there is no real need for that in this patch, then please leave the
headers as they are. You can propose changing the order of the headers
in a separate patch. Though, I would not bother with it unless there
is some real benefit in doing so, and I'm pretty sure there isn't any.

>  #include "tcpci.h"
>  
>  #define RT1711H_VID		0x29CF
> @@ -23,6 +25,7 @@
>  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
>  			    ((auto_idle) << 3) | ((tout) & 0x07))
> +#define RT1711H_AUTOIDLEEN	BIT(3)
>  
>  #define RT1711H_RTCTRL11	0x9E
>  
> @@ -109,8 +112,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>  {
>  	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
>  
> -	return rt1711h_write8(chip, RT1711H_RTCTRL8,
> -			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
> +				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
>  }
>  
>  static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
> -- 
> 2.25.1

thanks,

-- 
heikki
