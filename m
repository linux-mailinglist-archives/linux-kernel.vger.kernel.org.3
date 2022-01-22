Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02785496C62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiAVMjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:39:05 -0500
Received: from server.atrad.com.au ([150.101.241.2]:41382 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiAVMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:39:04 -0500
X-Greylist: delayed 1781 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2022 07:39:02 EST
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20MC7UKQ032381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 22 Jan 2022 22:37:32 +1030
Date:   Sat, 22 Jan 2022 22:37:30 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Herton Ronaldo Krzesinski <herton@canonical.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH 20/31] platform: x86: changing LED_* from enum
 led_brightness to actual value
Message-ID: <20220122120730.GA12371@marvin.atrad.com.au>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-21-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-21-sampaio.ime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:25PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.
> ---
>  drivers/platform/x86/acer-wmi.c          |  6 ++---
>  drivers/platform/x86/asus-wireless.c     |  6 ++---
>  drivers/platform/x86/dell/dell-laptop.c  |  2 +-
>  drivers/platform/x86/dell/dell-wmi-led.c |  4 ++--
>  drivers/platform/x86/fujitsu-laptop.c    | 28 ++++++++++++------------
>  drivers/platform/x86/lg-laptop.c         | 18 +++++++--------
>  drivers/platform/x86/system76_acpi.c     |  4 ++--
>  drivers/platform/x86/thinkpad_acpi.c     | 14 ++++++------
>  drivers/platform/x86/topstar-laptop.c    |  4 ++--
>  drivers/platform/x86/toshiba_acpi.c      | 24 ++++++++++----------
>  10 files changed, 55 insertions(+), 55 deletions(-)
> 
> ...
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 80929380ec7e..6ebfda771209 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -584,10 +584,10 @@ static int logolamp_set(struct led_classdev *cdev,
>  	int poweron = FUNC_LED_ON, always = FUNC_LED_ON;
>  	int ret;
>  
> -	if (brightness < LED_HALF)
> +	if (brightness < 127)
>  		poweron = FUNC_LED_OFF;
>  
> -	if (brightness < LED_FULL)
> +	if (brightness < 255)
>  		always = FUNC_LED_OFF;
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_POWERON, poweron);
> @@ -604,13 +604,13 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_ALWAYS, 0x0);
>  	if (ret == FUNC_LED_ON)
> -		return LED_FULL;
> +		return 255;
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_POWERON, 0x0);
>  	if (ret == FUNC_LED_ON)
> -		return LED_HALF;
> +		return 127;
>  
> -	return LED_OFF;
> +	return 0;
>  }
>  
>  static int kblamps_set(struct led_classdev *cdev,
> @@ -618,7 +618,7 @@ static int kblamps_set(struct led_classdev *cdev,
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
>  
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
>  				      FUNC_LED_ON);
>  	else
> @@ -629,11 +629,11 @@ static int kblamps_set(struct led_classdev *cdev,
>  static enum led_brightness kblamps_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device,
>  			   FUNC_LEDS, 0x2, KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }
> @@ -643,7 +643,7 @@ static int radio_led_set(struct led_classdev *cdev,
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
>  
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
>  				      RADIO_LED_ON);
>  	else
> @@ -654,10 +654,10 @@ static int radio_led_set(struct led_classdev *cdev,
>  static enum led_brightness radio_led_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }
> @@ -669,7 +669,7 @@ static int eco_led_set(struct led_classdev *cdev,
>  	int curr;
>  
>  	curr = call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0);
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
>  				      curr | ECO_LED_ON);
>  	else
> @@ -680,10 +680,10 @@ static int eco_led_set(struct led_classdev *cdev,
>  static enum led_brightness eco_led_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }

In a way it's less descriptive to revert from the identifiers to what amount
to seemingly magic numbers.  However, since the value attributed to maximum
LED brightness in the LED class is now variable I can see why the global
enum no longer makes sense.  We could define a suitable enum within
fujitsu-laptop.c, but there's probably little to be gained in the long run.

To make the patch description a little clearer, could I suggest you add the
word "variable" before "max_brightness", or even just use the phrase
"variable maximum brightness"?

For the fujitsu-laptop.c portion of this patch:
    Acked-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan
