Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDB48D68B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiAMLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiAMLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:16:28 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720DC06173F;
        Thu, 13 Jan 2022 03:16:27 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-190-118.tukw.qwest.net [174.21.190.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7491618D;
        Thu, 13 Jan 2022 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1642072587;
        bh=Z92R/qrCCHBnNh6yB0yQlxCSfgJ+rdavB/NoqMjyhZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCv2f+K5uIkR8D7ZAbiTaHvInC6MaeDcabLhOGKuPmF+YlupSEh9WxJg3Cj/nrrRK
         qbp26omOhzPgYikVLeyM8xzq2zggNy7JNQJwBu6XC+37SpRYOuVgvNWfXqE8zkBiNf
         o5zWPoYztDm6qSTGYpBkXH5cnqKNrSO647mZkM9M=
Date:   Thu, 13 Jan 2022 03:16:26 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>
Subject: Re: [PATCH v3] hwmon: (nct6775) add support for TSI temperature
 registers
Message-ID: <YeAKCos0hioMAiqi@hatter.bewilderbeest.net>
References: <20220112034824.3467-1-zev@bewilderbeest.net>
 <20220112164729.GA399472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220112164729.GA399472@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:47:29AM PST, Guenter Roeck wrote:
>On Tue, Jan 11, 2022 at 07:48:24PM -0800, Zev Weiss wrote:
>> These registers report CPU temperatures (and, depending on the system,
>> sometimes chipset temperatures) via the TSI interface on AMD systems.
>> They're distinct from most of the other Super-IO temperature readings
>> (CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
>> monitoring and are in a different (higher resolution) format, but can
>> still provide useful temperature data.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> Tested-by: Renze Nicolai <renze@rnplus.nl>
>> ---
>>
>[ ... ]
>
>> +		switch (data->kind) {
>> +		case nct6791:
>> +		case nct6792:
>> +		case nct6793:
>> +			data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
>> +			num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
>> +			break;
>> +		case nct6795:
>> +		case nct6796:
>> +		case nct6797:
>> +		case nct6798:
>> +			data->REG_TSI_TEMP = NCT6796_REG_TSI_TEMP;
>> +			num_reg_tsi_temp = ARRAY_SIZE(NCT6796_REG_TSI_TEMP);
>> +			break;
>> +		default:
>> +			dev_warn(dev, "unknown number of TSI temp registers for %s\n", data->name);
>> +			num_reg_tsi_temp = 0;
>> +			break;
>
>Please drop the message. This is new functionality which should not
>suddenly produce a warning for chips which possibly do not support those
>registers in the first place. For users with those chips the warning
>is just confusing.
>

Just to confirm, this switch currently covers all the enum cases handled 
by the surrounding switch case, so as it stands the default case should 
be unreachable and hence it should be guaranteed not to warn for any 
existing chip, only for a hypothetical newly-added one (the intent being 
that someone adding another chip in the future would be less likely to 
accidentally omit TSI support).  Unfortunately gcc doesn't seem to be 
quite smart enough to realize that and avoid warning about missing 
switch cases in the inner switch if I remove the default case entirely, 
so we can't just rely on the compiler to warn about it.

Shall I still remove it anyway?  (I could certainly also add a comment 
clarifying the above.)


Zev

