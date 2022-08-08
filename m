Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43C58C695
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbiHHKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiHHKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:38:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46001A1B9;
        Mon,  8 Aug 2022 03:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659955101; x=1691491101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i0OaVs7vkKYWne9ZknDeoaUYlRMrkt/ldlaa0MEbAZA=;
  b=DMS1YJRiaClfsW8aERSbM/kc24XQjpNEO/ZsVejHN6QxaEnqpIeBwene
   1mNp1sqMzhhJbbzbzYiD+QpMSnw9HAx4gCfUDhNOGnc+/jTS6d70KFeX9
   9sqdO0GXrJXfb4lONRWZAGetEYaAxGqWdiPPWxsTAjzK12QdJNPgW311d
   tdNmZQiXcllX0+93M8fmBEK1H5TiuoAY2aBqNXcz8nJ1zWDTK/zgYbgOu
   n8zYgw/EVPxU9O4VrK0hZrmN6Q9gxQ4x4yIm+lEXRbjBJkjCS8eOp3D3A
   K96GBBPZB+PNoDBTlXVQDtVZ0izjWjKgegLzmmZerRrUAz6S5t/AVu0IS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="354559347"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="354559347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 03:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746584608"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Aug 2022 03:38:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Aug 2022 13:38:16 +0300
Date:   Mon, 8 Aug 2022 13:38:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
Message-ID: <YvDnmP4bmAZkFgAD@kuha.fi.intel.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-5-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-5-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:17:10PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add initial phy setting about phy dicard retry,
> rx filter deglitch time and BMC-encoded wait time
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index fb19d7b..5c51d04 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -19,6 +19,9 @@
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
>  
> +#define RT1711H_PHYCTRL1	0x80
> +#define RT1711H_PHYCTRL2	0x81
> +
>  #define RT1711H_RTCTRL8		0x9B
>  
>  /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> @@ -106,8 +109,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  		return ret;
>  
>  	/* dcSRC.DRP : 33% */
> -	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable phy discard retry, retry count 7, rx filter deglitch 100 us */
> +	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
> +	if (ret < 0)
> +		return ret;
>  
> +	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
> +	/* wait time : (val * .4167) us */
> +	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
>  }
>  
>  static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> -- 
> 2.7.4

-- 
heikki
