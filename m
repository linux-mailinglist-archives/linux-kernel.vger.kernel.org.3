Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769A4EB532
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiC2VZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:25:24 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD17DA6EB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:23:30 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E8FE52C447
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:23:29 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZJJJnGrQpdx86ZJJJnr5cf; Tue, 29 Mar 2022 16:23:29 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Eqja+35AiPaP+/froXDclBXcF+k2P0sqhy4p54XlVe4=; b=rmcO17oKEJ+V9lI3q4opF07fOS
        ZruzAcE7TEm+eG6MX1mIfI2tiXXYah4gggv9FtOFLc4y6SEz1uJyx5JkGZy7vQAkkxyfvZ5vK6mu1
        pB+hlW4gZevmDIX7PaofCRBrjan+3f0vU4Fcai3rIPANgZ6k7dP/6qVMpnSAETS4fJDLM/4j0HVA4
        pZ2mhgnQGYpdMUqM/pJlWLQqFvg6D5HaAV6p0UD+vBkGcB7tgVMryIuevojFp8KEFXYdq0+s76BpJ
        wTmQOMEuMR2eBBUUr6IOC9Lt1T44ySPXACzUnRgSqX5BNpnNYr2A3gO0cmMXhRK4ad6nqgRyVV32f
        xV54zH/A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54546)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZJJJ-003tpO-Il; Tue, 29 Mar 2022 21:23:29 +0000
