Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F014A47A3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378282AbiAaM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiAaM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:57:24 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341DCC061714;
        Mon, 31 Jan 2022 04:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a4c0lJULIYhZL9lSY0iYSY6PkI9m9JaIMExgqqqU4N0=; b=GkaD/SxJ9buika23MArYqvcBBq
        7/TF3Z14dg3YGX5m6IqyrAtIMqVKEBOJGsr5gagrr6LZzr4FgJzzhjvjxNMCM9YeJpZxzouT5jPSH
        iUOOXcOFg54FEERYqWbnM61Dim/sINEfz/CilGpD5CS5r3w7S7DREUC8RCBjHApuByt0=;
Received: from p200300daa71e0b007047aa2ce81d99ce.dip0.t-ipconnect.de ([2003:da:a71e:b00:7047:aa2c:e81d:99ce] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEWF8-0005lH-5M; Mon, 31 Jan 2022 13:57:14 +0100
Message-ID: <04c91b4e-e7c8-ac6a-f60a-0453a49122fa@nbd.name>
Date:   Mon, 31 Jan 2022 13:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v9 03/13] ARM: Add basic support for Airoha EN7523 SoC
Content-Language: en-US
To:     Luka Perkov <luka.perkov@sartura.hr>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
References: <20220130145116.88406-1-nbd@nbd.name>
 <20220130145116.88406-4-nbd@nbd.name>
 <CAKQ-crhDHXZptWr5rO5Rb9JttQREoPqE4YO-6nzC2OWc-z06_g@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CAKQ-crhDHXZptWr5rO5Rb9JttQREoPqE4YO-6nzC2OWc-z06_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31.01.22 11:51, Luka Perkov wrote:
> Hello Felix,
> 
> On Sun, Jan 30, 2022 at 3:56 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> From: John Crispin <john@phrozen.org>
>>
>> EN7523 is an armv8 based silicon used inside broadband access type devices
>> such as xPON and xDSL. It shares various silicon blocks with MediaTek
>> silicon such as the MT7622.
>>
>> Add basic support for Airoha EN7523, enough for booting to console.
>>
>> The UART is basically 8250-compatible, except for the clock selection.
>> A clock-frequency value is synthesized to get this to run at 115200 bps.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>> index 000000000000..ea23b5abb478
>> --- /dev/null
>> +++ b/arch/arm/mach-airoha/airoha.c
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Device Tree support for Airoha SoCs
>> + *
>> + * Copyright (c) 2022 Felix Fietkau <nbd@nbd.name>
>> + */
>> +#include <asm/mach/arch.h>
>> +
>> +static const char * const airoha_board_dt_compat[] = {
>> +       "airoha,en7523",
>> +       NULL,
>> +};
>> +
>> +DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
> 
> Since this is Cortex-A53 core is there a reason why this is not placed
> within arm64 directory?
 From what I can tell, it's a stripped-down core that only runs in 
32-bit mode.

- Felix
