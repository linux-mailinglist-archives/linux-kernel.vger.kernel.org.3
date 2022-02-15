Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887294B77D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbiBOTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:49:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiBOTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:49:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E3654A4;
        Tue, 15 Feb 2022 11:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B571B81C29;
        Tue, 15 Feb 2022 19:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A009AC340EB;
        Tue, 15 Feb 2022 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644954552;
        bh=zYw4hS76sWSz3mcCSu9xkghn3i2e8FB6UA3DxAMKpYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3EsJVtcy+ECvCWMVO6ueSSdFrQJvog4LylsTgJEYJW5itItAH1LRuM7sZk84qqB+
         j7Bh5NZMGxvHGdSWYxpISKgmFINGCWksom+oUCIocRfa06dNxmbQkNjBGLbJdYyZ6c
         SQewUYnQFq9d57jA4RMSadKxLhQMzawVd2GpYnRwDgo1jtxrOTEGyrKGtD1BoJozE6
         KEl89C0dB/4y07rAkgNddgMf4ipNDd51hTR3nB15YHPp0tiEpdfH6q6o4A4TYKWlVu
         fiRrFOMWOUtwoH0liXuZ2gZxhnJzko6Mq0SlQQdUail3jv63pZIkxIimNbcOWNTHYk
         IG94CkcsvMsVg==
Received: by pali.im (Postfix)
        id 5940BF13; Tue, 15 Feb 2022 20:49:09 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:49:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] hwmon: (dell-smm) Allow for specifying fan control
 method as module parameter
Message-ID: <20220215194909.py62gbsfwe2qxq2i@pali>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-2-W_Armin@gmx.de>
 <20220215191941.azk5gpcn42ahcnna@pali>
 <a450a2b6-92d3-d2cd-db63-b578480ff385@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a450a2b6-92d3-d2cd-db63-b578480ff385@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2022 20:44:20 Armin Wolf wrote:
> Am 15.02.22 um 20:19 schrieb Pali Rohár:
> > On Tuesday 15 February 2022 20:11:07 Armin Wolf wrote:
> > > Right now, the only way to test if setting manual/auto fan control works
> > > is to edit and recompile the module, which may be too cumbersome for
> > > the average user.
> > There is also another way suitable for testing purposes which do not
> > requires any kernel patch. Call iopl(3) syscall which changes I/O
> > privilege level to 3 and which allows to poke I/O registers.
> > 
> This is not possible under kernel lockdown/Secure Boot.

Under Secure Boot it should be still possible.

With kernel lockdown, no kernel testing/debugging at HW level is
acceptable due to security reasons, as it is against what kernel
lockdown should achieve.