Message-ID: <df43bce6-b1bc-1abc-307b-878ee7acb261@roeck-us.net>
Date:   Tue, 29 Mar 2022 14:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
In-Reply-To: <20220327121404.1702631-3-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nZJJJ-003tpO-Il
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54546
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 05:14, Eugene Shalygin wrote:
> For some board models ASUS uses the global ACPI lock to guard access to
> the hardware, so do we.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>   drivers/hwmon/asus-ec-sensors.c | 143 +++++++++++++++++++++++++-------
>   1 file changed, 115 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 7e28fc62f717..34841eeb800f 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -56,6 +56,9 @@ static char *mutex_path_override;
>   
>   #define MAX_IDENTICAL_BOARD_VARIATIONS	2
>   
> +/* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
> +#define ACPI_GLOBAL_LOCK_PSEUDO_PATH	":GLOBAL_LOCK"
> +

That needs to be documented.

>   typedef union {
>   	u32 value;
>   	struct {
> @@ -166,6 +169,14 @@ static const struct ec_sensor_info known_ec_sensors[] = {
>   struct ec_board_info {
>   	const char *board_names[MAX_IDENTICAL_BOARD_VARIATIONS];
>   	unsigned long sensors;
> +	/*
> +	 * Defines which mutex to use for guarding access to the state and the
> +	 * hardware. Can be either a full path to an AML mutex or the
> +	 * pseudo-path ACPI_GLOBAL_LOCK_PSEUDO_PATH to use the global ACPI lock,
> +	 * or left empty to use a regular mutex object, in which case access to
> +	 * the hardware is not guarded.
> +	 */
> +	const char *mutex_path;
>   };
>   
>   static const struct ec_board_info board_info[] __initconst = {
> @@ -173,12 +184,14 @@ static const struct ec_board_info board_info[] __initconst = {
>   		.board_names = {"PRIME X570-PRO"},
>   		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
>   			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"Pro WS X570-ACE"},
>   		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG CROSSHAIR VIII DARK HERO"},
> @@ -187,6 +200,7 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>   			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
>   			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
> @@ -194,6 +208,7 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
>   			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {
> @@ -206,6 +221,7 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
>   			SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
> @@ -213,12 +229,14 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG STRIX B550-E GAMING"},
>   		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>   			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_CPU_OPT,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG STRIX B550-I GAMING"},
> @@ -226,6 +244,7 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG STRIX X570-E GAMING"},
> @@ -233,17 +252,20 @@ static const struct ec_board_info board_info[] __initconst = {
>   			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
>   			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG STRIX X570-F GAMING"},
>   		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>   			SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{
>   		.board_names = {"ROG STRIX X570-I GAMING"},
>   		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
>   			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
>   			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>   	},
>   	{}
>   };
> @@ -253,6 +275,57 @@ struct ec_sensor {
>   	s32 cached_value;
>   };
>   
> +struct lock_data {
> +	union {
> +		acpi_handle aml;
> +		u32 global_lock_handle;
> +		struct mutex regular;
> +	} mutex;
> +	int (*lock)(struct lock_data *data);
> +	int (*unlock)(struct lock_data *data);
> +};
> +
> +/*
> + * The next function pairs implement options for locking access to the
> + * state and the EC
> + */
> +static int lock_via_acpi_mutex(struct lock_data *data)
> +{
> +	/*
> +	 * ASUS DSDT does not specify that access to the EC has to be guarded,
> +	 * but firmware does access it via ACPI
> +	 */
> +	return acpi_acquire_mutex(data->mutex.aml, NULL,
> +				  ACPI_LOCK_DELAY_MS);
> +}
> +
> +static int unlock_acpi_mutex(struct lock_data *data)
> +{
> +	return acpi_release_mutex(data->mutex.aml, NULL);
> +}
> +
> +static int lock_via_global_acpi_lock(struct lock_data *data)
> +{
> +	return acpi_acquire_global_lock(ACPI_LOCK_DELAY_MS,
> +					&data->mutex.global_lock_handle);
> +}
> +
> +static int unlock_global_acpi_lock(struct lock_data *data)
> +{
> +	return acpi_release_global_lock(data->mutex.global_lock_handle);
> +}
> +
> +static int lock_via_mutex(struct lock_data *data)
> +{
> +	return mutex_trylock(&data->mutex.regular) ? 0 : -EBUSY;
> +}

There is some type confusion in the above lock functions. Some return
ACPI error codes, some return Linux error codes. Please make return
values consistent.

Also, why use mutex_trylock() instead of mutex_lock() ? This is
unusual since it will result in errors if more than one user
tries to access the data (eg multiple processes reading sysfs
attributes at the same time), and thus warrants a detailed
explanation.

> +
> +static int unlock_mutex(struct lock_data *data)
> +{
> +	mutex_unlock(&data->mutex.regular);
> +	return 0;
> +}
> +
>   struct ec_sensors_data {
>   	struct ec_board_info board_info;
>   	struct ec_sensor *sensors;
> @@ -263,7 +336,9 @@ struct ec_sensors_data {
>   	u8 banks[ASUS_EC_MAX_BANK + 1];
>   	/* in jiffies */
>   	unsigned long last_updated;
> -	acpi_handle aml_mutex;
> +	struct lock_data lock_data;
> +	/* number of board EC sensors */
> +	u8 nr_sensors;

Ok, I must admit I am more than a bit lost. In patch 1/4
you removed this variable (and argued that removing it was
for "deduplication"), only to re-introduce it here.
Sorry, I don't follow the logic.

>   	/*
>   	 * number of EC registers to read
>   	 * (sensor might span more than 1 register)
> @@ -370,23 +445,36 @@ static void __init fill_ec_registers(struct ec_sensors_data *ec)
>   	}
>   }
>   
> -static acpi_handle __init asus_hw_access_mutex(struct device *dev)
> +static int __init setup_lock_data(struct device *dev)
>   {
>   	const char *mutex_path;
> -	acpi_handle res;
>   	int status;
> +	struct ec_sensors_data *state = dev_get_drvdata(dev);
>   
>   	mutex_path = mutex_path_override ?
> -		mutex_path_override : ASUS_HW_ACCESS_MUTEX_ASMX;
> -
> -	status = acpi_get_handle(NULL, (acpi_string)mutex_path, &res);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(dev,
> -			"Could not get hardware access guard mutex '%s': error %d",
> -			mutex_path, status);
> -		return NULL;
> +		mutex_path_override : state->board_info.mutex_path;
> +
> +	if (!mutex_path || !strlen(mutex_path)) {

When would mutex_path be NULL ?

> +		mutex_init(&state->lock_data.mutex.regular);
> +		state->lock_data.lock = lock_via_mutex;
> +		state->lock_data.unlock = unlock_mutex;
> +	} else if (!strcmp(mutex_path, ACPI_GLOBAL_LOCK_PSEUDO_PATH)) {
> +		state->lock_data.lock = lock_via_global_acpi_lock;
> +		state->lock_data.unlock = unlock_global_acpi_lock;
> +	} else {
> +		status = acpi_get_handle(NULL, (acpi_string)mutex_path,
> +					 &state->lock_data.mutex.aml);
> +		if (ACPI_FAILURE(status)) {
> +			dev_err(dev,
> +				"Failed to get hardware access guard AML mutex"
> +				"'%s': error %d",

Please no string splits. And the negative impact can be seen here:
No space between "mutex" and "'%s'".

> +				mutex_path, status);
> +			return -ENOENT;
> +		}
> +		state->lock_data.lock = lock_via_acpi_mutex;
> +		state->lock_data.unlock = unlock_acpi_mutex;
>   	}
> -	return res;
> +	return 0;
>   }
>   
>   static int asus_ec_bank_switch(u8 bank, u8 *old)
> @@ -417,7 +505,8 @@ static int asus_ec_block_read(const struct device *dev,
>   	if (prev_bank) {
>   		/* oops... somebody else is working with the EC too */
>   		dev_warn(dev,
> -			"Concurrent access to the ACPI EC detected.\nRace condition possible.");
> +			"Concurrent access to the ACPI EC detected.\n"
> +			"Race condition possible.");

Why this change, and how is it related to this patch ?

>   	}
>   
>   	/* read registers minimizing bank switches. */
> @@ -489,15 +578,9 @@ static int update_ec_sensors(const struct device *dev,
>   {
>   	int status;
>   
> -	/*
> -	 * ASUS DSDT does not specify that access to the EC has to be guarded,
> -	 * but firmware does access it via ACPI
> -	 */
> -	if (ACPI_FAILURE(acpi_acquire_mutex(ec->aml_mutex, NULL,
> -					    ACPI_LOCK_DELAY_MS))) {
> -		dev_err(dev, "Failed to acquire AML mutex");
> -		status = -EBUSY;
> -		goto cleanup;
> +	if (ec->lock_data.lock(&ec->lock_data)) {
> +		dev_warn(dev, "Failed to acquire mutex");
> +		return -EBUSY;
>   	}
>   
>   	status = asus_ec_block_read(dev, ec);
> @@ -505,10 +588,10 @@ static int update_ec_sensors(const struct device *dev,
>   	if (!status) {
>   		update_sensor_values(ec, ec->read_buffer);
>   	}
> -	if (ACPI_FAILURE(acpi_release_mutex(ec->aml_mutex, NULL))) {
> -		dev_err(dev, "Failed to release AML mutex");
> -	}
> -cleanup:
> +
> +	if (ec->lock_data.unlock(&ec->lock_data))
> +		dev_err(dev, "Failed to release mutex");
> +
>   	return status;
>   }
>   
> @@ -648,6 +731,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   	enum hwmon_sensor_types type;
>   	struct device *hwdev;
>   	unsigned int i;
> +	int status;
>   
>   	pboard_info = get_board_info();
>   	if (!pboard_info)
> @@ -663,6 +747,11 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   	ec_data->sensors = devm_kcalloc(dev, sensor_count(&ec_data->board_info),
>   					sizeof(struct ec_sensor), GFP_KERNEL);
>   
> +	status = setup_lock_data(dev);
> +	if (status) {
> +		dev_err(dev, "Failed to setup state/EC locking: %d", status);
> +		return status;
> +	}
>   	setup_sensor_data(ec_data);
>   	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
>   					  sizeof(u16), GFP_KERNEL);
> @@ -674,8 +763,6 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   
>   	fill_ec_registers(ec_data);
>   
> -	ec_data->aml_mutex = asus_hw_access_mutex(dev);
> -
>   	for (i = 0; i < sensor_count(&ec_data->board_info); ++i) {
>   		si = get_sensor_info(ec_data, i);
>   		if (!nr_count[si->type])

