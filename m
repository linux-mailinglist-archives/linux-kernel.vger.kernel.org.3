Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8057033D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGKMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiGKMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:46:24 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28461D94;
        Mon, 11 Jul 2022 05:46:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 56358C80091;
        Mon, 11 Jul 2022 14:46:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sW0mNK6XUXn5; Mon, 11 Jul 2022 14:45:59 +0200 (CEST)
Received: from [192.168.178.47] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 65F0DC80089;
        Mon, 11 Jul 2022 14:45:59 +0200 (CEST)
Message-ID: <c5a7fa10-7b6a-fa0d-622e-4392fda1ee93@tuxedocomputers.com>
Date:   Mon, 11 Jul 2022 14:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-3-wse@tuxedocomputers.com>
 <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
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

Hi,

On 7/8/22 21:39, Hans de Goede wrote:
> Hi,
>
> On 7/8/22 18:10, Werner Sembach wrote:
>> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
>> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
>> have an external PS/2 port so this can safely be set for all of them.
>>
>> I'm not entirely sure if every device listed really needs all four quirks,
>> but after testing and production use. No negative effects could be
>> observed when setting all four.
>>
>> Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
>> and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
>> boot and sometimes also after resume. However both are required for the
>> keyboard to not fail completely sometimes after boot or resume.
> Hmm, the very laggy bit does not sound good. Have you looked into other
> solutions, e.g. what happens if you use just nomux without any of the
> other 3 options ?

I tried a lot of combinations, but it was some time ago.

iirc: at least nomux and reset are required and both individually cause 
the lagging.

So the issue is not fixed by just using a different set of quirks.

Regards,

Werner

>
> Regards,
>
> Hans
>
>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/input/serio/i8042-x86ia64io.h | 28 +++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
>> index 5204a7dd61d4..9dc0266e5168 100644
>> --- a/drivers/input/serio/i8042-x86ia64io.h
>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>> @@ -1107,6 +1107,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>   		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>   					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>   	},
>> +	{
>> +		/*
>> +		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
>> +		 * the keyboard very laggy for ~5 seconds after boot and
>> +		 * sometimes also after resume.
>> +		 * However both are required for the keyboard to not fail
>> +		 * completely sometimes after boot or resume.
>> +		 */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>>   	{
>>   		.matches = {
>>   			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>> @@ -1114,6 +1128,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>   		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>>   					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>>   	},
>> +	{
>> +		/*
>> +		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
>> +		 * the keyboard very laggy for ~5 seconds after boot and
>> +		 * sometimes also after resume.
>> +		 * However both are required for the keyboard to not fail
>> +		 * completely sometimes after boot or resume.
>> +		 */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
>> +		},
>> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>> +	},
>>   	{
>>   		.matches = {
>>   			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
