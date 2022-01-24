Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5687497AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiAXIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:55:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:19950 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242477AbiAXIzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643014510; x=1674550510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B7mRVQn3mGN3EOaG2zxuvdC0hKN77JXTeveSRmb0/ZQ=;
  b=FO4O4sd4KL/7iz7SjW8782ijhREtC042mS4H30znv+TuqxG/dh7ZLgSc
   Umbmr5mHNkGtZBGuQjzY0keVjLatmOZTyaguA4bTEXnPMJvtpplZGKtUv
   8DR1QCDkyDCKIvsYrvOoWraBAF7ws6ERoCT4iMY0pNQRaGNHNBhtXiaC4
   KImH7yZFB5CGJ1NWmtKlDWqR9WQIbv+5eXqn8MW9KwnMjpeBVp6egI+P6
   C6lcEr+wj1U8oEVwiE23+X/2VgTUTZ5UKgROSsZdi8LKm36xgy2PXr20Y
   eoOxzoOoHbWblCGVuCQza3HwSqeSU6H5mlJIKDtjdboFTvxpFYWizXZ56
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309320373"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309320373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673558970"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2022 00:55:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Jan 2022 10:54:59 +0200
Date:   Mon, 24 Jan 2022 10:54:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH] usb: typec: Only attempt to link USB ports if there is
 fwnode
Message-ID: <Ye5pY97VOb4TdZjH@kuha.fi.intel.com>
References: <20220118093627.74098-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220118093627.74098-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 12:36:27PM +0300, Heikki Krogerus wrote:
> The code that creates the links to the USB ports attached to
> a connector inside the system assumed that the ACPI nodes
> (fwnodes) always exist for the connectors, but it can not do
> that.
> 
> There is no guarantee that every USB Type-C connector has
> ACPI device node representing it in the ACPI tables, and
> even if there are the nodes in the ACPI tables, the _STA
> method in those nodes may still return 0 (which means the
> device does not exist from ACPI PoW).
> 
> This fixes NULL pointer dereference that happens if the
> nodes are missing.

I'll resend this togher wit the other fix.

thanks,

> Reported-and-tested-by: Robert Święcki <robert@swiecki.net>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Fixes: 730b49aac426 ("usb: typec: port-mapper: Convert to the component framework")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi guys,
> 
> Mikhail, I got confirmation from Robert that the patch fixes the
> issue.
> 
> thanks,
> ---
>  drivers/usb/typec/port-mapper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
> index 07d307418b470..b6e0c6acc628c 100644
> --- a/drivers/usb/typec/port-mapper.c
> +++ b/drivers/usb/typec/port-mapper.c
> @@ -56,6 +56,9 @@ int typec_link_ports(struct typec_port *con)
>  {
>  	struct each_port_arg arg = { .port = con, .match = NULL };
>  
> +	if (!has_acpi_companion(&con->dev))
> +		return 0;
> +
>  	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
>  
>  	/*
> @@ -74,5 +77,6 @@ int typec_link_ports(struct typec_port *con)
>  
>  void typec_unlink_ports(struct typec_port *con)
>  {
> -	component_master_del(&con->dev, &typec_aggregate_ops);
> +	if (has_acpi_companion(&con->dev))
> +		component_master_del(&con->dev, &typec_aggregate_ops);
>  }
> -- 
> 2.34.1

-- 
heikki
