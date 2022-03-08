Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9954D10B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiCHHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiCHHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:09:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D037A92
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB64B8179E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD64EC340EB;
        Tue,  8 Mar 2022 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646723281;
        bh=806RbM3GSl0lCzZ1Vh8RXqDEQY0njqRzw1M3TDJbdJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbWkLbJN5YaU+/wzIwi1t8uEr+9F0Ep/q+qp10uSiees/swR2uXzT1RVnhI5Q00Ud
         H0ay5vpHFYZ8ixwlmVo32nvmbRPMZnECjiyXkS2m6Jn50/q8XPhkJX+IwjR6xqiltU
         eHImxUp4yKsOHqFZ0CxpUhz2pii0e5HVGcm37hEQ=
Date:   Tue, 8 Mar 2022 08:07:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add power-efuse driver
Message-ID: <YicAzSara5Sr3LQ7@kroah.com>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308011811.10353-3-zev@bewilderbeest.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:18:10PM -0800, Zev Weiss wrote:
> +static DEVICE_ATTR(operstate, 0644, efuse_show_operstate, efuse_set_operstate);

DEVICE_ATTR_RW()?

> +
> +#define EFUSE_ERROR_ATTR(name, bit)							    \
> +	static ssize_t efuse_show_##name(struct device *dev, struct device_attribute *attr, \
> +					 char *buf)                                         \
> +	{                                                                                   \
> +		struct efuse *efuse = dev_get_drvdata(dev);                                 \
> +		int status = efuse_update_error_flags(efuse);                               \
> +		if (status)                                                                 \
> +			return status;                                                      \
> +		return sysfs_emit(buf, "%d\n", !!(efuse->error_flags.cache & bit));         \
> +	}                                                                                   \
> +	static DEVICE_ATTR(name, 0444, efuse_show_##name, NULL)

DEVICE_ATTR_RO()?

> +EFUSE_ERROR_ATTR(under_voltage, REGULATOR_ERROR_UNDER_VOLTAGE);
> +EFUSE_ERROR_ATTR(over_current, REGULATOR_ERROR_OVER_CURRENT);
> +EFUSE_ERROR_ATTR(regulation_out, REGULATOR_ERROR_REGULATION_OUT);
> +EFUSE_ERROR_ATTR(fail, REGULATOR_ERROR_FAIL);
> +EFUSE_ERROR_ATTR(over_temp, REGULATOR_ERROR_OVER_TEMP);
> +EFUSE_ERROR_ATTR(under_voltage_warn, REGULATOR_ERROR_UNDER_VOLTAGE_WARN);
> +EFUSE_ERROR_ATTR(over_current_warn, REGULATOR_ERROR_OVER_CURRENT_WARN);
> +EFUSE_ERROR_ATTR(over_voltage_warn, REGULATOR_ERROR_OVER_VOLTAGE_WARN);
> +EFUSE_ERROR_ATTR(over_temp_warn, REGULATOR_ERROR_OVER_TEMP_WARN);
> +
> +static struct attribute *efuse_attrs[] = {
> +	&dev_attr_operstate.attr,
> +	&dev_attr_under_voltage.attr,
> +	&dev_attr_over_current.attr,
> +	&dev_attr_regulation_out.attr,
> +	&dev_attr_fail.attr,
> +	&dev_attr_over_temp.attr,
> +	&dev_attr_under_voltage_warn.attr,
> +	&dev_attr_over_current_warn.attr,
> +	&dev_attr_over_voltage_warn.attr,
> +	&dev_attr_over_temp_warn.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(efuse);

Shouldn't these all just be what all regulator drivers report?  Or power
drivers?  I find it odd that this would be the first driver that would
need to export these types of attributes.  Surely there's already a
class for this?

thanks,

greg k-h
