Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58944E2AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiCUOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349355AbiCUO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:29:59 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7557B1F;
        Mon, 21 Mar 2022 07:25:23 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 8C7C7C8008A;
        Mon, 21 Mar 2022 15:25:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AKq31pyT3rN5; Mon, 21 Mar 2022 15:25:21 +0100 (CET)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id EE73FC80080;
        Mon, 21 Mar 2022 15:25:20 +0100 (CET)
Message-ID: <e8fa9e33-f8af-d449-b357-6c6f310329ad@tuxedocomputers.com>
Date:   Mon, 21 Mar 2022 15:25:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] Input/i8042: Merge quirk tables
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308170523.783284-1-wse@tuxedocomputers.com>
 <20220308170523.783284-2-wse@tuxedocomputers.com>
 <e84d98e6-541d-8cc7-626e-f92d76230528@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <e84d98e6-541d-8cc7-626e-f92d76230528@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 09.03.22 um 18:16 schrieb Hans de Goede:
> Hi,
>
> On 3/8/22 18:05, Werner Sembach wrote:
>> Merge i8042 quirk tables to reduce code duplication for devices that need
>> more than one quirk.
>>
>> Also align quirkable options with command line parameters and make vendor
>> wide quirks per device overwriteable on a per device basis.
>>
>> Some duplication on the ASUS devices is required to mirror the exact
>> behaviour of the previous code.
> Can you explain this a bit more ?
Yes, see next patch
>
>
>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/input/serio/i8042-x86ia64io.h | 1125 ++++++++++++++-----------
>>  1 file changed, 640 insertions(+), 485 deletions(-)
>>
>> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
>> index 148a7c5fd0e2..689b9ee3e742 100644
>> --- a/drivers/input/serio/i8042-x86ia64io.h
>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>> @@ -67,675 +67,821 @@ static inline void i8042_write_command(int val)
>>  
>>  #include <linux/dmi.h>
>>  
>> -static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>> +#define SERIO_QUIRK_NOKBD		BIT(0)
>> +#define SERIO_QUIRK_NOAUX		BIT(1)
>> +#define SERIO_QUIRK_NOMUX		BIT(2)
>> +#define SERIO_QUIRK_FORCEMUX		BIT(3)
>> +#define SERIO_QUIRK_UNLOCK		BIT(4)
>> +#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
>> +#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
>> +#define SERIO_QUIRK_RESET_NEVER		BIT(7)
>> +#define SERIO_QUIRK_DIECT		BIT(8)
>> +#define SERIO_QUIRK_DUMBKBD		BIT(9)
>> +#define SERIO_QUIRK_NOLOOP		BIT(10)
>> +#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
>> +#define SERIO_QUIRK_KBDRESET		BIT(12)
>> +#define SERIO_QUIRK_DRITEK		BIT(13)
>> +#define SERIO_QUIRK_NOPNP		BIT(14)
>> +
>> +/* Quirk table for different mainboards. Options similar or identical to i8042
>> + * module parameters.
>> + * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
>> + * This allows entries to overwrite vendor wide quirks on a per device basis.
>> + * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
>> + * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
>> + */
>> +static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
> <snip>
>
>> @@ -1167,11 +1307,6 @@ static int __init i8042_pnp_init(void)
>>  	bool pnp_data_busted = false;
>>  	int err;
>>  
>> -#ifdef CONFIG_X86
>> -	if (dmi_check_system(i8042_dmi_nopnp_table))
>> -		i8042_nopnp = true;
>> -#endif
>> -
>>  	if (i8042_nopnp) {
>>  		pr_info("PNP detection disabled\n");
>>  		return 0;
> have you checked that i8042_platform_init() *always*
> gets called before i8042_pnp_init()?
As far as i can tell i8042_pnp_init() is only ever called inside i8042_platform_init() so moving this check from pnp
init to platform init should be no problem.
>
> Maybe just add something like this:
>
> #ifdef CONFIG_X86
> static void __init i8042_check_quirks(void)
> {
> 	const struct dmi_system_id *device_quirk_info;
> 	uintptr_t quirks;
>
> 	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
> 	if (!device_quirk_info)
> 		return;
>
> 	quirks = (uintptr_t)device_quirk_info->driver_data;
>
> 	if (i8042_reset == I8042_RESET_DEFAULT) {
> 		if (quirks & SERIO_QUIRK_RESET)
> 			i8042_reset = I8042_RESET_ALWAYS;
> 		if (quirks & SERIO_QUIRK_NOSELFTEST)
> 			i8042_reset = I8042_RESET_NEVER;
> 	}
>
> 	/* Do more quirk checks */
> }
> #else
> static inline void i8042_check_quirks(void) {}
> #endif
>
> (above the declaration of i8042_pnp_init())
>
> And call i8042_check_quirks() in both
> i8042_platform_init() and i8042_platform_init() ?
>
> This also abstracts some of the CONFIG_X86
> ifdef-ery out of the other functions.
>
>
>> @@ -1277,6 +1412,9 @@ static inline void i8042_pnp_exit(void) { }
>>  
>>  static int __init i8042_platform_init(void)
>>  {
>> +	bool i8042_reset_always_quirk = false;
>> +	bool i8042_reset_never_quirk = false;
> I'm not a fan of these 2 helper variables, you can do this directly,
> see above.
>
>> +	const struct dmi_system_id *device_quirk_info;
> All 3 these variables will trigger unused variable
> settings when compiling without CONFIG_X86 set. Note
> introducing the i8042_check_quirks() helper as I suggest
> above avoids this without needing more #ifdef-ery.

Fixed by moving it to its own function as you suggested.

My original reasoning for the helper variables was that i didn't want to move the i8042_reset evaluation, but then did
it anyways in the next patch after checking that pnp_init doesn't use the variable.

>
>>  	int retval;
>>  
>>  #ifdef CONFIG_X86
>> @@ -1297,6 +1435,44 @@ static int __init i8042_platform_init(void)
>>  	i8042_kbd_irq = I8042_MAP_IRQ(1);
>>  	i8042_aux_irq = I8042_MAP_IRQ(12);
>>  
>> +#ifdef CONFIG_X86
>> +	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
>> +	if (device_quirk_info) {
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOKBD)
>> +			i8042_nokbd = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOAUX)
>> +			i8042_noaux = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOMUX)
>> +			i8042_nomux = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_FORCEMUX)
>> +			i8042_nomux = false;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_UNLOCK)
>> +			i8042_unlock = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_PROBE_DEFER)
>> +			i8042_probe_defer = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_ALWAYS)
>> +			i8042_reset_always_quirk = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_NEVER)
>> +			i8042_reset_never_quirk = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DIECT)
>> +			i8042_direct = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DUMBKBD)
>> +			i8042_dumbkbd = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOLOOP)
>> +			i8042_noloop = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOTIMEOUT)
>> +			i8042_notimeout = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_KBDRESET)
>> +			i8042_kbdreset = true;
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DRITEK)
>> +			i8042_dritek = true;
>> +#ifdef CONFIG_PNP
>> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOPNP)
>> +			i8042_nopnp = true;
>> +#endif
>> +	}
>> +#endif
>> +
>>  	retval = i8042_pnp_init();
>>  	if (retval)
>>  		return retval;
>> @@ -1308,34 +1484,13 @@ static int __init i8042_platform_init(void)
>>  #ifdef CONFIG_X86
>>  	/* Honor module parameter when value is not default */
>>  	if (i8042_reset == I8042_RESET_DEFAULT) {
>> -		if (dmi_check_system(i8042_dmi_reset_table))
>> +		if (i8042_reset_always_quirk)
>>  			i8042_reset = I8042_RESET_ALWAYS;
>>  
>> -		if (dmi_check_system(i8042_dmi_noselftest_table))
>> +		if (i8042_reset_never_quirk)
>>  			i8042_reset = I8042_RESET_NEVER;
>>  	}
>>  
>> -	if (dmi_check_system(i8042_dmi_noloop_table))
>> -		i8042_noloop = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_nomux_table))
>> -		i8042_nomux = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_forcemux_table))
>> -		i8042_nomux = false;
>> -
>> -	if (dmi_check_system(i8042_dmi_notimeout_table))
>> -		i8042_notimeout = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_dritek_table))
>> -		i8042_dritek = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_kbdreset_table))
>> -		i8042_kbdreset = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_probe_defer_table))
>> -		i8042_probe_defer = true;
>> -
>>  	/*
>>  	 * A20 was already enabled during early kernel init. But some buggy
>>  	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
> Regards,
>
> Hans
>
>
Regards,

Werner

