Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFC4E2215
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiCUIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiCUIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594F13AA0E;
        Mon, 21 Mar 2022 01:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87EC7B81141;
        Mon, 21 Mar 2022 08:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72016C340E8;
        Mon, 21 Mar 2022 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647850913;
        bh=W7j35n3i7ouQcxLyTwP0bCw1+grg/FGzjCKUso/dVLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ps2bUPVPU2suvW45Df6jEflofLA9ipyAVHmyhz6mrrzwn5ZOC0u3kaXjUvM0VnV0A
         SJqHNeaWuu4NDAEKW+y6ax4aUHPgoepoVm3szvaigNDQw/resQ99+ghSzi/WihBjV3
         lCkPE0jcCykg22Xrseo9BnbSIfoUW+hbSzC2BVds=
Date:   Mon, 21 Mar 2022 09:21:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v7 5/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
Message-ID: <Yjg1nREijopyA+8A@kroah.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
 <20220321081355.6802-6-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321081355.6802-6-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:13:51PM +0700, Quan Nguyen wrote:
> This commit adds driver support for accessing various information
> reported by Ampere's SMpro co-processor such as Boot Progress and
> other miscellaneous data.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

No Documentation/ABI/ entries for your sysfs file?

> +static ssize_t boot_progress_show(struct device *dev, struct device_attribute *da, char *buf)
> +{
> +	struct smpro_misc *misc = dev_get_drvdata(dev);
> +	u32 boot_progress;
> +	u8 current_stage;
> +	u8 boot_status;
> +	u8 boot_stage;
> +	u32 select;
> +	u32 reg_lo;
> +	u32 reg;
> +	int ret;
> +
> +	/* Read current boot stage */
> +	ret = regmap_read(misc->regmap, BOOTSTAGE_CUR_STAGE, &reg);
> +	if (ret)
> +		return ret;
> +
> +	current_stage = reg & 0xff;
> +
> +	/* Read the boot progress */
> +	ret = regmap_read(misc->regmap, BOOTSTAGE_SELECT, &select);
> +	if (ret)
> +		return ret;
> +
> +	boot_stage = (select >> 8) & 0xff;
> +	boot_status = select & 0xff;
> +
> +	if (boot_stage > current_stage)
> +		return -EINVAL;
> +
> +	ret = regmap_read(misc->regmap,	BOOTSTAGE_STATUS_LO, &reg_lo);
> +	if (!ret)
> +		ret = regmap_read(misc->regmap, BOOTSTAGE_STATUS_HI, &reg);
> +	if (ret)
> +		return ret;
> +
> +	boot_progress = swab16(reg) << 16 | swab16(reg_lo);
> +
> +	/* Tell firmware to provide next boot stage next time */
> +	if (boot_stage < current_stage) {
> +		ret = regmap_write(misc->regmap, BOOTSTAGE_SELECT, ((select & 0xff00) | 0x1));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x 0x%02x 0x%08x\n",
> +			boot_stage, boot_status, boot_progress);

sysfs_emit() please.

Also, this is 3 different things, put all of these in different sysfs
files.

thanks,

greg k-h
