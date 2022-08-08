Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C209058C691
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbiHHKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbiHHKhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:37:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C08F591;
        Mon,  8 Aug 2022 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659955023; x=1691491023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dhyH4WmnOdlIJT3KtfNaqqX4xZEyYdOxO+yy7M4m6yw=;
  b=S7RWFL2tegAfsu8ey9krlgji7ybaIICyxxPvsqBZZbp/dzDKdDSU0n+1
   i31zSYlk45RL1KLVb4RsLHdPylW3BYSqZWOdtB+7lxMjzjSetgcK44107
   +sFh5BkTp8v3AJpVd/5+grcCxM88PQ4DGX3tT7ZgcDWmxBlA/5SmEQCRO
   3JRil8S/L2dhcAYDNhpHi8l/WT14AjSlxr0FM1Z6JlLJR47Zl8xdKyNh5
   9maTWFfGGLgjRC1px679p4g1fz5FB0M8aKCIDrK2WEucgG3GCgFBt0UiK
   27cdsD6fDrhl3Ksv70DoCXSCOFJU2wlRzP7BzHWfUrEOv2aYNS1ff+eja
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270334715"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270334715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 03:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746584281"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2022 03:36:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Aug 2022 13:36:59 +0300
Date:   Mon, 8 Aug 2022 13:36:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting
 when set vconn
Message-ID: <YvDnSzBkJGg5ba/7@kuha.fi.intel.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-3-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-3-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:17:08PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> replace overwrite whole register with update bits
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 3291ca4..f2f1fb0 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -5,6 +5,7 @@
>   * Richtek RT1711H Type-C Chip Driver
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -23,6 +24,7 @@
>  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
>  			    ((auto_idle) << 3) | ((tout) & 0x07))
> +#define RT1711H_AUTOIDLEEN	BIT(3)
>  
>  #define RT1711H_RTCTRL11	0x9E
>  
> @@ -109,8 +111,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
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
> 2.7.4

-- 
heikki