> > > Allow for specifying the desired fan mode control method when loading
> > > the module, but taint the kernel if so since there is the possibility
> > > for strange side effects on non-whitelisted models.
> > > Also update docs and kernel-parameters.txt accordingly.
> > > 
> > > Tested on a Dell Inspiron 3505.
> > > 
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   .../admin-guide/kernel-parameters.txt         |  3 +++
> > >   Documentation/hwmon/dell-smm-hwmon.rst        | 21 ++++++++++------
> > >   drivers/hwmon/dell-smm-hwmon.c                | 25 +++++++++++++------
> > >   3 files changed, 35 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index d68053db21cc..4f1b6c2b7ed1 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -968,6 +968,9 @@
> > >   	dell_smm_hwmon.fan_max=
> > >   			[HW] Maximum configurable fan speed.
> > > 
> > > +	dell_smm_hwmon.fan_mode_method=
> > > +			[HW] Method to use for changing fan mode.
> > > +
> > >   	dfltcc=		[HW,S390]
> > >   			Format: { on | off | def_only | inf_only | always }
> > >   			on:       s390 zlib hardware support for compression on
> > > diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> > > index beec88491171..564d99cda869 100644
> > > --- a/Documentation/hwmon/dell-smm-hwmon.rst
> > > +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> > > @@ -67,13 +67,16 @@ for your hardware. It is possible that codes that work for other
> > >   laptops actually work for yours as well, or that you have to discover
> > >   new codes.
> > > 
> > > -Check the list ``i8k_whitelist_fan_control`` in file
> > > -``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
> > > -attempt you can try to add your machine and use an already-known code
> > > -pair. If, after recompiling the kernel, you see that ``pwm1_enable``
> > > -is present and works (i.e., you can manually control the fan speed),
> > > -then please submit your finding as a kernel patch, so that other users
> > > -can benefit from it. Please see
> > > +As a first step, you can load the module with the module parameter
> > > +``fan_mode_method`` set to 1 to test if your hardware works with
> > > +an already know method for disabling automatic BIOS fan control.
> > > +If ``pwm1_enable`` is now present and works (i.e., you can
> > > +manually control the fan speed), then please submit your finding
> > > +as a kernel patch, so that other users can benefit from it.
> > > +Just add your model to the list ``i8k_whitelist_fan_control`` in
> > > +file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
> > > +the already known code pair.
> > > +Please read
> > >   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> > >   for information on submitting patches.
> > > 
> > > @@ -120,6 +123,10 @@ Module parameters
> > >                      Maximum configurable fan speed. (default:
> > >                      autodetect)
> > > 
> > > +* fan_mode_method:uint
> > > +                   Method to use for changing fan mode (default:
> > > +                   from whitelist)
> > > +
> > >   Legacy ``/proc`` interface
> > >   --------------------------
> > > 
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > index 9949eeb79378..1c4cc516c8b2 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -111,6 +111,10 @@ static uint fan_max;
> > >   module_param(fan_max, uint, 0);
> > >   MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (default: autodetect)");
> > > 
> > > +static uint fan_mode_method;
> > > +module_param_unsafe(fan_mode_method, uint, 0);
> > > +MODULE_PARM_DESC(fan_mode_method, "Method to use for changing fan mode (default: from whitelist)");
> > No, please really do not introduce another kernel parameter for this
> > driver. There are already many and we do not need to extend this list.
> > 
> > > +
> > >   struct smm_regs {
> > >   	unsigned int eax;
> > >   	unsigned int ebx;
> > > @@ -677,7 +681,7 @@ static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types
> > > 
> > >   			break;
> > >   		case hwmon_pwm_enable:
> > > -			if (data->auto_fan)
> > > +			if (data->auto_fan && data->manual_fan)
> > >   				/*
> > >   				 * There is no command for retrieve the current status
> > >   				 * from BIOS, and userspace/firmware itself can change
> > > @@ -1282,14 +1286,21 @@ static int __init dell_smm_probe(struct platform_device *pdev)
> > >   	data->i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
> > >   	data->i8k_pwm_mult = DIV_ROUND_UP(255, data->i8k_fan_max);
> > > 
> > > -	fan_control = dmi_first_match(i8k_whitelist_fan_control);
> > > -	if (fan_control && fan_control->driver_data) {
> > > -		const struct i8k_fan_control_data *control = fan_control->driver_data;
> > > +	/* value specified via module param overrides whitelist */
> > > +	if (fan_mode_method > 0 && fan_mode_method <= ARRAY_SIZE(i8k_fan_control_data)) {
> > > +		data->manual_fan = i8k_fan_control_data[fan_mode_method - 1].manual_fan;
> > > +		data->auto_fan = i8k_fan_control_data[fan_mode_method - 1].auto_fan;
> > > +	} else {
> > > +		fan_control = dmi_first_match(i8k_whitelist_fan_control);
> > > +		if (fan_control && fan_control->driver_data) {
> > > +			const struct i8k_fan_control_data *control = fan_control->driver_data;
> > > 
> > > -		data->manual_fan = control->manual_fan;
> > > -		data->auto_fan = control->auto_fan;
> > > -		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan control\n");
> > > +			data->manual_fan = control->manual_fan;
> > > +			data->auto_fan = control->auto_fan;
> > > +		}
> > >   	}
> > > +	if (data->manual_fan && data->auto_fan)
> > > +		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan control\n");
> > > 
> > >   	if (!fan_mult) {
> > >   		/*
> > > --
> > > 2.30.2
> > > 
