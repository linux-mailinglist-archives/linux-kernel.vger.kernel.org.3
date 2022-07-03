Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169056452F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGCFLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGCFLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:11:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1DB844;
        Sat,  2 Jul 2022 22:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Z8g+4ukw2CLthzMM1gq6Od4t4ufeoyAju4zb5s6iGe4=; b=2y6Wu5Zfw8sD7qVm5zg4dZAl6V
        3IZ4ANmVDw3pzNwY42LZFh8dOzpaRrA8ol0PRBjYjTHhF2HFd+16ZlGPgnIKqd73ZzlpCXuW4X2cF
        3km4bzbzrNxisg89oGt90QGrWeeiTR5Hhx0HOMzyIlRkSxdb5BG5uSbw51jHLewXKm6hpEht2QBpg
        K37MrJ0FWYCmmZSIMCf5aEukaFJt7HMseeF9FprMp1bxWgg3rPDrvOONKY9YWvuwoO/WR4p++Ypja
        B+opZD80JPxjFUihPjxcpJLgvOVroWuSWdFg4i7nM+UZFJ1k+dEtgYwyNcJvQcDsRCoXW+k+xmbON
        KN26vw6g==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7rtP-00Dq1q-Je; Sun, 03 Jul 2022 05:11:35 +0000
Message-ID: <01b66305-4dc2-3825-eb59-c0882b662bab@infradead.org>
Date:   Sat, 2 Jul 2022 22:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: |Question] iforce Boeder Force Feedback Wheel
Content-Language: en-US
To:     Greg T <greg.iforce@gmail.com>, linux-kernel@vger.kernel.org
References: <495ce212-addc-8ab1-a851-4fd5f6c5c8d9@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <495ce212-addc-8ab1-a851-4fd5f6c5c8d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add INPUT]

On 7/1/22 03:39, Greg T wrote:
> I'm trying to make a Boeder Force Feedback Wheel work using its serial 
> interface (/dev/ttyS0).
> 
> 1. As iforce-main.c identifies it as "Unknown I-Force Device 
> [%04x:%04x]", I think those placeholders should be replaced by vendor 
> and product ids, but aren't.
> 
> 2. Here's a patch to make it recognized:
> 
> --- drivers/input/joystick/iforce/iforce-main.c.orig	2022-06-14 19:21:30.000000000 +0200
> +++ drivers/input/joystick/iforce/iforce-main.c	2022-06-30 18:52:38.022039742 +0200
> @@ -50,6 +50,7 @@
>  	{ 0x046d, 0xc291, "Logitech WingMan Formula Force",		btn_wheel, abs_wheel, ff_iforce },
>  	{ 0x05ef, 0x020a, "AVB Top Shot Pegasus",			btn_joystick_avb, abs_avb_pegasus, ff_iforce },
>  	{ 0x05ef, 0x8884, "AVB Mag Turbo Force",			btn_wheel, abs_wheel, ff_iforce },
> +	{ 0x05ef, 0x8886, "Boeder Force Feedback Wheel",		btn_wheel, abs_wheel, ff_iforce },
>  	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
> 
> 3. There's a problem that the GAS and BRAKE values (in jstest) start 
> from -32767, not 0, and it causes menus in games like RVGL to 
> malfunction and you have to press the pedal halfway while using a 
> menu with keyboard as a really unpleasant workaround.
> The below patches eliminate that problem, but I'm not sure if it's a 
> kernel or user space problem or just my ignorance. (With its Windows 
> 9x driver, by default, both pedals are on the Y-axis, but move away 
> from 0 in the opposite directions.)
> 
> --- drivers/input/joystick/iforce/iforce-main.c.orig	2022-06-14 19:21:30.000000000 +0200
> +++ drivers/input/joystick/iforce/iforce-main.c	2022-07-01 09:49:58.344970061 +0200
> @@ -350,7 +351,7 @@
>  		case ABS_THROTTLE:
>  		case ABS_GAS:
>  		case ABS_BRAKE:
> -			input_set_abs_params(input_dev, t, 0, 255, 0, 0);
> +			input_set_abs_params(input_dev, t, 0, 511, 0, 0);
>  			break;
>  
>  		case ABS_RUDDER:
> 
> --- drivers/input/joystick/iforce/iforce-packets.c.orig	2022-06-14 19:21:30.000000000 +0200
> +++ drivers/input/joystick/iforce/iforce-packets.c	2022-07-01 09:58:10.061354919 +0200
> @@ -178,8 +178,8 @@
>  	case 0x03:	/* wheel position data */
>  		input_report_abs(dev, ABS_WHEEL,
>  				 (__s16) get_unaligned_le16(data));
> -		input_report_abs(dev, ABS_GAS,   255 - data[2]);
> -		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
> +		input_report_abs(dev, ABS_GAS,   510 - data[2]);
> +		input_report_abs(dev, ABS_BRAKE, 510 - data[3]);
>  
>  		iforce_report_hats_buttons(iforce, data);
>  
> 4. Force feedback seems to work from fftest (at least some of the 
> functions), but when using ff in RVGL or VDrift, the system freezes 
> and I can't find anything related in journalctl after hard resetting. 
> How should I debug this problem?
> 
> It's on Fedora release 34. Kernel/iforce source is from 
> https://gitlab.com/cki-project/kernel-ark/-/tree/fedora-5.17/drivers/input/joystick/iforce
> and the kernel-devel-5.17.12-100.fc34.x86_64 package.

-- 
~Randy
