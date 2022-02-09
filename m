Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0824AF089
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiBIMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiBIL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:58:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40ADE00F7FB;
        Wed,  9 Feb 2022 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407751; x=1675943751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldRegzxx4MqZ33e5eDdwL59Yst9wpfymoOupa1NIuxA=;
  b=HATw4rcPKevZfPRj5edOb8uC7a2YLN52g9j43Dhxyj2pkf7WCE1GWpVo
   T6dcYqwp2xfOoi7R0+3O9rK9oaFuaeumN2DZU7Ia+zX0gH9zaXwOqbkIn
   ORny5tOWjaLqJIogj+uBP08RJKssqXSNFVtbGv1vWRk1rk+nGXI08mAbp
   8DkweR2ENwENUODumpUc9CCPWnWlhgBj949iTEAEt0ddMljMMz/oaSY5s
   NIbPSOTe78opO6rZscWMpcvgGbX3fsStOXK3Id3ZX1xvQnSmk1c5kFnbJ
   RCMEsne6Q1HY1AY8zqlIr18zZ/zDMajrQPK7ADGKzcUnk59DVwAB6XL9a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246771011"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="246771011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678549160"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 03:55:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 13:55:39 +0200
Date:   Wed, 9 Feb 2022 13:55:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] usb: typec: Support the WUSB3801 port controller
Message-ID: <YgOruoTJSybLweNC@kuha.fi.intel.com>
References: <20220202221948.5690-1-samuel@sholland.org>
 <20220202221948.5690-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202221948.5690-5-samuel@sholland.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 04:19:47PM -0600, Samuel Holland wrote:
> WUSB3801 features a configurable port type, accessory detection, and
> plug orientation detection. It provides a hardware "ID" pin output for
> compatibility with USB 2.0 OTG PHYs. Add a typec class driver for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - License the driver as GPL 2 only; probably best anyway as I used a
>    lot of other drivers/usb/typec code as inspiration
>  - Don't try to be clever; use `default` instead of `unreachable`
>  - Free the IRQ before unregistering the partner/port
> 
>  drivers/usb/typec/Kconfig    |  10 +
>  drivers/usb/typec/Makefile   |   1 +
>  drivers/usb/typec/wusb3801.c | 445 +++++++++++++++++++++++++++++++++++
>  3 files changed, 456 insertions(+)
>  create mode 100644 drivers/usb/typec/wusb3801.c

This looked mostly OK to me. One nitpick below.

> +static int wusb3801_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *connector;
> +	unsigned int device_id, test01;
> +	struct wusb3801 *wusb3801;
> +	const char *cap_str;
> +	int ret;
> +
> +	wusb3801 = devm_kzalloc(dev, sizeof(*wusb3801), GFP_KERNEL);
> +	if (!wusb3801)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, wusb3801);
> +
> +	wusb3801->dev = dev;
> +
> +	wusb3801->regmap = devm_regmap_init_i2c(client, &config);
> +	if (IS_ERR(wusb3801->regmap))
> +		return PTR_ERR(wusb3801->regmap);
> +
> +	regmap_read(wusb3801->regmap, WUSB3801_REG_DEVICE_ID, &device_id);
> +	regmap_read(wusb3801->regmap, WUSB3801_REG_TEST01, &test01);
> +	dev_info(dev, "Vendor ID: %ld, Version ID: %ld, Vendor SubID: 0x%02lx\n",
> +		 device_id & WUSB3801_DEVICE_ID_VENDOR_ID,
> +		 (device_id & WUSB3801_DEVICE_ID_VERSION_ID) >> 3,
> +		 test01 & WUSB3801_TEST01_VENDOR_SUB_ID);

That is just noise.

> +	wusb3801->vbus_supply = devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(wusb3801->vbus_supply))
> +		return PTR_ERR(wusb3801->vbus_supply);
> +
> +	connector = device_get_named_child_node(dev, "connector");
> +	if (!connector)
> +		return -ENODEV;
> +
> +	ret = typec_get_fw_cap(&wusb3801->cap, connector);

One note here: Don't use fw_devlink_purge_absent_suppliers() here
either unless you really see some problem yourself!

That function is broken like I said. What ever it's fixing, it's doing
it wrong. That function seems to be just a broken hack that most
likely covered some individual case that was reported at the time.
Instead of hacks like that, we need to figure out a solution for the
core problem, what ever that might be.

> +	if (ret)
> +		goto err_put_connector;
> +	wusb3801->port_type = wusb3801->cap.type;
> +
> +	ret = fwnode_property_read_string(connector, "typec-power-opmode", &cap_str);
> +	if (ret)
> +		goto err_put_connector;
> +
> +	ret = typec_find_pwr_opmode(cap_str);
> +	if (ret < 0 || ret == TYPEC_PWR_MODE_PD)
> +		goto err_put_connector;
> +	wusb3801->pwr_opmode = ret;
> +
> +	/* Initialize the hardware with the devicetree settings. */
> +	ret = wusb3801_hw_init(wusb3801);
> +	if (ret)
> +		return ret;
> +
> +	wusb3801->cap.revision		= USB_TYPEC_REV_1_2;
> +	wusb3801->cap.accessory[0]	= TYPEC_ACCESSORY_AUDIO;
> +	wusb3801->cap.accessory[1]	= TYPEC_ACCESSORY_DEBUG;
> +	wusb3801->cap.orientation_aware	= true;
> +	wusb3801->cap.driver_data	= wusb3801;
> +	wusb3801->cap.ops		= &wusb3801_typec_ops;
> +
> +	wusb3801->port = typec_register_port(dev, &wusb3801->cap);
> +	if (IS_ERR(wusb3801->port)) {
> +		ret = PTR_ERR(wusb3801->port);
> +		goto err_put_connector;
> +	}
> +
> +	/* Initialize the port attributes from the hardware state. */
> +	wusb3801_hw_update(wusb3801);
> +
> +	ret = request_threaded_irq(client->irq, NULL, wusb3801_irq,
> +				   IRQF_ONESHOT, dev_name(dev), wusb3801);
> +	if (ret)
> +		goto err_unregister_port;
> +
> +	fwnode_handle_put(connector);
> +
> +	return 0;
> +
> +err_unregister_port:
> +	typec_unregister_port(wusb3801->port);
> +err_put_connector:
> +	fwnode_handle_put(connector);
> +
> +	return ret;
> +}

thanks,

-- 
heikki
