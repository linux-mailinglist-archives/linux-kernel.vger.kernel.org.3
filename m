Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF655FE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiF2LaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiF2LaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:30:01 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD0326DC;
        Wed, 29 Jun 2022 04:29:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id ACCF9C8012A;
        Wed, 29 Jun 2022 13:29:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oXzVoYcSRpNm; Wed, 29 Jun 2022 13:29:57 +0200 (CEST)
Received: from [192.168.178.47] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 67B6CC80128;
        Wed, 29 Jun 2022 13:29:56 +0200 (CEST)
Message-ID: <71d7c2bd-006b-6321-46c5-78a5276736c5@tuxedocomputers.com>
Date:   Wed, 29 Jun 2022 13:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 4/4] input/i8042: Add TUXEDO devices to i8042 quirk
 tables
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de,
        hdegoede@redhat.com, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
 <20220329143622.31394-5-wse@tuxedocomputers.com>
 <Yrvk29RjekvMpJIk@google.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Yrvk29RjekvMpJIk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 07:36, Dmitry Torokhov wrote:
> Hi Werner,
>
> On Tue, Mar 29, 2022 at 04:36:22PM +0200, Werner Sembach wrote:
>> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
>> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
>> have an external PS/2 port so this can safely be set for all of them.
>>
>> I'm not entirely sure if every device listed really needs all four quirks,
>> but after testing and production use. No negative effects could be
>> observed when setting all four.
>>
>> The list is quite massive as neither the TUXEDO nor the Clevo dmi strings
>> have been very consistent historically. I tried to keep the list as short
>> as possible without risking on missing an affected device.
>>
>> This is revision 3. The Clevo N150CU barebone is still removed as it might
>> have problems with the fix and needs further investigations. The
>> SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
>> added. This is now based in the quirk table refactor. This now also
>> includes the additional noaux flag for the NS7xMU.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/input/serio/i8042-x86ia64io.h | 125 ++++++++++++++++++++++++++
>>   1 file changed, 125 insertions(+)
>>
>> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
>> index 5c0eb5594fb1..a59c6aba7c75 100644
>> --- a/drivers/input/serio/i8042-x86ia64io.h
>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>> @@ -1025,6 +1025,25 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>   		},
>>   		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
>>   	},
>> +	/*
>> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
>> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
>> +	 * none of them have an external PS/2 port so this can savely be set for
> s/savely/safely/
>
>> +	 * all of them. These two are based on a Clevo design, but have the
>> +	 * board_name changed.
>> +	 */
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
>> +		},
> Don't you need to set driver_data here and below?
>
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
>> +		},
>> +	},
>>   	{
>>   		/* Mivvy M310 */
>>   		.matches = {
>> @@ -1054,6 +1073,112 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>   		},
>>   		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
>>   	},
>> +	/*
>> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
>> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
>> +	 * none of them have an external PS/2 port so this can savely be set for
> safely
>
>> +	 * all of them.
>> +	 * Clevo barebones come with board_vendor and/or system_vendor set to
>> +	 * either the very generic string "Notebook" and/or a different value
>> +	 * for each individual reseller. The only somewhat universal way to
>> +	 * identify them is by board_name.
>> +	 */
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	/*
>> +	 * At least one modern Clevo barebone has the touchpad connected both
>> +	 * via PS/2 and i2c interface. This causes a race condition between the
>> +	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
>> +	 * is available via the i2c interface and the device has no external
>> +	 * PS/2 port, it is save to just ignore all ps2 mouses here to avoid
> safe
>
>> +	 * this issue. The know affected device is the
> known
>
>> +	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
>> +	 * the two different dmi strings below. NS50MU is not a typo!
>> +	 */
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
>> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
>> +					SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
>> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
>> +					SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>>   	{ }
>>   };
>>   
>> -- 
>> 2.25.1
>>
> Thanks.
>
Everything applied in v6, thanks for the feedback.
