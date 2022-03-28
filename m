Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3424E9BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiC1P7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiC1P7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:59:32 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8744F5E163;
        Mon, 28 Mar 2022 08:57:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 7EBBAC80082;
        Mon, 28 Mar 2022 17:57:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id NG8Sca-FmaOl; Mon, 28 Mar 2022 17:57:46 +0200 (CEST)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id CF2BFC80080;
        Mon, 28 Mar 2022 17:57:45 +0200 (CEST)
Message-ID: <298eb9f7-50d4-121c-1674-1ad8730ae995@tuxedocomputers.com>
Date:   Mon, 28 Mar 2022 17:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/4] input/i8042: Merge quirk tables
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
 <20220322162125.59838-3-wse@tuxedocomputers.com>
 <c8b3158a-d48d-9abd-d651-5a982609166e@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <c8b3158a-d48d-9abd-d651-5a982609166e@redhat.com>
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


Am 28.03.22 um 14:02 schrieb Hans de Goede:
> Hi,
>
> On 3/22/22 17:21, Werner Sembach wrote:
>> Merge i8042 quirk tables to reduce code duplication for devices that need
>> more than one quirk. Before every quirk had its own table with devices
>> needing that quirk. If a new quirk needed to be added a new table had to
>> be created. When a device needed multiple quirks, it appeared in multiple
>> tables. Now only one table called i8042_dmi_quirk_table exists. In it every
>> device has one entry and required quirks are coded in the .driver_data
>> field of the struct dmi_system_id used by this table. Multiple quirks for
>> one device can be applied by bitwise-and of the new SERIO_QUIRK_* defines.
> that should be bitwise-or, at least when setting the quirks, testing
> them happens by bitwise-and. But to me applying here describes the setting
> of the quirks in the table, so bitwise-or.
Yes, ofc, I somehow blanked out when writing that sentence.
>
>> Also align quirkable options with command line parameters and make vendor
>> wide quirks per device overwriteable on a per device basis. The first match
>> is honored while following matches are ignored. So when a vendor wide quirk
>> is defined in the table, a device can inserted before and therefore
>> ignoring the vendor wide define.
>>
>> Some duplication on the ASUS devices is required to mirror the exact
>> behaviour of the previous code. All "ASUSTeK COMPUTER INC" devices of
>> chassis type 10 and 31 got the "reset never" quirk. In other tables some
>> ASUS devices got other quirks. With everything being one table now, vendor
>> wide quirks are still possible, but when a device is included explicitly,
>> it will ignore all vendor wide quirks and needs to explicitly include them
>> again. Not knowing which "ASUSTeK COMPUTER INC" devices are of chassis type
>> 10 or 31, there now exists three entries for each of them: One matching
>> chassis type 10, one matching, chassis type 31, and one matching the rest.
>> The quirks are set accordingly to mirror the previous behaviour.
> Ah, I see. There is a database of DMI dumps from people who have run
> the hwprobe util on their Linux machine here:
>
> https://github.com/linuxhw/DMI/
>
> Looking at the DMI table after your patch the following 4 Asus models
> now have 3 entries per model because of this: X750LN, X450LCP,
> ZenBook UX425UA, ZenBook UX325UA_UM325UA:
>
> X750LN: https://github.com/linuxhw/DMI/blob/master/Notebook/ASUSTek%20Computer/X750/X750LN/1E1B975B9B01
> Chassis Type: "Desktop", so "3" iow not 10 or 31 so we want just
> SERIO_QUIRK_NOLOOP for this one. Also note that the no chassis-type-match
> entry for this is wrong, you kept SERIO_QUIRK_RESET_NEVER there instead
> of SERIO_QUIRK_NOLOOP.
>
> X450LCP: https://github.com/linuxhw/DMI/blob/master/Notebook/ASUSTek%20Computer/X450/X450LCP/24D04D5FCB2F
> Chassis Type: "Notebook", so "10", so want to have:
> (SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER) for this one.
>
> UX425UA: https://github.com/linuxhw/DMI/blob/master/Notebook/ASUSTek%20Computer/ZenBook/ZenBook%20UX425UA_UM425UA/C70168C3DFC7
> Note the "Product Name" is not an exact match here, but with a DMI_MATCH of the beginnings
> of the strings match that counts as a match, so this is actually a match.
> Chassis Type: "Notebook", so "10", so want to have:
> (SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER) for this one.
>
> UX325UA: https://github.com/linuxhw/DMI/blob/master/Notebook/ASUSTek%20Computer/ZenBook/ZenBook%20UX325UA_UM325UA/C52AA8CE00C7
> Chassis Type: "Notebook", so "10", so want to have:
> (SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER) for this one.
>
> So with this figured out, there no longer is a need for the 3 entries
> per model thing and you can also drop this paragraph from
> the commit msg.
Thanks for this reference. Directly bookmarking it for the future.
>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/input/serio/i8042-x86ia64io.h | 1149 ++++++++++++++-----------
>>  1 file changed, 656 insertions(+), 493 deletions(-)
>>
>> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
>> index 91c6f24b4837..dbfbd6a2763a 100644
>> --- a/drivers/input/serio/i8042-x86ia64io.h
>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>> @@ -67,951 +67,1091 @@ static inline void i8042_write_command(int val)
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
>>  	{
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
>> @@ -1275,6 +1410,62 @@ static inline int i8042_pnp_init(void) { return 0; }
>>  static inline void i8042_pnp_exit(void) { }
>>  #endif /* CONFIG_PNP */
>>  
>> +
>> +#ifdef CONFIG_X86
>> +static void __init i8042_check_quirks(void)
>> +{
>> +	const struct dmi_system_id *device_quirk_info;
>> +	uintptr_t quirks;
>> +
>> +	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
>> +	if (!device_quirk_info)
>> +		return;
>> +
>> +	quirks = (uintptr_t)device_quirk_info->driver_data;
>> +
>> +	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
> This line is duplicated from above and can be dropped.
Copy paste error, thanks for spotting it
>
>> +	if (device_quirk_info) {
> You already do:
>
> 	if (!device_quirk_info)
> 		return;
>
> Above so this if can be dropped and the code block below can
> be un-indented 1 step.
Also copy paste related without rethinking according to the new position in code.
>
>> +		if (quirks & SERIO_QUIRK_NOKBD)
>> +			i8042_nokbd = true;
>> +		if (quirks & SERIO_QUIRK_NOAUX)
>> +			i8042_noaux = true;
>> +		if (quirks & SERIO_QUIRK_NOMUX)
>> +			i8042_nomux = true;
>> +		if (quirks & SERIO_QUIRK_FORCEMUX)
>> +			i8042_nomux = false;
>> +		if (quirks & SERIO_QUIRK_UNLOCK)
>> +			i8042_unlock = true;
>> +		if (quirks & SERIO_QUIRK_PROBE_DEFER)
>> +			i8042_probe_defer = true;
>> +		/* Honor module parameter when value is not default */
>> +		if (i8042_reset == I8042_RESET_DEFAULT) {
>> +			if (quirks & SERIO_QUIRK_RESET_ALWAYS)
>> +				i8042_reset = I8042_RESET_ALWAYS;
>> +			if (quirks & SERIO_QUIRK_RESET_NEVER)
>> +				i8042_reset = I8042_RESET_NEVER;
>> +		}
>> +		if (quirks & SERIO_QUIRK_DIECT)
>> +			i8042_direct = true;
>> +		if (quirks & SERIO_QUIRK_DUMBKBD)
>> +			i8042_dumbkbd = true;
>> +		if (quirks & SERIO_QUIRK_NOLOOP)
>> +			i8042_noloop = true;
>> +		if (quirks & SERIO_QUIRK_NOTIMEOUT)
>> +			i8042_notimeout = true;
>> +		if (quirks & SERIO_QUIRK_KBDRESET)
>> +			i8042_kbdreset = true;
>> +		if (quirks & SERIO_QUIRK_DRITEK)
>> +			i8042_dritek = true;
>> +#ifdef CONFIG_PNP
>> +		if (quirks & SERIO_QUIRK_NOPNP)
>> +			i8042_nopnp = true;
>> +#endif
>> +	}
>> +}
>> +#else
>> +static inline void i8042_check_quirks(void) {}
>> +#endif
>> +
>>  static int __init i8042_platform_init(void)
>>  {
>>  	int retval;
>> @@ -1297,45 +1488,17 @@ static int __init i8042_platform_init(void)
>>  	i8042_kbd_irq = I8042_MAP_IRQ(1);
>>  	i8042_aux_irq = I8042_MAP_IRQ(12);
>>  
>> -	retval = i8042_pnp_init();
>> -	if (retval)
>> -		return retval;
>> -
>>  #if defined(__ia64__)
>> -        i8042_reset = I8042_RESET_ALWAYS;
>> +	i8042_reset = I8042_RESET_ALWAYS;
>>  #endif
>>  
>> -#ifdef CONFIG_X86
>> -	/* Honor module parameter when value is not default */
>> -	if (i8042_reset == I8042_RESET_DEFAULT) {
>> -		if (dmi_check_system(i8042_dmi_reset_table))
>> -			i8042_reset = I8042_RESET_ALWAYS;
>> -
>> -		if (dmi_check_system(i8042_dmi_noselftest_table))
>> -			i8042_reset = I8042_RESET_NEVER;
>> -	}
>> -
>> -	if (dmi_check_system(i8042_dmi_noloop_table))
>> -		i8042_noloop = true;
>> -
>> -	if (dmi_check_system(i8042_dmi_nomux_table))
>> -		i8042_nomux = true;
>> +	i8042_check_quirks();
>>  
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
>> +	retval = i8042_pnp_init();
>> +	if (retval)
>> +		return retval;
>>  
>> +#ifdef CONFIG_X86
>>  	/*
>>  	 * A20 was already enabled during early kernel init. But some buggy
>>  	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
>
> Other then the above remarks this looks good to me.
>
> Regards,
>
> Hans
>
Thanks for your feedback, i will code up revision 5

Kind Regards,

Werner Sembach

