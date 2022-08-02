Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5725878AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiHBIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiHBIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:05:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA94BD0B;
        Tue,  2 Aug 2022 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659427501; x=1690963501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFxXpTNDYC6+rl1qHTft8GB0Nk6/VMUr+z49r399VS4=;
  b=hHg5WVPhp5RpKV6afwiOKvDSpRmdUNCaizuEfd50UE/wzMa03KshzYXl
   deJk3sAwSBhf+8wSAgo9DRowYTQ4BRgJYoC+cM8HX+9kjkW/JEJkPw+YC
   I5uJjQp3k8XARF0t/jM7ohbk8YwkG01KJ0Uw/CVQkgmCmXMuhlpd0Hcva
   lDY0SAFSlqg8EyysqGpckp5mEgfRwdaI6jhegVk/22bsMM2m73ByiQCI+
   1KFlQMdK+UErRfJ93gkfnl7cv6F/w66ySXqm4Q8IJh8jRUN+X32ZSA4u1
   9B3lGd5Yd5ynsyKl8g0AdeNTpP0HeuOwhOOGitUiV8959R67+umTytNR9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289364466"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="289364466"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744583231"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:04:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:04:56 +0300
Date:   Tue, 2 Aug 2022 11:04:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 3/7] usb: typec: tcpci_rt1711h: Add regulator support
 when source vbus
Message-ID: <YujaqOK2MwxvoHZ2@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-4-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-4-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:14:43PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add regulator support when source vbus
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 6197d9a05d36..df7bfe299987 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/usb/tcpm.h>
>  
>  #include "tcpci.h"
> @@ -42,6 +43,8 @@ struct rt1711h_chip {
>  	struct tcpci_data data;
>  	struct tcpci *tcpci;
>  	struct device *dev;
> +	struct regulator *vbus;
> +	bool src_en;
>  };
>  
>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -105,6 +108,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  
>  	/* dcSRC.DRP : 33% */
>  	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +
> +}
> +
> +static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			    bool src, bool snk)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	int ret;
> +
> +	if (chip->src_en == src)
> +		return 0;
> +
> +	if (src)
> +		ret = regulator_enable(chip->vbus);
> +	else
> +		ret = regulator_disable(chip->vbus);
> +
> +	if (!ret)
> +		chip->src_en = src;
> +	return ret;
>  }
>  
>  static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
> @@ -248,7 +271,12 @@ static int rt1711h_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	chip->vbus = devm_regulator_get(&client->dev, "vbus");
> +	if (IS_ERR(chip->vbus))
> +		return PTR_ERR(chip->vbus);
> +
>  	chip->data.init = rt1711h_init;
> +	chip->data.set_vbus = rt1711h_set_vbus;
>  	chip->data.set_vconn = rt1711h_set_vconn;
>  	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.25.1

-- 
heikki
