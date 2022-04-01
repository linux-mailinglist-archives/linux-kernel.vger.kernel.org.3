Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2154EEE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbiDANz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbiDANzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:55:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624D3153D;
        Fri,  1 Apr 2022 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648821215; x=1680357215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JVIFR1RY3e4c1DpSi0zz4R7HTop2QK2Mx5IigfiEgA=;
  b=BgVXgZca8UcIkIqGCH9ubUE6Ty0rdYiMjBpJWb7Eg/7GuzCahVuBdIId
   /NpljIlBNYOCZrkTKRebmU9vSJTVEGzXJyPpIGG/PxxLZJN4Kq1gkManL
   WsaDgvkvtzVjsGcT3ca3POO7s6SyUUS5/9728kEWjhF1s323w7EJoPrxn
   H1dgxiRWnBgfEUk286+5JptMfcjGCje12LFV6pqACxEpUKs6WEuZBpk8W
   ZPZRZuMWaevQ8iUajE+dUNW8x7AXzNOs5Od+NDurZLOYJzv6qB47LOOmm
   3BpsfKhLgXq+LxpQfsWsW1Bzc5lASnwqX/5PYIWXAy++HlkzsRekcqYi3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323311000"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="323311000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="695898668"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 01 Apr 2022 06:53:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Apr 2022 16:53:31 +0300
Date:   Fri, 1 Apr 2022 16:53:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     tanveer1.alam@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhijeet.rao@intel.com
Subject: Re: [PATCH] usb: typec: mux: intel_pmc_mux: Add retry logic to a PMC
 command
Message-ID: <YkcD25gTJ07h7XDK@kuha.fi.intel.com>
References: <20220328105137.6223-1-tanveer1.alam@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328105137.6223-1-tanveer1.alam@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 04:21:37PM +0530, tanveer1.alam@intel.com wrote:
> From: Tanveer Alam <tanveer1.alam@intel.com>
> 
> There are few scenerio when PMC reports 'busy condition' and command
> fail.
> 
> If PMC receives a high priority command while servicing a low priority
> command then it discards the low priority command and start servicing
> the high priority command. The lower priority command fail and driver
> returns error. If the same command resend to the PMC then PMC latches
> the command and service it accordingly.
> 
> Thus adds the retry logic for the PMC command.
> 
> Signed-off-by: Tanveer Alam <tanveer1.alam@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 2cdd22130834..da6b381ddf00 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -173,7 +173,7 @@ static int hsl_orientation(struct pmc_usb_port *port)
>  	return port->orientation - 1;
>  }
>  
> -static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> +static int pmc_usb_send_command(struct intel_scu_ipc_dev *ipc, u8 *msg, u32 len)
>  {
>  	u8 response[4];
>  	u8 status_res;
> @@ -184,7 +184,7 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
>  	 * Status can be checked from the response message if the
>  	 * function intel_scu_ipc_dev_command succeeds.
>  	 */
> -	ret = intel_scu_ipc_dev_command(port->pmc->ipc, PMC_USBC_CMD, 0, msg,
> +	ret = intel_scu_ipc_dev_command(ipc, PMC_USBC_CMD, 0, msg,
>  					len, response, sizeof(response));
>  
>  	if (ret)
> @@ -203,6 +203,23 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
>  	return 0;
>  }
>  
> +static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> +{
> +	int retry_count = 3;
> +	int ret;
> +
> +	/*
> +	 * If PMC is busy then retry the command once again
> +	 */
> +	while (retry_count--) {
> +		ret = pmc_usb_send_command(port->pmc->ipc, msg, len);
> +		if (ret != -EBUSY)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int
>  pmc_usb_mux_dp_hpd(struct pmc_usb_port *port, struct typec_displayport_data *dp)
>  {

thanks,

-- 
heikki
