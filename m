Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752734AF221
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiBIMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBIMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:52:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40CC05CBB4;
        Wed,  9 Feb 2022 04:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644411135; x=1675947135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YN6m3ojQveYXsN0fWhiPObJr9Xint2NRxEikhaXzaVU=;
  b=LhSUeUGF3l1he7GDTqGWhxgxSjuGBbEPsfJqkxW5M5aXqkBK4iY/pV0U
   taeMDCVJP5+v4oUTO4CArNQdahMnDuAdHcuxfmWNYaSDJ0P5EkcJzn2TA
   JYQGyCTvSNssdMzeYsU9I2KIh058wAoMvLI1h38DhKMt+t2wElpfkKT3Z
   9mHnbLt0h8ABjMBVK+0VQcdAE0CDHcuygWPbCM9RbmkJ/ziLdv4PB7yHQ
   N/bwJomkGYUv4HUS0V6+i4ASlWgJWBjl2xiFT4XmiYzLda+3zWYk3vZzb
   pv+8NFSrooDiSCHJ9L+xb+dMpsqtUkao6dJGAhmoBM4rTj76cIZd2SkkX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312491141"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="312491141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678567236"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 04:52:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 14:52:10 +0200
Date:   Wed, 9 Feb 2022 14:52:10 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        will_lin@richtek.com, th_chuang@richtek.com
Subject: Re: [PATCH v3 2/2] usb: typec: rt1719: Add support for Richtek RT1719
Message-ID: <YgO4+mB5xJ5DbX61@kuha.fi.intel.com>
References: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
 <1644246970-18305-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644246970-18305-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, there is still one more problem that I realised - not your
problem, but a problem with fw_devlink_purge_absent_suppliers()...

On Mon, Feb 07, 2022 at 11:16:10PM +0800, cy_huang wrote:
> +static int rt1719_probe(struct i2c_client *i2c)
> +{
> +	struct rt1719_data *data;
> +	struct fwnode_handle *fwnode;
> +	struct typec_capability typec_cap = { };
> +	int ret;
> +
> +	data = devm_kzalloc(&i2c->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = &i2c->dev;
> +	init_completion(&data->req_completion);
> +
> +	data->regmap = devm_regmap_init_i2c(i2c, &rt1719_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rt1719_check_exist(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = rt1719_get_caps(data);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This fwnode has a "compatible" property, but is never populated as a
> +	 * struct device. Instead we simply parse it to read the properties.
> +	 * This it breaks fw_devlink=on. To maintain backward compatibility
> +	 * with existing DT files, we work around this by deleting any
> +	 * fwnode_links to/from this fwnode.
> +	 */
> +	fwnode = device_get_named_child_node(&i2c->dev, "connector");
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	fw_devlink_purge_absent_suppliers(fwnode);

So don't use that function unless you really see some issue that it's
fixing yourself.

That function is broken. It breaks at least if the fwnode is shared -
fwnodes can be, and are, shared - most likely it's broken in
some other ways too. That function seems to be a hack for some
individual problem that was caused by some deeper problem with the
device links.

We really need to figure out a fix for the core problem now instead of
trying to come up with these hacks for every single separate scenario
that is breaking because of the core problem, what ever that core
problem may be.

> +	data->role_sw = fwnode_usb_role_switch_get(fwnode);
> +	if (IS_ERR(data->role_sw)) {
> +		ret = PTR_ERR(data->role_sw);
> +		dev_err(&i2c->dev, "Failed to get usb role switch (%d)\n", ret);
> +		goto err_fwnode_put;
> +	}
> +
> +	ret = devm_rt1719_psy_register(data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to register psy (%d)\n", ret);
> +		goto err_role_put;
> +	}
> +
> +	typec_cap.revision = USB_TYPEC_REV_1_2;
> +	typec_cap.pd_revision = 0x300;	/* USB-PD spec release 3.0 */
> +	typec_cap.type = TYPEC_PORT_SNK;
> +	typec_cap.data = TYPEC_PORT_DRD;
> +	typec_cap.ops = &rt1719_port_ops;
> +	typec_cap.fwnode = fwnode;
> +	typec_cap.driver_data = data;
> +	typec_cap.accessory[0] = TYPEC_ACCESSORY_DEBUG;
> +
> +	data->partner_desc.identity = &data->partner_ident;
> +
> +	data->port = typec_register_port(&i2c->dev, &typec_cap);
> +	if (IS_ERR(data->port)) {
> +		ret = PTR_ERR(data->port);
> +		dev_err(&i2c->dev, "Failed to register typec port (%d)\n", ret);
> +		goto err_role_put;
> +	}
> +
> +	ret = rt1719_init_attach_state(data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init attach state (%d)\n", ret);
> +		goto err_role_put;
> +	}
> +
> +	ret = rt1719_irq_init(data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init irq\n");
> +		goto err_role_put;
> +	}
> +
> +	fwnode_handle_put(fwnode);
> +
> +	i2c_set_clientdata(i2c, data);
> +
> +	return 0;
> +
> +err_role_put:
> +	usb_role_switch_put(data->role_sw);
> +err_fwnode_put:
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
> +}
> +
> +static int rt1719_remove(struct i2c_client *i2c)
> +{
> +	struct rt1719_data *data = i2c_get_clientdata(i2c);
> +
> +	typec_unregister_port(data->port);
> +	usb_role_switch_put(data->role_sw);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused rt1719_device_table[] = {
> +	{ .compatible = "richtek,rt1719", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rt1719_device_table);
> +
> +static struct i2c_driver rt1719_driver = {
> +	.driver = {
> +		.name = "rt1719",
> +		.of_match_table = rt1719_device_table,
> +	},
> +	.probe_new = rt1719_probe,
> +	.remove = rt1719_remove,
> +};
> +module_i2c_driver(rt1719_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT1719 Sink Only USBPD Controller Driver");
> +MODULE_LICENSE("GPL v2");

Oh, you probable want the make that "GPL" instead. See
Documentation/process/license-rules.rst.

thanks,

-- 
heikki
