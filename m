Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445BE46AE3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbhLFXIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:08:46 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:35067 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhLFXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:08:46 -0500
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1ABA15B1;
        Mon,  6 Dec 2021 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1638831916;
        bh=AGZUvdoz1R/W4UGcI1sQgiuXPO1E1UwVokdQHmJX2XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+Hq59pJTf0HeC60xL18SQ1NRlYfPzNViiEaAFvLov1s302L/L9DIpY/cUfw4XD8g
         UM9m0iZdUijm6HcJAemqg/QgxQafZaSmj5CjxIW3s0FqzWFPJ9bqyNyTNwX+Az5/q9
         rm5Gve+vEkPdOYHJrfPJ7+kTIXCv0Boi9ND6kDc0=
Date:   Mon, 6 Dec 2021 15:05:14 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>, g@hatter.bewilderbeest.net
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: add Delta AHE-50DC fan control module driver
Message-ID: <Ya6XKtxREvocOXow@hatter.bewilderbeest.net>
References: <20211206224419.15736-1-zev@bewilderbeest.net>
 <20211206224419.15736-2-zev@bewilderbeest.net>
 <28719505-ace1-bb04-bbc2-043c56b0db7d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <28719505-ace1-bb04-bbc2-043c56b0db7d@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:02:49PM PST, Guenter Roeck wrote:
>On 12/6/21 2:44 PM, Zev Weiss wrote:
>>This device is an integrated module of the Delta AHE-50DC Open19 power
>>shelf.  For lack of proper documentation, this driver has been developed
>>referencing an existing (GPL) driver that was included in a code release
>>from LinkedIn [1].  It provides four fan speeds, four temperatures, and
>>one voltage reading, as well as a handful of warning and fault
>>indicators.
>>
>>[1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>
>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>---
>
>[ ... ]
>
>>+
>>+static const u8 AHE50DC_FAN_TEMP_REGS[] = { 0x8d, 0x8e, 0x8f, 0xd0 };
>>+static const u8 AHE50DC_FAN_SPEED_REGS[] = { 0x90, 0x91, 0x92, 0x93 };
>>+static const u8 AHE50DC_FAN_FAN_STATUS_REGS[] = { 0x81, 0x82 };
>>+#define AHE50DC_FAN_VIN_REG 0x88
>>+#define AHE50DC_FAN_CHIP_STATUS_REG 0x79
>
>PMBus registers:
>
>	PMBUS_STATUS_WORD               = 0x79,
>
>	PMBUS_STATUS_FAN_12             = 0x81,
>	PMBUS_STATUS_FAN_34             = 0x82,
>
>	PMBUS_READ_VIN                  = 0x88,
>
>        PMBUS_READ_TEMPERATURE_1        = 0x8D,
>        PMBUS_READ_TEMPERATURE_2        = 0x8E,
>        PMBUS_READ_TEMPERATURE_3        = 0x8F,
>        PMBUS_READ_FAN_SPEED_1          = 0x90,
>        PMBUS_READ_FAN_SPEED_2          = 0x91,
>        PMBUS_READ_FAN_SPEED_3          = 0x92,
>        PMBUS_READ_FAN_SPEED_4          = 0x93,
>
>This is quite obviously a PMBus device. Why not use the PMBus driver ?
>
>Guenter

Ah, so it appears -- not familiar enough with the constants to recognize 
it immediately I suppose (and wasn't expecting PMBus on this particular 
device).  Let me try that.


Thanks,
Zev

