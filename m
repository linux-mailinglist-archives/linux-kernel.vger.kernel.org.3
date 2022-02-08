Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33554AD3F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbiBHIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbiBHIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FCC03FEC0;
        Tue,  8 Feb 2022 00:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F2661309;
        Tue,  8 Feb 2022 08:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE671C004E1;
        Tue,  8 Feb 2022 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644310267;
        bh=LF21Pve9wnpG/No0P1OZHAk/VrRqWJcQttpv2IYdL1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbADg1SI8fGdpeBVaFt3AEOknG01qJNSGYgx0juGBF/bdr/s0r+VJS3R7dWc4Q2TL
         kJjGHycLQQ0uCcYRfYJYJMduTiPFLb+6+t6vTr6uC+q1bgBetUADfyjuBZWHc1PanZ
         H9fqaZYQVKxRGAA9mnoLO8H41Ioya59f8DXbSYHs=
Date:   Tue, 8 Feb 2022 09:51:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
Message-ID: <YgIu+Lrt0p85yog1@kroah.com>
References: <20220206022023.376142-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206022023.376142-1-andrew.smirnov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 06:20:23PM -0800, Andrey Smirnov wrote:
> +#define STEAMDECK_ATTR_RO(_name, _method)				\
> +	static ssize_t _name##_show(struct device *dev,			\
> +				    struct device_attribute *attr,	\
> +				    char *buf)				\
> +	{								\
> +		struct steamdeck *jup = dev_get_drvdata(dev);		\
> +		unsigned long long val;					\
> +									\
> +		if (ACPI_FAILURE(acpi_evaluate_integer(			\
> +					 jup->adev->handle,		\
> +					 _method, NULL, &val)))		\
> +			return -EIO;					\
> +									\
> +		return sprintf(buf, "%llu\n", val);			\

Please use sysfs_emit() for this and any other sysfs show functions.

Also, you have no Documenation/ABI/ entries for all of these new sysfs
files you are creating.  How do we know what these entries are for, and
what they contain?  Please add that in future versions of this commit,
as-is we can't take this :(


> +	}								\
> +	static DEVICE_ATTR_RO(_name)
> +
> +STEAMDECK_ATTR_RO(firmware_version, "PDFW");
> +STEAMDECK_ATTR_RO(board_id, "BOID");
> +STEAMDECK_ATTR_RO(pdcs, "PDCS");
> +
> +static umode_t
> +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int index)
> +{
> +	return attr->mode;
> +}

As Guenter pointed out, this is not needed.


> +
> +static struct attribute *steamdeck_attributes[] = {
> +	&dev_attr_target_cpu_temp.attr,
> +	&dev_attr_gain.attr,
> +	&dev_attr_ramp_rate.attr,
> +	&dev_attr_hysteresis.attr,
> +	&dev_attr_maximum_battery_charge_rate.attr,
> +	&dev_attr_recalculate.attr,
> +	&dev_attr_power_cycle_display.attr,
> +
> +	&dev_attr_led_brightness.attr,
> +	&dev_attr_content_adaptive_brightness.attr,
> +	&dev_attr_gamma_set.attr,
> +	&dev_attr_display_brightness.attr,
> +	&dev_attr_ctrl_display.attr,
> +	&dev_attr_cabc_minimum_brightness.attr,
> +	&dev_attr_memory_data_access_control.attr,
> +
> +	&dev_attr_display_normal_mode_on.attr,
> +	&dev_attr_display_inversion_off.attr,
> +	&dev_attr_display_inversion_on.attr,
> +	&dev_attr_idle_mode_on.attr,
> +
> +	&dev_attr_firmware_version.attr,
> +	&dev_attr_board_id.attr,
> +	&dev_attr_pdcs.attr,
> +
> +	NULL
> +};
> +
> +static const struct attribute_group steamdeck_group = {
> +	.attrs = steamdeck_attributes,
> +	.is_visible = steamdeck_is_visible,
> +};
> +
> +static const struct attribute_group *steamdeck_groups[] = {
> +	&steamdeck_group,
> +	NULL
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
