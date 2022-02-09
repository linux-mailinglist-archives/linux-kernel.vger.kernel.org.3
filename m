Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B624AF07A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiBIL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiBIL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29828C0068AD;
        Wed,  9 Feb 2022 02:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644404343; x=1675940343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nzol2qAJ2pcwfsSlTz2txXFSTnV1hNw5G1nXpEt7930=;
  b=iCZIZYBmq870bjyaIZewxEfZggcM8iOkwREt+PT9d45U1YXd5KFhnyI7
   XFuhLE4z5kz5RKpSymQfiQM3BKrbZ67bv/k8c7WJJ1hWVrPo9V2jwtTbC
   skRibFj7AAGxJ4zLNn1BLUlobSTf9gddtLnOmbO4rR5T5isg6SllELiSf
   QD02wNiKt4t640XxPr5m5lok04p5OUAWG5e+PASK9NJC2hPFAB7WEgAJn
   BGqiJlVTX7eitRf9WzTOxXMg6tQgwtwTUWGVblJKmniy6qdial2EyQ5ds
   sw1bV8L3o/lST9Wd6Vk1GlZeXOXqJ6zuFICL/3cSxXUgIn0JGbw95G9ng
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229148803"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229148803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678505057"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 02:59:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 12:58:59 +0200
Date:   Wed, 9 Feb 2022 12:58:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] usb: typec: Factor out non-PD fwnode properties
Message-ID: <YgOecxgyaMN+/3sN@kuha.fi.intel.com>
References: <20220202221948.5690-1-samuel@sholland.org>
 <20220202221948.5690-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202221948.5690-4-samuel@sholland.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 02, 2022 at 04:19:46PM -0600, Samuel Holland wrote:
> Basic programmable non-PD Type-C port controllers do not need the full
> TCPM library, but they share the same devicetree binding and the same
> typec_capability structure. Factor out a helper for parsing those
> properties which map to fields in struct typec_capability, so the code
> can be shared between TCPM and basic non-TCPM drivers.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Always put the return values from typec_find_* in a signed variable
>    for error checking.
> 
>  drivers/usb/typec/class.c     | 52 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c | 32 +--------------------
>  include/linux/usb/typec.h     |  3 ++
>  3 files changed, 56 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 45a6f0c807cb..b67ba9478c82 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1894,6 +1894,58 @@ void *typec_get_drvdata(struct typec_port *port)
>  }
>  EXPORT_SYMBOL_GPL(typec_get_drvdata);
>  
> +int typec_get_fw_cap(struct typec_capability *cap,
> +		     struct fwnode_handle *fwnode)
> +{
> +	const char *cap_str;
> +	int ret;
> +
> +	/*
> +	 * This fwnode has a "compatible" property, but is never populated as a
> +	 * struct device. Instead we simply parse it to read the properties.
> +	 * This it breaks fw_devlink=on. To maintain backward compatibility
> +	 * with existing DT files, we work around this by deleting any
> +	 * fwnode_links to/from this fwnode.
> +	 */
> +	fw_devlink_purge_absent_suppliers(fwnode);

Let's not put that call here. That function is broken. I think it in
practice assumes that there can only be one device linked to fwnode,
but that's not true. The fwnodes can be, and are, shared. So by using
it we may end up doing things to some completely wrong devices.

So let's keep that call in the drivers that really have to have it for
now. I think that function - fw_devlink_purge_absent_suppliers() -
needs some serious rethinking.

There is some deeper problem. I have a feeling that all the functions
that rely on the fwnode->dev member are broken. We need a proper
reverce search mechanism that can be used to find the devices linked
to fwnodes. But I have no idea how to that could be done.

> +	cap->fwnode = fwnode;
> +
> +	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = typec_find_port_power_role(cap_str);
> +	if (ret < 0)
> +		return ret;
> +	cap->type = ret;
> +
> +	/* USB data support is optional */
> +	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
> +	if (ret == 0) {
> +		ret = typec_find_port_data_role(cap_str);
> +		if (ret < 0)
> +			return ret;
> +		cap->data = ret;
> +	}
> +
> +	/* Get the preferred power role for a DRP */
> +	if (cap->type == TYPEC_PORT_DRP) {
> +		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +
> +		ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
> +		if (ret == 0) {
> +			ret = typec_find_power_role(cap_str);
> +			if (ret < 0)
> +				return ret;
> +			cap->prefer_role = ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_fw_cap);

thanks,

-- 
heikki
