Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3D4E23E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiCUKEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbiCUKEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD1147AF9;
        Mon, 21 Mar 2022 03:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B3761251;
        Mon, 21 Mar 2022 10:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5453C340E8;
        Mon, 21 Mar 2022 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647856962;
        bh=UllJSsQg00ZnHBhZbERtaYlT/9n0riP5truM20tn4m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoLl+mAzwgOEykMATfNyoxYBOKibroqamcG5UXr/BkdtaN6MJsyURn0LlXVPh1pkC
         eJBQmPnsq6Vho1bFHdNRtszlvkLzb5zQo87nWhZ+Tviokbyy5AeabDIXpSnfx+eJFl
         u+kmU+dMw8zx/goRqkmi1Lopj2mkS+vswrIQaVlY=
Date:   Mon, 21 Mar 2022 11:02:39 +0100
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
Message-ID: <YjhNP+Jzn/z4+5Zw@kroah.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
 <20220321081355.6802-6-quan@os.amperecomputing.com>
 <Yjg1nREijopyA+8A@kroah.com>
 <e9f92650-4f7c-260d-8aa2-92d1c84bf74a@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f92650-4f7c-260d-8aa2-92d1c84bf74a@os.amperecomputing.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:46:50PM +0700, Quan Nguyen wrote:
> 
> 
> On 21/03/2022 15:21, Greg Kroah-Hartman wrote:
> > On Mon, Mar 21, 2022 at 03:13:51PM +0700, Quan Nguyen wrote:
> > > This commit adds driver support for accessing various information
> > > reported by Ampere's SMpro co-processor such as Boot Progress and
> > > other miscellaneous data.
> > > 
> > > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > 
> > No Documentation/ABI/ entries for your sysfs file?
> > 
> 
> Thank you, Greg, for a very quick review.
> I have put this file in other patch.
> 
> > > +static ssize_t boot_progress_show(struct device *dev, struct device_attribute *da, char *buf)
> > > +{
> > > +	struct smpro_misc *misc = dev_get_drvdata(dev);
> > > +	u32 boot_progress;
> > > +	u8 current_stage;
> > > +	u8 boot_status;
> > > +	u8 boot_stage;
> > > +	u32 select;
> > > +	u32 reg_lo;
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	/* Read current boot stage */
> > > +	ret = regmap_read(misc->regmap, BOOTSTAGE_CUR_STAGE, &reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	current_stage = reg & 0xff;
> > > +
> > > +	/* Read the boot progress */
> > > +	ret = regmap_read(misc->regmap, BOOTSTAGE_SELECT, &select);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	boot_stage = (select >> 8) & 0xff;
> > > +	boot_status = select & 0xff;
> > > +
> > > +	if (boot_stage > current_stage)
> > > +		return -EINVAL;
> > > +
> > > +	ret = regmap_read(misc->regmap,	BOOTSTAGE_STATUS_LO, &reg_lo);
> > > +	if (!ret)
> > > +		ret = regmap_read(misc->regmap, BOOTSTAGE_STATUS_HI, &reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	boot_progress = swab16(reg) << 16 | swab16(reg_lo);
> > > +
> > > +	/* Tell firmware to provide next boot stage next time */
> > > +	if (boot_stage < current_stage) {
> > > +		ret = regmap_write(misc->regmap, BOOTSTAGE_SELECT, ((select & 0xff00) | 0x1));
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return snprintf(buf, PAGE_SIZE, "0x%02x 0x%02x 0x%08x\n",
> > > +			boot_stage, boot_status, boot_progress);
> > 
> > sysfs_emit() please.
> > 
> Thanks, Greg.
> 
> Will switch to sysfs_emit() in my next version.
> 
> > Also, this is 3 different things, put all of these in different sysfs
> > files.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Actually, no. It is single value of boot stage.

You are displaying 3 things in a single line, those are 3 different
things.

> Let me explain:
> The boot progress consists of three things together: boot_stage, boot_status
> and boot_progress and they have no meaning if reported them as three
> separate values:
> + boot_stage is to indicate the boot stage
> + boot_status is to report the result of that boot_stage: started, complete
> or error.
> + boot_progress is to report more extra information for the stage other than
> the boot_stage/boot_status.

Why are these just not 3 different files?  They describe three different
things, please do not EVER force userspace to parse a sysfs file other
than a single value.

thanks,

greg k-h
