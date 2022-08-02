Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1758790A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiHBIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHBIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:32:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEEE1EC;
        Tue,  2 Aug 2022 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659429155; x=1690965155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4ANagiP0pBWnABd6SaYZfcztDCXLk8K/eo+vzXaOEU=;
  b=XjNNHQ4FTw0bMy5XnTMKBUhqmtc9RvabPrkZaJMMXlv3xio5e1OFTVnk
   +cZdWsP+s0i/utOjKoCCAEq28KaYgqTb1ZBtHN4mSrSZMyOFljpWDX+nC
   v2orYgrqAYN1OyKvFndPWjmZ72XkADHvgZqWV+w2D0EIood3PE8ELpGvI
   0ctSV7Ew3hy8X9t0KEsxnHfU35VgZZgssJd2qKPR6No5CuZ+14pfx6nk+
   KadoBH/u8QDj2jWPMNpBs1w119jmbWDdg+gPbQnnDJ74/B5snYREqLMCz
   jduZVi1WVgftAoNakIsjlffa5tsOSokHpKfJgzP2zNf93sClGqonQZOdJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288113370"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="288113370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744590675"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:32:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:32:30 +0300
Date:   Tue, 2 Aug 2022 11:32:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 6/7] usb: typec: tcpci: Move function
 "tcpci_to_typec_cc" to common
Message-ID: <YujhHk4uvMI8PcWo@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-7-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-7-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:14:46PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Move transition function "tcpci_to_typec_cc" to common header
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 22 ----------------------
>  drivers/usb/typec/tcpm/tcpci.h | 23 +++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f33e08eb7670..0f45d456df32 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -28,11 +28,6 @@
>  #define	VPPS_VALID_MIN_MV			100
>  #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
>  
> -#define tcpc_presenting_rd(reg, cc) \
> -	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> -	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> -	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> -
>  struct tcpci {
>  	struct device *dev;
>  
> @@ -219,23 +214,6 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  			    TCPC_CMD_LOOK4CONNECTION);
>  }
>  
> -static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> -{
> -	switch (cc) {
> -	case 0x1:
> -		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
> -	case 0x2:
> -		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
> -	case 0x3:
> -		if (sink)
> -			return TYPEC_CC_RP_3_0;
> -		fallthrough;
> -	case 0x0:
> -	default:
> -		return TYPEC_CC_OPEN;
> -	}
> -}
> -
>  static int tcpci_get_cc(struct tcpc_dev *tcpc,
>  			enum typec_cc_status *cc1, enum typec_cc_status *cc2)
>  {
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index b2edd45f13c6..3f45cb0426df 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -166,6 +166,11 @@
>  /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
>  #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
>  
> +#define tcpc_presenting_rd(reg, cc) \
> +	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> +	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> +	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> +
>  struct tcpci;
>  
>  /*
> @@ -206,4 +211,22 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci);
>  
>  struct tcpm_port;
>  struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
> +
> +static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> +{
> +	switch (cc) {
> +	case 0x1:
> +		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
> +	case 0x2:
> +		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
> +	case 0x3:
> +		if (sink)
> +			return TYPEC_CC_RP_3_0;
> +		fallthrough;
> +	case 0x0:
> +	default:
> +		return TYPEC_CC_OPEN;
> +	}
> +}
> +
>  #endif /* __LINUX_USB_TCPCI_H */
> -- 
> 2.25.1

-- 
heikki
