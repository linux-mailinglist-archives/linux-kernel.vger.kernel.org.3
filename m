Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC165479FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 07:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhLSG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 01:29:48 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:46387 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhLSG3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 01:29:47 -0500
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E5E8B198;
        Sat, 18 Dec 2021 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1639895387;
        bh=A1Y33nDJNLUYMQCBlzG4WqjqBHb/XRonsXCmK42MlY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RC+dzFxEVA3PeOeFV4u7gqdqGe763tGypKU2fSYtRn2sTVlr6bZT8uACpjJqkbI6q
         XWsfp3gBHtPWkEvUt2cgrCaCVWlIK29MtVnMMyoxfzMaZJXVKY4sYGkTP0uv5khA32
         lSp0yQFu/fOfnSTB7vQVpcBoXiDF5HNuOKqpFa+s=
Date:   Sat, 18 Dec 2021 22:29:42 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) add support for TSI temperature
 registers
Message-ID: <Yb7RVu6fQc+tLIAg@hatter.bewilderbeest.net>
References: <20211110231440.17309-1-zev@bewilderbeest.net>
 <20211217214043.GA489498@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211217214043.GA489498@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:40:43PM PST, Guenter Roeck wrote:
>On Wed, Nov 10, 2021 at 03:14:39PM -0800, Zev Weiss wrote:
>> @@ -1490,6 +1516,7 @@ static bool is_word_sized(struct nct6775_data 
>> *data, u16 reg)
>>  		    (reg & 0x00ff) == 0x55)) ||
>>  		  (reg & 0xfff0) == 0x630 ||
>>  		  reg == 0x402 ||
>> +		  (reg >= 0x409 && reg <= 0x419 && (reg & 1)) ||
>>  		  reg == 0x640 || reg == 0x642 ||
>>  		  ((reg & 0xfff0) == 0x650 && (reg & 0x000f) >= 0x06) ||
>>  		  reg == 0x73 || reg == 0x75 || reg == 0x77;
>> @@ -1497,13 +1524,18 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
>>  	case nct6791:
>>  	case nct6792:
>>  	case nct6793:
>> +		num_tsi_regs = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
>> +		goto check;
>
>This is unnecessarily pendantic. We did not do that for other chips
>with different array sizes, and we should not start doing it for this
>unless there is evidence that the same registers are 8-bit wide for
>some of the chips (instead of being unused).
>

Ack, will fix in v2 -- thanks for the review.


Zev

