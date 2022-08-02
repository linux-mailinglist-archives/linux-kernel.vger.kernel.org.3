Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521D558793B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiHBIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiHBImx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:42:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032754E61E;
        Tue,  2 Aug 2022 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659429768; x=1690965768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZF0IHsPtb+gbc1KaCMUjMyQHkEwEgaEUAB54zUumpw=;
  b=a39+81fbrFSKmADmgUBDDmQutb7tgM7kA41XB+2EqNZYOP/GR25Xra6/
   jq/SKvRT4G54jdPbFeeQaMqxSQLQAHp62Gn46J6XLPXf0Omhu3AY0eBAQ
   Zu7wecrfirlfNS01oursnpobZJnMMu+KnnSDzVPxjcHMy1Bfh+lx2zOCP
   gEkuQvR/BYgV2xcCLoHFtG1mKkChudOY9rMLEKYPPa6cvjY7ew9uVrH1/
   64XKahMxF+vxfMHYaWV6xEaWBpImXBOcdJ/czpPYTBw8qvgYftaH1SmyM
   rMSg/a5q0dT9ydVsXFkH2nasXSCTMfplzCLD2sW0Yw4v5XRoDZwot8WGc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353361600"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="353361600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744593107"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:42:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:42:42 +0300
Date:   Tue, 2 Aug 2022 11:42:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 7/7] usb: typec: tcpci_rt1711h: Fix CC PHY noise
 filter of voltage level
Message-ID: <YujjgqE8h6AMwzF5@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-8-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-8-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:14:47PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Fix CC PHY noise filter of voltage level according to
> current cc voltage level
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

I was unable to apply this series on top of Greg's latest usb-next, so
I think you need to rebase these. But in any case, for this patch FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 58 +++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index da35dd3e8a59..6d2568de553b 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -25,8 +25,11 @@
>  #define RT1711H_PHYCTRL1	0x80
>  #define RT1711H_PHYCTRL2	0x81
>  
> -#define RT1711H_RTCTRL8		0x9B
> +#define RT1711H_RTCTRL4		0x93
> +/* rx threshold of rd/rp: 1b0 for level 0.4V/0.7V, 1b1 for 0.35V/0.75V */
> +#define RT1711H_BMCIO_RXDZSEL	BIT(0)
>  
> +#define RT1711H_RTCTRL8		0x9B
>  /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
>  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
> @@ -45,6 +48,10 @@
>  #define RT1711H_RTCTRL15	0xA2
>  #define RT1711H_RTCTRL16	0xA3
>  
> +#define RT1711H_RTCTRL18	0xAF
> +/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
> +#define BMCIO_RXDZEN	BIT(0)
> +
>  struct rt1711h_chip {
>  	struct tcpci_data data;
>  	struct tcpci *tcpci;
> @@ -165,6 +172,53 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>  				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
>  }
>  
> +/*
> + * Selects the CC PHY noise filter voltage level according to the remote current
> + * CC voltage level.
> + *
> + * @status: The port's current cc status read from IC
> + * Return 0 if writes succeed; failure code otherwise
> + */
> +static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
> +{
> +	int ret, cc1, cc2;
> +	u8 role = 0;
> +	u32 rxdz_en, rxdz_sel;
> +
> +	ret = rt1711h_read8(chip, TCPC_ROLE_CTRL, &role);
> +	if (ret < 0)
> +		return ret;
> +
> +	cc1 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC1_SHIFT) &
> +				TCPC_CC_STATUS_CC1_MASK,
> +				status & TCPC_CC_STATUS_TERM ||
> +				tcpc_presenting_rd(role, CC1));
> +	cc2 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC2_SHIFT) &
> +				TCPC_CC_STATUS_CC2_MASK,
> +				status & TCPC_CC_STATUS_TERM ||
> +				tcpc_presenting_rd(role, CC2));
> +
> +	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
> +	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
> +		rxdz_en = BMCIO_RXDZEN;
> +		if (chip->did == RT1715_DID)
> +			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> +		else
> +			rxdz_sel = 0;
> +	} else {
> +		rxdz_en = 0;
> +		rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> +	}
> +
> +	ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
> +				 BMCIO_RXDZEN, rxdz_en);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
> +				  RT1711H_BMCIO_RXDZSEL, rxdz_sel);
> +}
> +
>  static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>  				      struct tcpci_data *tdata,
>  				      enum typec_cc_status cc)
> @@ -225,6 +279,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>  		/* Clear cc change event triggered by starting toggling */
>  		if (status & TCPC_CC_STATUS_TOGGLING)
>  			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
> +		else
> +			rt1711h_init_cc_params(chip, status);
>  	}
>  
>  out:
> -- 
> 2.25.1

-- 
heikki
