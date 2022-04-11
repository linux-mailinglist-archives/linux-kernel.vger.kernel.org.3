Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24B4FC6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350232AbiDKVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiDKVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:48:04 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39A1A3B0;
        Mon, 11 Apr 2022 14:45:47 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 69FA3C26B5;
        Mon, 11 Apr 2022 21:38:40 +0000 (UTC)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 76453E0004;
        Mon, 11 Apr 2022 21:38:33 +0000 (UTC)
Message-ID: <1fde1970-c7b7-a0a2-c68d-a3b26ec6621f@zago.net>
Date:   Mon, 11 Apr 2022 16:38:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] HID: Add support for Mega World controller force feedback
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220209052807.138007-1-frank@zago.net>
 <nycvar.YFH.7.76.2204111710040.30217@cbobk.fhfr.pm>
From:   Frank Zago <frank@zago.net>
In-Reply-To: <nycvar.YFH.7.76.2204111710040.30217@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 10:10, Jiri Kosina wrote:
> On Tue, 8 Feb 2022, frank zago wrote:
> 
>> This patch adds support for one of the several Mega World USB game
>> controller with integrated force feedback. It is a HID based
>> memory-less game controller, with a weak motor on the left, and a
>> strong one on the right.
>>
>> Signed-off-by: frank zago <frank@zago.net>
>> ---
>>  drivers/hid/Kconfig         |  14 ++++
>>  drivers/hid/Makefile        |   1 +
>>  drivers/hid/hid-ids.h       |   3 +
>>  drivers/hid/hid-megaworld.c | 136 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 154 insertions(+)
>>  create mode 100644 drivers/hid/hid-megaworld.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index f5544157576c..2344830d3680 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -684,6 +684,20 @@ config HID_MAYFLASH
>>  	Say Y here if you have HJZ Mayflash PS3 game controller adapters
>>  	and want to enable force feedback support.
>>  
>> +config HID_MEGAWORLD
>> +	tristate "Mega World based game controller support"
>> +	depends on HID
>> +	help
>> +	  Say Y here if you have a Mega World based game controller.
>> +
>> +config MEGAWORLD_FF
>> +	bool "Mega World based game controller force feedback support"
>> +	depends on HID_MEGAWORLD
>> +	select INPUT_FF_MEMLESS
>> +	help
>> +	  Say Y here if you have a Mega World based game controller and want
>> +	  to have force feedback support for it.
>> +
> 
> Hi Frank,
> 
> as the *only* functionality provided by the driver seems to be the force 
> feedback, does it really make sense to decouple the two options?

I don't think so, but that's what at least hid-tmff.c and hid-zpff.c are doing.
I can rework the patch if you prefer to just have the HID_MEGAWORLD option.

Frank.

